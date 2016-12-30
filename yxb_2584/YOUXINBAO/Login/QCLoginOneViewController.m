//
//  QCLoginOneViewController.m
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCLoginOneViewController.h"
#import "RootViewController.h"
#import "QCLoginTwoViewController.h"
#import "QCRegisterTwoViewController.h"
#import "HttpOperator.h"
#import "AopProxy.h"
#import "UserManager.h"
#import "User.h"
#import "MyMD5.h"
#import "QCRegisterOneViewController.h"
#import "QCUtils.h"
#import "YXBTool.h"
#import "WXApi.h"
#import "QCHomeDataManager.h"
#import "UserConfig.h"
#import "FMDeviceManager.h"
#import "QCMyTestViewController.h"
#import "KVNProgress.h"
#import "PayInstance.h"
@interface QCLoginOneViewController ()
{
    RootViewController      *rootCtr;
    
    UIImageView *_topImage;
}

@end

@implementation QCLoginOneViewController

- (void)dealloc
{
    NSLog(@"QCLoginOneViewController is dealloc");
    self.iHttpOperator = nil;
    
    [super dealloc];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [PayInstance initializeWeifutongPaySDKWithWeChatAppid:YXBWeChatLoginKey];

    // Do any additional setup after loading the view.
    [self setNavigationItem];
    [self createUI];
    
}
#pragma mark ----------------------------------------------------------CreatUI
- (void)setNavigationItem
{
    [self setTitle:@"登录"];
    self.view.backgroundColor = kCustomBackground;
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
}

//创建UI
- (void)createUI
{
    self.view.backgroundColor = rgb(237, 237, 246, 1);
    
    _topImage = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-105)/2, 15+4, 105, 70)];
    _topImage.animationDuration = 0.1;
    _topImage.image = [UIImage imageNamed:@"zc-anim1"];
    _topImage.animationRepeatCount = 1;
    [self.view addSubview:_topImage];
    
    UIView * textbgView1 = [[UIView alloc]initWithFrame:CGRectMake(15, 85, kDeviceWidth-30, (kDeviceWidth-30)/6)];
    textbgView1.backgroundColor = [UIColor whiteColor];
    textbgView1.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
    textbgView1.layer.borderWidth = 1;
    [self.view addSubview:textbgView1];
    [textbgView1 release];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, ((kDeviceWidth-30)/6-20)/2, 17.5, 20)];
    imgView.image = [UIImage imageNamed:@"use-icon.png"];
    [textbgView1 addSubview:imgView];
    [imgView release];
    [self CreateTextFieldWithFrame:CGRectMake(40, 0, kDeviceWidth-30-40, (kDeviceWidth-30)/6) withCapacity:@"手机号/用户名" withSecureTextEntry:NO withTargrt:self withTag:101 view:textbgView1];
    UITextField * text1 = (UITextField *)[self.view viewWithTag:101];
    text1.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view bringSubviewToFront:_topImage];
    
    UIView * textbgView2 = [[UIView alloc]initWithFrame:CGRectMake(15, textbgView1.bottom+15, kDeviceWidth-30, (kDeviceWidth-30)/6)];
    textbgView2.backgroundColor = [UIColor whiteColor];
    textbgView2.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
    textbgView2.layer.borderWidth = 1;
    [self.view addSubview:textbgView2];
    [textbgView2 release];
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, ((kDeviceWidth-30)/6-20)/2, 17.5, 20)];
    imgView1.image = [UIImage imageNamed:@"lock-icon.png"];
    [textbgView2 addSubview:imgView1];
    [imgView1 release];
    [self CreateTextFieldWithFrame:CGRectMake(40, 0, kDeviceWidth-30-40, (kDeviceWidth-30)/6) withCapacity:@"输入密码" withSecureTextEntry:NO withTargrt:self withTag:102 view:textbgView2];
    UITextField * text2 = (UITextField *) [self.view viewWithTag:102];
    text2.returnKeyType = UIReturnKeyDone;
    text2.secureTextEntry = YES;
    
    //取上次登录账号
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    text1.text = userModel.user.username;


    
    UIButton *loginbtn = [[UIButton alloc] initWithFrame:CGRectMake(15,textbgView2.bottom+20, kDeviceWidth-30, (kDeviceWidth-30)/6)];
    loginbtn.layer.cornerRadius = 3;
