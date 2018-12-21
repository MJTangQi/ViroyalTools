//
//  UIScreen+GF.h
//  GFCocoaTools
//
//  Created by guofengld on 2017/3/14.
//  Copyright © 2017年 guofengld@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIDeviceResolution)
{
    UIDeviceResolution_iPhoneStandard,      // iPhone 1,3,3GS Standard Display      (320x480px)
    UIDeviceResolution_iPhoneRetina4,       // iPhone 4,4S Retina Display 3.5"      (640x960px)
    UIDeviceResolution_iPhoneRetina5,       // iPhone 5,5s,se Retina Display 4"     (640x1136px)
    UIDeviceResolution_iPhoneRetina6,       // iPhone 6 Retina Display 4.7"         (750x1334px)
    UIDeviceResolution_iPhoneRetina6p,      // iPhone 6p,6sp Retina Display 5.5"    (1242x2208px)
    UIDeviceResolution_iPhoneRetinaX,       // iPhone X, XS, Retina Display 5.8"    (1125x2436px)
    UIDeviceResolution_iPhoneRetinaXR,      // iPhone XR, Retina Display 6.1"       (828x1792px)
    UIDeviceResolution_iPhoneRetinaXMax,    // iPhone XMax, Retina Display 6.5"     (1242x2688)
    
    UIDeviceResolution_iPadStandard,        // iPad 1,2,mini Standard Display       (1024x768px)
    UIDeviceResolution_iPadRetina,          // iPad 3 Retina Display                (2048x1536px)
    
    UIDeviceResolution_Unknown
};

@interface UIScreen (GF)

+ (UIDeviceResolution)resolution;

+ (CGSize)screenSize;

@end
