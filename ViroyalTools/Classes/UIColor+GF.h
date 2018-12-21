//
//  UIColor+GF.h
//  Pods
//
//  Created by 熊国锋 on 2017/7/27.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (GF)

+ (instancetype)colorFromHex:(long long)value;
+ (instancetype)colorAlphaFromHex:(long long)value;

+ (instancetype)colorFromString:(NSString *)string;
+ (instancetype)colorAlphaFromString:(NSString *)string;

- (NSString *)hexStringWithAlpha:(BOOL)alpha;

- (UIColor *)colorWithMinimumSaturation:(CGFloat)saturation;

@end
