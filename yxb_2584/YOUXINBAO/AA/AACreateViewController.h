//
//  AACreateViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/3/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AABaseViewController.h"
#import "AAActivitiesListViewController.h"

@interface AACreateViewController : AABaseViewController

@property (nonatomic,strong) AAActivitiesListViewController *listVC;
@property (nonatomic,assign) BOOL isFromRoot;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UIButton *btn7;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end
