//
//  QCLoginTwoViewController.m
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCLoginTwoViewController.h"
#import "QCLoginOneViewController.h"
#import "CPBTimerManager.h"
#import "HttpOperator.h"
#import "UserManager.h"
#import "MyMD5.h"
#import "QCModifyPassWordViewController.h"
#import "YXBTool.h"

#define kVerifyColor rgb(226,225,230,1)

@interface QCLoginTwoViewController ()<CPBTimerDelegate,UIScrollViewDelegate>
{
    UITableView * _tableView;
    NSInteger time;
    CPBTimerManager * verifyTimer;
    UILabel     *_timeLabel;


}
@end

@implementation QCLoginTwoViewController

- (void)dealloc
{
    [self removeNotification];
    [verifyTimer release];
    [_tableView release];
    self.iHttpOperator = nil;
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
    [self createUI];
    [self getkeyboundheight];
}

#pragma mark ---------------------------------------------------------CreatUI
- (void)setNavigationItem
{
    [self setTitle:@"忘记密码"];
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
}
//创建UI
- (void)createUI
{
    self.view.backgroundColor = rgb(237, 237, 246, 1);
    [self CreateTextFieldWithFrame:CGRectMake(15, 15, kDeviceWidth/3*2-40, kTextFieldHeight) withCapacity:@" 手机号" withSecureTextEntry:NO withTargrt:self withTag:201 view:self.view];
    UITextField * textFild1 = (UITextField *)[self.view viewWithTag:201];
    textFild1.keyboardType = UIKeyboardTypeNumberPad;
    UILabel *leftView1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, textFild1.height)];
    textFild1.leftViewMode = UITextFieldViewModeAlways;
    textFild1.leftView = leftView1;
    textFild1.backgroundColor = [UIColor whiteColor];
    textFild1.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
    textFild1.layer.borderWidth = 1;
//    textFild1.textAlignment = NSTextAlignmentCenter;
    //验证码按钮
    [self createButtonWithframe:CGRectMake(kDeviceWidth/3*2-10, 15, kDeviceWidth/3-5,kTextFieldHeight) withImage:@"" withView:self.view withTarget:self withAcation:@selector(getVerificationCode:) withTag:211];
    UIButton * ybtn = (UIButton *)[self.view viewWithTag:211];
    [ybtn setBackgroundImage:[UIImage imageNamed:@"message-vali-but.png"] forState:UIControlStateNormal];
    
    
    
    [self CreateTextFieldWithFrame:CGRectMake(15, textFild1.bottom+15, kDeviceWidth-30, kTextFieldHeight) withCapacity:@" 请输入验证码" withSecureTextEntry:NO withTargrt:self withTag:202 view:self.view];
    UITextField * textFild2 = (UITextField *)[self.view viewWithTag:202];
    textFild2.keyboardType = UIKeyboardTypeNumberPad;
    UILabel *leftView2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, textFild1.height)];
    textFild2.leftViewMode = UITextFieldViewModeAlways;
    textFild2.leftView = leftView2;
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
    
    [self createButtonWithframe:CGRectMake(15, textFild2.bottom+20, kDeviceWidth-30, kTextFieldHeight) withImage:@"val-telphone-but" withView:self.view withTarget:self withAcation:@selector(submitClicked) withTag:212];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(butuserInteractionEnabled) name:UITextFieldTextDidChangeNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(butuserInteractionEnabled) name:UITextFieldTextDidBeginEditingNotification object:nil];

}

- (void)butuserInteractionEnabled {
    UITextField * text1 = (UITextField *)[self.view viewWithTag:201];
    UITextField * text2 = (UITextField *)[self.view viewWithTag:202];
    if ([text1.text isEqualToString:@""] || [text2.text isEqualToString:@""]) {
        UIButton *loginbtn = (UIButton *)[self.view viewWithTag:212];
        loginbtn.alpha = 0.3;
        loginbtn.userInteractionEnabled = NO;
    }else {
        UIButton *loginbtn = (UIButton *)[self.view viewWithTag:212];
        loginbtn.alpha = 1;
        loginbtn.userInteractionEnabled = YES;
    }
}

- (UIView *)createTextFiledbgViewframe:(CGRect)frame
{
    UIView * textbgView1 = [[[UIView alloc]initWithFrame:frame]autorelease];
    textbgView1.backgroundColor = [UIColor whiteColor];
    textbgView1.layer.borderColor = [rgb(215, 208, 198, 1) CGColor];
    textbgView1.layer.borderWidth = 1;
    [_tableView addSubview:textbgView1];
    return textbgView1;
}

