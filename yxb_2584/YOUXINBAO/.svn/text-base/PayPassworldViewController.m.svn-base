//
//  PayPassworldViewController.m
//  YOUXINBAO
//
//  Created by 密码是111 on 16/5/24.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "PayPassworldViewController.h"
#import "MessageCodeMangger.h"
#import "MyMD5.h"
#import "HttpOperator.h"
#import "UserManager.h"
#import "CPBTimerManager.h"

#define PaypassworldTextTag 10001
@interface PayPassworldViewController ()<MessageCodeManggerDelegate,CPBTimerDelegate,UIScrollViewDelegate>

{
    
    MessageCodeMangger *manager;
    QCBaseTextField *field1;
    QCBaseTextField *field2;
    QCBaseTextField *validatenumber2;
    QCBaseTextField *rePassWord3;
    QCBaseTextField *field_3;
    CPBTimerManager * verifyTimer;
    NSInteger time;
    UIScrollView*scrollview;
    
    
}

@property (nonatomic,strong) HttpOperator *iHttpOperator;

@property(nonatomic,strong)UIButton*verifyButton;
@property(nonatomic,strong)UILabel*label1;
@property(nonatomic,strong)UILabel*lab_1;
@property(nonatomic,strong)UIButton * sureBtn1;

@property(nonatomic,strong)UILabel*label2;
@property(nonatomic,strong)UIButton *  sureBtn2;

@property(nonatomic,strong)UILabel*label3;
@property(nonatomic,strong)UILabel*lab_3;
@property(nonatomic,strong)UIButton *sureBtn3;

@end

@implementation PayPassworldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"修改支付密码"];
     manager=[MessageCodeMangger sharedInstanceWithDelegate:self];
    self.view.backgroundColor = rgb(237, 237, 246, 1);
    [self CreatScroll];
    [self CreatView1];
//    NSUserDefaults*pass=[NSUserDefaults ]
}


-(void)viewWillDisappear:(BOOL)animated
{
    verifyTimer.delegate = nil;
    [verifyTimer stop];

}

-(void)CreatScroll{
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    scrollview.backgroundColor = rgb(237, 237, 246, 1);
    //设置委托
    scrollview.delegate = self;
    // 隐藏水平 垂直 滚动条
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator=NO;
    // 去掉弹簧效果
    scrollview.bounces = NO;
    scrollview.contentSize = CGSizeMake(0,scrollview.frame.size.height*1.4 );
    [self.view addSubview:scrollview];
    
}


#pragma mark - Create UI
-(void)CreatView1{
    _label1=[[UILabel alloc]initWithFrame:CGRectMake(13, 13, kDeviceWidth-26, 13)
                    ];
    _label1.backgroundColor=[UIColor clearColor];
    _label1.font = [UIFont systemFontOfSize:16.0];
    _label1.textAlignment = NSTextAlignmentLeft;
    _label1.text = @"输入原支付密码";
    _label1.userInteractionEnabled = YES;
    [scrollview addSubview:_label1];
    
    
    
    field1 = [[QCBaseTextField alloc] initWithFrame:CGRectMake(15, 30+8, kDeviceWidth-30, (kDeviceWidth-30)/6)];
    field1.delegate = self;
    field1.tag=1100;
    field1.secureTextEntry = YES;
    //    messageVerify.tag = kVerifyTag;
    field1.backgroundColor = [UIColor whiteColor];
    field1.font = [UIFont systemFontOfSize:15];
    field1.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
    field1.layer.borderWidth = 1;
    field1.clearButtonMode = UITextFieldViewModeWhileEditing;
    field1.leftViewMode = UITextFieldViewModeAlways;
    field1.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, field1.height)];
    field1.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:field1];
    
    
    _lab_1=[[UILabel alloc]initWithFrame:CGRectMake(13, field1.frame.origin.y+kDeviceWidth/6+8, kDeviceWidth-30, 15)
                    ];
    _lab_1.backgroundColor=[UIColor clearColor];
    _lab_1.textColor = rgb(149, 149, 149, 1);
    _lab_1.font = [UIFont systemFontOfSize:13.0];
    _lab_1.textAlignment = NSTextAlignmentLeft;
    _lab_1.text = @"若尚未设置支付密码，请输入登录密码。";
    _lab_1.userInteractionEnabled = YES;
    [scrollview addSubview:_lab_1];
    
    _sureBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(15, _lab_1.bottom+75, kDeviceWidth-30, (kDeviceWidth-30)/6)];
    [_sureBtn1 setBackgroundImage:[UIImage imageNamed:@"xiugaizhifu"] forState:UIControlStateNormal];
    _sureBtn1.tag=4001;
    [_sureBtn1 addTarget:self action:@selector(sureBtnAction1:) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:_sureBtn1];

 }
