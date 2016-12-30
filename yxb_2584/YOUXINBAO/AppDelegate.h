//
//  AppDelegate.h
//  YOUXINBAO
//
//  Created by CH10 on 15/3/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//com.feili.quanCai
//com.365cp.game

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
//#import "BMapKit.h"
#import "PushManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LoanCenterViewController.h"
#import "Loan.h"
#import "LoanOrRepayMessageViewController.h"
@class LeftViewController;
@class WWSideslipViewController;
@class RootViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,UIAlertViewDelegate> {
//    BMKMapManager* _mapManager;
}

//是否切换到了后台
@property (assign, nonatomic) BOOL isInForeground;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController * rootNav;

@property (nonatomic,strong) PushManager *iPushManager;

//显示左视图
- (void)showLeftVC;
//获取左侧控制器
-(LeftViewController *)getLeftViewController;
//获取rootViewController
-(RootViewController *)getRootViewController;

/**
 *  @author chenglibin
 *
 *  返回根控制器
 *
 *  @return
 */
-(WWSideslipViewController *)getMySlidesipViewController;


- (void)showAlertViewWithdic:(NSDictionary *)dic type:(NSString *)type;//轮训弹框
@property(nonatomic,strong)NSDictionary *lunxundic;
@end

