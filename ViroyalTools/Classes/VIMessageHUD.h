//
//  VIMessageHUD.h
//  AFNetworking
//
//  Created by 熊国锋 on 2018/7/18.
//

#import <UIKit/UIKit.h>

typedef void (^VIMessageHUDCompletionBlock)(void);

@interface VIMessageAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title completion:(VIMessageHUDCompletionBlock)completion;

@end

@interface VIMessageHUD : UIView

@property (nonatomic, copy) VIMessageHUDCompletionBlock     completionBlock;

+ (VIMessageHUD *)showHudOn:(UIView *)view
                      title:(nullable NSString *)title
                    message:(nullable NSString *)message
                    actions:(nullable NSArray<VIMessageAction *> *)actions
                  delayHide:(BOOL)delayHide
                 completion:(nullable VIMessageHUDCompletionBlock)completionBlock;

- (void)hideAnimated:(BOOL)animated;

@end