-(void)CreatView2{
    _label2=[[UILabel alloc]initWithFrame:CGRectMake(15, 15, kDeviceWidth-30, 15)
             ];
    _label2.backgroundColor=[UIColor clearColor];
    _label2.font = [UIFont systemFontOfSize:16.0];
    _label2.textAlignment = NSTextAlignmentLeft;
    _label2.text = @"验证手机号";
    _label2.userInteractionEnabled = YES;
    [scrollview addSubview:_label2];
    
    validatenumber2 = [[QCBaseTextField alloc] initWithFrame:CGRectMake(15, _label2.bottom+25, kDeviceWidth-30-(kDeviceWidth-30)/6/92*190, (kDeviceWidth-30)/6)];
    validatenumber2.keyboardType = UIKeyboardTypeNumberPad;
    validatenumber2.delegate = self;
    //    messageVerify.tag = kVerifyTag;
    validatenumber2.backgroundColor = [UIColor whiteColor];
    validatenumber2.font = [UIFont systemFontOfSize:15];
    validatenumber2.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
    validatenumber2.layer.borderWidth = 1;
    validatenumber2.leftViewMode = UITextFieldViewModeAlways;
    validatenumber2.placeholder = @"输验证码";
    validatenumber2.tag=1101;
    validatenumber2.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, validatenumber2.height)];
    validatenumber2.clearButtonMode = UITextFieldViewModeWhileEditing;
    validatenumber2.borderStyle = UITextBorderStyleRoundedRect;
    
    [scrollview addSubview:validatenumber2];
    
    
    _verifyButton=[[UIButton alloc] initWithFrame:CGRectMake(validatenumber2.right+2, _label2.bottom+25, (kDeviceWidth-30)/6/92*190, (kDeviceWidth-30)/6)];
      [_verifyButton addTarget:self action:@selector(sureBtnAction3:) forControlEvents:UIControlEventTouchUpInside];
    
  
    if(manager.time>0&&manager.time<60)
    {
        _verifyButton.userInteractionEnabled = NO;
        [_verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg2"] forState:UIControlStateNormal];
        
        NSString *str = [NSString stringWithFormat:@"剩余%02ld秒",(long)manager.time];
        [_verifyButton setTitle:str forState:UIControlStateNormal];
        
    }else
    {
        _verifyButton.userInteractionEnabled = YES;
        
        [_verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg"] forState:UIControlStateNormal];
        
        [_verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    [scrollview addSubview:_verifyButton];
    
    _sureBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(15, validatenumber2.bottom+ 54, kDeviceWidth-30, (kDeviceWidth-30)/6)];
    [_sureBtn2 setBackgroundImage:[UIImage imageNamed:@"xiugaizhifu"] forState:UIControlStateNormal];
    _sureBtn2.tag=4002;
    [_sureBtn2 addTarget:self action:@selector(sureBtnAction2:) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:_sureBtn2];
    
    
}

-(void)CreatView3{
    _label3=[[UILabel alloc]initWithFrame:CGRectMake(15, 15, kDeviceWidth-30, 15)
             ];
    _label3.backgroundColor=[UIColor clearColor];
    _label3.font = [UIFont systemFontOfSize:16.0];
    _label3.textAlignment = NSTextAlignmentLeft;
    _label3.text = @"设置支付密码";
    _label3.userInteractionEnabled = YES;
    [scrollview addSubview:_label3];
    
    
    rePassWord3 = [[QCBaseTextField alloc] initWithFrame:CGRectMake(15, _label3.bottom+10, kDeviceWidth-30, (kDeviceWidth-30)/6)];
    rePassWord3.delegate = self;
    rePassWord3.keyboardType = UIKeyboardTypeNumberPad;
    rePassWord3.backgroundColor = [UIColor whiteColor];
    rePassWord3.font = [UIFont systemFontOfSize:15];
    rePassWord3.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
    rePassWord3.layer.borderWidth = 1;
    rePassWord3.clearButtonMode = UITextFieldViewModeWhileEditing;
    rePassWord3.leftViewMode = UITextFieldViewModeAlways;
    rePassWord3.tag=1102;
    rePassWord3.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, rePassWord3.height)];
    rePassWord3.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:rePassWord3];
    
    
    
    
    _lab_3=[[UILabel alloc]initWithFrame:CGRectMake(15, rePassWord3.bottom+10, kDeviceWidth-30, 15)
            ];
    _lab_3.backgroundColor=[UIColor clearColor];
    _lab_3.font = [UIFont systemFontOfSize:16.0];
    _lab_3.textAlignment = NSTextAlignmentLeft;
    _lab_3.text = @"确认支付密码";
    _lab_3.userInteractionEnabled = YES;
    [scrollview addSubview:_lab_3];
    
    
    field_3 = [[QCBaseTextField alloc] initWithFrame:CGRectMake(15, _lab_3.bottom+10, kDeviceWidth-30, (kDeviceWidth-30)/6)];
    field_3.secureTextEntry = YES;
    field_3.delegate = self;
    field_3.keyboardType=UIKeyboardTypeNumberPad;
    field_3.backgroundColor = [UIColor whiteColor];
    field_3.font = [UIFont systemFontOfSize:15];
    field_3.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
    field_3.layer.borderWidth = 1;
    field_3.tag=1103;
    field_3.clearButtonMode = UITextFieldViewModeWhileEditing;
    field_3.leftViewMode = UITextFieldViewModeAlways;
    field_3.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, field_3.height)];
    field_3.borderStyle = UITextBorderStyleRoundedRect;
    
    [scrollview addSubview:field_3];
    
    _sureBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(15, field_3.bottom+50, kDeviceWidth-30, (kDeviceWidth-30)/6)];
    [_sureBtn3 setBackgroundImage:[UIImage imageNamed:@"xiugaimimaDone"] forState:UIControlStateNormal];
    [_sureBtn3 addTarget:self action:@selector(sureBtnAction4:) forControlEvents:UIControlEventTouchUpInside];
    _sureBtn3.tag=4003;
    [scrollview addSubview:_sureBtn3];
    
    
}
#pragma mark - Button Click

