//
//  AACompleteViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/5/22.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AACompleteViewController.h"
#import "AAActivitiesListViewController.h"

@interface AACompleteViewController ()

@end

@implementation AACompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationButtonItrmWithiamge:nil withRightOrleft:@"left" withtargrt:self withAction:NULL];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"创建活动聚会"];
    
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(25, 40, kDeviceWidth-50, 100)];
    tip.backgroundColor = [UIColor clearColor];
    tip.font = [UIFont boldSystemFontOfSize:18];
    tip.textColor  = rgb(139, 139, 139, 1);
    //tip.text = @"您的活动申请已发布，小宝正在拼命审核中，稍事休息，审核结果很快到来！";
    tip.text=@"活动发布成功，客服人员将对活动进行审核，若不符合《无忧借条活动聚会协议》，活动将被撤销。";
    tip.numberOfLines = 0;
    [self.view addSubview:tip];
    
    UIButton *mine = [[UIButton alloc] initWithFrame:CGRectMake(25, 155, kDeviceWidth-50, 45)];
    [mine setTitle:@"我的活动" forState:UIControlStateNormal];
    [mine setBackgroundImage:[UIImage imageNamed:@"blue-but"] forState:UIControlStateNormal];
//    [mine setTitleColor:rgb(62, 163, 255, 1) forState:UIControlStateNormal];
    [mine addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    mine.titleLabel.font = [UIFont systemFontOfSize:18];
    mine.tag = 10000;
    [self.view addSubview:mine];
    UIButton *nearby = [[UIButton alloc] initWithFrame:CGRectMake(25, 220, kDeviceWidth-50, 45)];
    [nearby setTitle:@"逛逛附近活动" forState:UIControlStateNormal];
    [nearby setBackgroundImage:[UIImage imageNamed:@"blue-but"] forState:UIControlStateNormal];
//    [nearby setTitleColor:rgb(62, 163, 255, 1) forState:UIControlStateNormal];
    [nearby addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    nearby.titleLabel.font = [UIFont systemFontOfSize:18];
    nearby.tag = 10001;
    [self.view addSubview:nearby];
}

- (void)btnAction:(UIButton *)button {
    for (UIViewController *vc in self.navigationController.childViewControllers) {
        if ([vc isKindOfClass:[AAActivitiesListViewController class]]) {
            AAActivitiesListViewController *list = (AAActivitiesListViewController *)vc;
            if (button.tag == 10000) {
                //我的
                list.listStyle = L_myList;
            }else if (button.tag == 10001) {
                //附近
                list.listStyle = L_nearByList;
            }
            
            [self.navigationController popToViewController:list animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)leftClicked {
////    for (UIViewController *vc in self.navigationController.childViewControllers) {
////        if ([vc isKindOfClass:[QCIssueViewController class]]) {
////            QCIssueViewController *issue = (QCIssueViewController *)vc;
////            issue.
////        }
////    }
//    [self.navigationController popViewControllerAnimated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