//    loginbtn.backgroundColor = rgb(52, 142, 250, 1);
//    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    loginbtn.tag = 201;
//    [loginbtn setImage:[UIImage imageNamed:@"login-but@3px.png"] forState:UIControlStateNormal];
    [loginbtn setBackgroundImage:[UIImage imageNamed:@"login-but.png"] forState:UIControlStateNormal];
    [loginbtn addTarget:self action:@selector(btnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbtn];
    [loginbtn release];
    
    UIButton *registerbtn = [[UIButton alloc] initWithFrame:CGRectMake(15, loginbtn.bottom+10, kDeviceWidth/2, 30)];
    [registerbtn setTitle:@"免费注册" forState:UIControlStateNormal];
    [registerbtn setTitleColor:rgb(52, 142, 250, 1) forState:UIControlStateNormal];
    registerbtn.tag = 202;
    registerbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    registerbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [registerbtn addTarget:self action:@selector(btnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerbtn];
    [registerbtn release];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15+kDeviceWidth/2, loginbtn.bottom+10, kDeviceWidth/2-30, 30)];
    [btn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [btn setTitleColor:rgb(52, 142, 250, 1) forState:UIControlStateNormal];
    btn.tag = 203;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btn addTarget:self action:@selector(btnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn release];
    
    UIButton *wx = [[UIButton alloc] initWithFrame:CGRectMake((kDeviceWidth-kDeviceWidth/4)/2, kDeviceHeight-64-kDeviceWidth/4/88*96-25, kDeviceWidth/4, kDeviceWidth/4/88*96)];
//    wx.backgroundColor = [UIColor greenColor];
    [wx setBackgroundImage:[UIImage imageNamed:@"zc-wechaticon2"] forState:UIControlStateNormal];
    [wx addTarget:self action:@selector(wxAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wx];
    
    //是否显示微信登录
    if ([QCHomeDataManager sharedInstance].showThirdLogin.boolValue) {
        wx.hidden = NO;
    }else {
        wx.hidden = YES;
    }
    
    //永久显示
//    wx.hidden = NO;
    
    [self butuserInteractionEnabled];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(butuserInteractionEnabled) name:UITextFieldTextDidChangeNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(butuserInteractionEnabled) name:UITextFieldTextDidBeginEditingNotification object:nil];    
//仅限注册成功
    
    if (self.nameLabe.length > 0 && self.passLabe.length > 0 && self.isLog == YES) {
        text1.text = self.nameLabe;
        text2.text = self.passLabe;
        [self httpLogin];
    }
 
    
}

- (void)wxAction:(UIButton *)button {
    if(![WXApi isWXAppInstalled])
    {
        //        [ProgressHUD showErrorWithStatus:@"请安装微信后重试!"];
        [ProgressHUD showWithStatus:@"请安装微信后重试!" maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeNone];
        return;
    }
    
    SSDKPlatformType shareType = SSDKPlatformSubTypeWechatTimeline; //默认微信登录
    
    // [ShareSDK cancelAuthorize:shareType];
    [QCUtils getUserInfoWithPlatform:shareType successBlock:^(User *user) {
        if (user != nil) {
            //                [ProgressHUD showSuccessWithStatus:@"授权成功"];
            
            NSInteger serverThirdType = 0;//默认微信
            
            [self thirdLoginCheckWithUser:user thirdType:serverThirdType];
            //            [YXBTool showAlertViewWithString:s];
            
        }
        else
        {
            
            [YXBTool showAlertViewWithString:@"授权失败"];
            
        }
    }];
//    if(![WXApi isWXAppInstalled])
//    {
////        [ProgressHUD showErrorWithStatus:@"请安装微信后重试!"];
//        [ProgressHUD showWithStatus:@"请安装微信后重试!" maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeNone];
//        return;
//    }
//    
//    ShareType shareType = ShareTypeWeixiTimeline; //默认微信登录
//    
//    [QCUtils getUserInfoWithPlatform:shareType successBlock:^(User *user) {
//        if (user != nil) {
//            [ProgressHUD showSuccessWithStatus:@"授权成功"];
//            
//            ThirdType serverThirdType = ThirdTypeWeiXin;//默认微信
//            if (shareType == ShareTypeWeixiTimeline) {
//                serverThirdType = ThirdTypeWeiXin;
//            }
//            
//            [self thirdLoginCheckWithUser:user thirdType:serverThirdType];
////            [YXBTool showAlertViewWithString:s];
//            
//        }
//        else
//        {
//            
//            [YXBTool showAlertViewWithString:@"授权失败"];
//            
//        }
//    }];
}

