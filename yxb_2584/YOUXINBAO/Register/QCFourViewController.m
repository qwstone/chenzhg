//
//  QCFourViewController.m
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCFourViewController.h"
#import "QCFiveViewController.h"
#import "HttpOperator.h"
#import "UserManager.h"
#import "FMDeviceManager.h"
#import "QCLoginOneViewController.h"
#import "YXBTool.h"

@interface QCFourViewController ()<UITextFieldDelegate>

@end

@implementation QCFourViewController

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
	// Do any additional setup after loading the view.
    self.iHttpOperator = nil;

    [self setNavigationItem];
    [self createUI];

}

#pragma mark -----------------------------------------------------CreatUI
- (void)setNavigationItem
{
    self.title = @"身份验证(1/2)";

    //返回按钮
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(backAction)];
    [self setNavigationButtonItrmWithiamge:@"register_tiaoguo1.png" withRightOrleft:@"right" withtargrt:self withAction:@selector(overleapAction)];
}

- (void)createUI
{
    //身份证号
    UIView * textbgView1 = [[UIView alloc]initWithFrame:CGRectMake(10, 20, kDeviceWidth-20, 35)];
    textbgView1.backgroundColor = [UIColor whiteColor];
    textbgView1.layer.borderColor = [rgb(215, 208, 198, 1) CGColor];
    textbgView1.layer.borderWidth = 1;
    [self.view addSubview:textbgView1];
    [textbgView1 release];
    [self CreateTextFieldWithFrame:CGRectMake(10, 0, kDeviceWidth-20, 35) withCapacity:@"请输入身份证号" withSecureTextEntry:NO withTargrt:self withTag:1001 view:textbgView1];
    UITextField * textfield1 = (UITextField *)[self.view viewWithTag:1001];
    textfield1.returnKeyType = UIReturnKeyDone;
//    textfield1.text = @"152527199405020315";
//    textfield1.keyboardType = UIKeyboardTypeNumberPad;
    


    //真实姓名
    UIView * textbgView2 = [[UIView alloc]initWithFrame:CGRectMake(10, 70, kDeviceWidth-20, 35)];
    textbgView2.backgroundColor = [UIColor whiteColor];
    textbgView2.layer.borderColor = [rgb(215, 208, 198, 1) CGColor];
    textbgView2.layer.borderWidth = 1;
    [self.view addSubview:textbgView2];
    [textbgView2 release];
    [self CreateTextFieldWithFrame:CGRectMake(10, 0, kDeviceWidth-20, 35) withCapacity:@"请输入真实姓名" withSecureTextEntry:NO withTargrt:self withTag:1002 view:textbgView2];
    
    UITextField * textfiledname = (UITextField *)[self.view viewWithTag:1002];
//    textfiledname.text = @"等等";
    textfiledname.returnKeyType = UIReturnKeyDone;
    //确定
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 120, kDeviceWidth, 50)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView release];
    [self createButtonWithframe:CGRectMake(10, 5, kDeviceWidth-20, 40) withImage:@"register_sure.png" withView:bgView withTarget:self withAcation:@selector(completeAction:) withTag:1005];
}
#pragma mark ------------------------------------------------- Actions
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController dismissModalViewControllerAnimated:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)overleapAction
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"验证身份后才能申请借款,您也可以在申请之前验证" delegate:self cancelButtonTitle:@"继续验证" otherButtonTitles:@"以后验证", nil];
    alertView.tag = 333;
    [alertView show];
    [alertView release];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1&&alertView.tag ==333) {
        [self httpLogin];
    }else{
        
    }
}


- (void)completeAction:(UITapGestureRecognizer *)tap {
    UITextField * id = (UITextField *)[self.view viewWithTag:1001];
    UITextField * name = (UITextField *)[self.view viewWithTag:1002];
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"身份证号或名字输入有误请核对" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];

//    if ([id.text isEqualToString:@""]) {
//        alert.title = @"温馨提示";
//        [alert show];
//    }else if ([name.text isEqualToString:@""]){
//        alert.title = @"温馨提示";
//        alert.message = @"请输入真实姓名";
//        [alert show];
//
//    }
    if ([self validateIdentityCard:id.text] == NO) {
        alert.message = @"请输入正确的身份证号码";

        [alert show];
    }else if([name.text isEqualToString:@""]){
        alert.message = @"请输入真实姓名";
        [alert show];

    } else{
        QCFiveViewController * fiveView = [[QCFiveViewController alloc]init];
        fiveView.realName =  name.text;
        fiveView.idCardNo = id.text;
        [self.navigationController pushViewController:fiveView animated:YES];
        [fiveView release];
    
    }
}
//身份证号
- (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


#pragma mark --------------------------------------------UITextFieldDelegate
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
    for (int i = 0; i < 2; i++) {
        UITextField * textField = (UITextField *)[self.view viewWithTag:1001+i];
        [textField resignFirstResponder];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 1001) {
        if (range.location>17) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;

    if (textField.tag == 1001) {
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

#pragma mark -----------------------------httpDownload
- (void)keyBtnAction:(UIButton *)btn
{
    [self textfieldResignFirstResponder];
}


//自动登录
- (void)httpLogin
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[[HttpOperator alloc]init]autorelease];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCFourViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {

        [this httpLoadParams:assginHtttperator];
        
    } complete:^(User* r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    UserManager* _currUser = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[User class]];
    QCUserModel * userModer = [[QCUserManager sharedInstance]getLoginUser];
//    [_currUser userLogin:userModer.user.username pass:userModer.user.pwd];
    NSString *blackBox = [YXBTool getFMString];
    [_currUser userLoginWithFraudmetrix:userModer.user.username pwd:userModer.user.pwd fraudmetrixToken:blackBox];

}
- (void)httpLoadComplete:(User *)r{
    
    if (r.errCode ==0) {
        
        QCUserModel * currUser = [[QCUserModel alloc]init];
        currUser.isLogin = YES;
        currUser.user = r;
        TUnreadFlagCount * loanCount = [[TUnreadFlagCount alloc]init];
        currUser.unreadCont = loanCount;
        [loanCount release];
        currUser.unreadCont.lastQueryDate = @"";
        QCUserManager * um  = [QCUserManager sharedInstance];
        
        [um setLoginUser:currUser];
        [currUser release];
        
        //            [self.navigationController dismissModalViewControllerAnimated:YES];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        NSString * string = r.errString;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
