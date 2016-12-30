//
//  GestureLoginViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "GestureLoginViewController.h"
#import "YLInitSwipePasswordController.h"
#import "QCUserModel.h"
#import "MyMD5.h"

@interface GestureLoginViewController ()
{
    UITextField * _textField;
    UIButton * sureBtn;
}
@end

@implementation GestureLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb(239, 239, 239, 1);
    
    [self setTitle:@"验证登录密码"];
    
    // Do any additional setup after loading the view.
    _textField = [[QCBaseTextField alloc]initWithFrame:CGRectMake(10, 40,kDeviceWidth-20, 40)];
    _textField.secureTextEntry = YES;
//    _textField.borderStyle = UITextBorderStyleLine;
    _textField.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 40)];
//    label.backgroundColor = [UIColor redColor];
    label.text = @"登录密码";
    label.textAlignment = NSTextAlignmentCenter;
    _textField.leftView = label;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_textField];

    sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, kDeviceWidth-20, 40)];
    sureBtn.backgroundColor = rgb(51, 142, 250, 1.0);
    sureBtn.layer.cornerRadius = 5.0;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];

    [sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
}

- (void)sureBtnAction:(UIButton *)sender
{
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:_textField.text]]];

    if ([userModel.user.pwd isEqualToString:pwd]){
        QCUserManager * um = [QCUserManager sharedInstance];
        userModel.gestureOpen = _gestureSwith;
        [um setLoginUser:userModel];
        
        if (_gestureSwith) {
            YLInitSwipePasswordController * passWordViewController = [[YLInitSwipePasswordController alloc]init];
            [self.navigationController pushViewController:passWordViewController animated:YES];
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
//        
//        YLInitSwipePasswordController * passWordViewController = [[YLInitSwipePasswordController alloc]init];
//        [self.navigationController pushViewController:passWordViewController animated:YES];
    }else{
        UIAlertView * alertView;
        if (alertView == nil) {
             alertView= [[UIAlertView alloc]initWithTitle:nil message:@"密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        }
       
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
