//
//  AFSecurityPolicy.m
//  AFNetworking
//
//  Created by 熊国锋 on 2017/12/19.
//

#import "AFSecurityPolicy+GF.h"
#import "NSString+GF.h"

@implementation AFSecurityPolicy (GF)

- (NSSet<NSData *> *)certificatsWithAddress:(NSString *)string {
    NSURL *url = [NSURL URLWithString:string];
    NSURL *sslFolder = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    sslFolder = [sslFolder URLByAppendingPathComponent:@"ssl" isDirectory:YES];
    if (url) {
        [[NSFileManager defaultManager] createDirectoryAtURL:sslFolder withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSString *key = [NSString stringWithFormat:@"%@.cer", [string MD5InShort]];
        NSURL *localUrl = [sslFolder URLByAppendingPathComponent:key];
        if (![[NSFileManager defaultManager] fileExistsAtPath:localUrl.path]) {
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
            
            NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:[NSURLRequest requestWithURL:url]
                                                                     progress:nil
                                                                  destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                                      return localUrl;
                                                                  }
                                                            completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                                            }];
            [task resume];
        }
    }
    
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtURL:sslFolder
                                                             includingPropertiesForKeys:nil
                                                                                options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                           errorHandler:nil];
    
    NSMutableSet *set = [NSMutableSet set];
    for (NSURL *item in enumerator) {
        NSData *data = [NSData dataWithContentsOfURL:item];
        if (data) {
            [set addObject:data];
        }
    }
    
    return set.copy;
}

@end
