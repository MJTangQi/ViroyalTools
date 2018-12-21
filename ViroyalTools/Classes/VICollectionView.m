//
//  VICollectionView.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "VICollectionView.h"
#import <objc/runtime.h>

@interface VICollectionView ()

@property (nonatomic, strong)   NSMutableArray          *cache;
@property (nonatomic, strong)   NSMutableDictionary     *tempCells;

@end

@implementation VICollectionView

- (CGSize)sizeForItemWithIdentifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath
                         fixedWidth:(CGFloat)width
                      configuration:(void (^)(__kindof UICollectionViewCell *))configuration {
    BOOL hasCache = [self hasCacheForIndexPath:indexPath];
    if (hasCache) {
        NSValue *value = [self sizeCacheForIndexPath:indexPath];
        if ([value CGSizeValue].height > 0) {
            return [value CGSizeValue];
        }
    }
    
    // has no size chche
    UICollectionViewCell *cell = [self templeCaculateCellWithIdentifier:identifier];
    configuration(cell);
    
    NSLayoutConstraint *widthConstrait;
    if (width > 0) {
        widthConstrait = [NSLayoutConstraint constraintWithItem:cell.contentView
                                                      attribute:NSLayoutAttributeWidth
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:nil
                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                     multiplier:1.
                                                       constant:width];
        [cell.contentView addConstraint:widthConstrait];
    }
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    if (widthConstrait) {
        [cell.contentView removeConstraint:widthConstrait];
    }
    
    //for the separate line
    size.height += .5;
    
    NSValue *value = [NSValue valueWithCGSize:size];
    NSMutableArray *arr = self.cache[indexPath.section];
    if (hasCache) {
        [arr replaceObjectAtIndex:indexPath.row withObject:value];
    }
    else {
        //防止是从最后面刷新的
        while ([arr count] < indexPath.row) {
            [arr addObject:[NSValue valueWithCGSize:CGSizeMake(0, 0)]];
        }
        
        [arr insertObject:value atIndex:indexPath.row];
    }
    
    return size;
}

- (void)clearCache {
    [self.cache removeAllObjects];
}

- (void)clearCacheForIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *section;
    if (indexPath.section < [self.cache count]) {
        section = self.cache[indexPath.section];
    }
    
    if (indexPath.row < [section count]) {
        [section replaceObjectAtIndex:indexPath.row withObject:@0];
    }
}

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    [super registerClass:cellClass forCellWithReuseIdentifier:identifier];
    
    UICollectionViewCell *cell = [[cellClass alloc] initWithFrame:CGRectZero];
    self.tempCells[identifier] = cell;
}

- (void)reloadData {
    [self.cache removeAllObjects];
    [super reloadData];
}

- (NSMutableArray *)cache {
    if (!_cache) {
        _cache = [NSMutableArray new];
    }
    
    return _cache;
}

- (NSMutableDictionary *)tempCells {
    if (!_tempCells) {
        _tempCells = [NSMutableDictionary new];
    }
    
    return _tempCells;
}

- (id)templeCaculateCellWithIdentifier:(NSString *)identifier {
    NSMutableDictionary *templeCells = self.tempCells;
    id cell = [templeCells objectForKey:identifier];
    if (cell == nil) {
        NSDictionary *cellNibDict = [self valueForKey:@"_cellNibDict"];
        UINib *cellNIb = cellNibDict[identifier];
        cell = [[cellNIb instantiateWithOwner:nil options:nil] lastObject];
        templeCells[identifier] = cell;
    }
    
    return cell;
}

#pragma mark - cache methods

- (BOOL)hasCacheForIndexPath:(NSIndexPath *)indexPath {
    return [self sizeCacheForIndexPath:indexPath] != nil;
}

- (NSValue *)sizeCacheForIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < [self.cache count]) {
        NSMutableArray *arr = self.cache[indexPath.section];
        if (indexPath.row < [arr count]) {
            return arr[indexPath.row];
        }
    }
    else {
        for (NSInteger index = [self.cache count]; index <= indexPath.section; index++) {
            [self.cache addObject:@[].mutableCopy];
        }
    }
    
    return nil;
}

@end
