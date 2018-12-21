//
//  VITableView.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VITableView : UITableView

- (CGFloat)heightForRowWithIdentifier:(NSString *)identifier
                            indexPath:(NSIndexPath *)indexPath
                           fixedWidth:(CGFloat)width
                        configuration:(void (^)(__kindof UITableViewCell *cell))configuration;

- (void)clearCache;

- (void)clearCacheForIndexPath:(NSIndexPath *)indexPath;

- (void)setEmptyImage:(UIImage *)image emptyString:(NSString *)string;

@end
