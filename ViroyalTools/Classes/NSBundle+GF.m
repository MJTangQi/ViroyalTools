//
//  NSBundle+GF.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "NSBundle+GF.h"

@implementation UIImage (Bundle)

+ (UIImage *)bundleImageNamed:(NSString *)name {
    NSBundle *bundle = [NSBundle cocoaToolsBundle];
    
    NSString *string = [NSString stringWithFormat:@"@%.0fx", [UIScreen mainScreen].scale];
    NSArray *end = @[string, @"@3x", @"@2x"];
    
    NSString *fileName, *filePath;
    for (NSString *item in end) {
        fileName = [name stringByAppendingString:item];
        filePath = [bundle pathForResource:fileName ofType:@"png"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            break;
        }
    }
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

@end

@implementation NSBundle (GF)

+ (instancetype)cocoaToolsBundle {
    static dispatch_once_t onceToken;
    static NSBundle *bundle;
    
    dispatch_once(&onceToken, ^{
        NSBundle *frameworkBundle = [NSBundle bundleWithIdentifier:@"org.cocoapods.ViroyalTools"];
        NSString *path = [frameworkBundle pathForResource:@"ViroyalTools" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:path];
    });
    
    return bundle;
}

- (instancetype)cocoaToolsStringBundle {
    static dispatch_once_t onceToken;
    static NSBundle *stringBundle;
    dispatch_once(&onceToken, ^{
        NSBundle *bundle = [NSBundle cocoaToolsBundle];
        NSString *resource;
        NSString *local = [[NSLocale preferredLanguages] firstObject];
        if ([local containsString:@"zh"]) {
            if ([local containsString:@"Hans"]) {
                resource = @"zh-Hans";
            }
            else {
                resource = @"zh-Hant";
            }
        }
        else {
            resource = @"en";
        }
        
        stringBundle = [NSBundle bundleWithPath:[bundle pathForResource:resource ofType:@"lproj"]];
    });
    
    return stringBundle;
}

- (NSString *)cocoaToolsStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    return [[self cocoaToolsStringBundle] localizedStringForKey:key value:value table:tableName];
}

- (NSString *)bundleName {
    return [self objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

- (NSString *)bundleShortVersion {
    return [self objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *)bundleVersion {
    return [self objectForInfoDictionaryKey:@"CFBundleVersion"];
}

@end
