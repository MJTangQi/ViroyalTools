//
//  VIMessageHUD.m
//  AFNetworking
//
//  Created by 熊国锋 on 2018/7/18.
//

#import "VIMessageHUD.h"
#import <Masonry/Masonry.h>
#import "UIView+VI.h"
#import "NSAttributedString+GF.h"
#import "UIColor+GF.h"

const NSTimeInterval MESSAGE_DELAY_INVERTAL = 1.5;

@interface VIMessageAction ()

@property (nonatomic, copy) NSString                        *title;
@property (nonatomic, copy) VIMessageHUDCompletionBlock     completion;

@end

@implementation VIMessageAction

+ (instancetype)actionWithTitle:(NSString *)title completion:(VIMessageHUDCompletionBlock)completion {
    return [[self alloc] initWithTitle:title completion:completion];
}

- (instancetype)initWithTitle:(NSString *)title completion:(nullable VIMessageHUDCompletionBlock)completion {
    if (self = [self init]) {
        self.title = title;
        self.completion = completion;
    }
    
    return self;
}

@end

@interface VIBackgroundView : UIButton

@property (nonatomic, assign) CGFloat   destAlpha;

@end

@implementation VIBackgroundView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = .0;
        self.destAlpha = .3;
    }
    
    return self;
}

- (void)showAnimated:(BOOL)animated {
    [UIView animateWithDuration:.3
                          delay:0
         usingSpringWithDamping:.7
          initialSpringVelocity:.7
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = self.destAlpha;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}


- (void)hideAnimated:(BOOL)animated {
    [UIView animateWithDuration:.3
                          delay:0
         usingSpringWithDamping:.7
          initialSpringVelocity:.7
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

@end

@protocol VIContentViewDelegate <NSObject>

- (void)barItemClicked:(UIBarButtonItem *)item;

@end

@interface VIContentView : UIView

@property (nonatomic, weak) id<VIContentViewDelegate>       delegate;

@property (nonatomic, copy) NSString                        *titleString;
@property (nonatomic, copy) NSString                        *detailString;
@property (nonatomic, copy) NSArray<VIMessageAction *>      *actions;

@property (nonatomic, copy) UIFont                          *titleFont;
@property (nonatomic, copy) UIFont                          *detailFont;
@property (nonatomic, copy) UIColor                         *titleColor;
@property (nonatomic, copy) UIColor                         *detailColor;
@property (nonatomic, assign) NSInteger                     padding;

@property (nonatomic, assign) CGFloat                       preferredMaxLayoutWidth;
@property (nonatomic, strong) UILabel                       *labelView;
@property (nonatomic, assign) CGFloat                       toolBarHeight;
@property (nonatomic, strong) UIToolbar                     *toolBar;
@end

@implementation VIContentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorFromHex:0x242424];
        CALayer *layer = self.layer;
        layer.cornerRadius = 8.;
        
        self.titleFont = [UIFont boldSystemFontOfSize:17];
        self.detailFont = [UIFont systemFontOfSize:15];
        self.titleColor = [UIColor whiteColor];
        self.detailColor = [UIColor colorFromHex:0xd0d0d0];
        self.padding = 16;
        self.toolBarHeight = 32;
        
        self.labelView = [UILabel new];
        self.labelView.numberOfLines = 100;
        [self addSubview:self.labelView];
        [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(self.padding);
            make.right.equalTo(self).offset(-self.padding);
            make.top.equalTo(self).offset(self.padding);
        }];
        
        self.toolBar = [UIToolbar new];
        [self.toolBar setBackgroundImage:[UIImage new]
                      forToolbarPosition:UIBarPositionAny
                              barMetrics:UIBarMetricsDefault];
        
        [self.toolBar setShadowImage:[UIImage new]
                  forToolbarPosition:UIToolbarPositionAny];
        
        [self addSubview:self.toolBar];
        [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(self.padding);
            make.right.equalTo(self).offset(-self.padding);
            make.top.equalTo(self.labelView.mas_bottom).offset(self.padding);
            make.height.equalTo(@(self.toolBarHeight));
            make.bottom.equalTo(self).offset(-self.padding);
        }];
    }
    
    return self;
}

- (void)setTitleString:(NSString *)titleString {
    _titleString = [titleString copy];
    
    [self updateContent];
}

- (void)setDetailString:(NSString *)detailString {
    _detailString = [detailString copy];
    
    [self updateContent];
}

- (void)setActions:(NSArray<VIMessageAction *> *)actions {
    _actions = [actions copy];
    
    [self updateContent];
}

- (NSAttributedString *)attributedString {
    NSAttributedString *string;
    
    if (self.titleString.length && self.detailString.length) {
        string = [NSAttributedString attributedStringWithString:self.titleString font:self.titleFont color:self.titleColor
                                                         string:[@"\r\n" stringByAppendingString:self.detailString] font:self.detailFont color:self.detailColor];
    }
    else if (self.titleString.length) {
        string = [NSAttributedString attributedStringWithStrings:self.titleString, self.titleFont, self.titleColor, nil];
    }
    else if (self.detailString.length) {
        string = [NSAttributedString attributedStringWithStrings:self.detailString, self.detailFont, self.detailColor, nil];
    }
    
    return string;
}

