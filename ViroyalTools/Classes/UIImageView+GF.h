//
//  UIImageView+GF.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (GF)

- (void)setImage:(UIImage *)image fade:(BOOL)fade;

- (void)setSquaredImageWithURL:(nullable NSString *)urlString
                       rounded:(BOOL)rounded
              placeholderImage:(nullable UIImage *)placeholder
                     completed:(nullable void(^)(UIImage * _Nullable image))block;

@end

NS_ASSUME_NONNULL_END
