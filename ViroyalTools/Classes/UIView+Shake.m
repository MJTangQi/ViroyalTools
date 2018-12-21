//
//  UIView+Shake.m
//  Pods
//
//  Created by 熊国锋 on 2017/3/15.
//
//

#import "UIView+Shake.h"

@implementation UIView (Shake)

- (void)shakeView {
    CALayer *viewLayer = self.layer;
    CGPoint position = viewLayer.position;
    CGPoint x = CGPointMake(position.x + 10, position.y);
    CGPoint y = CGPointMake(position.x - 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    
    [animation setAutoreverses:YES];
    [animation setDuration:.05];
    [animation setRepeatCount:3];
    
    [viewLayer addAnimation:animation forKey:nil];
}

@end
