//
//  NSAttributedString+GF.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "NSAttributedString+GF.h"

@implementation NSAttributedString (GF);

+ (instancetype)attributedStringWithString:(NSString *)string1 font:(UIFont *)font1 color:(UIColor *)color1
                                    string:(NSString *)string2 font:(UIFont *)font2 color:(UIColor *)color2 {
    return [self attributedStringWithStrings:string1, font1, color1, string2, font2, color2, nil];
}

+ (instancetype)attributedStringWithStrings:(NSString *)firstString, ... {
    va_list v;
    va_start(v, firstString);
    NSString *string = firstString;
    UIFont *font;
    UIColor *color;
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    id obj = va_arg(v, id);
    while (obj) {
        if ([obj isKindOfClass:[NSString class]]) {
            string = obj;
        }
        else if ([obj isKindOfClass:[UIFont class]]) {
            font = obj;
        }
        else if ([obj isKindOfClass:[UIColor class]]) {
            color = obj;
            
            [result appendAttributedString:[[NSAttributedString alloc] initWithString:string
                                                                           attributes:@{ NSFontAttributeName : font,
                                                                                         NSForegroundColorAttributeName : color}]];
        }
        
        obj = va_arg(v, id);
    }
    
    va_end(v);
    return [[NSAttributedString alloc] initWithAttributedString:result];
}

@end
