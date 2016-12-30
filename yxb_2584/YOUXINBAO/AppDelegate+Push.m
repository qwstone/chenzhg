//
//  AppDelegate+AppDelegate_Push.m
//  YOUXINBAO
//
//  Created by CH10 on 15/7/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AppDelegate+Push.h"
#import "YXBTool.h"
#import "QCDeviceManager.h"
#import "MsgCenterMgr+Public.h"
#import "MiPushSDK.h"
@implementation AppDelegate (Push)

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //    [PFPush handlePush:userInfo];
    
    NSLog(@"%@", userInfo);
#ifdef __xiaomi_or_system_push__
    //UIApplicationState state = application.applicationState;
    NSLog(@"push userInfo---%@",[NSString stringWithFormat:@"APNS notify: %@", userInfo]);
    //    [ProgressHUD showSuccessWithStatus:@"receive"];
    // 当同时启动APNs与内部长连接时, 把两处收到的消息合并. 通过miPushReceiveNotification返回
    [MiPushSDK handleReceiveRemoteNotification:userInfo];
#endif
    if (self.isInForeground == YES) {
        [self.iPushManager dealPushDic:userInfo appState:10002];
    }
    else {
        [self.iPushManager dealPushDic:userInfo appState:10001];
    }
    
    
    
    
}


- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings NS_AVAILABLE_IOS(8_0) {
    //测试代码
    //     [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1000];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error  {
    NSLog(@"error");
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    if(deviceToken == NULL)
    return;
    NSString *dtoken = [NSString stringWithFormat:@"%@",deviceToken];
    NSMutableString *dtokennew = [NSMutableString stringWithString:dtoken];
    
    [dtokennew deleteCharactersInRange:NSMakeRange(0, 1)];//去掉<
    [dtokennew deleteCharactersInRange:NSMakeRange([dtokennew length]-1, 1)];//去掉>
    //
    NSLog(@"dtoken = %@", dtoken);
    NSString *search = @" ";
    NSString *replace = @"";
    NSRange subRange;
    subRange = [dtokennew rangeOfString:search];//搜索@" "把大空格替换成@""
    
    while (subRange.location != NSNotFound) {
        [dtokennew replaceCharactersInRange:subRange
                                 withString:replace];
        subRange = [dtokennew rangeOfString:search];
    }
    
    QCDeviceModel *dm = [[QCDeviceManager sharedInstance] getDevieModel];
    dm.deviceToken = dtokennew;
    [[QCDeviceManager sharedInstance] setPhoneDeviceModel:dm];
    //存储deviceToken
    [yxbSysConfig setObject:dtokennew forKey:PUSH_DEVICE_TOKEN_SYSVAR_NAME];
    NSLog(@"------------------------------------dtokennew = %@ ", dtokennew);
    [YXBTool SaveSysConfig];
    NSLog(@"deviceToken : %@",[deviceToken debugDescription]);
    //单例中保存deviceToken

#ifdef __xiaomi_or_system_push__
    // 注册APNS成功, 注册deviceToken
    [MiPushSDK bindDeviceToken:deviceToken];
    [MiPushSDK setAlias:dtokennew];//设置别名
#endif
}


-(void) showBadgeNumber {
    
    NSString* num = [[MsgCenterMgr sharedInstance] newMessageNumber];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = [num integerValue];
}



@end
