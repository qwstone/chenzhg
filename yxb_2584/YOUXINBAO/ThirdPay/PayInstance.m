//
//  PayInstance.m
//  LotteryApp
//
//  Created by chenglibin on 16/9/1.
//  Copyright © 2016年 windo. All rights reserved.
//

#import "PayInstance.h"
#import "SPayClientWechatConfigModel.h"
#import "SPayClient.h"

static PayInstance *payInstance = nil;

@implementation PayInstance
+(PayInstance *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        payInstance = [[[self class] alloc] init];
    });
    
    return payInstance;
}


+(void)initializeWeifutongPaySDKWithWeChatAppid:(NSString *)appid
{
    SPayClientWechatConfigModel *wechatConfigModel = [[SPayClientWechatConfigModel alloc] init];
    wechatConfigModel.appScheme = appid;
    wechatConfigModel.wechatAppid = appid;
    //配置微信APP支付
    [[SPayClient sharedInstance] wechatpPayConfig:wechatConfigModel];
    UIApplication *app = [UIApplication sharedApplication];
    
    NSDictionary *dic = payInstance.launchOptions;
    [[SPayClient sharedInstance] application:app
               didFinishLaunchingWithOptions:dic];
    
}

@end
