//
//  AppDelegate.m
//  YOUXINBAO
//
//  Created by CH10 on 15/3/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "QCLocalLocation.h"
//#import "RCIM.h"
//#import "YXBLockViewController.h"
//#import "YLCheckToUnlockViewController.h"
//#import "YLInitSwipePasswordController.h"

#import <ShareSDKConnector/ShareSDKConnector.h>
#import "BorrowingShellsView.h"
#import "ToUnlockView.h"
#import "LeftViewController.h"
#import "WWSideslipViewController.h"
#import "QCUserModel.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "HttpOperator.h"
#import "UserManager.h"
#import "YXBTool.h"
#import "BaiduMobStat.h"
#import "MsgCenterMgr+Public.h"
#import "YXBPaymentUtils.h"
#import "Payment_AveragePay.h"
#import "UIAlertView+Block.h"
#import "MsgCenterMgr.h"
#import "AppDelegate+Push.h"
#import "QCDeviceModel.h"
#import "QCDeviceManager.h"
#import "QCHomeDataManager.h"
#import "GuaranteeDaifuDetailViewController.h"
#import "PayForanotherViewController.h"
#import "CreditPopView.h"
#import "TwoCreditPopView.h"
#import "QCFriendsViewController.h"
#import "YXBTool.h"
#import "FMDeviceManager.h"
#import "CreditPopViewModel.h"
#import "YXBTabBarController.h"
#import "HomeViewController.h"
#import "UPPaymentControl.h"
#import "MsgCenterInstance.h"
#import"ZhifuViewController.h"
#import "MiPushSDK.h"
#import "PushSeletorStr.h"
#import "PayInstance.h"
#define AppUpdateInfoUrl @"mobile/version.jsp"


@interface AppDelegate ()<WXApiDelegate,MiPushSDKDelegate> {
    WWSideslipViewController * _slide;
    ToUnlockView *lockView;
    LeftViewController *_leftVC;
}

@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,strong)HttpOperator *iHttpOperator;

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    //cpbaotouzhu
    
    NSString* cbKey1 = @"yxbaoback://";
    NSString *yxbKey = @"utrust";
    NSLog(@"url---%@",url);
    NSLog(@"NSURL::%@",url);
    NSLog(@"sourceApplication::%@",sourceApplication);
    NSLog(@"annotation::%@",annotation);
    NSString *newUrl = [url absoluteString];
    if ([newUrl hasPrefix:YXBWeChatLoginKey]) {
        
        
        NSLog(@"has--%ld",(long)[newUrl hasPrefix:YXBWeChatLoginKey]);
        NSLog(@"has pay--%ld",(long)[YXBTool containString:@"pay" sourceString:newUrl]);

        if ([newUrl hasPrefix:YXBWeChatLoginKey] && [YXBTool containString:@"pay" sourceString:newUrl])
        {
//            微信支付的处理
            
            BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
            NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
            return  isSuc;
             
            
        }
//        //微信登录的处理
//        return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
    }

    if ([newUrl hasPrefix:YXBWeChatPayKey]) {
        
        //处理微信支付
        if ([newUrl hasPrefix:YXBWeChatPayKey] && [YXBTool containString:@"pay" sourceString:newUrl])
        {
            BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
            NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
            return  isSuc;
            
        }
        
    }

    //支付宝回调
    NSString* pay = [NSString stringWithFormat:@"%@safepay", cbKey1];
    if ([newUrl hasPrefix:@"caipiao://safepay/"] || [newUrl hasPrefix:pay]) {
        [self aliPayResult:url];
        return YES;
    }
    
    //银联回调
    if ([newUrl hasPrefix:@"uppayback://"]) {
        [self UPPayResult:url];
        return YES;
    }
    
    //浏览器跳转指定控制器
    if ([newUrl hasPrefix:yxbKey]) {
        [self jumpToDetailVCWithUrl:newUrl];
        return YES;

    }
    

    return YES;
}
-(void)registerShareSDK
{
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    
    //注册分享信息
    //    [ShareSDK registerApp:HWShareSDKAppKey];//字符串api20为您的ShareSDK的AppKey
    
    [ShareSDK registerApp:YXBShareSDKAppKey
     
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat),@(SSDKPlatformSubTypeYiXinTimeline)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
             case SSDKPlatformSubTypeYiXinTimeline:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
             case SSDKPlatformSubTypeYiXinTimeline:
                 [appInfo SSDKSetupWeChatByAppId:YXBWeChatLoginKey
                                       appSecret:YXBWeChatLoginSecret];
                 break;
             default:
                 break;
         }
     }];
    
}

