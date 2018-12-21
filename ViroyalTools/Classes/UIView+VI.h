//
//  UIView+VI.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VI)

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat width;

- (UIImage *)snapshotImage;

@end

extern CGPoint CGRectGetCenter(CGRect rect);
extern CGRect CGRectMakeWithCenterAndSize(CGPoint center, CGSize size);
