//
//  QCRegisterOneViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/6/24.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCRegisterOneViewController.h"
#import "QCLoginOneViewController.h"
#import "UserManager.h"
#import "QCRegisterfourViewController.h"
#import "CPBTimerManager.h"
#import "ModificationViewController.h"
#import "FMDeviceManager.h"
#import "YXBProtocolView.h"
#import "YXBTool.h"
#import "UIImageView+WebCache.h"
#import "MyMD5.h"
#import "MessageCodeMangger.h"
#define kServersTel @"0510-68785960"

#define kPhoneTextTag 10001
#define kPassWordTag 10002
#define kRePassWordTag 10003
#define kVerifyTag 10004
#define kSureButtonTag 10005
#define kCheckButtonTag 10006
#define kCodeAlter 10007
#define kNumVerifyTag 10008

@interface QCRegisterOneViewController ()<UITextFieldDelegate,CPBTimerDelegate,YXBProtocolViewtDelegate,UIAlertViewDelegate,MessageCodeManggerDelegate> {
    UIScrollView *_scrollView;
    UIImageView *_topImage;
    
    NSInteger _time;   //验证码倒计时
    YXBProtocolView *_agree;    //同意条款
    BOOL _checkSelected;
    NSString *deviceToken;
    MessageCodeMangger *manager;
    
}

@property (nonatomic,strong) UIButton *verifyButton;
@property (nonatomic,strong) UIImageView *verifyImage;
@property (nonatomic,strong) CPBTimerManager *verifyTimer;
@property(nonatomic,strong)UIImageView *numImage;
@property(nonatomic,strong)UIImageView *alohaImage;
@property(nonatomic,strong)UIButton *refreshButton;

@end

@implementation QCRegisterOneViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [_verifyTimer stop];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"注册无忧借条"];
    manager=[MessageCodeMangger sharedInstanceWithDelegate:self];
    
    self.view.backgroundColor = rgb(237, 237, 246, 1);
    _checkSelected = YES;
    //_time=60;
    [self initNavItem];
    [self initViews];
    [self reGetCode];
    [self getkeyboundheight];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btuUserintoush) name:UITextFieldTextDidChangeNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    /*
     [self.verifyTimer stop];
     
     _verifyButton.userInteractionEnabled = YES;
     [_verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg"] forState:UIControlStateNormal];
     [_verifyButton setTitle:@"短信验证码" forState:UIControlStateNormal];
     _time = 60;
     */
}

- (void)initNavItem {
    [self setBackView];
    
}
- (void)getkeyboundheight
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardShow:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.25 animations:^{
        if (kDeviceHeight <= 480) {
            _scrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight+120);
            
        }else{
            _scrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight+64);
        }
        
    }];
    
}

- (void)keyboardHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.1 animations:^{
        if (kDeviceHeight <= 480) {
            _scrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight);
            
        }else{
            _scrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight-64);
        }
        
        
    }];
}


