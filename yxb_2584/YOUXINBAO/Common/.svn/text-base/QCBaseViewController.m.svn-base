//
//  QCBaseViewController.m
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"
#import "HttpOperator.h"
#import "YXBTool.h"
#import "AppDelegate.h"
#import "JieKuanInstance.h"
@interface QCBaseViewController ()<UIGestureRecognizerDelegate>
{
    UIView *_tipView;
    UIImageView *animationView;
    NSInteger animationCount;//第一次显示加载动画
}

@end

@implementation QCBaseViewController

//- (void)dealloc {
//    Release(_tipView);
//    [super dealloc];
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"无忧借条"];

    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
       SHAREDAPP.rootNav = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:self.tabBarController.selectedIndex];
}
//跳出登陆页面
- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    //    loginNav.navigationBar.barTintColor = rgb(231, 27, 27, 1);
    //    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    loginView.modalPresentationStyle = UIModalPresentationPopover;
    [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = kCustomBackground;
    self.view.backgroundColor = [UIColor whiteColor];

// self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    animationCount = 0;
    [self setNavigationControllerImage];
    
    
}
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    if (self.navigationController.viewControllers.count == 1)//关闭主界面的右滑返回
//    {
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//}
//添加默认动画
-(void)layoutDefaultAnimation
{
    if (animationCount == 0) {
        animationCount ++;

        NSArray *animationArray=[NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"yxb_view_default1.png"],
                                 [UIImage imageNamed:@"yxb_view_default2.png"],
                                 nil];
        if (animationView == nil) {
            animationView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 60, kDeviceWidth, kDeviceHeight - 64 - 60)];
            animationView.clipsToBounds = YES;
            animationView.contentMode = UIViewContentModeCenter;
            //    animationView.backgroundColor=[UIColor purpleColor];
            animationView.animationImages=animationArray;
            animationView.animationDuration=0.2;
            animationView.animationRepeatCount=0;
            animationView.image = animationArray[0];
            [self.view addSubview:animationView];
            
        }
        [animationView startAnimating];

    }

}

//结束动画
-(void)stopDefaultAnimation
{
    if (animationView.isAnimating) {
        [animationView stopAnimating];
        [animationView removeFromSuperview];
    }
}

//设置Title
- (void)setTitle:(NSString *)title
{
    UILabel * view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 100)];
    view.text =title;
    view.textColor = [UIColor whiteColor];
    view.textAlignment = NSTextAlignmentCenter;
    view.font = [UIFont boldSystemFontOfSize:20]
    ;
    view.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = view;
//    [view release];
}
//设置UINavigation 背景
- (void)setNavigationControllerImage
{
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.barStyle =UIBarStyleBlackTranslucent;
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    if (KDeviceOSVersion < 7) {
//        self.navigationController.navigationBar.tintColor = kNavigationBar;
        
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//          [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_6.png"] forBarMetrics:UIBarMetricsDefault];
//    }else{
//        self.navigationController.navigationBar.barTintColor = kNavigationBar;
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_7.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barTintColor = rgb(231, 27, 27, 1);
//    }
//    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] initWithCGImage:[YXBTool imageWithColor:rgb(231, 27, 27, 1)].CGImage] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}


//设置UINavigation Button item
- (void)setNavigationButtonItrmWithiamge:(NSString *)imagename withRightOrleft:(NSString*)f withtargrt:(id)t withAction:(SEL)s
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn addTarget:self action:s forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    
    UIBarButtonItem * navItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if ([f isEqualToString:@"right"]) {
            self.navigationItem.rightBarButtonItem = navItem;
            
        }else if ([f isEqualToString:@"left"]){
            self.navigationItem.leftBarButtonItem = navItem;
    }
    
//    [navItem release];
}
//创建 UITextField
- (void)CreateTextFieldWithFrame:(CGRect)frame withCapacity:(NSString *)placeholder withSecureTextEntry:(BOOL)isSecoure withTargrt:(id)t withTag:(NSInteger)tag view:(UIView *)view
{
    UITextField * qcTextfield = [[UITextField alloc]initWithFrame:frame];
    [[UITextField appearance] setTintColor:[UIColor lightGrayColor]];
    //qcTextfield.background = [UIImage imageNamed:image];
    qcTextfield.backgroundColor = [UIColor clearColor];
    //qcTextfield.clearButtonMode = UITextFieldViewModeAlways;
    qcTextfield.returnKeyType = UIReturnKeyDefault;
    qcTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    qcTextfield.secureTextEntry = isSecoure;
    qcTextfield.placeholder = placeholder;
    qcTextfield.delegate = t;
    qcTextfield.tag = tag;
    [view addSubview:qcTextfield];
    
}
//创建UILabel
- (void)CreateLabel:(NSString *)text frame:(CGRect)frame withView:(UIView *)view textAlignment:(NSInteger)num fontSize:(NSInteger)size textColor:(UIColor*)color
{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:size];
    label.textAlignment = num;
    [view addSubview:label];
}

