//
//  QCRegisterTwoViewController.m
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCRegisterTwoViewController.h"
//#import "QCThreeViewController.h"
#import "QCRegisterOneViewController.h"

@interface QCRegisterTwoViewController ()
{
    UIScrollView * _scrollView;
}

@end

@implementation QCRegisterTwoViewController

- (void)dealloc
{
    [_scrollView release];
    [super dealloc];
}

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
    [self setnavigationItem];
    [self createUI];
    
}
#pragma mark ------------------------------------------------------CreatUI
- (void)setnavigationItem
{
    self.title = @"服务协议";

    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(backAction)];

}
- (void)createUI
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-49)];
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight);
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsVerticalScrollIndicator = NO;
   // [self.view addSubview:_scrollView];
    
    NSString * filePath = [[NSBundle mainBundle]pathForResource:@"agreement" ofType:@"txt"];
    NSString * txtString = [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"ffd =%@",txtString);
    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, kDeviceWidth-15, kDeviceHeight-46-49-30)];
    textView.backgroundColor = [UIColor clearColor];
    textView.text = txtString;
    [txtString release];
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textView];
    [textView release];
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kDeviceHeight-64-49, kDeviceWidth, 49)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = [rgb(255, 156, 146, 1) CGColor];
    bgView.layer.borderWidth = 1;
    [self.view addSubview:bgView];
    [bgView release];
    //同意按钮
    [self createButtonWithframe:CGRectMake(10, 5, kDeviceWidth-20, 40) withImage:@"register_agrees.png" withView:bgView withTarget:self withAcation:@selector(agreeAction:) withTag:1001];
    UIButton *agreeButton = (UIButton *)[self.view viewWithTag:1001];
    [agreeButton setImage:[UIImage imageNamed:@"register_sagrees"] forState:UIControlStateHighlighted];
}

#pragma mark ---------------------------------------------------- Actions
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)agreeAction:(UIButton *)button {
    QCRegisterOneViewController *phoneNumVC = [[QCRegisterOneViewController alloc] init];
    [self.navigationController pushViewController:phoneNumVC animated:YES];
    [phoneNumVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