- (void)initViews {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight-64);
    [self.view addSubview:_scrollView];
    
    _topImage = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-105)/2, 15+4, 105, 70)];
    _topImage.animationDuration = 0.1;
    _topImage.image = [UIImage imageNamed:@"zc-anim1"];
    _topImage.animationRepeatCount = 1;
    [_scrollView addSubview:_topImage];
    
    RegisterTextField *phone = [[RegisterTextField alloc] initWithFrame:CGRectMake(15, 85, kDeviceWidth-30, (kDeviceWidth-30)/6) withLeftText:@"手机号码"];
    phone.keyboardType = UIKeyboardTypeNumberPad;
    phone.delegate = self;
    phone.tag = kPhoneTextTag;
    phone.placeholder = @"请输入常用的手机号码";
    [_scrollView addSubview:phone];
    
    [_scrollView bringSubviewToFront:_topImage];
    
    RegisterTextField *passWord = [[RegisterTextField alloc] initWithFrame:CGRectMake(15, phone.bottom+5, kDeviceWidth-30, (kDeviceWidth-30)/6) withLeftText:@"密      码"];
    passWord.secureTextEntry = YES;
    passWord.delegate = self;
    passWord.tag = kPassWordTag;
    passWord.placeholder = @"设置一个复杂但容易记的密码";
    [_scrollView addSubview:passWord];
    
    RegisterTextField *rePassWord = [[RegisterTextField alloc] initWithFrame:CGRectMake(15, passWord.bottom+5, kDeviceWidth-30, (kDeviceWidth-30)/6) withLeftText:@"再次确认"];
    rePassWord.secureTextEntry = YES;
    rePassWord.delegate = self;
    rePassWord.tag = kRePassWordTag;
    rePassWord.placeholder = @"请再次确认您的密码";
    [_scrollView addSubview:rePassWord];
    
    //    RegisterTextField *verify = [[RegisterTextField alloc] initWithFrame:CGRectMake(15, rePassWord.bottom+5, kDeviceWidth-30-(kDeviceWidth-30)/6/92*190, (kDeviceWidth-30)/6) withLeftText:@"验 证 码"];
    //    verify.keyboardType = UIKeyboardTypeNumberPad;
    //    verify.delegate = self;
    //    verify.tag = kVerifyTag;
    //    [_scrollView addSubview:verify];
    
    QCBaseTextField *numverify = [[QCBaseTextField alloc] initWithFrame:CGRectMake(15, rePassWord.bottom+5, kDeviceWidth-30-(kDeviceWidth-30)/6/92*190, (kDeviceWidth-30)/6)];
    numverify.delegate = self;
    numverify.tag = kNumVerifyTag;
    numverify.backgroundColor = [UIColor whiteColor];
    numverify.font = [UIFont systemFontOfSize:15];
    numverify.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
    numverify.layer.borderWidth = 1;
    numverify.leftViewMode = UITextFieldViewModeAlways;
    numverify.placeholder = @"图片验证码";
    numverify.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, numverify.height)];
    numverify.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_scrollView addSubview:numverify];
    
    
    
    QCBaseTextField *messageVerify = [[QCBaseTextField alloc] initWithFrame:CGRectMake(15, numverify.bottom+5, kDeviceWidth-30-(kDeviceWidth-30)/6/92*190, (kDeviceWidth-30)/6)];
    messageVerify.keyboardType = UIKeyboardTypeNumberPad;
    messageVerify.delegate = self;
    messageVerify.tag = kVerifyTag;
    messageVerify.backgroundColor = [UIColor whiteColor];
    messageVerify.font = [UIFont systemFontOfSize:15];
    messageVerify.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
    messageVerify.layer.borderWidth = 1;
    messageVerify.leftViewMode = UITextFieldViewModeAlways;
    messageVerify.placeholder = @"短信验证码";
    messageVerify.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, messageVerify.height)];
    messageVerify.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_scrollView addSubview:messageVerify];
    
    _refreshButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _refreshButton.frame=CGRectMake(numverify.right, rePassWord.bottom+5,(kDeviceWidth-30)/6/92*190, (kDeviceWidth-30)/6);
    _alohaImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ((kDeviceWidth-30)/6/92*190-13), (kDeviceWidth-30)/6)];
    [_refreshButton addSubview:_alohaImage];
    _numImage=[[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth-30)/6/92*190-13, (kDeviceWidth-30)/12, 13, 13)];
    _numImage.image=[UIImage imageNamed:@"sx"];
    [_refreshButton addSubview:_numImage];
    _refreshButton.backgroundColor=[UIColor clearColor];
    [_refreshButton addTarget:self action:@selector(reGetCode) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_refreshButton];
    
    //190*92
    _verifyButton=[[UIButton alloc] initWithFrame:CGRectMake(messageVerify.right, numverify.bottom+5, (kDeviceWidth-30)/6/92*190, (kDeviceWidth-30)/6)];
    [_verifyButton addTarget:self action:@selector(verifyAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString * phoneStr= [[NSUserDefaults standardUserDefaults]objectForKey:@"registerPhone"];
    if(manager.time>0&&manager.time<60)
    {
        _verifyButton.userInteractionEnabled = NO;
        [_verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg2"] forState:UIControlStateNormal];
        
        NSString *str = [NSString stringWithFormat:@"剩余%02ld秒",(long)manager.time];
        [_verifyButton setTitle:str forState:UIControlStateNormal];
        if (phoneStr!=nil) {
            
            phone.text=phoneStr;
        }
        
        
    }else
    {
        _verifyButton.userInteractionEnabled = YES;
        
        [_verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg"] forState:UIControlStateNormal];
        
        [_verifyButton setTitle:@"短信验证码" forState:UIControlStateNormal];
    }
    [_scrollView addSubview:_verifyButton];
    
    
    
    _agree = [[YXBProtocolView alloc] initWithType:TYPE_TO_USER_REGIN_PROTOCOL Frame:CGRectMake(15, messageVerify.bottom+20, kDeviceWidth-30, 17) location:VIEWAlignmentLeft];
    _agree.tongyi.frame = CGRectMake(0, (_agree.height-12.5)/2, 12.5, 12.5);
    [_agree.tongyi setBackgroundImage:[UIImage imageNamed:@"zc-check"] forState:UIControlStateNormal];
    [_agree.tongyi setBackgroundImage:[UIImage imageNamed:@"zc-checked"] forState:UIControlStateSelected];
    [_agree.tongyitiaokuan setTitleColor:rgb(52, 142, 250, 1) forState:UIControlStateNormal];
    _agree.delegate = self;
    [_scrollView addSubview:_agree];
    
    UIButton *sure = [[UIButton alloc] initWithFrame:CGRectMake(15, _agree.bottom+15, kDeviceWidth-30, (kDeviceWidth-30)/290*50)];
    [sure setBackgroundImage:[UIImage imageNamed:@"ok-but"] forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    sure.tag = kSureButtonTag;
    sure.alpha = 0.3;
    sure.userInteractionEnabled = NO;
    [_scrollView addSubview:sure];
    
    UILabel *huanying = [[UILabel alloc] initWithFrame:CGRectMake(10, sure.bottom+20, kDeviceWidth-20, 20)];
    huanying.text = @"立即加入中国诚信大家庭，领取欢迎礼！";
    huanying.textAlignment = NSTextAlignmentCenter;
    huanying.textColor =[YXBTool colorWithHexString:@"#bfbfbf"];
    huanying.font = [UIFont systemFontOfSize:17];
    [huanying setAdjustsFontSizeToFitWidth:YES];
    [_scrollView addSubview:huanying];
    huanying.hidden = YES;
    
    UIImage *codeImage = [UIImage imageNamed:@"regis-tel.png"];
    CGFloat imageF = codeImage.size.height/(float)codeImage.size.width;
    CGFloat w = kDeviceWidth-30;
    CGFloat h = imageF * w;
    _verifyImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, sure.bottom+20, w, h)];
    //    _verifyImage.backgroundColor = [UIColor orangeColor];
    _verifyImage.hidden = YES;
    _verifyImage.userInteractionEnabled = YES;
    _verifyImage.image = [UIImage imageNamed:@"regis-tel.png"];
    [_scrollView addSubview:_verifyImage];
    UIControl *codeControl = [[UIControl alloc] initWithFrame:_verifyImage.bounds];
    [codeControl addTarget:self action:@selector(codeAction) forControlEvents:UIControlEventTouchUpInside];
    [_verifyImage addSubview:codeControl];
    
}

- (void)reGetCode{
    //清缓存
    [[SDImageCache sharedImageCache]clearDisk];
    [[SDImageCache sharedImageCache]clearMemory];
    NSString *str1=[NSString stringWithFormat:@"%@youxinbao",[YXBTool getIdfa]];
    NSString *str=[MyMD5 md5:str1];
    deviceToken=str;
    NSString *url = [NSString stringWithFormat:@"%@yzmCheck.jsp?id=%@",YXB_IP_ADRESS,str];
    [_alohaImage sd_setImageWithURL:[NSURL URLWithString:url]];
    
    
}
//获取验证码事件
-(void)codeAction
{
    [YXBTool callTelphoneWithNum:YXBCompanyTelephoneNO];
}

- (void)btuUserintoush {
    bool canTouch = YES;
    for (int i = kPhoneTextTag; i<kVerifyTag+1; i++) {
        RegisterTextField *textField = (RegisterTextField *)[_scrollView viewWithTag:i];
        if (textField.text.length == 0 || textField.text == nil) {
            canTouch = NO;
        }
    }
    

    if (!_checkSelected) {
        canTouch = NO;
    }
    
    UIButton *loginbtn = (UIButton *)[_scrollView viewWithTag:kSureButtonTag];
    
    if (!canTouch) {
        loginbtn.alpha = 0.3;
        loginbtn.userInteractionEnabled = NO;
    }else {
        loginbtn.alpha = 1;
        loginbtn.userInteractionEnabled = YES;
    }
    
}

- (void)loginAction:(UIButton *)button {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //    loginView.modalPresentationStyle = UIModalPresentationPopover;
    [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
}

- (void)verifyAction:(UIButton *)button {
    [self.view endEditing:YES];
    
    UITextField * mobile = (UITextField *)[self.view viewWithTag:kPhoneTextTag];
    UITextField * yzm = (UITextField *)[_scrollView viewWithTag:kNumVerifyTag];
    if ([YXBTool validateMobile:mobile.text] == NO || mobile.text == nil || mobile.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else if (yzm.text==nil||yzm.text.length==0){
    
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"图片验证码不能为空,请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        /*
         语音验证码
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"验证码将通过 %@ 的号码来电告知与您，请留意；若未收到验证码请拨打400-6688-658进行快速获取",kServersTel] delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"获取验证码", nil];
         alertView.tag = kCodeAlter;
         [alertView show];
         */
        
        //短信验证码f
        [self getVerifyCode];
        
    }

    
}

// 验证码
- (BOOL) ValidateYAM:(NSString *)string
{
    NSString *passWordRegex = @"^[0-9]{6}";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    NSLog(@"%d",[passWordPredicate evaluateWithObject:string]);
    
    return [passWordPredicate evaluateWithObject:string];
    
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
    
    
    return [phoneTest evaluateWithObject:mobile];
}


//密码

- (BOOL) validatePassword:(NSString *)passWord
{
    //6-16位
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    NSLog(@"%d",[passWordPredicate evaluateWithObject:passWord]);
    
    //纯数字
    NSString *pureNumRegex = @"^[0-9]+$";
    NSPredicate *pureNumPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pureNumRegex];
    NSLog(@"%d",[pureNumPredicate evaluateWithObject:passWord]);
    
    return ([passWordPredicate evaluateWithObject:passWord] && ![pureNumPredicate evaluateWithObject:passWord]);
    
}


//- (void)checkAction:(UIButton *)button {
//    button.selected = !button.selected;
//
//    if (!button.selected) {
//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"请先勾选友信宝用户注册协议" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alter show];
//
//    }
//}

- (void)sureAction:(UIButton *)button {
    UITextField * phone = (UITextField *)[_scrollView viewWithTag:kPhoneTextTag];
    UITextField * yzm = (UITextField *)[_scrollView viewWithTag:kVerifyTag];
    UITextField *password = (UITextField *)[_scrollView viewWithTag:kPassWordTag];
    UITextField *agPassword = (UITextField *)[_scrollView viewWithTag:kRePassWordTag];
    
    
    if ( [yzm.text isEqualToString:@""]) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"请输入验证码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
    }else if ([YXBTool validateMobile:phone.text] == NO) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
    }else if ([self ValidateYAM:yzm.text]== NO){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"验证码输入错误，请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
    }else if ([self validatePassword:password.text] == NO){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"请设置一个6-16位的密码保障安全,并且密码不能为纯数字" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }else if (![password.text isEqualToString:agPassword.text]) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"两次密码输入不一致，请重新输入。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
    }else{
        [self userReg];
        
    }
    
}