-(void)sureBtnAction1:(UIButton*)button{
    
        //校验密码
    if([field1.text isEqualToString:@""]){
    [ProgressHUD showErrorWithStatus:@"请输入正确密码"];
        
    }
    else{
    [self CheckPassworld1];
    }
}

-(void)sureBtnAction2:(UIButton*)button{
//    测试用
//    [self CreatView3];
//    [self setTitle:@"修改支付密码"];
//    _lab_1.hidden=YES;
//    _label1.hidden=YES;
//    field1.hidden=YES;
//    _sureBtn1.hidden=YES;
//    
//    _label2.hidden=YES;
//    field2.hidden=YES;
//    validatenumber2.hidden=YES;
//    _verifyButton.hidden=YES;
//    _sureBtn2.hidden=YES;
//    
//    _label3.hidden=NO;
//    rePassWord3.hidden=NO;
//    _lab_3.hidden=NO;
//    field_3.hidden=NO;
//    _sureBtn3.hidden=NO;

   [self CheckPassworld3];



}

-(void)sureBtnAction3:(UIButton*)button{
  
    
    [self CheckPassworld2];
    
    
}
-(void)sureBtnAction4:(UIButton*)button{
    
   
    if([rePassWord3.text isEqualToString:field_3.text]==NO){
        [ProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
        
    }
    else if([rePassWord3.text isEqualToString:@""]){
        [ProgressHUD showErrorWithStatus:@"请输入正确验证码"];
    }
    else if([field_3.text isEqualToString:@""]){
        [ProgressHUD showErrorWithStatus:@"请输入正确验证码"];
    }

    else{
     [self CheckPassworld4];
    
    }
}
#pragma mark - Http delegate 校验密码
-(void)CheckPassworld1
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak PayPassworldViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
        [this httpLoadCancel];
        
    } error:^(int d, THttpOperatorErrorCode error) {
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpLoadParamsThird1:assginHtttperator];
    } complete:^(TResultSet * r, int taskid) {
       
        [this httpLoad_LoginssComplete1:r];
        
    }];
    [self.iHttpOperator connect];

}