-(void)jumpToDetailVCWithUrl:(NSString *)newUrl
{
    
    
    
    //----utrust://friend   跳转到好友管理
    //----utrust://loan_1   跳转到借条中心    1表示借条中心默认显示第一个栏目  依次类推2,3,4,5位借条中心对应的栏目
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel == nil || userModel.isLogin == NO) {
        NSLog(@"未登录");
        [self toLogin];
    }
    else
    {
        if ([YXBTool containString:@"friend" sourceString:newUrl]) {
            //跳转好友
            QCFriendsViewController * controller = [[QCFriendsViewController alloc]init];
            [self.rootNav pushViewController:controller animated:YES];
        }
        else if ([YXBTool containString:@"loan" sourceString:newUrl])
        {
            NSArray *tempArray = [newUrl componentsSeparatedByString:@"_"];
            if (tempArray != nil && [tempArray count] > 0) {
                NSString *loanPageId = [tempArray lastObject];
                NSInteger loanIntId = [loanPageId integerValue] - 1;
                if (loanIntId >= 0) {
                    loanPageId = [NSString stringWithFormat:@"%ld",(long)loanIntId];
                    [YXBTool typeToJump:@"myLoan" info:loanPageId];
                    
                }
                
            }
        }
        
    }

}

-(void)aliPayResult:(NSURL *)url
{
    [[AlipaySDK defaultService]
     processOrderWithPaymentResult:url
     standbyCallback:^(NSDictionary *resultDic) {
         NSLog(@"result = %@", resultDic);
         NSLog(@"memo --%@",[resultDic objectForKey:@"memo"]);
         NSString *result = [resultDic objectForKey:@"result"];
         NSInteger resultStatus = [[resultDic objectForKey:@"resultStatus"] integerValue];
         if (result) {
             switch (resultStatus) {
                 case 9000:
                 {
//                     [[self getCurrentUINavigationController] popToRootViewControllerAnimated:YES];
                   
                     [ProgressHUD showSuccessWithStatus:@"支付成功！"];
                     
//                     [self.rootNav popViewControllerAnimated:YES];
                     
                 }
                     break;
                  
                 default:
                 {
                     //交易失败
                     [ProgressHUD showErrorWithStatus:@"支付宝充值失败！"];
                     
                 }
                     break;
             }
             
         }
         else
         {
             //交易失败
             [ProgressHUD showErrorWithStatus:@"支付宝充值失败！"];
             
         }
         
         
     }];
    
}


-(void)UPPayResult:(NSURL *)url {
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        
        //结果code为成功时，先校验签名，校验成功后做后续处理
        if([code isEqualToString:@"success"]) {
            
//            //数据从NSDictionary转换为NSString
//            NSDictionary *data;
//            NSData *signData = [NSJSONSerialization dataWithJSONObject:data
//                                                               options:0
//                                                                 error:nil];
//            NSString *sign = [[NSString alloc] initWithData:signData encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",sign);
//            //判断签名数据是否存在
//            if(data == nil){
//                //如果没有签名数据，建议商户app后台查询交易结果
//                return;
//            }
            NSString* msg = [NSString stringWithFormat:@"支付成功"];
            //交易失败
            [ProgressHUD showErrorWithStatus:msg];
//            //验签证书同后台验签证书
//            //此处的verify，商户需送去商户后台做验签
//            if([self verify:sign]) {
//                //支付成功且验签成功，展示支付成功提示
//
//            }
//            else {
//                //验签失败，交易结果数据被篡改，商户app后台查询交易结果
//            }
        }
        else if([code isEqualToString:@"fail"]) {
            //交易失败
            NSString* msg = [NSString stringWithFormat:@"支付失败"];
            //交易失败
            [ProgressHUD showErrorWithStatus:msg];
        }
        else if([code isEqualToString:@"cancel"]) {
            //交易取消
            NSString* msg = [NSString stringWithFormat:@"用户取消支付"];
            //交易失败
            [ProgressHUD showErrorWithStatus:msg];
        }
    }];

}

