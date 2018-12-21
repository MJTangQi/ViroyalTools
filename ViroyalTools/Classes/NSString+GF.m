//
//  NSString+GF.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "NSString+GF.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (GF)

- (NSString *)stringByLeftTrimmingCharactersInSet:(NSCharacterSet *)set {
    NSString *string = self;
    while ([string length] > 0) {
        unichar uchar = [string characterAtIndex:0];
        if ([set characterIsMember:uchar]) {
            string = [string substringFromIndex:1];
        }
        else {
            break;
        }
    }
    
    return string;
}

- (NSString *)stringByRightTrimmingCharactersInSet:(NSCharacterSet *)set {
    NSString *string = self;
    NSInteger len = [string length];
    while (len > 0) {
        unichar uchar = [string characterAtIndex:len - 1];
        if ([set characterIsMember:uchar]) {
            if (len > 1) {
                string = [string substringToIndex:len - 2];
                len = [string length];
            }
            else {
                string = @"";
                break;
            }
        }
        else {
            break;
        }
    }
    
    return string;
}


- (NSString *)phoneNumberStyledString {
    NSMutableString *str = [NSMutableString stringWithString:self];
    if ([str length] == 11) {
        [str insertString:@"-" atIndex:7];
        [str insertString:@"-" atIndex:3];
        
        [str insertString:@"+86 " atIndex:0];
    }
    
    return str.copy;
}

- (NSString *)MD5 {
    if ([self length] == 0) {
        return nil;
    }
    
    const char *str = [self UTF8String];
    if (str == NULL) {
        str = "";
    }
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, r);
    
    NSMutableString *output = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", r[i]];
    }
    
    return output;
}

- (NSString *)MD5InShort {
    NSString *string = [self MD5];
    return [string substringWithRange:NSMakeRange(8, 16)];
}

- (NSString *)sha1 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *)hmacWithKey:(NSString *)key {
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [self cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
    return [HMACData base64EncodedStringWithOptions:0];
}

- (BOOL)isValidMobileNumber {
    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9])|(19[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isValidPhoneNumber {
    if (self.length < 3) {
        return NO;
    }
    
    if ([self isValidMobileNumber]) {
        return YES;
    }
    
    NSString *phoneRegex = @"^[0-9]*$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}

- (NSString *)pinyin {
    // 将NSString装换成NSMutableString
    NSMutableString *pinyin = [self mutableCopy];
    
    // 将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    
    // 去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    
    // 替换数字
    NSString *string = pinyin.copy;
    string = [string stringByReplacingOccurrencesOfString:@"1" withString:@" yi "];
    string = [string stringByReplacingOccurrencesOfString:@"2" withString:@" er "];
    string = [string stringByReplacingOccurrencesOfString:@"3" withString:@" san "];
    string = [string stringByReplacingOccurrencesOfString:@"4" withString:@" si "];
    string = [string stringByReplacingOccurrencesOfString:@"5" withString:@" wu "];
    string = [string stringByReplacingOccurrencesOfString:@"6" withString:@" liu "];
    string = [string stringByReplacingOccurrencesOfString:@"7" withString:@" qi "];
    string = [string stringByReplacingOccurrencesOfString:@"8" withString:@" ba "];
    string = [string stringByReplacingOccurrencesOfString:@"9" withString:@" jiu "];
    string = [string stringByReplacingOccurrencesOfString:@"0" withString:@" shi "];
    
    // 两个空格替换为一个
    string = [string stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    
    return string;
}

- (NSString *)shengmu {
    NSString *string = @"zh ch sh b c d f g h j k l m n p q r s t w x y z";
    NSArray *arr = [string componentsSeparatedByString:@" "];
    for (NSString *item in arr) {
        if ([self hasPrefix:item]) {
            return item;
        }
    }
    
    return nil;
}

- (NSString *)yunmu {
    NSString *shengmu = [self shengmu];
    NSString *yunmu;
    if (shengmu) {
        NSRange range = [self rangeOfString:shengmu];
        yunmu = [self stringByReplacingCharactersInRange:range withString:@""];
    }
    else {
        yunmu = self;
    }
    
    return yunmu;
}

- (NSInteger)pinyinDiffWithWord:(NSString *)word {
    NSString *shengmu1 = [self shengmu];
    NSString *yunmu1 = [self yunmu];
    
    NSString *shengmu2 = [word shengmu];
    NSString *yunmu2 = [word yunmu];
    
    NSInteger value = 0;
    if (![shengmu1 isEqualToString:shengmu2]) {
        const NSArray *pairs = @[@[@"z", @"zh", @"ch"],
                                 @[@"c", @"ch"],
                                 @[@"s", @"sh"],
                                 @[@"l", @"n"],
                                 @[@"f", @"h"],
                                 @[@"r", @"l"]];
        BOOL found = NO;
        for (NSArray *item in pairs) {
            if ([item containsObject:shengmu1] && [item containsObject:shengmu2]) {
                found = YES;
                value++;
                break;
            }
        }
        
        if (!found) {
            value += 2;
        }
    }
    
    if (![yunmu1 isEqualToString:yunmu2]) {
        const NSArray *pairs = @[@[@"an", @"ang", @"en", @"eng", @"un", @"ong"],
                                 @[@"in", @"ing", @"eng"],
                                 @[@"i", @"ian", @"ie", @"iao", @"iang"],
                                 @[@"uan", @"uang"],
                                 @[@"ian", @"uan"],
                                 @[@"i", @"v"]];
        BOOL found = NO;
        for (NSArray *item in pairs) {
            if ([item containsObject:yunmu1] && [item containsObject:yunmu2]) {
                found = YES;
                value++;
                break;
            }
        }
        
        if (!found) {
            value += 2;
        }
    }
    
    return value;
}

- (NSInteger)pinyinDiffWithString:(NSString *)string {
    NSArray *arr1 = [self componentsSeparatedByString:@" "];
    NSArray *arr2 = [string componentsSeparatedByString:@" "];
    
    if (arr1.count != arr2.count) {
        return 100;
    }
    
    NSInteger index = 0;
    NSInteger value = 0;
    while (YES) {
        if (index >= arr1.count || index >= arr2.count) {
            break;
        }
        
        NSString *word1 = arr1[index];
        NSString *word2 = arr2[index];
        
        value += [word1 pinyinDiffWithWord:word2];
        
        index++;
    }
    
    return value;
}

@end