//上传参数
- (void)httpLoadParamsThird1:(HttpOperator *)assginHtttperator
{
    UserManager * _tesult = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[TResultSet class]];
     NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:field1.text]]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [_tesult checkPayPwdWithRedis: userModel.user.yxbToken pwd:pwd];
    
}
//请求完成
-(void)httpLoad_LoginssComplete1:(TResultSet *)r{
    if (r.errCode == 0) {
        [self setTitle:@"修改支付密码"];
        [self CreatView2];
        _label1.hidden=YES;
        field1.hidden=YES;
        _sureBtn1.hidden=YES;
        _lab_1.hidden=YES;
        
        _label2.hidden=NO;
        field2.hidden=NO;
        validatenumber2.hidden=NO;
        _verifyButton.hidden=NO;
        _sureBtn2.hidden=NO;

            }else{
       [ProgressHUD showErrorWithStatus:r.errString];
    }
    
}
#pragma mark - Http delegate 获取验证码
-(void)CheckPassworld2
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak PayPassworldViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
        [this httpLoadCancel];
        
    } error:^(int d, THttpOperatorErrorCode error) {
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpLoadParamsThird2:assginHtttperator];
    } complete:^(TResultSet * r, int taskid) {
        
        [this httpLoad_LoginssComplete2:r];
        
    }];
    [self.iHttpOperator connect];
    
}

//上传参数
- (void)httpLoadParamsThird2:(HttpOperator *)assginHtttperator
{
    UserManager * _tesult = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[TResultSet class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [_tesult getModifyPayPwdVerifyCode:userModel.user.username];
    
}
//请求完成
-(void)httpLoad_LoginssComplete2:(TResultSet *)r{
    if (r.errCode == 0) {
        NSLog(@"请求成功。。。。。。");
        verifyTimer = [[CPBTimerManager alloc]initWithTimeInterval:1.0 userInfo:Nil repeats:YES];
        verifyTimer.delegate = self;
        self.verifyButton.userInteractionEnabled = NO;
        [self.verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg2"] forState:UIControlStateNormal];
        
    }else{
       [ProgressHUD showErrorWithStatus:r.errString];
    }
    
}
#pragma mark - Http delegate 校验验证码
-(void)CheckPassworld3
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak PayPassworldViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
        [this httpLoadCancel];
        
    } error:^(int d, THttpOperatorErrorCode error) {
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpLoadParamsThird3:assginHtttperator];
    } complete:^(TResultSet * r, int taskid) {
        
        [this httpLoad_LoginssComplete3:r];
        
    }];
    [self.iHttpOperator connect];
    
}

