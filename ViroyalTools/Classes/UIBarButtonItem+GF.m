//
//  UIBarButtonItem.m
//  AFNetworking
//
//  Created by 熊国锋 on 2017/12/28.
//

#import "UIBarButtonItem+GF.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

NSString const * UIBarButtonItem_badgeLabel_key;
NSString const * UIBarButtonItem_badgeDot_key;

@implementation UIBarButtonItem (GF)

@dynamic badgeDot, badgeValue;

- (UIView *)containerView {
    if (self.customView) {
        return self.customView;
    }
    
    NSAssert(NO, @"badge label only on customView");
    return nil;
}

- (UILabel *)badgeLabel {
    UILabel *label = objc_getAssociatedObject(self, &UIBarButtonItem_badgeLabel_key);
    if (!label) {
        label = [UILabel new];
        label.backgroundColor = [UIColor redColor];
        
        UIView *superView = [self containerView];
        [superView addSubview:label];
        
        objc_setAssociatedObject(self, &UIBarButtonItem_badgeLabel_key, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return label;
}

- (void)setBadgeDot:(BOOL)badgeDot {
    objc_setAssociatedObject(self, &UIBarButtonItem_badgeDot_key, @(badgeDot), OBJC_ASSOCIATION_COPY);
    
    UIView *superView = [self containerView];
    UILabel *label = [self badgeLabel];
    if (badgeDot) {
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superView);
            make.right.equalTo(superView);
            make.width.equalTo(@8);
            make.height.equalTo(label.mas_width);
        }];
        CALayer *layer = label.layer;
        layer.cornerRadius = 4;
        layer.masksToBounds = YES;
    }
    else {
        
    }
}

- (BOOL)badgeDot {
    NSNumber *number = objc_getAssociatedObject(self, &UIBarButtonItem_badgeDot_key);
    return [number boolValue];
}

- (void)setBadgeValue:(NSString *)badgeValue {
    
}

@end