-(void) initSysConfig
{
    NSString *file = [[YXBTool getDocumentPath] stringByAppendingPathComponent:CONFIG_FILE_PATH];
    //	NSLog(@"file＝%@",file);
    
    if([[NSFileManager defaultManager] fileExistsAtPath:file]){
        
        NSData *d;
        NSPropertyListFormat format;
        d = [NSData dataWithContentsOfFile:file];
        yxbSysConfig =	[NSPropertyListSerialization propertyListFromData:d
                                                     mutabilityOption:NSPropertyListMutableContainers
                                                               format:&format
                                                     errorDescription:nil];
        
        if ([yxbSysConfig isKindOfClass:[NSMutableDictionary class]]) {
            NSLog(@"aaaa");
        }
        else if ([yxbSysConfig isKindOfClass:[NSDictionary class]]) {
            NSLog(@"aaaa");
        }
        
        if(yxbSysConfig == nil)
        {
            yxbSysConfig = [[NSMutableDictionary alloc] init];
        }
    }
    else
        yxbSysConfig = [[NSMutableDictionary alloc] init];
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    //
    
    [self registerShareSDK];
    //同盾SDK
    // 获取设备管理器实例
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
    // 准备SDK初始化参数
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
#ifndef  __TONGDUN_XCODE_DEBUG__
    // SDK具有防调试功能，当使用xcode运行时，请取消此行注释，开启调试模式
    // 否则使用xcode运行会闪退，(但直接在设备上点APP图标可以正常运行)
    // 上线Appstore的版本，请记得删除此行，否则将失去防调试防护功能！
    [options setValue:@"allowd" forKey:@"allowd"];  // TODO
    // 指定对接同盾的测试环境，正式上线时，请删除或者注释掉此行代码，切换到同盾生产环境
    [options setValue:@"sandbox" forKey:@"env"]; // TODO
#else
#endif
    [options setValue:@"youxinbao" forKey:@"partner"];
    // 使用上述参数进行SDK初始化
    manager->initWithOptions(options);
    //自动登录
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"长度 = %ld %@",[YXBTool getFMString].length,[YXBTool getFMString]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
    //需要写在同盾之后
    [self autoLoginAction];

    
    
    
    //设置状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

//    [RCIM initWithAppKey:RongCloudAppKey deviceToken:nil];
////    [RCIM setUserInfoFetcherWithDelegate:self isCacheUserInfo:YES];
//    [RCIM setUserInfoFetcherWithDelegate:[RongChat shareRongChat] isCacheUserInfo:YES];

    //请求app更新
    [self getAppUpdateInfoRequest];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
//    if (userModel != nil && [userModel.user.yxbToken length] > 0) {
//        //连接融云服务器
//
//        [[RongChat shareRongChat] connectRongServerWithRongToken:nil];
//
//    }
    //注册分享信息
//    [ShareSDK registerApp:YXBShareSDKAppKey];//字符串api20为您的ShareSDK的AppKey
    
    /*
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:kSinaAppKey
                               appSecret:kSinaAppSecret
                             redirectUri:kSinaRedirectUri];
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:kSinaAppKey
                                appSecret:kSinaAppSecret
                              redirectUri:kSinaRedirectUri
                              weiboSDKCls:[WeiboSDK class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:kShareSDKAppKey
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:kShareSDKAppKey
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
                           wechatCls:[WXApi class]];
    */
    //注册微信支付
    [WXApi registerApp:YXBWeChatLoginKey withDescription:@"微信支付"];
    //微信登陆
//    [ShareSDK connectWeChatWithAppId:WeChatAppKey
//                           wechatCls:[WXApi class]];
//    [ShareSDK connectWeChatWithAppId:YXBWeChatLoginKey
//                           appSecret:YXBWeChatLoginSecret
//                           wechatCls: [WXApi class]];

    //推送
    if (KDeviceOSVersion >= 8.0) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    }
    else {
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
    }
#ifdef __xiaomi_or_system_push__
    //小米推送
    //    // 只启动APNs.
//    [MiPushSDK registerMiPush:self];
    [MiPushSDK registerMiPush:self type:0 connect:YES];