//创建UIButton
- (void)createButtonWithframe:(CGRect)btnframe withImage:(NSString *)image withView:(UIView *)cview withTarget:(id)t withAcation:(SEL)s withTag:(NSInteger)tag
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = btnframe;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:t action:s forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    //    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    button.adjustsImageWhenHighlighted = NO;
    
    [cview addSubview:button];
}


//加载提示
- (void)showLoadingWithTitle:(NSString *)text imageName:(NSString *)fileName {
    if (_tipView.superview == nil) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake((kDeviceWidth-107)/2, (kDeviceHeight-20-44-49-100)/2, 107, 100)];
        _tipView.alpha = .0;
        UILabel *loadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, _tipView.width, 20)];
        loadLabel.backgroundColor = [UIColor clearColor];
        loadLabel.font = [UIFont systemFontOfSize:15.0f];
        loadLabel.tag = 1000;
        loadLabel.textColor = [UIColor whiteColor];
        loadLabel.textAlignment = NSTextAlignmentCenter;
//        [loadLabel sizeToFit];
        [_tipView addSubview:loadLabel];
        
        if (fileName.length != 0) {
            _tipView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:fileName]];
        }else {
            _tipView.backgroundColor = rgb(131, 131, 131, 1);
            loadLabel.top = (_tipView.height-20)/2;
        }
//        loadLabel.left = (_tipView.width-loadLabel.width)/2;
//        loadLabel.top = 60;
//        [loadLabel release];
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        _tipView.center = window.center;
        [[UIApplication sharedApplication].delegate.window addSubview:_tipView];
    }
    
    UILabel *loadLabel = (UILabel*)[_tipView viewWithTag:1000];
    loadLabel.text = text;
    
    [UIView animateWithDuration:.3 animations:^{
        _tipView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            _tipView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [_tipView removeFromSuperview];
        }];
    }];
}

- (void)hideLoading {
    if (_tipView.superview) {
        [UIView animateWithDuration:1 animations:^{
            _tipView.alpha = .0;
            
//            [_tipView removeFromSuperview];
            
        }completion:^(BOOL finished) {
            _tipView.hidden = YES;
        }];
    }
}

- (BOOL)isConnectionAvailable
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            break;
    }
    if ([r currentReachabilityStatus] == NotReachable) {
        return NO;
    }else{
        return YES;
    }
}


- (void)getkeyboundheight
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardShow:(NSNotification *)aNotification
{
    
}

- (void)keyboardHide:(NSNotification *)aNotification
{
}

- (void)removeKeyBoundNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backDefault
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setBackView
{
    //已经统一设置，如果单个页面需要换图片  使用- (void)setNavigationButtonItrmWithiamge:(NSString *)imagename withRightOrleft:(NSString*)f withtargrt:(id)t withAction:(SEL)s 设置left
    
//    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
//    self.navigationItem.backBarButtonItem = navItem;
    
}

-(void)setLeftView {
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
}

-(void)leftClicked
{
   
    [self.navigationController popViewControllerAnimated:YES];
   
}
- (void)httpLoadCancel{

}
- (void)httpLoadError:(THttpOperatorErrorCode) error{
    if (error == EHttp_Operator_Failed) {
        //服务器挂了
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }

}

- (void)httpLoadComplete:(id)r{
}
@end
