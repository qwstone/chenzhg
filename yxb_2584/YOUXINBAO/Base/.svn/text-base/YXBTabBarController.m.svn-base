//
//  YXBTabBarController.m
//  YOUXINBAO
//
//  Created by zjp on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBTabBarController.h"
#import "RootViewController.h"
#import "BaseNavigationController.h"
#import "CreditHallTuhaoListViewController.h"
#import "YXBHomeController.h"
#import "QCTwoController.h"
#import "UITabBar+badge.h"
#import "QCFourController.h"
#import "QCFiveController.h"
#import "YXBTool.h"
#import "QCFriendsViewController.h"
#import "MyInfoViewController.h"
#import "CreditHallMostNewViewController.h"
#import "XinYongViewController.h"
#import "MessageCenterController.h"
@interface YXBTabBarController ()<UINavigationControllerDelegate,UITabBarControllerDelegate>

@end

@implementation YXBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor=[YXBTool colorWithHexString:@"#ed2e24"];
    self.tabBar.backgroundImage=[YXBTool imageWithColor:[UIColor whiteColor]];
//    [self _createTabbarView];
    self.delegate = self;
    [self _createViewControllers];
}

//- (void)_createTabbarView {
//    
//    //1.隐藏tabbar工具栏
//    [self.tabBar setHidden:YES];
//
//    NSArray *array1 = @[@"6home1",@"6home2",@"6home3",@"6home4",@"6home5"];
//    NSArray *array2 = @[@"6home1_h",@"6home2_h",@"6home3_h",@"6home4_h",@"6home5_h"];
//    tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-49, kDeviceWidth, 49)];
//    tabbarView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:tabbarView];
//    for (int i=0; i<array1.count; i++) {
//
//        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*64/320*kDeviceWidth, 0, 64/320*kDeviceWidth, 49)];
//        [button setImage:[UIImage imageNamed:array1[i]]
//                forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:array2[i]]
//                forState:UIControlStateSelected];
//        button.showsTouchWhenHighlighted = YES;
////        button.frame = CGRectMake(i*64/320*kDeviceWidth, 0, 64/320*kDeviceWidth, 49);
//        [button addTarget:self action:@selector(buttonAction:)
//         forControlEvents:UIControlEventTouchUpInside];
//        button.tag = i;
//        
//        [tabbarView addSubview:button];
//    }
//
//    
//}
//
//- (void)buttonAction:(UIButton *)button {
//    
//    //1.通过修改selectedIndex索引，实现切换子控制器的显示
//    self.selectedIndex = button.tag;
//
//}
- (void)_createViewControllers {

    NSArray *array1 = @[@"6home1",@"6home2",@"6home3",@"6home4",@"6home5"];
    NSArray *array2 = @[@"6home1_h",@"6home2_h",@"6home3_h",@"6home4_h",@"6home5_h"];
//    NSArray *array1 = @[@"home1",@"home2",@"home3",@"home4",@"home5"];
//    NSArray *array2 = @[@"home1_h",@"home2_h",@"home3_h",@"home4_h",@"home5_h"];
    //1.创建三级控制器
    YXBHomeController *homeVC = [[YXBHomeController alloc] init];
    QCFriendsViewController *quareVC = [[QCFriendsViewController alloc] init];
    CreditHallMostNewViewController *searchVC = [[CreditHallMostNewViewController alloc] init];
    MessageCenterController *commandVC = [[MessageCenterController alloc] init];
    QCTwoController *msgVC = [[QCTwoController alloc] init];
    
    
    XinYongViewController *searchVCs = [[XinYongViewController alloc] init];
    searchVCs.title = @"信用大厅";
        NSArray *array = @[homeVC,quareVC,searchVC,commandVC,msgVC];
    if (kDeviceHeight <= 480) {
        searchVCs.webView.height -= 49;
        array = @[homeVC,quareVC,searchVCs,commandVC,msgVC];
    }

    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];
    for (int i=0; i<array.count; i++) {
        UIViewController *viewController = array[i];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        nav.interactivePopGestureRecognizer.delegate = (id)self;
//        nav.delegate = self;
        nav.tabBarItem.image = [UIImage imageNamed:array1[i]];
        nav.tabBarItem.selectedImage = [UIImage imageNamed:array2[i]];
        nav.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
        [viewControllers addObject:nav];
    }
    
    self.viewControllers = viewControllers;

    
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (tabBarController.selectedIndex != 0) {
        QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
        if (userModel.isLogin == YES) {
        }else {
            [self toLogin];
            tabBarController.selectedIndex = 0;
            return;
        }
    }
    
    //移除小红点
//    [self.tabBar hideBadgeOnItemIndex:tabBarController.selectedIndex];
}

//跳出登陆页面
- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    //    loginNav.navigationBar.barTintColor = rgb(231, 27, 27, 1);
    //    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    loginView.modalPresentationStyle = UIModalPresentationPopover;
    [[YXBTool getCurrentNav] presentViewController:loginNav animated:YES completion:nil ];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
