//
//  YXBWebViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/5/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBWebViewController.h"
#import "YXBTool.h"
#import "CreditConfig.h"
#import "DishonestyListViewController.h"
#import "CreditHallTuhaoListViewController.h"
#import "JSON.h"
#import "UserState.h"
#import "UserManager.h"
#import "StudentCertifyController.h"
#import "PayHomeViewController.h"
#import "QCLoginOneViewController.h"
#import "WhiteCollarViewController.h"
#import "MyOrderListController.h"
#import "UIImageView+WebCache.h"
#import <MessageUI/MFMessageComposeViewController.h>
#import "StudentVerifyViewController.h"
#import "AmorOrderDetailViewController.h"
#import "LoanOrRepayMessageViewController.h"
#import "YXBProgress.h"
#import "FMDeviceManager.h"
#import "MyLoanViewController.h"

@interface YXBWebViewController ()<UIWebViewDelegate,MFMessageComposeViewControllerDelegate>
@property (nonatomic, copy) NSString *urlStr;
@property (strong, nonatomic) HttpOperator* iHttpOperator;
@property(nonatomic,strong)YXBProgress  *yxbprogress;
@property (nonatomic, copy) NSString *mallReloadUrl;
@property (nonatomic, assign)BOOL      needReloadSelf;
@end

@implementation YXBWebViewController
-(void)dealloc{
    NSLog(@"YXBWebViewController is dealloc");
}
- (id)initWithURL:(NSString *)url
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;

        self.urlStr = url;
    }
    return self;
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
//    self.navigationController.navigationBarHidden = NO;
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
       [KVNProgress dismiss];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//     self.navigationController.navigationBarHidden = YES;
    if (_titleName != nil) {
        [self setTitle:_titleName];
    }
    UIView *viewstat = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 20)];
    viewstat.backgroundColor = rgb(231, 27, 27, 1);
    [self.view addSubview:viewstat];
//    self.view.backgroundColor = rgb(217, 29, 61, 1);
    self.view.backgroundColor = rgb(255, 255, 255, 1);
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, kDeviceWidth, kDeviceHeight-20)];
//    webView.backgroundColor = rgb(0, 0, 0, 1);
//    webView.backgroundColor = rgb(217, 29, 61, 1);
    self.webView.backgroundColor = rgb(255, 255, 255, 1);
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    NSLog(@"--------%@",_urlStr);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    [self.view addSubview:self.webView];
    
    self.yxbprogress = [[YXBProgress alloc] initWithFrame:self.webView.bounds];
    [self.view addSubview:self.yxbprogress];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
