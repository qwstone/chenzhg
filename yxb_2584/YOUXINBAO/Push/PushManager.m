//
//  PushManager.m
//  LotteryApp
//
//  Created by SKY on 13-10-25.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import "PushManager.h"
#import "AppDelegate.h"
#import "YXBTool.h"
#import "AADetailsViewController.h"
#import "YXBWebNavViewController.h"
#import "SetMessageReadManager.h"

#define GoodsDetailBaseUrl [NSString stringWithFormat:@"%@webView/goods/good.jsp?a=1",YXB_IP_ADRESS]
@implementation NSPushData

@synthesize title, param, mode;



//- (void)dealloc
//{
//    self.title = nil;
//    self.param = nil;
//    self.mode = nil;
//    [super dealloc];
//}

@end

@implementation PushManager

//@synthesize iPushDic;
@synthesize pushDicDic;
@synthesize iNSPushData;

- (id)init
{
    self = [super init];
    if (self) {
        self.iNSPushData = nil;
    }
    return self;
}

//- (void)dealloc
//{
//    self.iNSPushData = nil;
//    self.pushDicDic = nil;
//    [super dealloc];
//}

-(void) showAfter {
    [self performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld", (long)buttonIndex);
    if (buttonIndex == 0) {
        [self show];
    } else {
        NSLog(@"取消");
        
    }
}

-(void) showAlert2 {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提  示" message:self.iNSPushData.title delegate:self cancelButtonTitle:@"立即查看" otherButtonTitles:@"关闭", nil];
    [alertView show];
    //    [alertView release];
}

-(void) showAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:self.iNSPushData.title delegate:self cancelButtonTitle:@"立即查看" otherButtonTitles:@"关闭", nil];
    [alertView show];
//    [alertView release];
}

-(void) show {
    
    if (self.iNSPushData.messageID != nil) {
        [[SetMessageReadManager sharedInstance]setMessageRead:self.iNSPushData.messageID];
    }
    [YXBTool typeToJump:self.iNSPushData.mode info:self.iNSPushData.param];
    
    
//    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
//    if ([self.iNSPushData.mode isEqualToString:@"AA"]) {
////        HelpInfoViewController* tmp = [[HelpInfoViewController alloc] initWithNibName:@"HelpInfoViewController" bundle:nil];
////        tmp.htmlUrl = self.iNSPushData.param;
////        tmp.disFromPushMsg = YES;
////        CPBNavigationController *nav = [[CPBNavigationController alloc] initWithRootViewController:tmp];
////        [tmp release];
////        [SHAREDAPP.window addSubview: nav.view];
//        if (!userModel.isLogin) {
//            QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
//            UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
//            [[YXBTool getCurrentNav] presentViewController:loginNav animated:YES completion:nil ];
//            return;
//        }
//        AADetailsViewController * detailsViewController = [[AADetailsViewController alloc]init];
//        detailsViewController.activityId = [self.iNSPushData.param integerValue];
//        [[YXBTool getCurrentNav] pushViewController:detailsViewController animated:YES];
//    }else if ([self.iNSPushData.mode isEqualToString:@"TuHao"]){
//        DebtListViewController *vc = [[DebtListViewController alloc] init];
//        [[YXBTool getCurrentNav] pushViewController:vc animated:YES];
//    }else if ([self.iNSPushData.mode isEqualToString:@"Neiqian1"]){//带导航栏
//        
////        YXBWebNavViewController *webView = [[YXBWebNavViewController alloc] initWithURL:[YXBTool getURL:self.iNSPushData.param params:nil]];
////        [[YXBTool getCurrentNav] pushViewController:webView animated:YES];
//    
//        NSString *url = [YXBTool getURL:self.iNSPushData.param params:nil];
//        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"友信宝"];
//        
//    }else if ([self.iNSPushData.mode isEqualToString:@"Neiqian2"]){//不带导航栏
////        YXBWebViewController *webView = [[YXBWebViewController alloc] initWithURL:[YXBTool getURL:self.iNSPushData.param params:nil]];
////        [[YXBTool getCurrentNav] pushViewController:webView animated:YES];
//        NSString *url = [YXBTool getURL:self.iNSPushData.param params:nil];
//        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"友信宝"];
//
//        
//    }else if ([self.iNSPushData.mode isEqualToString:@"Web"]){//web浏览器
//        [YXBTool jumpSafariWithUrl:[YXBTool getURL:self.iNSPushData.param params:nil]];
//    }else if ([self.iNSPushData.mode isEqualToString:@"MyOrder"]){//我的订单详情
//        MyOrderScheduleViewController *controller = [[MyOrderScheduleViewController alloc] init];
//        controller.orderId = [self.iNSPushData.param integerValue];
//        [[YXBTool getCurrentNav] pushViewController:controller animated:YES];
//    }else if ([self.iNSPushData.mode isEqualToString:@"GoodsDetail"]){//商品详情
//        NSString *pidStr = [NSString stringWithFormat:@"pid=%@",self.iNSPushData.param];
//        NSString *url = [YXBTool getURL:GoodsDetailBaseUrl params:pidStr];
//        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"商品详情"];
//    }else if ([self.iNSPushData.mode isEqualToString:@"FundDetail"]){//资金明细 详情
//        QCCheckDetailViewController *checkVC = [[QCCheckDetailViewController alloc] init];
//        [[YXBTool getCurrentNav] pushViewController:checkVC animated:YES];
//    }
}

-(void) dealPushDic:(NSDictionary*) dic appState:(NSInteger) state {
    self.pushDicDic = dic;
    
    self.iNSPushData = [[NSPushData alloc] init];
    
    NSDictionary* d = [dic objectForKey:@"aps"];
    self.iNSPushData.title = [d objectForKey:@"alert"];
    self.iNSPushData.mode = [dic objectForKey:@"m"];
    self.iNSPushData.param = [dic objectForKey:@"p"];
    self.iNSPushData.messageID = [dic objectForKey:@"d"];
    
    
    if (self.iNSPushData.messageID != nil && [self.iNSPushData.messageID isEqualToString:@"n"]) {
        return;
    }
    
    //允许弹框的 几个type类型，其他的不弹框
    NSArray *typeArr = @[@"AA",@"TuHao",@"TuHao2",@"TuHao3",@"Neiqian1",@"Neiqian2",@"Web",@"MyOrder",@"GoodsDetail",@"FundDetail",@"Mall",@"Earning",@"Loan",@"Credit",@"order",@"loan2",@"myLoan",@"aaPay",@"aaLoan",@"loanDetail",@"loanV2"];
    if (![typeArr containsObject:self.iNSPushData.mode]) {
        return;
    }
    
//    if (UIApplicationStateInactive == state) {
//        //用户点击进入app
//        [self show];
//    }
    if (state == 10001) {
//        [self performSelector:@selector(showAfter) withObject:nil afterDelay:2.0];
        [self showAlert];
    }
    else if (UIApplicationStateBackground == state) {
        [self showAlert];
    }
    else {
        [self show];
    }
//    else {
//        [self showAlert];
//    }
    
}

@end