#endif
    
    self.iPushManager = [[PushManager alloc] init];
    
    if (launchOptions != nil) {
        //        NSLog(@"launchOptions = %@", launchOptions);
        NSDictionary* userInfo = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
        [self.iPushManager dealPushDic:userInfo appState:UIApplicationStateBackground];
    }
    
    //百度统计
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.enableExceptionLog = NO; // 是否允许截获并发送崩溃信息，请设置YES或者NO
    statTracker.channelId = CHANDLE_AK_ID;//设置您的app的发布渠道
    statTracker.logStrategy = BaiduMobStatLogStrategyAppLaunch;//根据开发者设定的时间间隔接口发送 也可以使用启动时发送策略
    statTracker.logSendInterval = 1;  //为1时表示发送日志的时间间隔为1小时
    statTracker.logSendWifiOnly = NO; //是否仅在WIfi情况下发送日志数据
    statTracker.sessionResumeInterval = 60;//设置应用进入后台再回到前台为同一次session的间隔时间[0~600s],超过600s则设为600s，默认为30s,测试时使用1S可以用来测试日志的发送。
    //    statTracker.shortAppVersion  = @"1.2"; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    statTracker.enableDebugOn = NO; //打开sdk调试接口，会有log打印
    [statTracker startWithAppId:@"1971b2c64e"];//设置您在mtj网站上添加的app的appkey


//获取地理位置信息
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    _locationManager.distanceFilter = 1000.0f;
    if (KDeviceOSVersion >= 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
    
//    // 要使用百度地图，请先启动BaiduMapManager
//    _mapManager = [[BMKMapManager alloc]init];
//    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
//    
////    BOOL ret = [_mapManager start:@"cHBkhimqH9j65IaGGxvXfdQa"  generalDelegate:nil];
//    //更新 百度 key
//    BOOL ret = [_mapManager start:YXBBaiduMapKey  generalDelegate:nil];
//
//    if (!ret) {
//        NSLog(@"manager start failed!");
//    }
    // Add the navigation controller's view to the window and display.
    
    
    [self initSysConfig];
    
    //获取IDFA
    NSString* idfa = [YXBTool getIdfa];
    if (idfa != nil && idfa.length > 0) {
        [yxbSysConfig setObject:idfa forKey:SYS_IDFA_SYSVAR_NAME];
        [YXBTool SaveSysConfig];
    }
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];


    [self showRootView];
//    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (userModel.gestureOpen) {
        [self lock];
    }
    [self.window makeKeyAndVisible];
    
//   [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self showBadgeNumber];
    
    //微付通支付使用
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [launchOptions enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [dic setObject:[obj copy] forKey:[key copy]];
    }];
    
    [PayInstance shareInstance].launchOptions = dic;


    return YES;
}



//-(void)YLCheckToUnlockDidDismiss:(YLCheckToUnlockViewController *)viewController {
//    [self showRootView];
//}
/**
 单例中保存devicetoken 为了请求header中添加devicetoken
 */

-(NSString *)savedeviceTokenInInstanceWithDeviceToken:(NSData *)deviceToken
{
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
    
    return dtokennew;
    
}
#pragma mark MiPushSDKDelegate
- (void)miPushRequestSuccWithSelector:(NSString *)selector data:(NSDictionary *)data
{
    NSLog(@"%@",[NSString stringWithFormat:@"command succ(%@): %@", [[PushSeletorStr defaultManager] getOperateType:selector], data]);
    NSLog(@"xiaomipush data---%@",data);
    
}

- (void)miPushRequestErrWithSelector:(NSString *)selector error:(int)error data:(NSDictionary *)data
{
    NSLog(@"%@",[NSString stringWithFormat:@"command error(%d|%@): %@", error, [[PushSeletorStr defaultManager] getOperateType:selector], data]);
}

