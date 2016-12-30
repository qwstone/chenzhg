//
//  QCFourController.m
//  YOUXINBAO
//
//  Created by zjp on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCFourController.h"
#import "MoreInformationHeaderView.h"

@interface QCFourController ()

@end

@implementation QCFourController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"4"];
//    self.view.backgroundColor = [UIColor lightGrayColor];
    
    MoreInformationHeaderView *view = [[MoreInformationHeaderView alloc] initWithFrame:CGRectMake(15, 15, kDeviceWidth-30, kDeviceHeight)];
    [self.view addSubview:view];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
