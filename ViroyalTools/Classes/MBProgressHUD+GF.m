//
//  MBProgressHUD+GF.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "MBProgressHUD+GF.h"
#import "NSBundle+GF.h"

@implementation MBProgressHUD (GF)

+ (MBProgressHUD *)showHudOn:(UIView *)view
                        mode:(MBProgressHUDMode)mode
                       image:(UIImage *)image
                     message:(NSString *)message
                   delayHide:(BOOL)delayHide
                  completion:(void (^)(void))completionBlock {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (image) {
        [hud setMode:MBProgressHUDModeCustomView];
        [hud setCustomView:[[UIImageView alloc] initWithImage:image]];
    }
    else {
        [hud setMode:mode];
    }
    hud.detailsLabel.text = message;
    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:16];
    if (delayHide) {
        [hud hideAnimated:YES afterDelay:PROGRESS_DELAY_HIDE];
    }
    
    hud.completionBlock = completionBlock;
    
    return hud;
}

+ (MBProgressHUD *)showFinishHudOn:(UIView *)view
                        withResult:(BOOL)success
                         labelText:(NSString *)labelText
                         delayHide:(BOOL)delayHide
                        completion:(void (^)(void))completionBlock {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    UIImage *image = success?[UIImage bundleImageNamed:@"ic_hud_success"]:[UIImage bundleImageNamed:@"ic_hud_fail"];
    [hud setMode:MBProgressHUDModeCustomView];
    [hud setCustomView:[[UIImageView alloc] initWithImage:image]];
    
    NSString *message = labelText;
    if (!message) {
        message = success?GFLocalizedString(@"Success", nil):GFLocalizedString(@"Failed", nil);
    }
    hud.detailsLabel.text = message;
    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:16];
    if (delayHide) {
        [hud hideAnimated:YES afterDelay:PROGRESS_DELAY_HIDE];
    }
    
    hud.completionBlock = completionBlock;
    
    return hud;
}

+ (void)finishHudWithResult:(BOOL)success
                        hud:(MBProgressHUD *)hud
                  labelText:(NSString *)labelText
                 completion:(void (^)(void))completionBlock {
    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:16];
    if (success) {
        [hud setMode:MBProgressHUDModeCustomView];
        [hud setCustomView:[[UIImageView alloc] initWithImage:[UIImage bundleImageNamed:@"ic_hud_success"]]];
        hud.detailsLabel.text = labelText?:GFLocalizedString(@"Success", nil);
    }
    else {
        [hud setMode:MBProgressHUDModeCustomView];
        [hud setCustomView:[[UIImageView alloc] initWithImage:[UIImage bundleImageNamed:@"ic_hud_fail"]]];
        hud.detailsLabel.text = labelText?:GFLocalizedString(@"Failed", nil);;
    }
    [hud hideAnimated:YES afterDelay:PROGRESS_DELAY_HIDE];
    [hud setCompletionBlock:completionBlock];
}

@end
