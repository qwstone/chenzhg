//
//  QCMyTestViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/7/4.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCMyTestViewController.h"

@interface QCMyTestViewController ()
@property (weak, nonatomic) IBOutlet UITextField *ipField;
@property (weak, nonatomic) IBOutlet UITextField *portField;

@end

@implementation QCMyTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    [self setTitle:@"测试"];
    NSString *ip = [[NSUserDefaults standardUserDefaults] objectForKey:TestIpAddressKey];
    if (ip != nil) {
        _ipField.text = ip;
    }
    else
    {
        _ipField.text = YXB_IP_ADRESS;
    }
    
    
    NSString *port = [[NSUserDefaults standardUserDefaults] objectForKey:TestIpPortKey];
    if (port != nil) {
        _portField.text = port;
    }
    else
    {
        _portField.placeholder = @"请输入端口号";
    }

    _ipField.keyboardType = UIKeyboardTypeDecimalPad;
    _portField.keyboardType = UIKeyboardTypeDecimalPad;
    
#ifndef  __OFFICIAL_SERVER_DEBUG__
    [ProgressHUD showErrorWithStatus:@"此版本不支持切换"];
#else
#endif

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SureAction:(id)sender {
    [self.view endEditing:YES];
    NSString *str = _ipField.text;
    NSString *port = _portField.text;
    if (str != nil && port!= nil) {
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:TestIpAddressKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:port forKey:TestIpPortKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        

        [ProgressHUD showSuccessWithStatus:@"修改成功"];
    }
    else
    {
        [ProgressHUD showSuccessWithStatus:@"ip或端口号错误"];
    }
    
}
- (IBAction)defaultAction:(id)sender {
    _ipField.text = @"www.51jt.com";
    _portField.text = @"";
}

-(void)leftClicked
{
    [self.view endEditing:YES];
    [super leftClicked];
}

@end