#pragma mark - Alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == kCodeAlter) {
        if (buttonIndex == 1) {
            [self getVerifyCode];
        }
    }
}

#pragma mark - ProtocolView delegate
- (void)checkButton:(UIButton *)sender {
    //    sender.selected = !sender.selected;
    
    if (!sender.selected) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"请先勾选无忧借条用户注册协议" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        _checkSelected = NO;
    }else {
        _checkSelected = YES;
    }
    
    [self btuUserintoush];
}
- (void)protocolButton:(UIButton *)sender {
    [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:_agree.urlStr params:nil] hasTopBar:YES titleName:_agree.webTitle view:self.view];
}

#pragma mark - UITextField delegate
- (void)textfieldResignFirstResponderExcept:(UITextField *)exceptTextField
{
    for (int i = 0; i < 4; i++) {
        UITextField * textField = (UITextField *)[_scrollView viewWithTag:kPhoneTextTag+i];
        if (![textField isEqual:exceptTextField]) {
            [textField resignFirstResponder];
            
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    //    NSLog(@"string == %@",string);
    //    UITextField * textFiled1 = (UITextField *)[self.view viewWithTag:1001];
    //    UITextField * textFilde2 = (UITextField *)[self.view viewWithTag:1002];
    //    UITextField * textFilde3 = (UITextField *)[self.view viewWithTag:1003];
    //计算剩下多少文字可以输入
    if (textField.tag == kPhoneTextTag) {
        if(range.location>=11)
        {
            return NO;
        }else{
            return YES;
        }
        
    }else if (textField.tag == kPassWordTag||textField.tag == kRePassWordTag){
        if (range.location >=16) {
            return NO;
        }else{
            
            return YES;
        }
        
    }else if (textField.tag == kVerifyTag){
        if (range.location >=6) {
            return NO;
        }else{
            
            return YES;
        }
    }else {
        return YES;
        
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self textfieldResignFirstResponderExcept:textField];
    
    UIImage *image1 = [UIImage imageNamed:@"zc-anim1"];
    UIImage *image2 = [UIImage imageNamed:@"zc-anim2"];
    UIImage *image3 = [UIImage imageNamed:@"zc-anim3"];
    NSArray * openImages = @[image3,image2,image1];
    NSArray * closeImages = @[image1,image2,image3];
    
    if (textField.tag == kPhoneTextTag || textField.tag == kVerifyTag) {
        if (![_topImage.image isEqual:image1]) {
            //睁开双眼，
            _topImage.animationImages = openImages;
            _topImage.image = image1;
            //            _topImage.animationDuration = 0.1;
            [_topImage startAnimating];
            
        }
    }else if (textField.tag == kPassWordTag||textField.tag == kRePassWordTag){
        if (![_topImage.image isEqual:image3]) {
            //闭上双眼
            _topImage.animationImages = closeImages;
            _topImage.image = image3;
            //            _topImage.animationDuration = 0.1;
            [_topImage startAnimating];
            
        }
    }
    
}

#pragma mark -----------------------------------------------HttpDownLoad
- (void)getVerifyCode
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCRegisterOneViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
        [this httpLoadCancel];
        
    } error:^(int d, THttpOperatorErrorCode error) {
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpLoadParamsThird:assginHtttperator];
    } complete:^(TResultSet * r, int taskid) {
        //        this.verifyButton.userInteractionEnabled = YES;
        //        this.verifyImage.hidden = YES;
        //        [this.verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg"] forState:UIControlStateNormal];
        [this httpLoadCompleteThird:r];
        
    }];
    [self.iHttpOperator connect];
    _verifyButton.userInteractionEnabled = NO;
    [this.verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg2"] forState:UIControlStateNormal];
    
    
}
- (void)httpLoadCancel{
    self.verifyButton.userInteractionEnabled = YES;
    self.verifyImage.hidden = YES;
    [self.verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg"] forState:UIControlStateNormal];
    
}

- (void)httpLoadError:(THttpOperatorErrorCode)error{
    self.verifyButton.userInteractionEnabled = YES;
    self.verifyImage.hidden = YES;
    [self.verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg"] forState:UIControlStateNormal];
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    
    if (error == EHttp_Operator_Failed) {
        //服务器挂了
    }
    
}
- (void)httpLoadParamsThird:(HttpOperator *)assginHtttperator{
    UserManager * _tesult = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[TResultSet class]];
    UITextField * userText = (UITextField *)[self.view viewWithTag:kPhoneTextTag];
    UITextField *numText=(UITextField *)[self.view viewWithTag:kNumVerifyTag];
    NSLog(@"tuserrr =%@",userText.text);
    //[_tesult getVerifyCode:userText.text request_type:1];
    //        [_currUser release];
    [_tesult getVerifyCodeV2:userText.text deviceToken:deviceToken imageVCode:numText.text];
}
- (void)httpLoadCompleteThird:(TResultSet *)r{
    
    if (r.errCode !=0) {
        [self reGetCode];
        UITextField *numText=(UITextField *)[self.view viewWithTag:kNumVerifyTag];
        numText.text=@"";
        [ProgressHUD showErrorWithStatus:r.errString];
        [self reGetCode];
        UITextField * imgyanzhengma = (UITextField *)[_scrollView viewWithTag:kNumVerifyTag];
        imgyanzhengma.text = @"";
        self.verifyButton.userInteractionEnabled = YES;
        self.verifyImage.hidden = YES;
        [self.verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg"] forState:UIControlStateNormal];
    }else{
        
        [ProgressHUD showErrorWithStatus:r.errString];

//        self.verifyTimer = [[CPBTimerManager alloc]initWithTimeInterval:1.0 userInfo:Nil repeats:YES];
//        self.verifyTimer.delegate = self;
        self.verifyButton.userInteractionEnabled = NO;
        [self.verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg2"] forState:UIControlStateNormal];
        if (manager.time==0) {
            manager.time=60;
        }
        
        [manager start];
        UITextField * phone = (UITextField *)[_scrollView viewWithTag:kPhoneTextTag];
        if (phone.text!=nil) {
            
            [[NSUserDefaults standardUserDefaults]setObject:phone.text forKey:@"registerPhone"];
            
        }
    }
    
    
}

- (void)userReg
{
    UITextField * userText = (UITextField *)[_scrollView viewWithTag:kPhoneTextTag];
    UITextField * yzmText = (UITextField *)[_scrollView viewWithTag:kVerifyTag];
    UITextField * wde = (UITextField *)[_scrollView viewWithTag:kPassWordTag];
    NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:wde.text]]];
    
    //    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCRegisterOneViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        [this httpLoadParamsTwo:assginHtttperator userText:userText yzmText:yzmText pwd:pwd];
        
    } complete:^(TResultSet * r, int taskid) {
        [this httpLoadCompleteTwo:r wde:wde userText:userText];
        
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParamsTwo:(HttpOperator *)assginHtttperator userText:(UITextField*)userText yzmText:(UITextField *)yzmText pwd:(NSString *)pwd{
    
    UserManager * _tesult = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[TResultSet class]];
    
    [_tesult userReg:userText.text verifyCode:yzmText.text pwd:pwd phoneType:@"ios" channeId:[CHANDLE_AK_ID integerValue]];
    
}
- (void)httpLoadCompleteTwo:(TResultSet *)r wde:(UITextField *)wde userText:(UITextField *)userText{
    
    if (r.errString == nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"服务器异常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    if (r.errCode == 0) {
        QCUserModel * _currUser = [[QCUserManager sharedInstance]getLoginUser];
        _currUser.user.username = userText.text;
        _currUser.user.pwd =  [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:wde.text]]];
        _currUser.user.nickname = @"";
        QCUserManager * um = [QCUserManager sharedInstance];
        [um setLoginUser:_currUser];
        [self httpLogin:r.resString];//注册成功之后 登录
        
    }else{
      [ProgressHUD showErrorWithStatus:r.errString];
        
    }
    
}

