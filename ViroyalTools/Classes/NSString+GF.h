//
//  NSString+GF.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GF)

- (NSString *)stringByLeftTrimmingCharactersInSet:(NSCharacterSet *)set;

- (NSString *)stringByRightTrimmingCharactersInSet:(NSCharacterSet *)set;

- (NSString *)phoneNumberStyledString;

- (NSString *)MD5;

- (NSString *)MD5InShort;

- (NSString *)sha1;

- (NSString *)hmacWithKey:(NSString *)key;

- (BOOL)isValidPhoneNumber;

- (BOOL)isValidMobileNumber;

- (NSString *)pinyin;

- (NSInteger)pinyinDiffWithString:(NSString *)string;

@end
