//
//  NSFileManager+GF.m
//  AFNetworking
//
//  Created by 熊国锋 on 2018/4/23.
//

#import "NSFileManager+GF.h"

@implementation NSFileManager (GF)

- (unsigned long long)sizeOfFolder:(NSString *)folderPath {
    NSArray *contents = [self contentsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    
    NSString *file;
    unsigned long long folderSize = 0;
    
    while (file = [contentsEnumurator nextObject]) {
        NSString *string = [folderPath stringByAppendingPathComponent:file];
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:string error:nil];
        if ([fileAttributes[NSFileType] isEqualToString:NSFileTypeDirectory]) {
            folderSize += [self sizeOfFolder:string];
        }
        else {
            folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
        }
    }
    
    return folderSize;
}

- (NSString *)stringSizeOfFolder:(NSString *)folderPath {
    unsigned long long size = [self sizeOfFolder:folderPath];
    NSString *folderSizeStr = [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile];
    return folderSizeStr;
}

@end
