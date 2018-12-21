//
//  CommonInterface.h
//  GFCocoaTools
//
//  Created by 熊国锋 on 2018/8/10.
//  Copyright © 2018年 南京远御网络科技有限公司. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, HttpMethod) {
    HttpGet,
    HttpPost,
    HttpPut,
    HttpDelete,
    HttpHead
};

@interface CommonInterface : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (nullable NSURLSessionTask *)doWithMethod:(HttpMethod)method
                                  urlString:(NSString *)urlString
                                    headers:(NSDictionary *)headers
                                 parameters:(nullable id)parameters
                  constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))constructingBlock
                                   progress:(nullable void (^)(NSProgress *progress))progress
                                    success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

@end
