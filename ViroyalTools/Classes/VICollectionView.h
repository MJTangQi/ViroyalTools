//
//  VICollectionView.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VICollectionView : UICollectionView

- (CGSize)sizeForItemWithIdentifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                         fixedWidth:(CGFloat)width
                      configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration;

- (void)clearCache;

- (void)clearCacheForIndexPath:(NSIndexPath *)indexPath;

@end