- (void)miPushReceiveNotification:(NSDictionary*)data
{
    // 1.当启动长连接时, 收到消息会回调此处
    // 2.[MiPushSDK handleReceiveRemoteNotification]
    //   当使用此方法后会把APNs消息导入到此
    NSLog(@"%@",[NSString stringWithFormat:@"XMPP notify: %@", data]);
}
- (void)showRootView {
    
    //中心控制器
//    RootViewController * rootView = [[RootViewController alloc]init];
//    self.rootNav = [[UINavigationController alloc]initWithRootViewController:rootView];
//    
//    //添加向左滑动控制器
//    LeftViewController * left = [[LeftViewController alloc]init];
//    _leftVC = left;
//    _slide = [[WWSideslipViewController alloc]initWithLeftView:left andMainView:_rootNav andRightView:nil andBackgroundImage:nil];
//    
//    //滑动速度系数
//    [_slide setSpeedf:0.8];
//    
//    //点击视图是是否恢复位置
//    _slide.sideslipTapGes.enabled = YES;
//    
//    [self.window setRootViewController:_slide];
//    HomeViewController * rootView = [[HomeViewController alloc]init];
//    self.rootNav = [[UINavigationController alloc]initWithRootViewController:rootView];
    
    //统一设置 push 返回button
    UIImage* image = [UIImage imageNamed:@"navigation_abck_.png"];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-400.f, 0) forBarMetrics:UIBarMetricsDefault];
    
    YXBTabBarController *tabbarController = [[YXBTabBarController alloc] init];
    self.rootNav = (UINavigationController *)[tabbarController.viewControllers objectAtIndex:tabbarController.selectedIndex];
    [self.window setRootViewController:tabbarController];
    [self.window makeKeyAndVisible];
    [self showLaunchView];
    
}


//显示左视图
- (void)showLeftVC {
    [_slide showLeftView];
}

//加锁
- (void)lock
{
    if (lockView == Nil) {
        lockView = [[ToUnlockView alloc]initWithFrame:self.window.bounds];
        lockView.nav = self.rootNav;
    }
    [lockView show];
}



#pragma mark - CLLocationManager delegate
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    QCLocalLocation *location = [QCLocalLocation shareInstance];
    location.longitude = newLocation.coordinate.longitude;
    location.latitude = newLocation.coordinate.latitude;
    
    //停止定位
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"未打开位置服务");
}


- (void)showLaunchView
{
    UIImageView *launchView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    launchView.tag = 12345;
    NSString *imgStr = nil;
    if (kDeviceHeight == 480) {
        imgStr = @"640x960";
    }else if (kDeviceHeight == 568){
            imgStr = @"640x1136";
    }else if (kDeviceHeight == 667){
        imgStr = @"750x1334";
    }else if (kDeviceWidth > 375){
        imgStr = @"1242x2208";
    }else{
        imgStr = @"1242x2208";
    }
    
    launchView.image = [UIImage imageNamed:imgStr];
    [self.window addSubview:launchView];
    
    [self performSelector:@selector(dismissLaunchView:) withObject:launchView afterDelay:2];
    
}

- (void)dismissLaunchView:(UIImageView *)imgView
{
    [UIView animateWithDuration:1.0f animations:^{
        imgView.alpha = 0;
    } completion:^(BOOL finished) {
        [imgView removeFromSuperview];
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    self.isInForeground = NO;
}


-(void) changeisInForeground {
    self.isInForeground = NO;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    self.isInForeground = YES;
    [self performSelector:@selector(changeisInForeground) withObject:nil afterDelay:1.0];
    NSLog(@"gesture open----%d",userModel.gestureOpen);
    if (userModel.isLogin == YES) {
        [self httpLogin];
        //调用轮询请求
        [MsgCenterInstance invokePollingRequest];
        
    }
    else
    {
        //未登录就没有手势密码了
//        [self isOpenGesture];
    }
    
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// 获取用户信息的方法。
-(void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    NSLog(@"userId****%@",userId);
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];

    RCUserInfo *userInfo = [[RCUserInfo alloc] initWithUserId:userModel.user.ryId name:userModel.user.nickname portrait:userModel.user.iconAddr];
    if ([userId isEqualToString:userModel.user.ryId]) {
         return completion(userInfo);
    }
    return completion(nil);
}
*/

-(LeftViewController *)getLeftViewController
{
    return _leftVC;
    
}
//获取rootViewController
-(RootViewController *)getRootViewController {
    return (RootViewController *)self.rootNav.topViewController;
}

/**
 *  @author chenglibin
 *
 *  返回根控制器
 *
 *  @return
 */
-(WWSideslipViewController *)getMySlidesipViewController
{
    if (_slide != nil) {
        return _slide;
    }
    
    return nil;
}



- (void)httpLogin
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AppDelegate *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_StatusCodeError) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        UserManager* _currUser = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[User class]];
        QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
        //        NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:userModel.user.pwd]]];
        NSString *blackBox = [YXBTool getFMString];
        if (userModel != nil && userModel.user.username != nil && userModel.user.pwd != nil) {
            // 获取设备管理器实例
            [_currUser userLoginWithFraudmetrix:userModel.user.username pwd:userModel.user.pwd fraudmetrixToken:blackBox];
//            [_currUser userLogin:userModel.user.username pass:userModel.user.pwd];
            
        }
