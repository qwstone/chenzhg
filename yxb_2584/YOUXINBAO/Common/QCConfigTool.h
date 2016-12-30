//
//  QCConfigTool.h
//  YOUXINBAO
//
//  Created by Walice on 15/6/12.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "QCConfigTool.h"
#import "QCDeviceManager.h"
#import <sys/sysctl.h>
#import "YXBTool.h"

@interface QCConfigTool : NSObject

+(NSString*)getHostUrl;
//请求添加cookie
+(void) setHttpSystemHeaderWithRequest:(ASIHTTPRequest *)postASIRequset;

+(void)setHttpSystemHeaderWithAFNManager:(NSMutableURLRequest *)request;


//请求添加cookie
+(void)setHttpSystemHeaderWithAFHTTPRequestSerializer:(AFHTTPRequestSerializer *)request;

@end
