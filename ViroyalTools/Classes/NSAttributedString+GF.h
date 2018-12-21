//
//  NSAttributedString+GF.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (GF)

+ (instancetype)attributedStringWithString:(NSString *)string1 font:(UIFont *)font1 color:(UIColor *)color1
                                            string:(NSString *)string2 font:(UIFont *)font2 color:(UIColor *)color2;

+ (instancetype)attributedStringWithStrings:(NSString *)firstString, ... NS_REQUIRES_NIL_TERMINATION;

@end
