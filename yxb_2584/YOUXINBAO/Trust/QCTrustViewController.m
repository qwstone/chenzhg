//
//  QCTrustViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCTrustViewController.h"
#import "QCCurvesView.h"
#import "QCBoardViewController.h"
#import "CreditHallTuhaoListViewController.h"
#import "DishonestyListViewController.h"

#define kRenYuanTag 1000
#define kHuoYueTag 1001
#define kShiXinTag 1002
#define kHaoZhaoLiTag 1003
#define kYiQiTag 1004
#define kTuHaoTag 1005
#define kButtonWidth 60
#define kButtonHeight 30

@interface QCTrustViewController ()

@end

@implementation QCTrustViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"信用大厅"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:nil];
    imageView.backgroundColor = [UIColor redColor];
    imageView.frame = CGRectMake((kDeviceWidth-80)/2, (kDeviceHeight-80-64)/2, 80, 80);
    [self.view addSubview:imageView];
    
//    //外圈
//    QCCurvesView *curvesView1 = [[QCCurvesView alloc] initWithFrame:CGRectMake((kDeviceWidth-350)/2, (kDeviceHeight-350-64)/2, 350, 350)];
//    [self.view addSubview:curvesView1];
//    
//    UIButton *renYuan = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kButtonWidth, kButtonHeight)];
//    renYuan.tag = kRenYuanTag;
//    renYuan.backgroundColor = [UIColor blackColor];
//    [renYuan addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [curvesView1 addSubview:renYuan];
//    
//    UIButton *huoYue = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kButtonWidth, kButtonHeight)];
//    huoYue.tag = kHuoYueTag;
//    huoYue.backgroundColor = [UIColor grayColor];
//    [huoYue addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [curvesView1 addSubview:huoYue];
//    
//    //中圈
//    QCCurvesView *curvesView2 = [[QCCurvesView alloc] initWithFrame:CGRectMake((kDeviceWidth-290)/2, (kDeviceHeight-290-64)/2, 290, 290)];
//    [self.view addSubview:curvesView2];
//    
//    UIButton *shiXin = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kButtonWidth, kButtonHeight)];
//    shiXin.tag = kShiXinTag;
//    shiXin.backgroundColor = [UIColor blueColor];
//    [shiXin addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [curvesView2 addSubview:shiXin];
//    
//    UIButton *haoZhaoLi = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kButtonWidth, kButtonHeight)];
//    haoZhaoLi.tag = kHaoZhaoLiTag;
//    haoZhaoLi.backgroundColor = [UIColor redColor];
//    [haoZhaoLi addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [curvesView2 addSubview:haoZhaoLi];
//    
//    //内圈
//    
//    QCCurvesView *curvesView3 = [[QCCurvesView alloc] initWithFrame:CGRectMake((kDeviceWidth-230)/2, (kDeviceHeight-230-64)/2, 230, 230)];
//    [self.view addSubview:curvesView3];
//    
//    UIButton *tuHao = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kButtonWidth, kButtonHeight)];
//    tuHao.tag = kTuHaoTag;
//    tuHao.backgroundColor = [UIColor greenColor];
//    [tuHao addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [curvesView3 addSubview:tuHao];
//    
//    UIButton *yiQi = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kButtonWidth, kButtonHeight)];
//    yiQi.tag = kYiQiTag;
//    yiQi.backgroundColor = [UIColor orangeColor];
//    [yiQi addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [curvesView3 addSubview:yiQi];
    
    UIButton *renYuan = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kButtonWidth, kButtonHeight)];
    renYuan.tag = kRenYuanTag;
    [renYuan setTitle:@"人缘榜" forState:UIControlStateNormal];
    [renYuan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    renYuan.backgroundColor = [UIColor orangeColor];
    [renYuan addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:renYuan];
    
    UIButton *huoYue = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 0, kButtonWidth, kButtonHeight)];
    huoYue.tag = kHuoYueTag;
    [huoYue setTitle:@"活跃榜" forState:UIControlStateNormal];
    [huoYue setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    huoYue.backgroundColor = [UIColor grayColor];
    [huoYue addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:huoYue];
    
    UIButton *shiXin = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, kButtonWidth, kButtonHeight)];
    shiXin.tag = kShiXinTag;
    [shiXin setTitle:@"失信榜" forState:UIControlStateNormal];
    [shiXin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    shiXin.backgroundColor = [UIColor blueColor];
    [shiXin addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shiXin];
    
    UIButton *haoZhaoLi = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 100, kButtonWidth, kButtonHeight)];
    haoZhaoLi.tag = kHaoZhaoLiTag;
    [haoZhaoLi setTitle:@"号召力榜" forState:UIControlStateNormal];
    [haoZhaoLi setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    haoZhaoLi.backgroundColor = [UIColor redColor];
    [haoZhaoLi addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:haoZhaoLi];
    
    UIButton *tuHao = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, kButtonWidth, kButtonHeight)];
    tuHao.tag = kTuHaoTag;
    [tuHao setTitle:@"土豪榜" forState:UIControlStateNormal];
    [tuHao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    tuHao.backgroundColor = [UIColor greenColor];
    [tuHao addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tuHao];
    
    UIButton *yiQi = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 200, kButtonWidth, kButtonHeight)];
    yiQi.tag = kYiQiTag;
    [yiQi setTitle:@"义气榜" forState:UIControlStateNormal];
    [yiQi setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    yiQi.backgroundColor = [UIColor orangeColor];
    [yiQi addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yiQi];

    
}

- (void)buttonAction:(UIButton *)button {
//    QCBoardViewController *boardVC = [[QCBoardViewController alloc] init];
    CreditHallTuhaoListViewController *boardVC = [[CreditHallTuhaoListViewController alloc] init];
    if (button.tag == kRenYuanTag) {
        boardVC.type = QCBoardTypeRenYuan;
    }else if (button.tag == kHuoYueTag) {
        boardVC.type = QCBoardTypeHuoYue;
    }else if (button.tag == kShiXinTag) {
        DishonestyListViewController *boardVCs = [[DishonestyListViewController alloc] init];
        [self.navigationController pushViewController:boardVCs animated:YES];
        return;
    }else if (button.tag == kHaoZhaoLiTag) {
        boardVC.type = QCBoardTypeHaoZhaoLi;
    }else if (button.tag == kYiQiTag) {
        boardVC.type = QCBoardTypeYiQi;
    }else if (button.tag == kTuHaoTag) {
        boardVC.type = QCBoardTypeTuHao;
    }
    [self.navigationController pushViewController:boardVC animated:YES];
}

- (void)leftClicked {
    [self.navigationController popViewControllerAnimated:YES];
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
