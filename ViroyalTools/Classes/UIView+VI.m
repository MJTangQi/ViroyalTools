//
//  UIView+VI.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "UIView+VI.h"

@implementation UIView (VI)

- (CGFloat)top {
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)top {
    CGRect rect = self.frame;
    rect.origin.y = top;
    self.frame = rect;
}

- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom {
    CGRect rect = self.frame;
    rect.origin.y = bottom - CGRectGetHeight(rect);
    self.frame = rect;
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)left {
    return CGRectGetMinX(self.frame);
}

- (void)setLeft:(CGFloat)left {
    CGRect rect = self.frame;
    rect.origin.x = left;
    self.frame = rect;
}

- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

- (void)setRight:(CGFloat)right {
    CGRect rect = self.frame;
    rect.origin.x = right - CGRectGetWidth(rect);
    self.frame = rect;
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (UIImage *)snapshotImage {
    NSAssert(CGRectGetWidth(self.bounds) > 0 && CGRectGetHeight(self.bounds) > 0, @"size must be greater than zero");
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self layoutIfNeeded];
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshot;
}

@end

CGPoint CGRectGetCenter(CGRect rect) {
    return CGPointMake(CGRectGetMaxX(rect) / 2, CGRectGetMaxY(rect) / 2);
}

CGRect CGRectMakeWithCenterAndSize(CGPoint center, CGSize size) {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    rect.origin.x = center.x - size.width / 2;
    rect.origin.y = center.y - size.height / 2;
    
    return rect;
}

