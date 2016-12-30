//
//  PasswordViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "PasswordViewController.h"
#import "PassWordTableViewCell.h"
#import "UserManager.h"
#import "MyMD5.h"
#import "YXBTool.h"
#import "FMDeviceManager.h"
@interface PasswordViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
//    UITextField * _OldPasswordTextField;
//    UITextField * _NewPasswordTextField;
//    UITextField * _AgainNewPassWordTextfild;
    NSArray * cellnameArray;

}
@end

@implementation PasswordViewController
-(void)dealloc{
    NSLog(@"PasswordViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = rgb(237, 237, 246, 1);
    cellnameArray = @[@"输入旧密码",@"新   密   码",@"确认新密码"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIView * sureBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/6)];
    
    UIButton * sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, kDeviceWidth-30, kDeviceWidth/6)];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"ok-but"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [sureBg addSubview:sureBtn];
    _tableView.tableFooterView = sureBg;
}

- (void)sureBtnAction:(UIButton *)sender
{
    if ([_textField.text isEqualToString:@""] || [_textField1.text isEqualToString:@""] || [_textField2.text isEqualToString:@""]) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:@"密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    if (![_textField2.text isEqualToString:_textField1.text]) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:@"两次新密码输入不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    [self httpLogin];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellnameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"celliD";

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
//    cell.leftView.text = cellnameArray[indexPath.row];
    if (indexPath.row == 0) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, kDeviceWidth-30, kDeviceWidth/6)];
        _textField.delegate =self;
        _leftView = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 110, 50)];
        _textField.secureTextEntry = YES;
        _leftView.text = cellnameArray[indexPath.row];
        _leftView.font = [UIFont systemFontOfSize:17];
        _leftView.textColor = [UIColor blackColor];
        _leftView.textAlignment = NSTextAlignmentCenter;
        _textField.leftView = _leftView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
        _textField.layer.borderWidth = 1;
        [cell.contentView addSubview:_textField];
    }else if (indexPath.row == 1){
        _textField1 = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, kDeviceWidth-30, kDeviceWidth/6)];
        _textField1.delegate =self;
        _leftView1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 110, 50)];
        _textField1.secureTextEntry = YES;
        _leftView1.text = cellnameArray[indexPath.row];
        _leftView1.font = [UIFont systemFontOfSize:17];
        _leftView1.textColor = [UIColor blackColor];
        _leftView1.textAlignment = NSTextAlignmentCenter;
        _textField1.leftView = _leftView1;
        _textField1.leftViewMode = UITextFieldViewModeAlways;
        _textField1.backgroundColor = [UIColor whiteColor];
        _textField1.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
        _textField1.layer.borderWidth = 1;
        [cell.contentView addSubview:_textField1];
    }else if (indexPath.row == 2){
        _textField2 = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, kDeviceWidth-30, kDeviceWidth/6)];
        _textField2.delegate =self;
        _leftView2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 110, 50)];
        _textField2.secureTextEntry = YES;
        _leftView2.text = cellnameArray[indexPath.row];
        _leftView2.font = [UIFont systemFontOfSize:17];
        _leftView2.textColor = [UIColor blackColor];
        _leftView2.textAlignment = NSTextAlignmentCenter;
        _textField2.leftView = _leftView2;
        _textField2.leftViewMode = UITextFieldViewModeAlways;
        _textField2.backgroundColor = [UIColor whiteColor];
        _textField2.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
        _textField2.layer.borderWidth = 1;
        [cell.contentView addSubview:_textField2];
    
    }
    
    
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIView * sendBackImage;
    if (sendBackImage == nil) {
        sendBackImage = [[UIView alloc]initWithFrame:CGRectMake(-1, 0, kDeviceWidth+2, 50)];
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
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, kDeviceWidth-20, 40)];
        [btn setBackgroundImage:[UIImage imageNamed:@"register_sure.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(keyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [sendBackImage addSubview:btn];
    }
    
    textField.inputAccessoryView = sendBackImage;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
        if (range.location >=16) {
            return NO;
        }else{
            
            return YES;
        }
}


- (void)keyBtnAction:(UIButton *)sender
{
    [_textField resignFirstResponder];
    [_textField1 resignFirstResponder];
    [_textField2 resignFirstResponder];
}



#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpLogin
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak PasswordViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_StatusCodeError) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(TResultSet* r, int taskid) {
        
        NSString * string = r.errString;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:this cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        if (r.errCode == 0) {
            [self httpLoginss];

            
        }
//        else{
//            NSString * string = r.errString;
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:this cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alertView show];
//        }
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    UserManager* _currUser = (UserManager*)  [httpOperation getAopInstance:[UserManager class] returnValue:[TResultSet class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:_textField.text]]];
    NSString * newpwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:_textField2.text]]];
    [_currUser resetPwdNew:userModel.user.yxbToken oldPwd:pwd newPwd:newpwd];
  
}
#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpLoginss
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak PasswordViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_StatusCodeError) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {

        [this httpLOad_LoginssParams:s httpOperation:assginHtttperator];
    } complete:^(User* r, int taskid) {
        
        [this httpLoad_LoginssComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOad_LoginssParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    UserManager* _currUser = (UserManager*)  [httpOperation getAopInstance:[UserManager class] returnValue:[User class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    NSString * newpwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:_textField2.text]]];
//    [_currUser userLogin:userModel.user.username pass:newpwd];
    NSString *blackBox = [YXBTool getFMString];
    [_currUser userLoginWithFraudmetrix:userModel.user.username pwd:newpwd fraudmetrixToken:blackBox];
}
//请求完成
-(void)httpLoad_LoginssComplete:(User *)r{
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
    }else{
        NSString * string = r.errString;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
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