//        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(User* r, int taskid) {
        if (r.errCode == 0) {
            QCUserModel * currUser = [[QCUserModel alloc]init];
            currUser.isLogin = YES;
            currUser.user = r;
            TUnreadFlagCount * unReaderCount = [[TUnreadFlagCount alloc]init];
            currUser.unreadCont = unReaderCount;
            currUser.unreadCont.lastQueryDate = @"";
            currUser.firstMessageTime = @"";
            currUser.lastMessageTime = @"";
            QCUserManager * um  = [QCUserManager sharedInstance];
            QCUserModel * oldUser = [um getLoginUser];
            if (![oldUser.user.username isEqualToString:r.username]) {
                currUser.gestureOpen = NO;
                [YXBTool setGesturePassWord:nil];
            }
            else
            {
                currUser.gestureOpen = oldUser.gestureOpen;
                
            }
            [um setLoginUser:currUser];
            
            //判断是否打开手势验证
            [this isOpenGesture];
            //            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            //            LeftViewController *leftVC = [appDelegate getLeftViewController];
            //            [leftVC refreshData];
            //            [appDelegate showLeftVC];
            
        }else{
            NSString * string = r.errString;
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:this cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            QCUserModel * currUser = [[QCUserModel alloc]init];
            currUser.isLogin = NO;
            
        }

//        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    UserManager* _currUser = (UserManager*)  [httpOperation getAopInstance:[UserManager class] returnValue:[User class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    //        NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:userModel.user.pwd]]];
    if (userModel != nil && userModel.user.username != nil && userModel.user.pwd != nil) {
        // 获取设备管理器实例
        
        // 获取设备指纹黑盒数据，请确保在应用开启时已经对SDK进行初始化，切勿在get的时候才初始化
        NSString *blackBox = [YXBTool getFMString];
        [_currUser userLoginWithFraudmetrix:userModel.user.username pwd:userModel.user.pwd fraudmetrixToken:blackBox];
//        [_currUser userLogin:userModel.user.username pass:userModel.user.pwd];
        
    }
}
//请求完成
-(void)httpLoadComplete:(User *)r{
    if (r.errCode == 0) {
        QCUserModel * currUser = [[QCUserModel alloc]init];
        currUser.isLogin = YES;
        currUser.user = r;
        TUnreadFlagCount * unReaderCount = [[TUnreadFlagCount alloc]init];
        currUser.unreadCont = unReaderCount;
        currUser.unreadCont.lastQueryDate = @"";
        currUser.firstMessageTime = @"";
        currUser.lastMessageTime = @"";
        QCUserManager * um  = [QCUserManager sharedInstance];
        QCUserModel * oldUser = [um getLoginUser];
        if (![oldUser.user.username isEqualToString:r.username]) {
            currUser.gestureOpen = NO;
            [YXBTool setGesturePassWord:nil];
        }
        else
        {
            currUser.gestureOpen = oldUser.gestureOpen;
            
        }
        [um setLoginUser:currUser];
        
        //判断是否打开手势验证
        [self isOpenGesture];
        //            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //            LeftViewController *leftVC = [appDelegate getLeftViewController];
        //            [leftVC refreshData];
        //            [appDelegate showLeftVC];
        
    }else{
        NSString * string = r.errString;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        QCUserModel * currUser = [[QCUserModel alloc]init];
        currUser.isLogin = NO;
        
    }

}
/**
 *  @author chenglibin
 *
 *  判断是否打开手势
 */
-(void)isOpenGesture
{
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    
//    BOOL isOpenGesture = [[[NSUserDefaults standardUserDefaults] objectForKey:__isGestureOpen] boolValue];
    if (userModel !=nil && userModel.gestureOpen)
    {
        lockView.unmatchCounter = 5;
        [self lock];
    }
    
    NSLog(@"gesture open----%d",userModel.gestureOpen);

}