- (CGSize)intrinsicContentSize {
    CGFloat height = 0;
    
    NSAttributedString *string = [self attributedString];
    CGSize stringSize = [string boundingRectWithSize:CGSizeMake(self.preferredMaxLayoutWidth - self.padding * 2, 1024)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                             context:nil].size;
    
    height = self.padding + stringSize.height;
    
    if (self.actions.count) {
        height += (self.padding + self.toolBarHeight);
    }
    
    height += self.padding;
    return CGSizeMake(self.preferredMaxLayoutWidth, height);
}

- (void)updateContent {
    self.labelView.attributedText = [self attributedString];
    
    self.toolBar.hidden = self.actions.count == 0;
    if (self.actions.count) {
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        NSMutableArray *arr = @[flex].mutableCopy;
        
        for (VIMessageAction *action in self.actions) {
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:action.title
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(touchToolBarButton:)];
            [arr addObject:item];
        }
        
        self.toolBar.items = arr.copy;
    }
}

- (void)touchToolBarButton:(UIBarButtonItem *)item {
    for (VIMessageAction *action in self.actions) {
        if ([action.title isEqualToString:item.title]) {
            if (action.completion) {
                action.completion();
            }
            
            break;
        }
    }
    
    [self.delegate barItemClicked:item];
}

- (void)setBounds:(CGRect)bounds {
    if (self.preferredMaxLayoutWidth != CGRectGetWidth(bounds)) {
        self.preferredMaxLayoutWidth = CGRectGetWidth(bounds);
        
        [self invalidateIntrinsicContentSize];
        [self layoutSubviews];
    }
    
    [super setBounds:bounds];
}

@end

@interface VIMessageHUD () < VIContentViewDelegate >

@property (nonatomic, strong) VIBackgroundView      *backgroundView;
@property (nonatomic, strong) VIContentView         *contentView;

@property (nonatomic, strong) NSTimer               *hideTimer;

@end

@implementation VIMessageHUD

+ (VIMessageHUD *)showHudOn:(UIView *)view
                      title:(nullable NSString *)title
                    message:(nullable NSString *)message
                    actions:(nullable NSArray<VIMessageAction *> *)actions
                  delayHide:(BOOL)delayHide
                 completion:(nullable VIMessageHUDCompletionBlock)completionBlock {
    
    VIMessageHUD *hud = [self new];
    hud.contentView.titleString = title;
    hud.contentView.detailString = message;
    hud.contentView.actions = actions;
    
    [view addSubview:hud];
    [hud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    [hud showAnimated:YES];
    
    if (delayHide) {
        [hud hideAnimated:YES afterDelay:MESSAGE_DELAY_INVERTAL];
    }
    
    hud.completionBlock = completionBlock;
    
    return hud;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    
    [self setupViews];
}

- (void)setupViews {
    self.backgroundView = [VIBackgroundView new];
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.backgroundView addTarget:self
                            action:@selector(touchBackground)
                  forControlEvents:UIControlEventTouchUpInside];
    
    self.contentView = [VIContentView new];
    self.contentView.delegate = self;
    [self addSubview:self.contentView];
}

- (void)touchBackground {
    [self hideAnimated:YES];
}

- (void)showAnimated:(BOOL)animated {
    [self.backgroundView showAnimated:animated];
    
    NSInteger padding = 16;
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).offset(padding);
        make.centerX.equalTo(self);
        make.width.lessThanOrEqualTo(self).offset(-(padding * 2));
        make.width.lessThanOrEqualTo(self.mas_height);
    }];
    
    [self layoutIfNeeded];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-padding);
        make.centerX.equalTo(self);
        make.width.lessThanOrEqualTo(self).offset(-(padding * 2));
        make.width.lessThanOrEqualTo(self.mas_height);
    }];
    
    [UIView animateWithDuration:.3
                          delay:0
         usingSpringWithDamping:.7
          initialSpringVelocity:.7
                        options:0
                     animations:^{
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         if (self.completionBlock) {
                             self.completionBlock();
                         }
                     }];
}

- (void)startHideTimer:(NSTimeInterval)delay {
    [self stopHideTimer];
    
    self.hideTimer = [NSTimer scheduledTimerWithTimeInterval:delay
                                                      target:self
                                                    selector:@selector(hideTimerFire:)
                                                    userInfo:nil
                                                     repeats:NO];
}

- (void)stopHideTimer {
    if ([self.hideTimer isValid]) {
        [self.hideTimer invalidate];
    }
    
    self.hideTimer = nil;
}

- (void)hideTimerFire:(NSTimer *)timer {
    [self hideAnimated:YES];
}

- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    [self startHideTimer:delay];
}

- (void)hideAnimated:(BOOL)animated {
    [self.backgroundView hideAnimated:YES];
    
    NSInteger padding = 16;
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).offset(padding);
        make.centerX.equalTo(self);
        make.width.lessThanOrEqualTo(self).offset(-(padding * 2));
        make.width.lessThanOrEqualTo(self.mas_height);
    }];
    
    [UIView animateWithDuration:.3
                     animations:^{
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

#pragma mark - VIContentViewDelegate

- (void)barItemClicked:(UIBarButtonItem *)item {
    [self hideAnimated:YES];
}

@end
