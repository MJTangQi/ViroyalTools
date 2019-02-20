//
//  CommonInterface.m
//  GFCocoaTools
//
//  Created by 熊国锋 on 2018/8/10.
//  Copyright © 2018年 南京远御网络科技有限公司. All rights reserved.
//

#import "CommonInterface.h"

@implementation CommonInterface

+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    static CommonInterface *client = nil;
    dispatch_once(&onceToken, ^{
        client = [CommonInterface new];
        
        client.requestSerializer = [AFJSONRequestSerializer serializer];
        client.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    
    return client;
}

- (nullable NSURLSessionTask *)doWithMethod:(HttpMethod)method
                                  urlString:(NSString *)urlString
                                    headers:(NSDictionary *)headers
                                 parameters:(id)parameters
                  constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))constructingBlock
                                   progress:(void (^)(NSProgress * _Nonnull))progress
                                    success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                                    failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    NSArray *arr = @[@"GET", @"POST", @"PUT", @"DELETE", @"HEAD"];
    NSString *url = [NSURL URLWithString:urlString relativeToURL:self.baseURL].absoluteString;
    NSLog(@"%@ method: %@ url: %@", [self class], arr[method], url);
    NSLog(@"%@ headers: %@, parameters: %@", [self class], self.requestSerializer.HTTPRequestHeaders, parameters);
    
#define HTTP_SUCCESS_LOG    NSLog(@"%@ success with url: %@", [self class], url);
#define HTTP_FAILURE_LOG    NSLog(@"%@ failed with url: %@ error: %@", [self class], url, [error localizedDescription]);
    
    if (method == HttpPost) {
        if (constructingBlock) {
            return [self POST:urlString
                   parameters:parameters
    constructingBodyWithBlock:constructingBlock
                     progress:progress
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          HTTP_SUCCESS_LOG
                          if (success) {
                              success(task, responseObject);
                          }
                      }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          HTTP_FAILURE_LOG
                          if (failure) {
                              failure(task, error);
                          }
                      }];
        }
        else {
            return [self POST:urlString
                   parameters:parameters
                     progress:progress
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          HTTP_SUCCESS_LOG
                          if (success) {
                              success(task, responseObject);
                          }
                      }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          HTTP_FAILURE_LOG
                          if (failure) {
                              failure(task, error);
                          }
                      }];
        }
    }
    else if (method == HttpPut) {
        if (constructingBlock) {
            return [self PUT:urlString
                  parameters:parameters
   constructingBodyWithBlock:constructingBlock
                    progress:progress
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         HTTP_SUCCESS_LOG
                         if (success) {
                             success(task, responseObject);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         HTTP_FAILURE_LOG
                         if (failure) {
                             failure(task, error);
                         }
                     }];
        }
        else {
            return [self PUT:urlString
                  parameters:parameters
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         HTTP_SUCCESS_LOG
                         if (success) {
                             success(task, responseObject);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         HTTP_FAILURE_LOG
                         if (failure) {
                             failure(task, error);
                         }
                     }];
        }
    }
    else if (method == HttpDelete) {
        return [self DELETE:urlString
                 parameters:parameters
                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        HTTP_SUCCESS_LOG
                        if (success) {
                            success(task, responseObject);
                        }
                    }
                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        HTTP_FAILURE_LOG
                        if (failure) {
                            failure(task, error);
                        }
                    }];
    }
    else if (method == HttpGet) {
        return [self GET:urlString
              parameters:parameters
                progress:progress
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     HTTP_SUCCESS_LOG
                     if (success) {
                         success(task, responseObject);
                     }
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     HTTP_FAILURE_LOG
                     if (failure) {
                         failure(task, error);
                     }
                 }];
    }
    
    NSAssert(NO, @"method error");
    return nil;
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
    constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                     progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"PUT" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];
    if (serializationError) {
        if (failure) {
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *task = [self uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    [task resume];
    
    return task;
}

@end
