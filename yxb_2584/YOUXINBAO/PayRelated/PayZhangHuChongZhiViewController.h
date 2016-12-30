//
//  PayZhangHuChongZhiViewController.h
//  LotteryApp
//
//  Created by 程立彬 on 14-4-9.
//  Copyright (c) 2014年 windo. All rights reserved.
//

//#import "CPBaseViewController.h"
#import "QCBaseViewController.h"
#import "PayHomeViewController.h"
//#import "UPPayPluginDelegate.h"
#import "UPPaymentControl.h"
#import "PayModel.h"
#import "LLPaySdk.h"
#import "PayModeModel.h"
#import "HttpOperator.h"
#import "UserManager.h"


//易宝.a文件只支持真机编译
#if TARGET_IPHONE_SIMULATOR //模拟器
@interface PayZhangHuChongZhiViewController : QCBaseViewController<UITextFieldDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate,LLPaySdkDelegate>
#elif TARGET_OS_IPHONE      //真机
#import "PayEaseComPayment.h"
#import "PMCRequest.h"
#import "PMCHmacmd5AndDescrypt.h"
#import "PMCMakeOrderInfo.h"
#import "PMCProgressViewHUD.h"
//下单 易宝 支付
#define kBaseIP @"https://pay.yizhifubj.com"
#define   kOrderUrl    [NSString stringWithFormat:@"%@%@", kBaseIP, @"/customer/gb/pay_mobile_payment_direct.jsp"]
@interface PayZhangHuChongZhiViewController : QCBaseViewController<UITextFieldDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate,LLPaySdkDelegate,PMCRequestDelegate, PayEaseComPaymentDelegate>{
    NSString *_orderMd5Info;
    NSString *_shanghuhao;//商户号
}

@property (nonatomic, strong) PMCRequest *orderRequest;
@property (nonatomic, strong) PayEaseComPayment *payeaseComPayment;
@property (nonatomic, strong) PMCProgressViewHUD *progressHUD;
#endif



@property (retain, nonatomic) HttpOperator* iHttpOperator;

@property(nonatomic,assign)int          isNew;//是否已参加，有两种情况 ==1是已参加 == 2未参加
@property(nonatomic,assign)Pay_Mode     payMode;
//@property (nonatomic,assign)SEL         result;//这里声明为属性方便在于外部传入。
@property(nonatomic,retain)PayModel*    payModel;//是否参与活动相关信息
@property(nonatomic,retain)PayModeModel *payModeModel;//银行相关信息
@property(nonatomic,assign)bool isShowHuodong;//是否显示活动按钮
//-(void)paymentResult:(NSString *)originResult; //支付宝回调
-(void)requestData;
@end
