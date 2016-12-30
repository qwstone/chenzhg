//
//  QCGetDeviceInfo.m
//  YOUXINBAO
//
//  Created by 张淼 on 14/12/4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCGetDeviceInfo.h"

#import "sys/utsname.h"

@implementation QCGetDeviceInfo

+ (NSString *)getDeviceVersionInfo
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithFormat:@"%s", systemInfo.machine];
    
    return platform;
}

+ (NSString *)correspondVersion
{
    NSString *correspondVersion = [self getDeviceVersionInfo];
    
    if ([correspondVersion isEqualToString:@"i386"])        return@"Simulator";
    if ([correspondVersion isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([correspondVersion isEqualToString:@"iPhone1,1"])   return@"iPhone 1";
    if ([correspondVersion isEqualToString:@"iPhone1,2"])   return@"iPhone 3";
    if ([correspondVersion isEqualToString:@"iPhone2,1"])   return@"iPhone 3S";
    if ([correspondVersion isEqualToString:@"iPhone3,1"] || [correspondVersion isEqualToString:@"iPhone3,2"])   return@"iPhone 4";
    if ([correspondVersion isEqualToString:@"iPhone4,1"])   return@"iPhone 4S";
    if ([correspondVersion isEqualToString:@"iPhone5,1"] || [correspondVersion isEqualToString:@"iPhone5,2"])   return @"iPhone 5";
    if ([correspondVersion isEqualToString:@"iPhone5,3"] || [correspondVersion isEqualToString:@"iPhone5,4"])   return @"iPhone 5C";
    if ([correspondVersion isEqualToString:@"iPhone6,1"] || [correspondVersion isEqualToString:@"iPhone6,2"])   return @"iPhone 5S";
    if ([correspondVersion isEqualToString:@"iPhone7,1"] || [correspondVersion isEqualToString:@"iPhone7,2"])   return @"iPhone 6Plus";

    
    if ([correspondVersion isEqualToString:@"iPod1,1"])     return@"iPod Touch 1";
    if ([correspondVersion isEqualToString:@"iPod2,1"])     return@"iPod Touch 2";
    if ([correspondVersion isEqualToString:@"iPod3,1"])     return@"iPod Touch 3";
    if ([correspondVersion isEqualToString:@"iPod4,1"])     return@"iPod Touch 4";
    if ([correspondVersion isEqualToString:@"iPod5,1"])     return@"iPod Touch 5";
    
    if ([correspondVersion isEqualToString:@"iPad1,1"])     return@"iPad 1";
    if ([correspondVersion isEqualToString:@"iPad2,1"] || [correspondVersion isEqualToString:@"iPad2,2"] || [correspondVersion isEqualToString:@"iPad2,3"] || [correspondVersion isEqualToString:@"iPad2,4"])     return@"iPad 2";
    if ([correspondVersion isEqualToString:@"iPad2,5"] || [correspondVersion isEqualToString:@"iPad2,6"] || [correspondVersion isEqualToString:@"iPad2,7"] )      return @"iPad Mini";
    if ([correspondVersion isEqualToString:@"iPad3,1"] || [correspondVersion isEqualToString:@"iPad3,2"] || [correspondVersion isEqualToString:@"iPad3,3"] || [correspondVersion isEqualToString:@"iPad3,4"] || [correspondVersion isEqualToString:@"iPad3,5"] || [correspondVersion isEqualToString:@"iPad3,6"])      return @"iPad 3";
    
    return correspondVersion;
}
@end
