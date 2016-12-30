//
//  AACreateViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/3/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AACreateViewController.h"
#import "AAStepViewController.h"
#import "QCIssueViewController.h"

@interface AACreateViewController ()

@end

@implementation AACreateViewController


#define kBUTTON_GAP 10

- (void)awakeFromNib {
//    _scrollView.contentSize = CGSizeMake(kDeviceWidth, 568);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"创建活动"];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    _nameLabel.text = userModel.user.nickname;
    
    _topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"AA-indexgraytop"]];
    
    
    float basicW = (kDeviceWidth - kBUTTON_GAP * 3) / 2;
    
    float startY = kBUTTON_GAP;
    
    [self convertBtn:self.btn1 y:startY];
    startY += self.btn1.frame.size.height;
    startY += kBUTTON_GAP;
    [self convertBtn:self.btn3 y:startY];
    startY += self.btn3.frame.size.height;
    startY += kBUTTON_GAP;
    [self convertBtn:self.btn7 x:kBUTTON_GAP y:startY w: (kDeviceWidth - kBUTTON_GAP * 2)];
    startY += self.btn7.frame.size.height;
    startY += kBUTTON_GAP;
    self.scrollView.contentSize = CGSizeMake(kDeviceWidth, startY);
    
    startY = kBUTTON_GAP;
    float startX = kBUTTON_GAP * 2 + basicW;
    [self convertBtn:self.btn2 x:startX y:startY w:basicW];
    startY += self.btn2.frame.size.height;
    startY += kBUTTON_GAP;
    [self convertBtn:self.btn4 x:startX y:startY w:basicW];
    startY += self.btn4.frame.size.height;
    startY += kBUTTON_GAP;
    
    
    basicW = (basicW - kBUTTON_GAP) / 2;
    [self convertBtn:self.btn5 x:startX y:startY w:basicW];
    [self convertBtn:self.btn6 x:(startX + kBUTTON_GAP + basicW) y:startY w:basicW];
    
    // Do any additional setup after loading the view from its nib.
}


-(void) convertBtn:(UIButton*) btn x:(float) x y:(float) y w:(float) w {
    btn.frame = CGRectMake(x, y, w, [self convertBtn:btn byWidth:w]);
}

-(void) convertBtn:(UIButton*) btn y:(float) y {
    float basicW = (kDeviceWidth - kBUTTON_GAP * 3) / 2;
    btn.frame = CGRectMake(kBUTTON_GAP, y, basicW, [self convertBtn:btn byWidth:basicW]);
}

-(float) convertBtn:(UIButton*) btn byWidth:(float) w {
    float res = 1;
    res = btn.frame.size.height * w / btn.frame.size.width;
    return res;
}

- (IBAction)createEat:(id)sender {
    [self pushWith:AAFilterOtherCategoryDinner];
}
- (IBAction)createKTV:(id)sender {
    [self pushWith:AAFilterOtherCategoryKTV];
}
- (IBAction)createSport:(id)sender {
    [self pushWith:AAFilterOtherCategoryStudy];
}
- (IBAction)createParty:(id)sender {
    [self pushWith:AAFilterOtherCategoryDating];
}
- (IBAction)createStudy:(id)sender {
    [self pushWith:AAFilterOtherCategorySport];
}
- (IBAction)createTravel:(id)sender {
    [self pushWith:AAFilterOtherCategoryOutdoor];
}
- (IBAction)createElse:(id)sender {
    [self pushWith:AAFilterOtherCategoryOther];
}

- (void)pushWith:(AAFilterOtherCategory)createType {
//    AAStepViewController *stepVC = [[AAStepViewController alloc] init];
//    stepVC.createType = createType;
//    stepVC.listVC = self.listVC;
//    [self.navigationController pushViewController:stepVC animated:YES];
    QCIssueViewController *issueVC = [[QCIssueViewController alloc] init];
    issueVC.category = createType;
    [self.navigationController pushViewController:issueVC animated:YES];
}

- (void)leftClicked
{
    if (_isFromRoot) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
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