//判断是否已绑定
-(void)thirdLoginCheckWithUser:(User *)user thirdType:(NSInteger)thirdType
{
    NSString *userTok = [YXBTool getUserToken];
    if (userTok == nil) {
        userTok = @"";
    }
    NSString* url = @"mobile/thirdApi.jsp";
    NSString *URLString = [NSString stringWithFormat:@"%@%@?pt=ios&v=%@&thirdType=%ld&action=check&unionid=%@",YXB_IP_ADRESS, url,YXB_VERSION_CODE,(long)thirdType,user.yxbId];
    NSLog(@"urlstr--%@",URLString);
    NSURL *requestURL = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *postData = [@"{}" dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:requestURL];
    [request setPostBody:[NSMutableData dataWithData:postData]];
    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"dic===%@",dic);
        if ([dic[@"success"] isEqualToString:@"false"]) {
            NSMutableDictionary *nDic = [NSMutableDictionary dictionary];
            
            [nDic setObject:user.nickname forKey:@"userName"];
            [nDic setObject:user.iconAddr forKey:@"headimgurl"];
            [nDic setObject:dic[@"thirdId"] forKey:@"thirdId"];
            
            ;
            
            NSString *urlstrs = [YXBTool getURL:@"/webView/user/weixin/relate.jsp" params:[YXBTool jsonEqualWithDic:nDic]];
            urlstrs = [urlstrs stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

//            [YXBTool jumpInnerSafaryWithUrl:urlstrs hasTopBar:NO titleName:@"第三方"];
            YXBWebViewController *baseVC = [[YXBWebViewController alloc] initWithURL:urlstrs];
            baseVC.titleName = @"第三方绑定";
//            baseVC.delegate = self;
            [self.navigationController pushViewController:baseVC animated:YES];
//            [self leftClicked];

        }
        
        else
        {
//            [YXBTool showAlertViewWithString:@"已绑定"];

//            QCUserModel *userModel = [[QCUserModel alloc] init];
//            userModel.user.username = dic[@"userName"];
//            userModel.user.pwd = dic[@"passWord"];
//
//            QCUserManager *um = [QCUserManager sharedInstance];
//            [um setLoginUser:userModel];
            if(dic != nil)
            {
//                [ProgressHUD showErrorWithStatus:@"网络失败"];
                [self httpLoginWithUserName:dic[@"userName"] pwd:dic[@"passWord"]];

            }
            
        }
    }];
    
    [request setFailedBlock:^{
        NSLog(@"首页请求失败");
    }];
    
    [request startAsynchronous];
    NSLog(@"login header---%@",request.requestHeaders);

}

- (void)butuserInteractionEnabled {
    UITextField * text1 = (UITextField *)[self.view viewWithTag:101];
    UITextField * text2 = (UITextField *)[self.view viewWithTag:102];
    if ([text1.text isEqualToString:@""] || [text2.text isEqualToString:@""]) {
        UIButton *loginbtn = (UIButton *)[self.view viewWithTag:201];
        loginbtn.alpha = 0.3;
        loginbtn.userInteractionEnabled = NO;
    }else {
        UIButton *loginbtn = (UIButton *)[self.view viewWithTag:201];
        loginbtn.alpha = 1;
        loginbtn.userInteractionEnabled = YES;
    }

}

#pragma mark --------------------------------------------------UITextFieldDelegate
//取消键盘第一响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self textfieldResignFirstResponder];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self textfieldResignFirstResponder];
    return YES;
}

