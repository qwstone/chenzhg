//
//  XinYongViewController.m
//  YOUXINBAO
//
//  Created by zjp on 16/2/16.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "XinYongViewController.h"
#import "CreditConfig.h"
#import "DishonestyListViewController.h"
#import "CreditHallTuhaoListViewController.h"
#import "YXBTool.h"
#import "JSON.h"
#import "UserState.h"
#import "UserManager.h"
#import "StudentCertifyController.h"
#import "QCLoginOneViewController.h"
#import "WhiteCollarViewController.h"
#import "PayHomeViewController.h"
#import "MyOrderListController.h"
#import <MessageUI/MFMessageComposeViewController.h>
#import "StudentVerifyViewController.h"
#import "AmorOrderDetailViewController.h"
#import "LoanOrRepayMessageViewController.h"
#import "FMDeviceManager.h"

#define kNavigationBarHeight    64.0f
@interface XinYongViewController ()<UIWebViewDelegate,UIAlertViewDelegate,MFMessageComposeViewControllerDelegate>
@property (nonatomic, copy) NSString *urlStr;
@property (retain, nonatomic) HttpOperator* iHttpOperator;



@property (nonatomic, copy) NSString *mallReloadUrl;
@property (nonatomic, assign)BOOL      needReloadSelf;

@end

@implementation XinYongViewController

- (id)initWithURL:(NSString *)url
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *creditUrl = @"wap/creditmaps/index.jsp";
    self.urlStr = [YXBTool getURL:creditUrl params:nil];
    self.needReloadSelf = NO;//是否需要刷新当前页
    
    if (_titleName != nil) {
        [self setTitle:_titleName];
    }
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-kNavigationBarHeight-49)];
    self.webView.delegate = self;
    //    self.webView.scrollView.bounces = NO;
    self.webView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    
    NSLog(@"------%@",_urlStr);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    [self.view addSubview:self.webView];
    
    self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];//指定进度轮的大小
    self.activity.backgroundColor = rgb(0, 0, 0, 0.7);
    self.activity.layer.cornerRadius = 5;
    [self.activity setCenter:CGPointMake(160, 140)];//指定进度轮中心点
    self.activity.center = self.view.center;
    [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];//设置进度轮显示类型
    [self.view addSubview:self.activity];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = [request.URL absoluteString];
    NSLog(@"return value : %@",urlStr);
    if ([urlStr hasPrefix:@"yxbaoback://"]) {
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

- (void)leftClicked {
    [super leftClicked];
    [KVNProgress dismiss];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activity startAnimating];
    //        [KVNProgress show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activity stopAnimating];
    //        [KVNProgress dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activity stopAnimating];
    //    [ProgressHUD showErrorWithStatus:@"加载失败"];
    [KVNProgress showErrorWithStatus:@"加载失败"];
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
//请求成功
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


#pragma mark ----alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10010){
        if (buttonIndex == 1) {
            [self toLogin];
        }
    } else if (alertView.tag == 10086){
        if (buttonIndex == 1) {
            [self toStudenttication];
        }
    } else if (alertView.tag == 100861){
        if (buttonIndex == 1) {
            [self towhitecollartication];
        }
    }
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
    StudentVerifyViewController *stuauthentic = [[StudentVerifyViewController alloc] init];
    [self.navigationController pushViewController:stuauthentic animated:YES];
}

//白领认证
- (void)towhitecollartication {
    self.needReloadSelf = YES;
    WhiteCollarViewController *white=[[WhiteCollarViewController alloc]init];
    [self.navigationController pushViewController:white animated:YES];
}

- (void)toAuthentication {
    self.needReloadSelf = YES;
    AuthenticationViewController *authentic = [[AuthenticationViewController alloc] init];
    [self.navigationController pushViewController:authentic animated:YES];
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



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [KVNProgress dismiss];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.hidesBottomBarWhenPushed = NO;
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.isLogin == YES) {
    }else {
        [self toLogin];
    }
    if (self.needReloadSelf == YES) {
        [self.webView removeFromSuperview];
        self.webView = nil;
        if (self.webView == nil) {
            self.urlStr = [YXBTool getURL:self.mallReloadUrl params:nil];
            self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-kNavigationBarHeight)];
            self.webView.delegate = self;
            self.webView.scrollView.bounces = NO;
            self.webView.scrollView.showsHorizontalScrollIndicator = NO;
            self.webView.scrollView.showsVerticalScrollIndicator = NO;
            NSString *urlStr = [self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
            [self.view addSubview:self.webView];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
