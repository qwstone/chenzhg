//
//  QCConfigTool.m
//  YOUXINBAO
//
//  Created by Walice on 15/6/12.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//


@implementation QCConfigTool
//获取域名地址

+(NSString*)getHostUrl
{
    NSString* res = @"https://www.51jt.com/";
    
    res = [self forTest];
#ifndef  __OFFICIAL_SERVER_DEBUG__
//    res = @"https://60.195.254.33:8083/";
    res = @"https://test.51jt.com/";
#else
//    res =  @"http://www.51jt.com/";
#endif
//    res = @"http://60.195.254.42:8083/";
    return res;
}


+(NSString *)forTest
{
//     测试用
     NSString* res = @"https://www.51jt.com/";

     NSString *ip = [[NSUserDefaults standardUserDefaults] objectForKey:TestIpAddressKey];
     NSString *port = [[NSUserDefaults standardUserDefaults] objectForKey:TestIpPortKey];
    
     if (ip != nil && port != nil && [port length] > 2) {
     res = [NSString stringWithFormat:@"https://%@:%@/",ip,port];
     }
     else
     {
     //        [ProgressHUD showSuccessWithStatus:@"自定义ip 端口"];
     }
    
    return res;
    
}

//请求添加cookie
+(void)setHttpSystemHeaderWithRequest:(ASIHTTPRequest *)postASIRequset
{
    if (postASIRequset == nil) {
        return;
    }
    
    NSString *userToken = [YXBTool getUserToken];
    [postASIRequset addRequestHeader:userToken value:@"x-HWUserToken"];

    [postASIRequset addRequestHeader:userToken value:@"application/x-www-form-urlencoded;charset=utf-8"];
    
    //    [self.postASIRequset addRequestHeader:@"Content-Type" value:@"application/json"];
    [postASIRequset addRequestHeader:@"x-phoneType" value:@"ios"];
    
    [postASIRequset addRequestHeader:@"x-osVersion" value:[[UIDevice currentDevice] systemVersion]];
    [postASIRequset addRequestHeader:@"x-phoneModel" value:[self platformString]];
    [postASIRequset addRequestHeader:@"x-version" value:YXB_VERSION_CODE];
    
    [postASIRequset addRequestHeader:@"x-YxbCookie" value:[YXBTool getYxbCookie]];


    
//    if ([yxbSysConfig objectForKey:SYS_IDFA_SYSVAR_NAME] != nil)
//    {
        QCDeviceModel *deviceModel = [[QCDeviceManager sharedInstance] getDevieModel];
        if (deviceModel != nil) {
            NSString *idfa = deviceModel.idfa;
            if (idfa == nil) {
                idfa = @"";
            }
            [postASIRequset addRequestHeader:@"x-idfa" value:idfa];
            
            NSString *deviceToken = deviceModel.deviceToken;
            if (deviceToken == nil) {
                deviceToken = @"";
            }
            [postASIRequset addRequestHeader:@"x-deviceToken" value:deviceToken];

        }


//    }
    
//    if ([yxbSysConfig objectForKey:MAC_ADDRESS_MD5_SYSVAR_NAME] != nil) {
//        NSString* md5 = [yxbSysConfig objectForKey:MAC_ADDRESS_MD5_SYSVAR_NAME];
//        [postASIRequset addRequestHeader:@"x-mac" value:md5];
//    }
    
    //    if ([yxbSysConfig objectForKey:PUSH_DEVICE_TOKEN_SYSVAR_NAME] != nil) {
    //        NSString* token = [yxbSysConfig objectForKey:PUSH_DEVICE_TOKEN_SYSVAR_NAME];
    //        [self.postASIRequset addRequestHeader:@"x-token" value:token];
    //    }
    
    
#ifdef CPB_AK_NUM
    [postASIRequset addRequestHeader:@"x-ak" value:CPB_AK_NUM];
#endif
}



// httpoperator  调用  和下面两种都需要
+(void)setHttpSystemHeaderWithAFNManager:(NSMutableURLRequest *)request
{
    if (request == nil) {
        return;
    }
    
    NSString *userToken = [YXBTool getUserToken];
    [request setValue:userToken forHTTPHeaderField:@"x-HWUserToken"];

    [request setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"ios" forHTTPHeaderField:@"x-phoneType"];
    [request setValue:[self platformString] forHTTPHeaderField:@"x-phoneModel"];
    [request setValue:YXB_VERSION_CODE forHTTPHeaderField:@"x-version"];
    [request setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"x-osVersion"];

    [request setValue:[YXBTool getYxbCookie] forHTTPHeaderField:@"x-YxbCookie"];

    QCDeviceModel *deviceModel = [[QCDeviceManager sharedInstance] getDevieModel];
    if (deviceModel != nil) {
        NSString *idfa = deviceModel.idfa;
        if (idfa == nil) {
            idfa = @"";
        }
        [request setValue:idfa forHTTPHeaderField:@"x-idfa"];
        
        NSString *deviceToken = deviceModel.deviceToken;
        if (deviceToken == nil) {
            deviceToken = @"";
        }
        [request setValue:deviceToken forHTTPHeaderField:@"x-deviceToken"];
        
    }

#ifdef CPB_AK_NUM
    //    [postASIRequset addRequestHeader:@"x-ak" value:CPB_AK_NUM];
#endif
}

// afn单例方式添加调用  和上面两种都需要

+(void)setHttpSystemHeaderWithAFHTTPRequestSerializer:(AFHTTPRequestSerializer *)request
{
    if (request == nil) {
        return;
    }
    [request setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"ios" forHTTPHeaderField:@"x-phoneType"];
    [request setValue:[self platformString] forHTTPHeaderField:@"x-phoneModel"];
    [request setValue:YXB_VERSION_CODE forHTTPHeaderField:@"x-version"];
    [request setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"x-osVersion"];
    
    [request setValue:[YXBTool getYxbCookie] forHTTPHeaderField:@"x-YxbCookie"];
    
    QCDeviceModel *deviceModel = [[QCDeviceManager sharedInstance] getDevieModel];
    if (deviceModel != nil) {
        NSString *idfa = deviceModel.idfa;
        if (idfa == nil) {
            idfa = @"";
        }
        [request setValue:idfa forHTTPHeaderField:@"x-idfa"];
        
        NSString *deviceToken = deviceModel.deviceToken;
        if (deviceToken == nil) {
            deviceToken = @"";
        }
        [request setValue:deviceToken forHTTPHeaderField:@"x-deviceToken"];
        
    }
    
#ifdef CPB_AK_NUM
    //    [postASIRequset addRequestHeader:@"x-ak" value:CPB_AK_NUM];
#endif
}


//获取手机型号
+ (NSString *)platformString
{
    // Gets a string with the device model
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine); 

    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad mini 2G (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad mini 2G (Cellular)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return platform;
}

@end
