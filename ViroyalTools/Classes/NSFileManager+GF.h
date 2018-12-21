//
//  NSFileManager+GF.h
//  AFNetworking
//
//  Created by 熊国锋 on 2018/4/23.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (GF)

- (unsigned long long)sizeOfFolder:(NSString *)folderPath;

- (NSString *)stringSizeOfFolder:(NSString *)folderPath;

@end