/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
- (void)onResp:(BaseResp *)resp
{
    
    if ([resp isKindOfClass:[PayResp class]])
    {
        NSString *tipStr = nil;
        PayResp *response = (PayResp *)resp;
        switch (response.errCode)
        {
            case WXSuccess:
            {
                
//                [[self getCurrentUINavigationController] popToRootViewControllerAnimated:YES];
                
                //当前栈中是否有支付页面
                for (UIViewController* controller in [YXBTool getCurrentNav].viewControllers) {
                    if ([controller isKindOfClass:[ZhifuViewController class]]) {
                        [(ZhifuViewController*)controller showAlert];
                    }
                }
                
                [self.rootNav popToViewController:[self.rootNav.viewControllers objectAtIndex:([self.rootNav.viewControllers count] -3)] animated:YES];
//                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//                if( [[userDefaultes objectForKey:@"user111"] isEqualToString:@"111"]){
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"您已充值成功，立即支付给好友，完成借款操作吧！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//                    [alert show];
//                    
//                    
//                }
                

                tipStr = @"微信支付成功";
                            }
                break;
            case WXErrCodeUserCancel:
            {
                tipStr = @"用户点击取消并返回";
                
                break;
            }
            default:
            {
                tipStr = @"微信支付失败";
                
            }
                break;
        }
        
        NSLog(@"response.errStr:%@",response.errStr);
        [ProgressHUD showSuccessWithStatus:tipStr];
    }
}


-(void)getAppUpdateInfoRequest
{
    NSString *userTok = [YXBTool getUserToken];
    if (userTok == nil) {
        userTok = @"";
    }
    //    NSString* url = HomeHttpRequest_ADRESS;
    //    NSString *URLString = [NSString stringWithFormat:@"%@&pt=ios&userToken=%@&v=%@", url,userTok,YXB_VERSION_CODE];
    NSString *url = [YXBTool getURL:AppUpdateInfoUrl params:nil];
    NSURL *requestURL = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *postData = [@"{}" dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:requestURL];
    __weak ASIFormDataRequest *requestWeak = request;
    [QCConfigTool setHttpSystemHeaderWithRequest:request];
    [request setPostBody:[NSMutableData dataWithData:postData]];
    [request setCompletionBlock:^{
        
        if ([requestWeak.responseString length]) {
            
            //{"words":"有新版本下载请升级","needupdate":"1","url":""}
            NSError* error = nil;
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:[requestWeak.responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
            NSString *needupdate = object[@"needupdate"];
            if (needupdate != nil) {
//#warning
//                needupdate = @"1";
                if ([needupdate isEqualToString:@"1"]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"升级提示" message:object[@"words"] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                        if (buttonIndex == 1) {
                            NSString *url = object[@"url"];
                            if (url != nil) {
                                [YXBTool jumpSafariWithUrl:url];                        }

                            }
                    }];
                }
            }
            
            
        } else {
            
        }
        
    }];
    
    [request setFailedBlock:^{
    }];
    
    [request startAsynchronous];
    
}

//轮询 弹出框
- (void)showAlertViewWithdic:(NSDictionary *)dic type:(NSString *)type{
    self.lunxundic = dic;
    NSString *othermss = @"";
    if ([type isEqualToString:@"loan"]) {
        if ([dic[@"isLoaner"] isEqualToString:@"0"]) {//借款人
            othermss = @"去看看";
        }
        else if ([dic[@"isLoaner"] isEqualToString:@"1"]){//放款人
            othermss = @"帮TA渡过难关";
        }
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:dic[@"mes"] delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:othermss, nil];
        alertview.tag = 10001;
        [alertview show];
    }else if ([type isEqualToString:@"guarantee"]){
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:dic[@"mes"] delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"去看看", nil];
        alertview.tag = 10002;
        [alertview show];
    }else if ([type isEqualToString:@"rateChange"]){
        [CreditPopViewModel shareInstance].rateChange = dic;
         for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
             if ([view isKindOfClass:[TwoCreditPopView class]] || [view isKindOfClass:[CreditPopView class]] || [view isKindOfClass:[AAShareView class]]) {
                 [view removeFromSuperview];
             }
         }