//    [webView  ]
 NSLog(@"return value : %@",request.URL);
    NSString *urlStr = [request.URL absoluteString];
    NSString *newStr = [self decodeFromPercentEscapeString:urlStr];
    NSLog(@"return value : %@",newStr);
    if ([newStr hasPrefix:@"yxbaoback://"]) {
        [self leftClicked];
        return NO;
    }

    //信用大厅
    NSString* creditURL = @"credit://";
    if ([urlStr hasPrefix:creditURL]) {
        NSString* contentDic = [urlStr substringFromIndex:[creditURL length]];
        
        NSString *str = [self  decodeFromPercentEscapeString:contentDic];
        NSError* error = nil;
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",dic);
        QCBoardType creditType = [dic[@"type"] integerValue];
        if (creditType >= QCBoardTypeTuHao && creditType <= QCBoardTypeShiXin) {
            
            
            if (creditType == QCBoardTypeShiXin) {
                DishonestyListViewController *boardVCs = [[DishonestyListViewController alloc] init];
                [[YXBTool getCurrentNav] pushViewController:boardVCs animated:YES];
                
            }
            else
            {
                CreditHallTuhaoListViewController *boardVC = [[CreditHallTuhaoListViewController alloc] init];
                boardVC.type = creditType;
                [[YXBTool getCurrentNav] pushViewController:boardVC animated:YES];
                
                
            }
            
        }
        else
        {
            NSLog(@"信用大厅  type错误");
        }
        
        return NO;
        
    }
    
    
    
    //信分期
    NSString* mallURL = @"mall://";
    if ([urlStr hasPrefix:mallURL]) {
        NSString* shareDic = [urlStr substringFromIndex:[mallURL length]];
        NSString *sharestr = [self  decodeFromPercentEscapeString:shareDic];
        NSError* error1 = nil;
        NSDictionary* mallstrdic = [NSJSONSerialization JSONObjectWithData:[sharestr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error1];
        NSLog(@"%@",mallstrdic);
        self.mallReloadUrl = mallstrdic[@"url"];
        
        if ([mallstrdic[@"type"] isEqualToString:@"login"]) {
            //            UIAlertView *aletv = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有登陆，请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            //            aletv.tag = 10010;
            //            [aletv show];
            [self toLogin];
        }else if ([mallstrdic[@"type"] isEqualToString:@"student"]){
            //            UIAlertView *aletv = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有完善学生认证，去认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            //            aletv.tag = 10086;
            //            [aletv show];
            [self toStudenttication];
        }else if ([mallstrdic[@"type"] isEqualToString:@"white-collar"]){
            //            UIAlertView *aletv = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有完善白领认证，去认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            //            aletv.tag = 1008611;
            //            [aletv show];
            [self towhitecollartication];
        }else if ([mallstrdic[@"type"] isEqualToString:@"certification"]){
            //            UIAlertView *aletv = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有完善白领认证，去认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            //            aletv.tag = 1008611;
            //            [aletv show];
            [self toAuthentication];
        }
        
        return NO;
        
    }
    
    //分享
    NSString* shareURL = @"share://";
    if ([urlStr hasPrefix:shareURL]) {
        NSString* shareDic = [urlStr substringFromIndex:[shareURL length]];
        
        NSString *sharestr = [self  decodeFromPercentEscapeString:shareDic];
        NSError* error1 = nil;
        NSDictionary* sharestrdic = [NSJSONSerialization JSONObjectWithData:[sharestr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error1];
        NSLog(@"%@",sharestrdic);
        
        NSString * shareType = sharestrdic[@"type"];
        NSString * shareAddress = sharestrdic[@"link"];
        NSString * content = sharestrdic[@"desc"];
         NSString * title = sharestrdic[@"title"];
        NSString * imgUrl = sharestrdic[@"imgUrl"];
        UIImage *imgwechat = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
        if ([shareType isEqualToString:@"weChatFriend"]) {
            NSLog(@"shareAddress : %@",shareAddress);//分享地址
            NSLog(@"content : %@",content);//分享内容
            NSLog(@"name : %@",title);//分享标题
            [YXBTool shareToWeixinSessionContent:content imgName:imgwechat url:shareAddress title:title callBackBlock:^{
                
            }];
        }else if ([shareType isEqualToString:@"weChat"]) {
            NSLog(@"shareAddress : %@",shareAddress);//分享地址
            NSLog(@"content : %@",content);//分享内容
            NSLog(@"name : %@",title);//分享标题
            [YXBTool shareToWeixinTimelineContent:content imgName:imgwechat url:shareAddress title:title callBackBlock:^{
                
            }];
        }
        return NO;
        
    }
    
    //第三方登录
    NSString *loginType = @"https://thirdlogin/";
    if ([urlStr hasPrefix:loginType]) {
        urlStr = [self decodeFromPercentEscapeString:urlStr];
        NSString* shareDic = [urlStr substringFromIndex:[loginType length]];
        
        NSString *sharestr = [self  decodeFromPercentEscapeString:shareDic];
        NSError* error1 = nil;
        NSDictionary* sharestrdic = [NSJSONSerialization JSONObjectWithData:[sharestr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error1];
        NSLog(@"%@",sharestrdic);
        
        NSString *userName = sharestrdic[@"userName"];
        NSString *passWord = sharestrdic[@"passWord"];
        //        if (_delegate && [_delegate respondsToSelector:@selector(httpLoginWithUserName:pwd:)]) {
        //            if (userName != nil && passWord != nil) {
        //                [_delegate httpLoginWithUserName:userName pwd:passWord];
        //
        //            }
        //        }
        [self httpLoginWithUserName:userName pwd:passWord];
        //        [self leftClicked];
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
            
        }];
        
        return NO;
        
    }
    
    //充值
    NSString* rechargeURL = @"recharge://";
    if ([urlStr hasPrefix:rechargeURL]) {
        PayHomeViewController *payhome = [[PayHomeViewController alloc] init];
        [self.navigationController pushViewController:payhome animated:YES];
        return NO;
        
    }
    
    //我的订单
    NSString* myorderList = @"myorderlist://";
    if ([urlStr hasPrefix:myorderList]) {
        MyOrderListController *MyOrderList = [[MyOrderListController alloc] init];
        [self.navigationController pushViewController:MyOrderList animated:YES];
        return NO;
        
    }
    
    //我的订单详情
    NSString* myOrder = @"myorder://";
    if ([urlStr hasPrefix:myOrder]) {
        urlStr = [self decodeFromPercentEscapeString:urlStr];
        NSString* shareDic = [urlStr substringFromIndex:[myOrder length]];
        
        NSString *sharestr = [self decodeFromPercentEscapeString:shareDic];
        NSError* error1 = nil;
        NSDictionary* sharestrdic = [NSJSONSerialization JSONObjectWithData:[sharestr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error1];
        NSLog(@"%@",sharestrdic);
        NSString *orderID = sharestrdic[@"orderID"];//订单ID
        AmorOrderDetailViewController *detail=[[AmorOrderDetailViewController alloc]init];
        detail.orderId = [orderID integerValue];
        [self.navigationController pushViewController:detail animated:YES];
        return NO;
        
    }
    
    //我的订单详情
    NSString* loandetail = @"loandetail://";
    if ([urlStr hasPrefix:loandetail]) {
        urlStr = [self decodeFromPercentEscapeString:urlStr];
        NSString* shareDic = [urlStr substringFromIndex:[loandetail length]];
        NSString *sharestr = [self decodeFromPercentEscapeString:shareDic];
        NSError* error1 = nil;
        NSDictionary* sharestrdic = [NSJSONSerialization JSONObjectWithData:[sharestr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error1];
        NSLog(@"%@",sharestrdic);
        NSString *loanDetail = sharestrdic[@"loanDetail"];//订单ID
        [YXBTool typeToJump:@"loanDetail" info:loanDetail];
        return NO;
        
    }
    
    
    //返回首页
    NSString* backIndexPage = @"backIndexPage://";
    if ([urlStr hasPrefix:backIndexPage]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        self.tabBarController.selectedIndex = 0;
        return NO;
        
    }
    
    //查看我的借条
    NSString* seeMyLoan = @"seeMyLoan://";
    if ([urlStr hasPrefix:seeMyLoan]) {
        urlStr = [self decodeFromPercentEscapeString:urlStr];
        NSString* shareDic = [urlStr substringFromIndex:[loandetail length]];
        NSString *sharestr = [self decodeFromPercentEscapeString:shareDic];
        NSError* error1 = nil;
        NSDictionary* sharestrdic = [NSJSONSerialization JSONObjectWithData:[sharestr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error1];
        NSLog(@"%@",sharestrdic);
        NSString *loanid = sharestrdic[@"loanID"];//订单ID
        MyLoanViewController *myLoanListVC = [[MyLoanViewController alloc] init];
        myLoanListVC.loanID = [loanid integerValue];
        [self.navigationController pushViewController:myLoanListVC animated:YES];
        return NO;
        
    }
    
    //跳转到拮据中心（新）
    NSString* jumploancenter = @"jumploancenter://";
    if ([urlStr hasPrefix:jumploancenter]) {
        
        YXBLoanCenterViewController *loanCenterVC = [[YXBLoanCenterViewController alloc] init];
        loanCenterVC.hidesBottomBarWhenPushed = YES;
        [[YXBTool getCurrentNav] pushViewController:loanCenterVC animated:YES];
        return NO;
        
    }
    
    //发送短信
    NSString* smess = @"sms://";
    if ([urlStr hasPrefix:smess]) {
        NSString* smesstr = [urlStr substringFromIndex:[smess length]];
        
        NSString *sharestr = [self  decodeFromPercentEscapeString:smesstr];
        NSError* error1 = nil;
        NSDictionary* sharestrdic = [NSJSONSerialization JSONObjectWithData:[sharestr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error1];
        NSLog(@"%@",sharestrdic);
        
        NSString * phone = sharestrdic[@"phone"];//手机号
        NSString * content = sharestrdic[@"content"];//短信内容

        NSArray *arr = @[phone];
        [self sendSMS:content recipientList:arr];
        return NO;
        
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.yxbprogress show];
//    [KVNProgress show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
   [self.yxbprogress hidden];
//    [KVNProgress showSuccessWithStatus:@"加载完成"];
//    [KVNProgress dismiss];
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [ProgressHUD showErrorWithStatus:@"加载失败"];
//    [self.yxbprogress hidden];
//    [KVNProgress showErrorWithStatus:@"加载失败"];
//    [YXBTool showAlertViewWithString:@"请求失败"];
//    [self leftClicked];
}

- (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


-(void)jumpToExpertDetailWithExpertId:(NSString *)expertId expertName:(NSString *)expertName isChase:(NSString *)isChase
{
    
    
}

-(void)leftClicked
{
    self.navigationController.navigationBarHidden = NO;
    [super leftClicked];
}

//登录
- (void)toLogin {
    self.needReloadSelf = YES;
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
}

//学生认证
- (void)toStudenttication {
    self.needReloadSelf = YES;
//    StudentCertifyController *stuauthentic = [[StudentCertifyController alloc] init];
//    [self.navigationController pushViewController:stuauthentic animated:YES];
    StudentVerifyViewController *stuauthentic = [[StudentVerifyViewController alloc] init];
    [self.navigationController pushViewController:stuauthentic animated:YES];
}

//白领认证
- (void)towhitecollartication {
    self.needReloadSelf = YES;
    WhiteCollarViewController *white=[[WhiteCollarViewController alloc]init];
    [self.navigationController pushViewController:white animated:YES];
    
}

//身份证认证
- (void)toAuthentication {
    self.needReloadSelf = YES;
    AuthenticationViewController *authentic = [[AuthenticationViewController alloc] init];
    [self.navigationController pushViewController:authentic animated:YES];
}
- (void)httpLoginWithUserName:(NSString *)userName pwd:(NSString *)password
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak typeof(self) this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        [this httpLoadParams:assginHtttperator userName:userName password:password];
        
    } complete:^(User* r, int taskid) {
        
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLoadParams:(HttpOperator *)assginHtttperator userName:(NSString *)userName password:(NSString *)password{
    UserManager* _currUser = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[User class]];
    //        UITextField * userText = (UITextField *)[this.view viewWithTag:101];
    //        UITextField * login = (UITextField *)[this.view viewWithTag:102];
    //        NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:login.text]]];
//    [_currUser userLogin:userName pass:password];
    NSString *blackBox = [YXBTool getFMString];
    [_currUser userLoginWithFraudmetrix:userName pwd:password fraudmetrixToken:blackBox];
    //        [_currUser release];
    

}
//请求完成
- (void)httpLoadComplete:(User *)r{
    
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
        [self leftClicked];
    }else{
        NSString * string = r.errString;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }


}

//发送短信
#pragma mark - Message Delegate
- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    
    if([MFMessageComposeViewController canSendText])
        
    {
        
        
        controller.messageComposeDelegate = self;
        controller.body = bodyOfMessage;
        
        controller.recipients = recipients;
        
        //        [self presentModalViewController:controller animated:YES];
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}

// 处理发送完的响应结果
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if (result == MessageComposeResultCancelled) {
        NSLog(@"Message cancelled");
    }else if (result == MessageComposeResultSent) {
        //        [self showLoadingWithTitle:@"短信发送成功" imageName:@"friends_send"];
        [ProgressHUD showWithStatus:@"短信发送成功"];
        [self performSelector:@selector(hideLoading) withObject:nil afterDelay:2];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        NSLog(@"Message failed")  ;
    }
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.35f;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    transition.type = kCATransitionReveal;
//    transition.subtype = kCATransitionFromRight;
//    transition.delegate = self;
//    
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (self.needReloadSelf == YES) {
        [self.webView removeFromSuperview];
        self.webView = nil;
        if (self.webView == nil) {
            self.urlStr = [YXBTool getURL:self.mallReloadUrl params:nil];
            self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, kDeviceWidth, kDeviceHeight-20)];
            self.webView.delegate = self;
            self.webView.scrollView.bounces = NO;
            self.webView.backgroundColor = rgb(255, 255, 255, 1);
            self.webView.scrollView.showsHorizontalScrollIndicator = NO;
            self.webView.scrollView.showsVerticalScrollIndicator = NO;
            NSString *urlStr = [self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
            [self.view addSubview:self.webView];
        }
    }
}

@end
