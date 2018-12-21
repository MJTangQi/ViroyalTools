//
//  UIDevice.m
//  AFNetworking
//
//  Created by 熊国锋 on 2017/11/9.
//

#import "UIDevice+GF.h"
#import <sys/utsname.h>

@implementation UIDevice (GF)

+ (NSString *)osPlatform {
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)osModel {
    struct utsname name;
    uname(&name);
    
    NSString *model = [NSString stringWithFormat:@"%s", name.machine];
    if ([model isEqualToString:@"iPod5,1"]) {
        return @"iPod Touch 5";
    }
    else if ([model isEqualToString:@"iPod7,1"]) {
        return @"iPod Touch 6";
    }
    else if ([model isEqualToString:@"iPhone3,1"] || [model isEqualToString:@"iPhone3,2"] || [model isEqualToString:@"iPhone3,3"]) {
        return @"iPhone 4";
    }
    else if ([model isEqualToString:@"iPhone4,1"]) {
        return @"iPhone 4s";
    }
    else if ([model isEqualToString:@"iPhone5,1"] || [model isEqualToString:@"iPhone5,2"]) {
        return @"iPhone 5";
    }
    else if ([model isEqualToString:@"iPhone5,3"] || [model isEqualToString:@"iPhone5,4"]) {
        return @"iPhone 5c";
    }
    else if ([model isEqualToString:@"iPhone6,1"] || [model isEqualToString:@"iPhone6,2"]) {
        return @"iPhone 5s";
    }
    else if ([model isEqualToString:@"iPhone7,2"]) {
        return @"iPhone 6";
    }
    else if ([model isEqualToString:@"iPhone7,1"]) {
        return @"iPhone 6 Plus";
    }
    else if ([model isEqualToString:@"iPhone8,1"]) {
        return @"iPhone 6s";
    }
    else if ([model isEqualToString:@"iPhone8,2"]) {
        return @"iPhone 6s Plus";
    }
    else if ([model isEqualToString:@"iPhone9,1"] || [model isEqualToString:@"iPhone9,3"]) {
        return @"iPhone 7";
    }
    else if ([model isEqualToString:@"iPhone9,2"] || [model isEqualToString:@"iPhone9,4"]) {
        return @"iPhone 7 Plus";
    }
    else if ([model isEqualToString:@"iPhone8,4"]) {
        return @"iPhone SE";
    }
    else if ([model isEqualToString:@"iPhone10,1"] || [model isEqualToString:@"iPhone10,4"]) {
        return @"iPhone 8";
    }
    else if ([model isEqualToString:@"iPhone10,2"] || [model isEqualToString:@"iPhone10,5"]) {
        return @"iPhone 8 Plus";
    }
    else if ([model isEqualToString:@"iPhone10,3"] || [model isEqualToString:@"iPhone10,6"]) {
        return @"iPhone X";
    }
    else if ([model isEqualToString:@"iPhone11,8"]) {
        return @"iPhone XR";
    }
    else if ([model isEqualToString:@"iPhone11,2"]) {
        return @"iPhone XS";
    }
    else if ([model isEqualToString:@"iPhone11,6"] || [model isEqualToString:@"iPhone11,4"]) {
        return @"iPhone XS Max";
    }
    else {
        return @"Simulator";
    }
}

+ (NSString *)osVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)WiFiSSID {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        id info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        return [[ NSString alloc] initWithData:info[@"SSIDDATA"] encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}

+ (NSString *)WiFiBSSID {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        id info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        return info[@"BSSID"];
    }
    
    return nil;
}

+ (NSString *)appVersion {
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    return [info objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersion {
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    return [info objectForKey:(__bridge NSString *)kCFBundleVersionKey];
}

@end
