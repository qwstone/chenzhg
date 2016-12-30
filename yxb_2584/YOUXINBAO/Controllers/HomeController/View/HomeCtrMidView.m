//
//  HomeCtrMidView.m
//  YOUXINBAO
//
//  Created by zjp on 16/2/17.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HomeCtrMidView.h"
#import "YXBJieKuanController.h"
#import "YXBJieChuController.h"
#import "YXBLoanCenterViewController.h"
#import "YXBTool.h"
#import "QCLoginOneViewController.h"
#import "StrengthsViewController.h"
#import "CSSSViewController.h"


@implementation HomeCtrMidView
#define RootViewControllerxinyongLoan [NSString stringWithFormat:@"%@webView/helpcenter/comesoon.jsp?a=1",YXB_IP_address_web]
#define RootViewControllercuishouLoan @"/webView/debt/index.jsp?a=1"
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        [self createButton];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)createView {
    
    NSLog(@"--------%f",kDeviceWidth);
    CGFloat midLIne = kDeviceWidth/640*17;
    CGFloat x = kDeviceWidth/640*30;
    CGFloat y  = kDeviceWidth/750*144+midLIne;
    if (kDeviceWidth <= 320) {
        y = kDeviceWidth/640*158;
        midLIne = kDeviceWidth/640*20;
    }
    CGFloat w = kDeviceWidth/640*282;
    CGFloat h = kDeviceWidth/640*153;
    UIButton *one = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [one addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    one.tag = 1;
    [one setBackgroundImage:[UIImage imageNamed:@"borrowone"] forState:UIControlStateNormal];
    [self addSubview:one];
    
    UIButton *two = [[UIButton alloc] initWithFrame:CGRectMake(one.right+midLIne, y, w, h)];
    [two addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    two.tag = 2;
    [two setBackgroundImage:[UIImage imageNamed:@"loantwo"] forState:UIControlStateNormal];
    [self addSubview:two];
    
    
    
//    UIButton *three = [[UIButton alloc] initWithFrame:CGRectMake(x, self.height/2+kDeviceWidth/750*10, w, h)];
//    [three addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
//    three.tag = 3;
//    [three setBackgroundImage:[UIImage imageNamed:@"threeloan"] forState:UIControlStateNormal];
//    [self addSubview:three];
    
//    UIButton *four = [[UIButton alloc] initWithFrame:CGRectMake(self.width/2+kDeviceWidth/750*10, self.height/2+kDeviceWidth/750*10, w, h)];
//    [four addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
//    four.tag = 4;
//    [four setBackgroundImage:[UIImage imageNamed:@"loanfour"] forState:UIControlStateNormal];
//    [self addSubview:four];
    
    
    
    UIButton *four = [[UIButton alloc] initWithFrame:CGRectMake(x, one.bottom+midLIne, w, h)];
    [four addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    four.tag = 4;
    [four setBackgroundImage:[UIImage imageNamed:@"loanfour"] forState:UIControlStateNormal];
    [self addSubview:four];
    
    
    UIButton *fif = [[UIButton alloc] initWithFrame:CGRectMake(four.right+midLIne, one.bottom+midLIne, kDeviceWidth/640*138, h)];
    [fif addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    fif.tag = 3;
    [fif setBackgroundImage:[UIImage imageNamed:@"daikuanfuwu"] forState:UIControlStateNormal];
    [self addSubview:fif];
    
    UIButton *six = [[UIButton alloc] initWithFrame:CGRectMake(fif.right+kDeviceWidth/640*8, one.bottom+midLIne, kDeviceWidth/640*138, h)];
    [six addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    six.tag = 6;
    [six setBackgroundImage:[UIImage imageNamed:@"cuishoufuwu"] forState:UIControlStateNormal];
    [self addSubview:six];
    
    
}

- (void)butAction:(UIButton *)button {
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.isLogin == YES) {
    }else {
        [self toLogin];
        return;
    }
    

    if (button.tag == 1) {
               if (userModel.user.accountStatus == 4)
        {
            YXBJieKuanController *controller = [[YXBJieKuanController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            [[YXBTool getCurrentNav] pushViewController:controller animated:YES];

        }
            else{
                [self ShowAlert1];
                        }

           }
    
    else if (button.tag == 2){
        if (userModel.user.accountStatus == 4)
               {
        YXBJieChuController *controller = [[YXBJieChuController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
                   
                   
        [[YXBTool getCurrentNav] pushViewController:controller animated:YES];
               }
        else{
            [self ShowAlert1];
        }
    
    }else if (button.tag == 3){
//        [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:RootViewControllerxinyongLoan params:nil] hasTopBar:YES titleName:@"借贷服务"];
        StrengthsViewController *controller = [[StrengthsViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [[YXBTool getCurrentNav] pushViewController:controller animated:YES];
    }else if (button.tag == 4){
        YXBLoanCenterViewController *loanCenterVC = [[YXBLoanCenterViewController alloc] init];
        loanCenterVC.hidesBottomBarWhenPushed = YES;
        [[YXBTool getCurrentNav] pushViewController:loanCenterVC animated:YES];
    }else if (button.tag == 6){
        if (userModel.user.accountStatus == 4)
        {
            CSSSViewController * csssVC = [[CSSSViewController alloc] init];
            csssVC.hidesBottomBarWhenPushed = YES;
            [[YXBTool getCurrentNav] pushViewController:csssVC animated:YES];
        }
        else{
             [self ShowAlert1];
        }
    }

}

- (void)createButton{
    
    CGFloat Button_Width =kDeviceWidth/750*104.0f ;   // 高
    CGFloat Button_Height =kDeviceWidth/750*110.0f;      // 宽
    CGFloat Start_X = kDeviceWidth/750*30;          // 第一个按钮的X坐标
    CGFloat Start_Y =kDeviceWidth/750*13.0f ;          // 第一个按钮的Y坐标
    CGFloat Width_Space =(kDeviceWidth-Start_X*2-Button_Width*5)/4 ;       // 2个按钮之间的横间距
    
    NSMutableArray *BtnImageArray = [NSMutableArray arrayWithObjects:
                                     @"home_BtnImg1.png",
                                     @"home_BtnImg2.png",
                                     @"home_BtnImg3.png",
                                     @"home_BtnImg4.png",
                                     @"home_BtnImg5.png",                                                                                                                nil];
    //分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(Start_X , kDeviceWidth/750*144, kDeviceWidth-Start_X*2, 1)];
    line.backgroundColor = [YXBTool colorWithHexString:@"#FFE9F1"];
    [self addSubview:line];
    
    for (int i = 0 ; i < 5; i++) {
        UIButton *home_Btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        home_Btn.frame = CGRectMake(Start_X+(Button_Width+Width_Space)*i,Start_Y,Button_Width,Button_Height);
        [home_Btn setBackgroundImage:[UIImage imageNamed:BtnImageArray[i]] forState:UIControlStateNormal];
        home_Btn.tag=i+1000;
        [home_Btn addTarget:self action:@selector(home_Btn_Action:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:home_Btn];
    }
}
- (void)home_Btn_Action:(UIButton *)button{
    
    StrengthsViewController *controller = [[StrengthsViewController alloc] init];
    controller.flagNumber=button.tag;
    controller.hidesBottomBarWhenPushed = YES;
    [[YXBTool getCurrentNav] pushViewController:controller animated:YES];
    
}
-(void)ShowAlert1
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"  您还没进行身份认证,请认证身份后再来吧！ "
                                                  delegate:self
                                         cancelButtonTitle:@"知道了"
                                         otherButtonTitles:@"去认证"
                          　　　　　　　　　　　　　　　　　　,nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex//点击弹窗按钮后
{
    NSLog(@"buttonIndex:%ld",(long)buttonIndex);
    
    if (buttonIndex == 0) {//取消
        NSLog(@"取消");
    }else if (buttonIndex == 1){//确定
        [self toAuthentication];
        NSLog(@"确定");
    }
}


//跳出登陆页面
- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    //    loginNav.navigationBar.barTintColor = rgb(231, 27, 27, 1);
    //    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    loginView.modalPresentationStyle = UIModalPresentationPopover;
    [[YXBTool getCurrentNav] presentViewController:loginNav animated:YES completion:nil ];
}

- (void)toAuthentication {

    AuthenticationViewController *authentic = [[AuthenticationViewController alloc] init];
    [[YXBTool getCurrentNav] pushViewController:authentic animated:YES];
}

@end
