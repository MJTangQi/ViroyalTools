//
//  AFSecurityPolicy.h
//  AFNetworking
//
//  Created by 熊国锋 on 2017/12/19.
//

@import AFNetworking;

NS_ASSUME_NONNULL_BEGIN

@interface AFSecurityPolicy (GF)

- (nullable NSSet<NSData *> *)certificatsWithAddress:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
