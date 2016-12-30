//
//  QCThreeViewController.m
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCThreeViewController.h"
#import "QCFourViewController.h"
#import "CPBTimerManager.h"
#import "HttpOperator.h"
#import "UserManager.h"
#import "QCUserManager.h"
#import "MyMD5.h"
#import "YLInitSwipePasswordController.h"
#import "QCLoginOneViewController.h"
#import "QCRegisterfourViewController.h"
#import "YXBTool.h"
#define kGap 10     //间隙
#define kTextFieldHeight   (kDeviceWidth-30)/6 //输入框高度
#define kVerifyColor rgb(226,225,230,1)


@interface QCThreeViewController ()<CPBTimerDelegate>
{
    UITableView * _tableView;
    CPBTimerManager * verifyTimer;
    long time;
    NSString * verifyCode;
    UIAlertView * alertView;
    
    UILabel     *_timeLabel;
    
}

@end

@implementation QCThreeViewController
- (void)dealloc
{
    self.iHttpOperator = nil;

    [alertView release];
    [verifyTimer release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        time = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setNavigationItem];
    [self CreatUI];
    [self getkeyboundheight];
}

#pragma mark --------------------------------CreatUI
- (void)setNavigationItem
{
    self.title = @"注册无忧借条";

    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(backAction:)];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 30);
    [btn addTarget:self action:@selector(rightNavigationItemAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    UIBarButtonItem *createItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = createItem;
}

- (void)rightNavigationItemAction {
    QCLoginOneViewController *logon = [[QCLoginOneViewController alloc] init];
    [self.navigationController pushViewController:logon animated:YES];
}

- (void)CreatUI
{
    self.view.backgroundColor = rgb(237, 236, 246, 1);
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    
    [self CreateTextFieldWithFrame:CGRectMake(15, 15, kDeviceWidth/3*2-40, kTextFieldHeight) withCapacity:@" 手机号" withSecureTextEntry:NO withTargrt:self withTag:1001 view:self.view];
    UITextField * textFild1 = (UITextField *)[self.view viewWithTag:1001];
    UILabel *leftView1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 10, textFild1.height)];
    textFild1.leftViewMode = UITextFieldViewModeAlways;
    textFild1.leftView = leftView1;
    textFild1.keyboardType = UIKeyboardTypeNumberPad;
    textFild1.backgroundColor = [UIColor whiteColor];
    textFild1.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
    textFild1.layer.borderWidth = 1;
//    textFild1.textAlignment = NSTextAlignmentCenter;

    //验证码按钮
    [self createButtonWithframe:CGRectMake(kDeviceWidth/3*2-10, 15, kDeviceWidth/3-5,kTextFieldHeight) withImage:@"" withView:self.view withTarget:self withAcation:@selector(yanZhengAction:) withTag:1005];
    UIButton * ybtn = (UIButton *)[self.view viewWithTag:1005];
    [ybtn setBackgroundImage:[UIImage imageNamed:@"message-vali-but.png"] forState:UIControlStateNormal];


    
    [self CreateTextFieldWithFrame:CGRectMake(15, textFild1.bottom+15, kDeviceWidth-30, kTextFieldHeight) withCapacity:@" 请输入验证码" withSecureTextEntry:NO withTargrt:self withTag:1002 view:self.view];
    UITextField * textFild2 = (UITextField *)[self.view viewWithTag:1002];
    UILabel *leftView2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, textFild1.height)];
    textFild2.leftViewMode = UITextFieldViewModeAlways;
    textFild2.leftView = leftView2;
    textFild2.keyboardType = UIKeyboardTypeNumberPad;
    textFild2.backgroundColor = [UIColor whiteColor];
    textFild2.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
    textFild2.layer.borderWidth = 1;
//    textFild2.textAlignment = NSTextAlignmentCenter;

    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 90, kTextFieldHeight-20)];
    [textFild2 addSubview:_timeLabel];
    _timeLabel.right = textFild2.right-45;
    _timeLabel.textAlignment  = NSTextAlignmentRight;
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    [_timeLabel release];
    
    [self createButtonWithframe:CGRectMake(15, textFild2.bottom+20, kDeviceWidth-30, kTextFieldHeight) withImage:@"next-but" withView:self.view withTarget:self withAcation:@selector(tiJiaoAction:) withTag:1006];
    
    [self btuUserintoush];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btuUserintoush) name:UITextFieldTextDidChangeNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btuUserintoush) name:UITextFieldTextDidBeginEditingNotification object:nil];

    alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
}