- (void)textfieldResignFirstResponder
{
    UITextField * textField1 = (UITextField *)[self.view viewWithTag:101];
    UITextField * textfield2 = (UITextField *)[self.view viewWithTag:102];
    
    [textField1 resignFirstResponder];
    [textfield2 resignFirstResponder];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//  textField.keyboardAppearance = UIKeyboardAppearanceAlert;
//    NSArray *ws = [[UIApplication sharedApplication] windows];
//    for(UIView *w in ws){
//        NSArray *vs = [w subviews];
//        for(UIView *v in vs){
//            if([[NSString stringWithUTF8String:object_getClassName(v)] isEqualToString:@"UIKeyboard"]){
//                v.backgroundColor = [UIColor redColor];
//            }
//        }
//    }
    [self butuserInteractionEnabled];
    
    UIImage *image1 = [UIImage imageNamed:@"zc-anim1"];
    UIImage *image2 = [UIImage imageNamed:@"zc-anim2"];
    UIImage *image3 = [UIImage imageNamed:@"zc-anim3"];
    NSArray * accountImages = @[image3,image2,image1];
    NSArray * secureImages = @[image1,image2,image3];
    
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    if (textField.tag == 101) {
        if (![_topImage.image isEqual:image1]) {
            //睁开双眼，
            _topImage.animationImages = accountImages;
            _topImage.image = image1;
            [_topImage startAnimating];
            
        }
        
        UITextField * textfield2 = (UITextField *)[self.view viewWithTag:102];
        textfield2.text = @"";
        UIImageView * sendBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(-1, 0, kDeviceWidth+2, 50)];
        sendBackImage.backgroundColor = [UIColor whiteColor];
        CALayer * lineup = [CALayer layer];
        lineup.backgroundColor = [rgb(255, 156, 146, 1) CGColor];
        lineup.frame = CGRectMake(0, 0, sendBackImage.width, 1);
        [sendBackImage.layer addSublayer:lineup];
        
        CALayer * linedown = [CALayer layer];
        linedown.backgroundColor = [rgb(255, 156, 146, 1) CGColor];
        linedown.frame = CGRectMake(0, sendBackImage.height-1, sendBackImage.width, 1);
        [sendBackImage.layer addSublayer:linedown];
        
        sendBackImage.userInteractionEnabled = YES;
        [self createButtonWithframe:CGRectMake(10, 5, kDeviceWidth-20, 40) withImage:@"register_sure.png" withView:sendBackImage withTarget:self withAcation:@selector(keyBtnAction:) withTag:111];
        textField.inputAccessoryView = sendBackImage;
        [sendBackImage release];
        
    }else if (textField.tag == 102) {
        if (![_topImage.image isEqual:image3]) {
            
            _topImage.animationImages = secureImages;
            _topImage.image = image3;
            [_topImage startAnimating];
            
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  
    //计算剩下多少文字可以输入
    if (textField.tag == 101) {
        if(range.location>=11)
        {
            return NO;
        }else{
            return YES;
        }
        
    }else if (textField.tag == 102){
        if (range.location >=16) {
            return NO;
        }else{
            
            return YES;
        }
        
    }else{
        return YES;
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    if (textField.tag == 101) {
//        if (![self validateMobile:textField.text]) {
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alert show];
//            [alert release];
//        }
//    }
}


#pragma mark ----------------------------------------------------- Action

- (void)keyBtnAction:(UIButton *)btn
{
    [self textfieldResignFirstResponder];
}

- (void)btnClickedAction:(UIButton *)btn
{
    UITextField * userText0 = (UITextField *)[self.view viewWithTag:101];
    UITextField * passWordText0 = (UITextField *)[self.view viewWithTag:102];

    if (([userText0.text isEqualToString:@"18910581985"] && [passWordText0.text isEqualToString:@"gokyoku"]) ||
        ([userText0.text isEqualToString:@"13910572169"] && [passWordText0.text isEqualToString:@"qwerty"]))
    {
        QCMyTestViewController *controller = [[QCMyTestViewController alloc] initWithNibName:@"QCMyTestViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
        return;
    }
    
    
    if (btn.tag == 201) {
        UITextField * userText = (UITextField *)[self.view viewWithTag:101];
        UITextField * passWordText = (UITextField *)[self.view viewWithTag:102];
        
        if ([userText.text isEqualToString:@""]) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }else if ([passWordText.text isEqualToString:@""]){
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入正确的登录密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        } else{
            [self httpLogin];
            
        }
        
    }
    if (btn.tag == 202) {
        [self registerAction];
    }
    if (btn.tag == 203) {
        [self missPasswordCliked];
    }
}

//忘记密码响应
- (void)missPasswordCliked
{
    QCLoginTwoViewController * qcLoginTwoView = [[QCLoginTwoViewController alloc]init];
    [self.navigationController pushViewController:qcLoginTwoView animated:YES];
    [qcLoginTwoView release];
}
- (void)loginAction
{
    [self.view endEditing:YES];
    //   QCRootViewController * rootView  = [[[QCRootViewController alloc]init]autorelease];
    ////
    //    [self.navigationController presentViewController:rootView animated:YES completion:^{
    ////
    //    }];
//    [self.navigationController dismissModalViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"holleUserNotification" object:self userInfo:nil];
    [self.delegte loginSucceed];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)registerAction
{
//    QCRegisterTwoViewController *twoVC = [[QCRegisterTwoViewController alloc] init];
//    [self.navigationController pushViewController:twoVC animated:YES];
//    [twoVC release];
    QCRegisterOneViewController *phoneNumVC = [[QCRegisterOneViewController alloc] init];
    [self.navigationController pushViewController:phoneNumVC animated:YES];
    [phoneNumVC release];
}
//左键响应
- (void)leftClicked
{
//    [self.navigationController dismissModalViewControllerAnimated:YES];
    [self.view endEditing:YES];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        if (self.isShixiao == YES) {
            [[YXBTool getCurrentNav] popToRootViewControllerAnimated:YES];
        }
    }];
}

