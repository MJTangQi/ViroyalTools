//
//  UIImageView+GF.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "UIImageView+GF.h"
#import "UIImage+GF.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>

@implementation UIImageView (GF)

- (void)setImage:(UIImage *)image fade:(BOOL)fade {
    if (self.image != image) {
        [UIView transitionWithView:self
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.image = image;
                        }
                        completion:nil];
    }
    else {
        self.image = image;
    }
}

- (void)setSquaredImageWithURL:(NSString *)urlString
                       rounded:(BOOL)rounded
              placeholderImage:(UIImage *)placeholder
                     completed:(void (^)(UIImage * _Nullable))block {
    
    NSString *string = [urlString stringByAppendingString:@"+squared"];
    if (rounded) {
        string = [string stringByAppendingString:@"+rounded"];
    }
    
    UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:string];
    if (image) {
        self.image = image;
        if (block) {
            block(image);
        }
    }
    else {
        self.image = placeholder;
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:urlString]
                                                    options:0
                                                   progress:nil
                                                  completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                                                      if (image) {
                                                          CGSize size = image.size;
                                                          CGFloat cropSize = size.width > size.height?size.height:size.width;
                                                          CGRect rect = CGRectMake((size.width - cropSize) / 2, (size.height - cropSize) / 2, cropSize, cropSize);
                                                          UIImage *squaredImage = [image croppedImage:rect];
                                                          
                                                          if (rounded) {
                                                              UIImage *roundedImage = [squaredImage imageWithCornerRadius:cropSize scale:squaredImage.scale];
                                                              self.image = roundedImage;
                                                              [[SDImageCache sharedImageCache] storeImage:roundedImage
                                                                                                   forKey:string
                                                                                               completion:nil];
                                                              
                                                              if (block) {
                                                                  block(roundedImage);
                                                              }
                                                          }
                                                          else {
                                                              self.image = squaredImage;
                                                              [[SDImageCache sharedImageCache] storeImage:squaredImage
                                                                                                   forKey:string
                                                                                               completion:nil];
                                                              
                                                              if (block) {
                                                                  block(squaredImage);
                                                              }
                                                          }
                                                      }
                                                      else if (block) {
                                                          block(nil);
                                                      }
                                                  }];
    }
}

@end
