//
//  HomeViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HomeViewController.h"
#import "AAActivitiesListViewController.h"
#import "QCConst.h"
#import "QCLoginOneViewController.h"
#import "QCRegisterTwoViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "QCFriendsViewController.h"
#import "QCTrustViewController.h"
#import "LoanOrRepayViewController.h"
#import "YLInitSwipePasswordController.h"
#import "SetViewController.h"
#import "DebtListViewController.h"
#import "AppDelegate.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

#pragma mark --- 登录成功
- (void)loginSucceed {
    //     [self happyValueAction];
}
- (void)happyValueAction {
    
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [_userInfoImg sd_setImageWithURL:[NSURL URLWithString:userModel.user.iconAddr] placeholderImage:[UIImage imageNamed:@"register_photo.png"]];
    _userName.text = [NSString stringWithFormat:@"欢迎回来 : %@",userModel.user.nickname];
    self.bgScrollView.transform = CGAffineTransformMakeTranslation(0, (kDeviceWidth/2.5f));
    //    CGRectMake(0, (kDeviceWidth/2.5f), kDeviceWidth, kDeviceHeight-64);
    _userInfoImgbg.bottom = self.bgScrollView.top;
    [UIView animateWithDuration:2 animations:^{
        //        self.bgScrollView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64);
        self.bgScrollView.transform = CGAffineTransformIdentity;
        _userInfoImgbg.bottom = self.bgScrollView.top;
    } completion:^(BOOL finished) {
        
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"无忧借条"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(happyValueAction)
                                                 name:@"holleUserNotification"
                                               object:nil];
    
    
    
    //    NSArray * array = @[@"login",@"AA",@"friend",@"信用大厅",@"友借友还",@"设置手势密码",@"设置"];
    //    for (NSInteger i = 0;i < array.count; i++) {
    //        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30+i*40,kDeviceWidth-60, 30)];
    //        btn.tag =i+1;
    //        [btn setBackgroundColor:[UIColor redColor]];
    ////        btn.center = self.view.center;
    //        [btn setTitle:array[i] forState:UIControlStateNormal];
    //        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //        [self.bgScrollView addSubview:btn];
    //        UIImage * newImage =[UIImage imageNamed:@"new.jpg"];
    //        UIImageView * newImageView = [[UIImageView alloc]initWithImage:newImage];
    //        newImageView.frame = CGRectMake(btn.origin.x+btn.width+5, btn.origin.y+3, newImage.size.width/4, newImage.size.height/4);
    //        newImageView.tag = 100+i;
    //        [self.bgScrollView addSubview:newImageView];
    //
    //    }
    [self createHomeUI];
    
}


- (void)createHomeUI{
    self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftAction)];
    
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64)];
    [self.view addSubview:self.bgScrollView];
    
    _userInfoImgbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, (kDeviceWidth/2.5f))];
    _userInfoImgbg.bottom = self.bgScrollView.top;
    _userInfoImgbg.image = [UIImage imageNamed:@"welcomebgimg.jpg"];
    [self.view addSubview:_userInfoImgbg];
    
    _userInfoImg = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-_userInfoImgbg.height/2)/2, (_userInfoImgbg.height-_userInfoImgbg.height/2)/2, _userInfoImgbg.height/2,  _userInfoImgbg.height/2)];
    _userInfoImg.layer.cornerRadius = _userInfoImg.size.width/2;
    _userInfoImg.layer.borderColor = [UIColor whiteColor].CGColor;
    _userInfoImg.layer.borderWidth = 1.5f;
    _userInfoImg.layer.masksToBounds = YES;
    _userInfoImg.image = [UIImage imageNamed:@"homeUserPhoto.png"];
    [_userInfoImgbg addSubview:_userInfoImg];
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(0, _userInfoImg.bottom+10, kDeviceWidth, 20)];
    _userName.textAlignment = NSTextAlignmentCenter;
    _userName.textColor = [UIColor whiteColor];
    _userName.font = [UIFont boldSystemFontOfSize:16];
    _userName.text = @"欢迎回来 : Liu Ran";
    [_userInfoImgbg addSubview:_userName];
    
    
    //背景上的UIScroll
    _scrollView = [[NoticeScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/320*150)];
    if (kDeviceHeight == 480) {
        _scrollView.frame = CGRectMake(0, 0, kDeviceWidth, 84);
    }else if (kDeviceHeight == 568){
        _scrollView.frame = CGRectMake(0, 0, kDeviceWidth, 150);
    }
    [_scrollView.layer setMasksToBounds:YES];
    [self.bgScrollView addSubview:_scrollView];
    
    _middleView = [[HomeMiddleView alloc] initWithFrame:CGRectMake(0, _scrollView.bottom, kDeviceWidth, kDeviceWidth/320*125)];
    if (kDeviceHeight == 480) {
        _middleView.frame = CGRectMake(0, _scrollView.bottom, kDeviceWidth, 115);
    }else if (kDeviceHeight == 568){
        _middleView.frame = CGRectMake(0, _scrollView.bottom, kDeviceWidth, 125);
    }
    _middleView.backgroundColor = [UIColor clearColor];
    [self.bgScrollView addSubview:_middleView];
    
    
    _bottomView = [[HomeBottomView alloc] initWithFrame:CGRectMake(0, _middleView.bottom, kDeviceWidth, kDeviceWidth/320*165)];
    if (kDeviceHeight == 480) {
        _bottomView.frame = CGRectMake(0, _middleView.bottom, kDeviceWidth, 175);
    }else if (kDeviceHeight == 568){
        _bottomView.frame = CGRectMake(0, _middleView.bottom, kDeviceWidth, 175);
    }
    _bottomView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.bgScrollView addSubview:_bottomView];
    
    
    
}



- (void)buttonAction:(UIButton *)sender
{
    if (sender.tag == 1) {
        QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
        UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
        [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
        
    }else if (sender.tag == 2){
        AAActivitiesListViewController * aaViewController = [[AAActivitiesListViewController alloc]init];
        [self.navigationController pushViewController:aaViewController animated:YES];
    }else if (sender.tag == 3){
        QCFriendsViewController *friendVC = [[QCFriendsViewController alloc]init];
        [self.navigationController pushViewController:friendVC animated:YES];
    }else if (sender.tag == 4) {
        QCTrustViewController *trustVC = [[QCTrustViewController alloc] init];
        [self.navigationController pushViewController:trustVC animated:YES];
    }else if (sender.tag == 5){
        LoanOrRepayViewController * loanViewController = [[LoanOrRepayViewController alloc]init];
        [self.navigationController pushViewController:loanViewController animated:YES];
    }else if (sender.tag == 6) {
        
        YLInitSwipePasswordController * initSwipeView = [[YLInitSwipePasswordController alloc]init];
        [self.navigationController pushViewController:initSwipeView animated:YES];
    }else if (sender.tag == 7){
        SetViewController * setViewController = [[SetViewController alloc]init];
        [self.navigationController pushViewController:setViewController animated:YES];
    }
}

- (void)leftAction {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate showLeftVC];
    
}


@end