//上传参数
- (void)httpLoadParamsThird3:(HttpOperator *)assginHtttperator
{
    UserManager * _tesult = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[TResultSet class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [_tesult checkPayPwdVerifyCode:userModel.user.yxbToken verifyCode:validatenumber2.text];
    
}
//请求完成
-(void)httpLoad_LoginssComplete3:(TResultSet *)r{
    if (r.errCode == 0) {
        NSLog(@"请求成功");
        [self CreatView3];
        [self setTitle:@"修改支付密码"];
        _lab_1.hidden=YES;
        _label1.hidden=YES;
        field1.hidden=YES;
        _sureBtn1.hidden=YES;
        
        _label2.hidden=YES;
        field2.hidden=YES;
        validatenumber2.hidden=YES;
        _verifyButton.hidden=YES;
        _sureBtn2.hidden=YES;
        
        _label3.hidden=NO;
        rePassWord3.hidden=NO;
        _lab_3.hidden=NO;
        field_3.hidden=NO;
        _sureBtn3.hidden=NO;
        
        
    }else{
        [ProgressHUD showErrorWithStatus:r.errString];
    }
    
}
#pragma mark - Http delegate重置密码
-(void)CheckPassworld4
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak PayPassworldViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
        [this httpLoadCancel];
        
    } error:^(int d, THttpOperatorErrorCode error) {
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpLoadParamsThird4:assginHtttperator];
    } complete:^(TResultSet * r, int taskid) {
        
        [this httpLoad_LoginssComplete4:r];
        
    }];
    [self.iHttpOperator connect];
    
}

//上传参数
- (void)httpLoadParamsThird4:(HttpOperator *)assginHtttperator
{
    UserManager * _tesult = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[TResultSet class]];
    NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:field_3.text]]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [_tesult setUserPayPwd:userModel.user.yxbToken setPaw:pwd];
    
}
//请求完成
-(void)httpLoad_LoginssComplete4:(TResultSet *)r{
    if (r.errCode == 0) {
        NSLog(@"请求成功。。。。。。。。。。。");
        [self.navigationController popViewControllerAnimated:YES];
        [ProgressHUD showErrorWithStatus:@"修改成功"];
        
    }else{
        [ProgressHUD showErrorWithStatus:r.errString];
    }
    
}

#pragma mark---------------------------cpbTimerDelegate
- (void)CPBTimerManagerAction:(CPBTimerManager *)timer
{
    if (time <60) {
        time ++;
        NSString *str = [NSString stringWithFormat:@"剩余%ld秒",(long)(60- time)];       [_verifyButton setTitle:str forState:UIControlStateNormal];

    }else{
        [verifyTimer stop];
        [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.verifyButton.userInteractionEnabled = YES;
        [self.verifyButton setBackgroundImage:[UIImage imageNamed:@"zc-yzmbutbg"] forState:UIControlStateNormal];
                time = 0;
    }
    
}
#pragma mark---------------------------字数限制

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    //计算剩下多少文字可以输入
    if ((textField.tag == 1102)||(textField.tag == 1103)) {
        if(range.location>=6)
        {
            return NO;
        }else{
            return YES;
        }
        
    }else if (textField.tag == 1101){
        if (range.location >=6) {
            return NO;
        }else{
            
            return YES;
        }
        
    }
    else if (textField.tag == 1100){
        if (range.location >=16) {
            return NO;
        }else{
            
            return YES;
        }
        
    }else{
        return YES;
    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![field1 isExclusiveTouch]) {
        [field1 resignFirstResponder];
    }
    else if (![validatenumber2 isExclusiveTouch]) {
        [validatenumber2 resignFirstResponder];
    }
    else if (![rePassWord3 isExclusiveTouch]) {
        [rePassWord3 resignFirstResponder];
    }
    else if (![field_3 isExclusiveTouch]) {
        [field_3 resignFirstResponder];
    }
}



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