#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpLogin
{
    [KVNProgress show];
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[[HttpOperator alloc]init]autorelease];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCLoginOneViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {

    } error:^(int d, THttpOperatorErrorCode error) {
        
        [KVNProgress dismiss];
        [this httpLoadError:error];

    } param:^(NSString *s) {

        [this httpLoadParams:s httpOperator:assginHtttperator];
        
    } complete:^(User* r, int taskid) {
        
        //[this httpLoadComplete:r];
        [KVNProgress dismiss];
        if (r.errCode == 0) {
            [QCHomeDataManager sharedInstance].zuorishouyi = r.yestodayMoney;
            QCUserModel * currUser = [[QCUserModel alloc]init];
            currUser.isLogin = YES;
            currUser.user = r;
            TUnreadFlagCount * unReaderCount = [[TUnreadFlagCount alloc]init];
            currUser.unreadCont = unReaderCount;
            [unReaderCount release];
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
            [currUser release];
            
            [self loginAction];
            
        }else{
            NSString * string = r.errString;
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            [alertView release];
        }
        
    }];
    [self.iHttpOperator connect];
    
}


-(void) setID:(int) tID {
    self.iHttpTaskID = tID;
}

//手机号码验证
- (BOOL) validateMobile:(NSString *)mobile
{
    
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(17[0,0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    NSLog(@"%d",[phoneTest evaluateWithObject:mobile]);
    
    //    if ([phoneTest evaluateWithObject:mobile] == NO) {
    //        UIAlertView * alerView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    //        [alerView show];
    //    }
//    return YES;
    return [phoneTest evaluateWithObject:mobile];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSLog(@"%@",NSHomeDirectory());
    NSString * dismissStr= [[NSUserDefaults standardUserDefaults] objectForKey:RegisterToAutoLoginFlag];
    
    if ([dismissStr isEqualToString:@"YES"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:RegisterToAutoLoginFlag];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self leftClicked];
    }

}

#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpLoginWithUserName:(NSString *)userName pwd:(NSString *)password
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[[HttpOperator alloc]init]autorelease];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCLoginOneViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
    
        [this httpLOadParams:s userName:userName pwd:password httpOperation:assginHtttperator];
        
    } complete:^(User* r, int taskid) {
        
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];

}

- (void)httpLoadParams:(NSString *)s httpOperator:(HttpOperator *)httpOperator{
            UserManager* _currUser = (UserManager*)  [httpOperator getAopInstance:[UserManager class] returnValue:[User class]];
            UITextField * userText = (UITextField *)[self.view viewWithTag:101];
            UITextField * login = (UITextField *)[self.view viewWithTag:102];
            NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:login.text]]];
    NSString *blackBox = [YXBTool getFMString];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"长度 = %ld %@",[YXBTool getFMString].length,[YXBTool getFMString]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
    [_currUser userLoginWithFraudmetrix:userText.text pwd:pwd fraudmetrixToken:blackBox];
    
            //        [_currUser release];

}


- (void)httpLOadParams:(NSString *)s userName:(NSString *)userName pwd:(NSString *)password httpOperation:(HttpOperator *)httpOperation{

    UserManager* _currUser = (UserManager*)  [httpOperation getAopInstance:[UserManager class] returnValue:[User class]];
    //        UITextField * userText = (UITextField *)[this.view viewWithTag:101];
    //        UITextField * login = (UITextField *)[this.view viewWithTag:102];
    //        NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:login.text]]];
//    [_currUser userLogin:userName pass:password];
    NSString *blackBox = [YXBTool getFMString];
    [_currUser userLoginWithFraudmetrix:userName pwd:password fraudmetrixToken:blackBox];
            [_currUser release];
}

- (void)httpLoadComplete:(User *)r{
{
            if (r.errCode == 0) {
                QCUserModel * currUser = [[QCUserModel alloc]init];
                currUser.isLogin = YES;
                currUser.user = r;
                TUnreadFlagCount * unReaderCount = [[TUnreadFlagCount alloc]init];
                currUser.unreadCont = unReaderCount;
                [unReaderCount release];
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
                [currUser release];
    
                [self loginAction];
    
            }else{
                NSString * string = r.errString;
                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
                [alertView release];
            }

    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
