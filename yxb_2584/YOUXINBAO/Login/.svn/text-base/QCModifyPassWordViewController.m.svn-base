//
//  QCModifyPassWordViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/5/12.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCModifyPassWordViewController.h"

@interface QCModifyPassWordViewController ()<CPBTimerDelegate>
{
    //    UITableView * _tableView;
    CPBTimerManager * verifyTimer;
    long time;
    NSString * verifyCode;
    UIAlertView * alertView;
    
    UILabel     *_timeLabel;
    
}

@end

@implementation QCModifyPassWordViewController


- (void)dealloc{
    
    NSLog( @"ffsd");
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
    self.title = @"修改密码";
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(backAction:)];
//    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(rightNavigationItemAction)];
//    rightItem.tintColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)rightNavigationItemAction {
    QCLoginOneViewController *logon = [[QCLoginOneViewController alloc] init];
    [self.navigationController pushViewController:logon animated:YES];
}

- (void)CreatUI
{
    self.view.backgroundColor = rgb(237, 236, 246, 1);
    UIView * textbgView1 = [[UIView alloc]initWithFrame:CGRectMake(15, 15, kDeviceWidth-30, (kDeviceWidth-30)/6)];
    textbgView1.backgroundColor = [UIColor whiteColor];
    textbgView1.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
    textbgView1.layer.borderWidth = 1;
    [self.view addSubview:textbgView1];
    [self CreateLabel:@"新 密 码" frame:CGRectMake(0, 0, 90, (kDeviceWidth-30)/6) withView:textbgView1 textAlignment:1 fontSize:15 textColor:[UIColor blackColor]];
    [self CreateTextFieldWithFrame:CGRectMake(100, 0, kDeviceWidth-30-100, (kDeviceWidth-30)/6) withCapacity:@" 请设置6-16位登录密码" withSecureTextEntry:NO withTargrt:self withTag:1003 view:textbgView1];
    UITextField * textFild1 = (UITextField *)[self.view viewWithTag:1003];
    textFild1.keyboardType = UIKeyboardTypeDefault;
    textFild1.backgroundColor = [UIColor whiteColor];
    textFild1.secureTextEntry = YES;
//    textFild1.textAlignment = NSTextAlignmentCenter;

    UIView * textbgView2 = [[UIView alloc]initWithFrame:CGRectMake(15, textbgView1.bottom+15, kDeviceWidth-30, (kDeviceWidth-30)/6)];
    textbgView2.backgroundColor = [UIColor whiteColor];
    textbgView2.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
    textbgView2.layer.borderWidth = 1;
    [self.view addSubview:textbgView2];
    [self CreateLabel:@"再次确认" frame:CGRectMake(0, 0, 90, (kDeviceWidth-30)/6) withView:textbgView2 textAlignment:1 fontSize:15 textColor:[UIColor blackColor]];
    [self CreateTextFieldWithFrame:CGRectMake(100, 0, kDeviceWidth-30-100, (kDeviceWidth-30)/6) withCapacity:@" 请再次输入密码" withSecureTextEntry:NO withTargrt:self withTag:1004 view:textbgView2];
    UITextField * textFild2 = (UITextField *)[self.view viewWithTag:1004];
    textFild2.keyboardType = UIKeyboardTypeDefault;
    textFild2.backgroundColor = [UIColor whiteColor];
    textFild2.secureTextEntry = YES;
//    textFild2.textAlignment = NSTextAlignmentCenter;

    [self createButtonWithframe:CGRectMake(15, textbgView2.bottom+20, kDeviceWidth-30, (kDeviceWidth-30)/6) withImage:@"ok-but" withView:self.view withTarget:self withAcation:@selector(tiJiaoAction:) withTag:1006];
    
    [self butuserInteractionEnabled];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(butuserInteractionEnabled) name:UITextFieldTextDidChangeNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(butuserInteractionEnabled) name:UITextFieldTextDidBeginEditingNotification object:nil];
    alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
}


- (void)butuserInteractionEnabled {
    UITextField * text1 = (UITextField *)[self.view viewWithTag:1003];
    UITextField * text2 = (UITextField *)[self.view viewWithTag:1004];
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

    if (textField.tag == 1001) {
        if(range.location>=11)
        {
            return NO;
        }else{
            return YES;
        }
        
    }else if (textField.tag == 1003||textField.tag == 1004){
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
    [self butuserInteractionEnabled];
    if (textField.tag == 1003) {
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self butuserInteractionEnabled];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    if (textField.tag == 1003 ||textField.tag == 1004) {
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


- (void)tiJiaoAction:(UIButton *)button {
    UITextField * password = (UITextField *)[self.view viewWithTag:1003];
    UITextField * agPassword = (UITextField *)[self.view viewWithTag:1004];
    
    if ([password.text isEqualToString:@""]) {
        alertView.title = @"温馨提示";
        alertView.message = @"请您完善您的信息,才能提交";
        [alertView show];
        
    }else if ([self validatePassword:password.text] == NO || [self isPureInt:password.text]== YES){
        alertView.title = @"温馨提示";
        alertView.message = @"密码格式错误，请输入正确的密码";
        [alertView show];
    }else if (![password.text isEqualToString:agPassword.text]) {
        alertView.title = @"温馨提示";
        alertView.message = @"两次输入的密码不一致，请重新输入";
        [alertView show];
        
    }else {
        [self userReg];
    }
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
    UIButton * btn  = (UIButton *)[self.view viewWithTag:1005];
    
    //    NSLog(@"w");
    if (time <60) {
        
        time ++;
        //        [btn setTitle:[NSString stringWithFormat:@"%ld秒后再次获取",60- time] forState:UIControlStateNormal];
        ////        btn.userInteractionEnabled= NO;
        _timeLabel.hidden = NO;
        _timeLabel.text = [NSString stringWithFormat:@"剩余%ld秒",60- time];
    }else{
        [verifyTimer stop];
        //        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        //        btn.backgroundColor = [UIColor lightGrayColor];
        btn.userInteractionEnabled = YES;
        _timeLabel.hidden = YES;
        time = 0;
        
        
    }
    
}

#pragma mark -----------------------------------------------HttpDownLoad

- (void)userReg
{
    //    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCModifyPassWordViewController *this = self;
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
            UITextField * wde = (UITextField *)[self.view viewWithTag:1003];
            NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:wde.text]]];
    
            [_tesult resetPwd:self.userTextiphone verifyCode:self.yzmStr newPwd:pwd];

}
- (void)httpLoadComplete:(TResultSet *)r{

    if (r.errString == nil) {
        alertView.title = @"温馨提示";
        alertView.message = @"服务器异常(-1)";
        [alertView show];
        
        return;
    }
    if (r.errCode == 0) {
        
        if (r.errCode == 0) {
            [self showLoadingWithTitle:@"修改成功" imageName:@"friends_send"];
            
            [self performSelector:@selector(hideLoading) withObject:nil afterDelay:2];
            
            //        [this.navigationController popViewControllerAnimated:YES];
            QCLoginOneViewController *logon = [[QCLoginOneViewController alloc] init];
            [self.navigationController pushViewController:logon animated:YES];
            
        }else{
            UIAlertView * alertView1 = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView1 show];
            
        }
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
