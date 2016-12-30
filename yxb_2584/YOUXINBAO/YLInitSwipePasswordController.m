//
//  YLInitSwipePasswordController.m
//  YLSwipeLockViewDemo
//
//  Created by 肖 玉龙 on 15/2/27.
//  Copyright (c) 2015年 Yulong Xiao. All rights reserved.
//

#import "YLInitSwipePasswordController.h"
#import "YLSwipeLockView.h"
#import "ModificationViewController.h"
#import "RootViewController.h"
#import "QCLoginOneViewController.h"
#import "GestureViewController.h"
@interface YLInitSwipePasswordController ()<YLSwipeLockViewDelegate>
@property (nonatomic, weak) YLSwipeLockView *lockView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, strong) NSString *passwordString;
@property (nonatomic, weak) UIButton *resetButton;
@property (nonatomic, strong)UIBarButtonItem * rightItem;
@end

@implementation YLInitSwipePasswordController


#pragma mark ----------------------------------------------------------CreatUI
- (void)setNavigationItem
{
    [self setTitle:@"绘制手势密码"];
    self.view.backgroundColor = kCustomBackground;
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
}

//左键响应
- (void)leftClicked
{
    //    [self.navigationController dismissModalViewControllerAnimated:YES];
    if (self.isRegisterLogen == YES) {//如果是注册进来的
        QCLoginOneViewController *logon = [[QCLoginOneViewController alloc] init];
//        logon.isLogon = YES;
        [self.navigationController pushViewController:logon animated:YES];
    }else {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *gp = [userDefault objectForKey:@"gesturePassword"];
        NSLog(@"gp--%@",gp);
        if (gp == nil || [gp isEqualToString:@""]) {
            QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
            model.gestureOpen = NO;
            [userDefault setObject:nil forKey:@"gesturePassword"];
            [userDefault synchronize];
            [[QCUserManager sharedInstance] setLoginUser:model];
            for (UIViewController *vc in [self.navigationController viewControllers]) {
                if ([vc isKindOfClass:[GestureViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                    return;
                }
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self.navigationController popToRootViewControllerAnimated:YES];

        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItem];
    self.view.backgroundColor = [UIColor colorWithRed:35/255.0 green:39/255.0 blue:54/255.0 alpha:1];
    
    CGFloat viewWidth = self.view.bounds.size.width - 40;
    CGFloat viewHeight = viewWidth;
    
    NSString *savedPassword = [[NSUserDefaults standardUserDefaults] objectForKey:@"gesturePassword"];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    if (savedPassword.length == 0 || savedPassword == nil) {
       titleLabel.text = @"请绘制手势密码";
    }else {
        titleLabel.text = @"请重新绘制手势密码";
        
    }
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.frame = CGRectMake(40, 130, self.view.bounds.size.width - 80, 20);
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    YLSwipeLockView *lockView = [[YLSwipeLockView alloc] initWithFrame:CGRectMake(20, (self.view.bounds.size.height - viewHeight - 64)/2, viewWidth, viewHeight)];
    [self.view addSubview:lockView];
    
    self.lockView = lockView;
    self.lockView.delegate = self;
    
    //调整titleLabel位置
    titleLabel.frame = CGRectMake(40, (lockView.top-20)/2, self.view.bounds.size.width - 80, 20);
    
    if (_isRegisterLogen) {
        UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(0, (titleLabel.top-15)/3, kDeviceWidth, 15)];
        tip.backgroundColor = [UIColor clearColor];
        tip.textColor = [UIColor redColor];
        tip.textAlignment = NSTextAlignmentCenter;
        tip.font = [UIFont systemFontOfSize:13.5];
        tip.text = @"恭喜您，已注册成功！";
        [self.view addSubview:tip];
    }
    
    UIButton *resetButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 70, 80, 20)];
    [resetButton setTitle:@"重新设置" forState:UIControlStateNormal];
    [resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    resetButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [resetButton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    self.resetButton = resetButton;
    self.resetButton.hidden = YES;
    
    
    if (self.isRegisterLogen == YES) {
    _rightItem = [[UIBarButtonItem alloc]initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(rightNavigationItemAction)];
        _rightItem.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = _rightItem;
        titleLabel.text = @"绘制一个手势密码来保护隐私吧";
    }
}

- (void)rightNavigationItemAction {
    ModificationViewController * modificationViewController = [[ModificationViewController alloc]init];
    modificationViewController.isRegisterLogen = YES;
    [self.navigationController pushViewController:modificationViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(YLSwipeLockViewState)swipeView:(YLSwipeLockView *)swipeView didEndSwipeWithPassword:(NSString *)password
{
    if (self.passwordString == nil) {
        self.passwordString = password;
        self.titleLabel.text = @"请再次绘制手势密码";
        return YLSwipeLockViewStateNormal;
    }else if ([self.passwordString isEqualToString:password]){
        self.titleLabel.text = @"设置成功";
        self.passwordString = nil;
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:password forKey:@"gesturePassword"];
        
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        return YLSwipeLockViewStateSelected;
    }else{
        self.titleLabel.text = @"两次绘制不一样";
        self.resetButton.hidden = NO;
        return YLSwipeLockViewStateWarning;
    }
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)dismiss{
    if (self.isRegisterLogen == YES) {//如果是注册进来的
        ModificationViewController *logon = [[ModificationViewController alloc] init];
        logon.isRegisterLogen = YES;
        [self.navigationController pushViewController:logon animated:YES];
    }else {
    
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{//设置手势密码进来的
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[GestureViewController class]]) {
                    
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
            
        }
    }
}

-(void)reset
{
    self.passwordString = nil;
    self.titleLabel.text = @"请重新绘制手势密码";
    self.resetButton.hidden = YES;
}

@end