- (void)httpLogin:(NSString *)indeXuser
{
    //重新初始化httpOperator
    self.iHttpOperator = [[HttpOperator alloc]init];
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCRegisterOneViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpLoadParams:assginHtttperator];
        
    } complete:^(User* r, int taskid) {
        [this httpLoadCompleteOne:r indeXuser:indeXuser];
        
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    
    UITextField * userText = (UITextField *)[_scrollView viewWithTag:kPhoneTextTag];
    UserManager* _currUser = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[User class]];
    UITextField * wde = (UITextField *)[self.view viewWithTag:kPassWordTag];
    NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:wde.text]]];
    //    [_currUser userLogin:userText.text pass:pwd];
    // 获取设备管理器实例
    NSString *blackBox = [YXBTool getFMString];
    [_currUser userLoginWithFraudmetrix:userText.text pwd:pwd fraudmetrixToken:blackBox];
    
}
- (void)httpLoadCompleteOne:(User *)r indeXuser:(NSString *)indeXuser{
    
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
        ModificationViewController * modificationViewController = [[ModificationViewController alloc]init];
        modificationViewController.isRegisterLogen = YES;
        modificationViewController.indexUser = indeXuser;
        [self.navigationController pushViewController:modificationViewController animated:YES];
        
    }else{
        NSString * string = r.errString;
        UIAlertView * alertViewa = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertViewa show];
    }
    
}
- (void)MessageCodeManggerAction:(MessageCodeMangger *)messageManage{
    //    _time=messageManage.time;
    if (messageManage.time > 0) {
        
        //        _time --;
        _verifyButton.userInteractionEnabled = NO;
        [_verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg2"] forState:UIControlStateNormal];
        
        NSString *str = [NSString stringWithFormat:@"剩余%02ld秒",(long)messageManage.time];
        [_verifyButton setTitle:str forState:UIControlStateNormal];
        
    }else{
        //        [self.verifyTimer stop];
        //        self.verifyTimer = nil;
        [messageManage stop];
        
        _verifyButton.userInteractionEnabled = YES;
        [_verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg"] forState:UIControlStateNormal];
        [_verifyButton setTitle:@"短信验证码" forState:UIControlStateNormal];
        // _time = 60;
        
        
    }
    
}
- (void)setBackView{
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    
}


#pragma mark---------------------------cpbTimerDelegate
//- (void)CPBTimerManagerAction:(CPBTimerManager *)timer
//{
//
//    if (_time > 0) {
//
//        _time --;
//        _verifyButton.userInteractionEnabled = NO;
//        [_verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg2"] forState:UIControlStateNormal];
//
//        NSString *str = [NSString stringWithFormat:@"剩余%02ld秒",(long)_time];
//        [_verifyButton setTitle:str forState:UIControlStateNormal];
//
//    }else{
//        [self.verifyTimer stop];
//        self.verifyTimer = nil;
////        UIButton * ybtn = (UIButton *)[self.view viewWithTag:kVerifyTag];
////        ybtn.userInteractionEnabled = YES;
////        ybtn.alpha = 1;
////        _timeLabel.hidden = YES;
//        _verifyButton.userInteractionEnabled = YES;
//        [_verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg"] forState:UIControlStateNormal];
//        [_verifyButton setTitle:@"短信验证码" forState:UIControlStateNormal];
//        _time = 60;
//
//
//    }
//
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@implementation RegisterTextField

- (id)initWithFrame:(CGRect)frame withLeftText:(NSString *)text {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:15];
        self.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
        self.layer.borderWidth = 1;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, frame.size.height)];
        leftLabel.textColor = [UIColor blackColor];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.text = text;
        leftLabel.font = [UIFont systemFontOfSize:15];
        self.leftView = leftLabel;
    }
    
    return self;
}

@end

@implementation EnlargeButton
//扩大点击区域
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGRect rect = CGRectMake(-getScreenFitSize(_enlargeInsets.left), -getScreenFitSize(_enlargeInsets.top), self.frame.size.width+getScreenFitSize(_enlargeInsets.left+_enlargeInsets.right), self.frame.size.height+getScreenFitSize(_enlargeInsets.top+_enlargeInsets.bottom));
    
    return CGRectContainsPoint(rect, point) ? self : nil;
}

@end
