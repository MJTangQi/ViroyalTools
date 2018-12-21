//
//  ArchiveManager.m
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import "ArchiveManager.h"
#import <SSZipArchive/SSZipArchive.h>

@interface ArchiveManager ()

@end

@implementation ArchiveManager

+ (instancetype)manager
{
    static ArchiveManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ArchiveManager alloc] init];
    });
    
    return _sharedClient;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)unzipFile:(NSString *)path
      destination:(NSString *)dest
      complection:(void (^)(BOOL, NSString * _Nonnull))complection {
    
    NSString *destination = dest;
    if (!destination) {
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
        destination = url.path;
    }

    [SSZipArchive unzipFileAtPath:path
                    toDestination:destination
                  progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {
                  }
                completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nonnull error) {
                    if (complection) {
                        complection(succeeded, destination);
                    }
                }];
}

@end