//        NSDictionary* dic = @{@"newRate":@"BB", @"str1":@"已进入是新地图\n惜您的信用呵呵", @"str2":@"", @"str3":@"", @"type":@"2"};
//        NSDictionary* dic = @{@"newRate":@"BB", @"str1":@"已进入是新地图呵\n惜您的信用", @"str2":@"", @"str3":@"", @"type":@"3"};
        CreditPopView *crr = [[CreditPopView alloc] initWithcreditData:dic];
        [crr show];

    }else if ([type isEqualToString:@"scoreChange"]){
        [CreditPopViewModel shareInstance].rateChange2 = dic;
        for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([view isKindOfClass:[TwoCreditPopView class]] || [view isKindOfClass:[AAShareView class]]) {
                [view removeFromSuperview];
            }
            
        }
        if ([CreditPopViewModel shareInstance].rateChange == nil) {
            TwoCreditPopView *crrs = [[TwoCreditPopView alloc] initWithcreditData:dic];
            [crrs show];
        }

    }else if ([type isEqualToString:@"loanDetail"]){
        for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([view isKindOfClass:[BorrowingShellsView class]]) {
                [view removeFromSuperview];
            }
        }
        BorrowingShellsView *view = [[BorrowingShellsView alloc] initWithcreditData:dic];
        [view show];
        
    }

}

#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10001) {
        if (buttonIndex == 1) {
            if ([self.lunxundic[@"mode"] isEqualToString:@"1"]) {
                LoanCenterViewController *controller = [[LoanCenterViewController alloc] init];
                [self.rootNav pushViewController:controller animated:YES];
            }else if ([self.lunxundic[@"mode"] isEqualToString:@"2"]) {
                Loan *loan = [[Loan alloc] init];
                LoanOrRepayMessageViewController * messageViewController =  [[LoanOrRepayMessageViewController alloc]init];
                if ([self.lunxundic[@"isLoaner"] isEqualToString:@"0"]) {
                    messageViewController.bOrL = BORROWER;
                }
                else if ([self.lunxundic[@"isLoaner"] isEqualToString:@"1"]){
                    messageViewController.bOrL =LENDERS ;
                }
                loan.t_id = [self.lunxundic[@"loanID"] integerValue];
                loan.loanType = [self.lunxundic[@"loanQuickType"] integerValue];
                loan.loanFriendType = [self.lunxundic[@"loanFriendType"] integerValue];
                messageViewController.loan = loan;
                messageViewController.hidesBottomBarWhenPushed = YES;
                [self.rootNav pushViewController:messageViewController animated:YES];
            }
        } else {
            //如果不查看，首页，友借款页面出现小红点
            QCHomeDataManager *manger = [QCHomeDataManager sharedInstance];
            manger.ishasNewLoanMess = YES;
        }
    }else if (alertView.tag == 10002) {
        if (buttonIndex == 1) {
            if ([self.lunxundic[@"mode"] isEqualToString:@"1"]) {//担保
                //分期代付
                GuaranteeDaifuDetailViewController *ctr = [[GuaranteeDaifuDetailViewController alloc] init];
                ctr.guaranteeID = [self.lunxundic[@"dataId"] integerValue];
                ctr.hidesBottomBarWhenPushed = YES;
                [self.rootNav pushViewController:ctr animated:YES];
            }else if ([self.lunxundic[@"mode"] isEqualToString:@"2"]) {//代付
                PayForanotherViewController *ctr = [[PayForanotherViewController alloc] init];
                ctr.helpID = [self.lunxundic[@"dataId"] integerValue];
                ctr.hidesBottomBarWhenPushed = YES;
                [self.rootNav pushViewController:ctr animated:YES];
            }
        } else {

        }
    
    
    }
}

//跳出登陆页面
- (void)toLogin
{
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    //    loginNav.navigationBar.barTintColor = rgb(231, 27, 27, 1);
    //    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    loginView.modalPresentationStyle = UIModalPresentationPopover;
    [self.rootNav presentViewController:loginNav animated:YES completion:nil ];
}

//执行自动登录
-(void)autoLoginAction
{
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSLog(@"gesture open----%d",userModel.gestureOpen);
    if (userModel.isLogin == YES) {
        [self httpLogin];
        
    }

}
@end