#pragma mark ------------------------------------------------UITextFieldDelegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    [self textfieldResignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self textfieldResignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if (textField.tag == 201) {
        if (range.location >=11) {
            return NO;
        }else{
            return YES;
        }
    }else if (textField.tag == 203||textField.tag == 204){
        if (range.location >= 12) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

- (void)textfieldResignFirstResponder
{
    for (int i = 0; i < 4; i++) {
        UITextField * textField = (UITextField *)[self.view viewWithTag:201+i];
        [textField resignFirstResponder];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;

    if (textField.tag == 201||textField.tag == 202) {
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
#pragma  mark --------------------------------------------------------Action
- (void)keyBtnAction:(UIButton *)btn
{
    [self textfieldResignFirstResponder];
}

//获取验证码
- (void)getVerificationCode:(UIButton *)btn
{
    UITextField * phone = (UITextField *)[self.view viewWithTag:201];
    if ([YXBTool validateMobile:phone.text] == NO) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入有效的手机号码来获取验证码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        
    }else{

        btn.userInteractionEnabled = NO;
        [self getVerifyCode];
    }
}

//手机号码验证
- (BOOL) validateMobile:(NSString *)mobile
{
    
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    NSLog(@"%d",[phoneTest evaluateWithObject:mobile]);
    return [phoneTest evaluateWithObject:mobile];
}

//提交响应
- (void)submitClicked
{
    UITextField * phone = (UITextField *)[self.view viewWithTag:201];

    if(![YXBTool validateMobile:phone.text]){
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }else{
        [self resetPwd];
  
    }
}
//左键响应
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

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
        _timeLabel.text = [NSString stringWithFormat:@"剩余%ld秒",(long)(60- time)];
    }else{
        [verifyTimer stop];
//        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        UIButton * ybtn = (UIButton *)[self.view viewWithTag:211];
        ybtn.backgroundColor = [UIColor lightGrayColor];
        ybtn.userInteractionEnabled = YES;
        ybtn.alpha = 1;
        _timeLabel.hidden = YES;
        time = 0;
        
        
    }
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    verifyTimer.delegate = nil;
//    [verifyTimer stop];
}

#pragma mark -----------------------------------------------HttpDownLoad
- (void)getVerifyCode
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[[HttpOperator alloc]init]autorelease];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCLoginTwoViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
         [this httpLoadError:error];
        
    } param:^(NSString *s) {

        [this httpLoadParams:s assginHtttperator:assginHtttperator];
        
    } complete:^(TResultSet * r, int taskid) {

        [this httpLoadComplete:r];
        
        
    }];
    [self.iHttpOperator connect];
    
}

- (void)resetPwd
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[[HttpOperator alloc]init]autorelease];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCLoginTwoViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        [this httpLoadParamsTwo:s assginHtttperator:assginHtttperator];
        
    } complete:^(TResultSet * r, int taskid) {
        [this httpLoadCompleteTwo:r];
        
    }];
    [self.iHttpOperator connect];
    
    
}

- (void)httpLoadParams:(NSString *)s assginHtttperator:(HttpOperator *)assginHtttperator{
    
    UserManager * _tesult = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[TResultSet class]];
    UITextField * userText = (UITextField *)[self.view viewWithTag:201];
    //[_tesult getVerifyCode:userText.text request_type:2];
    [_tesult getAlterPsdVerifyCode:userText.text];
    //        [_currUser release];

}
- (void)httpLoadComplete:(TResultSet *)r{

    if (r.errCode !=0) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        UIButton * ybtn = (UIButton *)[self.view viewWithTag:211];
        ybtn.userInteractionEnabled = YES;
    }else{
        verifyTimer = [[CPBTimerManager alloc]initWithTimeInterval:1.0 userInfo:Nil repeats:YES];
        verifyTimer.delegate = self;
        UIButton * ybtn = (UIButton *)[self.view viewWithTag:211];
        ybtn.backgroundColor = [UIColor lightGrayColor];
        ybtn.userInteractionEnabled = NO;
        ybtn.alpha = 0.3f;
    }
}

- (void)httpLoadParamsTwo:(NSString *)s assginHtttperator:(HttpOperator *)assginHtttperator{

            UserManager * _tesult = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[TResultSet class]];
            UITextField * userText = (UITextField *)[self.view viewWithTag:201];
            UITextField * yzmText = (UITextField *)[self.view viewWithTag:202];
    
            [_tesult checkVerifyCode:userText.text verifyCode:yzmText.text requestType:2];
    
}
- (void)httpLoadCompleteTwo:(TResultSet *)r{

    if (r.errCode == 0) {
        //            [this showLoadingWithTitle:@"修改成功" imageName:@"friends_send"];
        //
        //            [this performSelector:@selector(hideLoading) withObject:nil afterDelay:2];
        //
        //            [this.navigationController popViewControllerAnimated:YES];
        QCModifyPassWordViewController *moPass = [[QCModifyPassWordViewController alloc] init];
        UITextField * userText = (UITextField *)[self.view viewWithTag:201];
        UITextField * yzmText = (UITextField *)[self.view viewWithTag:202];
        moPass.yzmStr = yzmText.text;
        moPass.userTextiphone = userText.text;
        [self.navigationController pushViewController:moPass animated:YES];
    }else{
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        
    }


}

#pragma mark  ---------------------------------------------------keyBoard

- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
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
            _tableView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight+5);
            
        }else{
            _tableView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight);
        }
        
    }];
    
}

- (void)keyboardHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.1 animations:^{
        if (kDeviceHeight <= 480) {
            _tableView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight-64);
            
        }else{
            _tableView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight-64);
        }
        
        
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