- (void)btuUserintoush {
    UITextField * text1 = (UITextField *)[self.view viewWithTag:1001];
    UITextField * text2 = (UITextField *)[self.view viewWithTag:1002];
    if ([text1.text isEqualToString:@""] || [text2.text isEqualToString:@""]) {
        UIButton *loginbtn = (UIButton *)[self.view viewWithTag:1006];
        loginbtn.alpha = 0.3;
        loginbtn.userInteractionEnabled = NO;
    }else {
        UIButton *loginbtn = (UIButton *)[self.view viewWithTag:1006];
        loginbtn.alpha = 1;
        loginbtn.userInteractionEnabled = YES;
    }

}

#pragma mark -------------------------------------------------UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self textfieldResignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self textfieldResignFirstResponder];
    
}
- (void)textfieldResignFirstResponder
{
    for (int i = 0; i < 4; i++) {
        UITextField * textField = (UITextField *)[self.view viewWithTag:1001+i];
        [textField resignFirstResponder];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
//    NSLog(@"string == %@",string);
//    UITextField * textFiled1 = (UITextField *)[self.view viewWithTag:1001];
//    UITextField * textFilde2 = (UITextField *)[self.view viewWithTag:1002];
//    UITextField * textFilde3 = (UITextField *)[self.view viewWithTag:1003];
    //计算剩下多少文字可以输入
    if (textField.tag == 1001) {
        if(range.location>=11)
        {
            return NO;
        }else{
            return YES;
        }

    }else if (textField.tag == 1003||textField.tag == 1004){
        if (range.location >=12) {
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
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;

    if (textField.tag == 1001 ||textField.tag == 1002) {
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

    }

}


#pragma mark ---------------------------------------------------------- Actions

- (void)keyBtnAction:(UIButton *)btn
{
    [self textfieldResignFirstResponder];
}
- (void)backAction:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)showpassword:(UIButton *)btn
//{
//    UITextField * textField = (UITextField *)[self.view viewWithTag:1003];
//    if (btn.selected == YES) {
//        textField.secureTextEntry = NO;
//        
//    }else{
//        textField.secureTextEntry = YES;
//    }
//    btn.selected = !btn.selected;
//}

- (void)yanZhengAction:(UIButton *)button {
    NSLog(@"获取验证码");
    UITextField * mobile = (UITextField *)[self.view viewWithTag:1001];
    if ([mobile.text isEqualToString:@""]) {
        alertView.message = @"手机号不能为空，请重新输入";
        [alertView show];
    }
    if ([YXBTool validateMobile:mobile.text] == NO) {
        alertView.title = @"温馨提示";
        alertView.message = @"请输入正确的手机号码";
        [alertView show];
        
    }else{
        button.userInteractionEnabled = NO;
//        button.selected = YES;
        [self getVerifyCode];
        
    }
    
}

- (void)tiJiaoAction:(UIButton *)button {

    UITextField * phone = (UITextField *)[self.view viewWithTag:1001];
    UITextField * yzm = (UITextField *)[self.view viewWithTag:1002];


    if ( [yzm.text isEqualToString:@""]) {
        alertView.title = @"温馨提示";
        alertView.message = @"请输入验证码";
        [alertView show];
        
    }else if ([YXBTool validateMobile:phone.text] == NO) {
        alertView.title = @"温馨提示";
        alertView.message = @"请输入正确的手机号码";
        [alertView show];
    }else if ([self ValidateYAM:yzm.text]== NO){
        alertView.title = @"温馨提示";
        alertView.message = @"请输入正确的验证码";
        [alertView show];

    }else{
        [self userReg];

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
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    NSLog(@"%d",[passWordPredicate evaluateWithObject:passWord]);
   
    return [passWordPredicate evaluateWithObject:passWord];
    
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark---------------------------cpbTimerDelegate
- (void)CPBTimerManagerAction:(CPBTimerManager *)timer
{

    if (time <60) {
        
        time ++;

        _timeLabel.hidden = NO;
        _timeLabel.text = [NSString stringWithFormat:@"剩余%ld秒",60- time];
    }else{
        [verifyTimer stop];

        UIButton * ybtn = (UIButton *)[self.view viewWithTag:1005];
        ybtn.userInteractionEnabled = YES;
        ybtn.alpha = 1;
        _timeLabel.hidden = YES;
        time = 0;
        
        
    }
    
}

#pragma mark -----------------------------------------------HttpDownLoad
- (void)getVerifyCode
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[[HttpOperator alloc]init]autorelease];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCThreeViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        [this httpLoadParams:assginHtttperator];
     
        
    } complete:^(TResultSet * r, int taskid) {

        [this httpLoadComplete:r];
       
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    UserManager * _tesult = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[TResultSet class]];
    UITextField * userText = (UITextField *)[self.view viewWithTag:1001];
    NSLog(@"tuserrr =%@",userText.text);
    [_tesult getVerifyCode:userText.text request_type:1];
    
}
- (void)httpLoadComplete:(TResultSet *)r{
    if (r.errCode !=0) {
        alertView.title = @"温馨提示";
        alertView.message =r.errString;
        [alertView show];
        UIButton * btn  = (UIButton *)[self.view viewWithTag:1005];
        btn.userInteractionEnabled = YES;
    }else{
        alertView.title = @"短信已下发,请注意查收";
        alertView.message =r.errString;
        [alertView show];
        verifyTimer = [[CPBTimerManager alloc]initWithTimeInterval:1.0 userInfo:Nil repeats:YES];
        verifyTimer.delegate = self;
        UIButton * ybtn = (UIButton *)[self.view viewWithTag:1005];
        ybtn.backgroundColor = [UIColor lightGrayColor];
        ybtn.userInteractionEnabled = NO;
        ybtn.alpha = 0.3f;
    }
    

}

- (void)userReg
{
//    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[[HttpOperator alloc]init]autorelease];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCThreeViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {

        [this httpLoadParamsTwo:assginHtttperator];
    } complete:^(TResultSet * r, int taskid) {
        [this httpLoadCompleteTwo:r];
        
    }];
    [self.iHttpOperator connect];

}
- (void)httpLoadParamsTwo:(HttpOperator *)assginHtttperator{

    UserManager * _tesult = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[TResultSet class]];
    UITextField * userText = (UITextField *)[self.view viewWithTag:1001];
    UITextField * yzmText = (UITextField *)[self.view viewWithTag:1002];
    [_tesult checkVerifyCode:userText.text verifyCode:yzmText.text requestType:1];
    //        [_tesult release];

}
- (void)httpLoadCompleteTwo:(TResultSet *)r{

    if (r.errString == nil) {
        alertView.title = @"温馨提示";
        alertView.message = @"服务器异常(-1)";
        [alertView show];
        
        return;
    }
    if (r.errCode == 0) {
        UITextField * userText = (UITextField *)[self.view viewWithTag:1001];
        UITextField * yzmText = (UITextField *)[self.view viewWithTag:1002];
        QCRegisterfourViewController *reFour = [[QCRegisterfourViewController alloc] init];
        reFour.yzmStr = yzmText.text;
        reFour.userTextiphone = userText.text;
        [self.navigationController pushViewController:reFour animated:YES];
        
    }else{
        alertView.title = @"温馨提示";
        alertView.message = r.errString;
        [alertView show];
        
    }

}

#pragma mark  ---------------------------------------------------keyBoard
- (void)getkeyboundheight
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardShow:(NSNotification *)aNotification
{
//    NSDictionary *info = [aNotification userInfo];
//    NSValue * aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGSize keyBoardSize = [aValue CGRectValue].size;
    [UIView animateWithDuration:0.25 animations:^{
        if (kDeviceHeight <= 480) {
//            _tableView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight+5);
            
        }else{
//            _tableView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight);
        }
        
    }];
    
}

- (void)keyboardHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.1 animations:^{
        if (kDeviceHeight <= 480) {
//            _tableView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight-64);
            
        }else{
//            _tableView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight-64);
        }
        
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    verifyTimer.delegate = nil;
//    [verifyTimer stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
