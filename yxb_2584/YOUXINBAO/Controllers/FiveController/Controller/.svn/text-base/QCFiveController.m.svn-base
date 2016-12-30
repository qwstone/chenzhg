//
//  QCFiveController.m
//  YOUXINBAO
//
//  Created by zjp on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCFiveController.h"
#import "IOUDetailsHeaderView.h"
#import "LoanCertificate.h"
@interface QCFiveController ()

@end

@implementation QCFiveController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"5"];
    self.view.backgroundColor = [UIColor brownColor];
    IOUDetailsHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"IOUDetailsHeaderView" owner:self options:nil] lastObject];;
    view.frame = CGRectMake(15, 15, kDeviceWidth-30,view.botimg.bottom/320*kDeviceWidth);
//    IOUDetailsHeaderView *view = [[IOUDetailsHeaderView alloc] initWithFrame:CGRectMake(15, 15, kDeviceWidth-30,(kDeviceWidth-30)/580*585)];
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
