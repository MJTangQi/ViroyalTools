//
//  ArchiveManager.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArchiveManager : NSObject

+ (instancetype)manager;

- (void)unzipFile:(NSString *)path
      destination:(nullable NSString *)dest
      complection:(nullable void(^)(BOOL success, NSString *destination))complection;

@end

NS_ASSUME_NONNULL_END
