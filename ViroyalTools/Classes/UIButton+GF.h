//
//  UIButton+GF.h
//  Pods
//
//  Created by 熊国锋 on 2017/7/8.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (GF)

+ (instancetype)buttonWithTitleColor:(nullable UIColor *)titleColor
                     backgroundColor:(nullable UIColor *)backgroundColor
                         cornerRadii:(CGSize)cornerRadii;

+ (instancetype)buttonWithTitleColor:(nullable UIColor *)titleColor
                     backgroundColor:(nullable UIColor *)backgroundColor
                         borderColor:(nullable UIColor *)borderColor
                         cornerRadii:(CGSize)cornerRadii;

- (void)setTitleColor:(nullable UIColor *)titleColor
      backgroundColor:(nullable UIColor *)backgroundColor
          borderColor:(nullable UIColor *)borderColor
          cornerRadii:(CGSize)cornerRadii;

@end

NS_ASSUME_NONNULL_END

