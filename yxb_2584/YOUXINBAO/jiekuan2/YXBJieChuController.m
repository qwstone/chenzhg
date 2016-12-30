//
//  YXBJieChuController.m
//  YOUXINBAO
//
//  Created by Feili on 16/2/16.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBJieChuController.h"
#import "YXBJieChuGaoJiController.h"
#import "HeaderView.h"
#import "JieKuanConfig.h"
#import "QClendToViewController.h"
#import "YXBJieChuShanDianController.h"
#import "UIAlertView+Block.h"
#import "FriendSelecteViewController.h"
#import "YXBTool.h"

@interface YXBJieChuController ()<UIScrollViewDelegate,HeaderViewDelegate,UIAlertViewDelegate>
{
    UIScrollView *rootScrollView;
    UIButton *bottomBtn;

}
@property(nonatomic,strong)HeaderView *headerView;
@property (nonatomic,strong)YXBJieChuGaoJiController *loanDetailVC;
@property(nonatomic,strong)YXBJieChuShanDianController *quickVC;
@property (nonatomic,strong)UIScrollView *scrollView;

@end

@implementation YXBJieChuController

-(void)dealloc
{
    JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];
    loanInstance.yxbLoan = nil;
}


-(void)leftClicked
{
    if ([_quickVC isMoneyCellEdit]) {
        [_quickVC.view endEditing:YES];
        return;
    }
    if ([_loanDetailVC isMoneyCellEdit]) {
        [_loanDetailVC.view endEditing:YES];
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"返回将丢失您填写的信息,是否确定返回?" message:nil delegate:nil cancelButtonTitle:@"确定返回" otherButtonTitles:@"留在此页", nil];
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 0) {
            [super leftClicked];
        }
        
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGB(239, 239, 239);
    [self setLeftView];
    self.title = @"借款给好友";
    [self initViews];
    // Do any additional setup after loading the view.
}

-(void)initViews
{
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:ccr(15, 10, kDeviceWidth-30, 48)];
    bgImage.userInteractionEnabled = YES;
    UIImage *image = [UIImage imageNamed:@"jiekuanTop.png"];
    bgImage.height = [YXBTool heightWithSize:image.size width:bgImage.width];
    bgImage.image = image;
    [self.view addSubview:bgImage];
//    bgImage.backgroundColor = [UIColor redColor];

    //添加两条线
    UIView *vLine = [[UIView alloc] initWithFrame:ccr(2, bgImage.height - 1, bgImage.width - 4, 1)];
    vLine.backgroundColor = rgb(240, 240, 240, 1.0);
    [bgImage addSubview:vLine];
    
    UIView *hLine = [[UIView alloc] initWithFrame:ccr(bgImage.width/2, 5, 1, bgImage.height - 10)];
    hLine.backgroundColor = rgb(240, 240, 240, 1.0);
    [bgImage addSubview:hLine];


//    CGFloat a = adjustValue * 2;
    self.headerView = [[HeaderView alloc] initWithFrame:CGRectMake(2, 0, bgImage.width - 4, bgImage.height - 5) WithArray:[NSArray arrayWithObjects:@"闪电借出",@"高级借出", nil]];
//    _headerView.frame = bgImage.bounds;
    [_headerView setHeaderViewColorsWithUnSelectedBgColor:[UIColor clearColor] selectedBgColor:[UIColor clearColor] unSelectedTextColor:[YXBTool colorWithHexString:@"#808080"] selectedTextColor:rgb(217, 30, 61, 1.0)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _headerView.delegate = self;
    _headerView.selectedIndex = 0;
    _headerView.backgroundColor = [UIColor clearColor];
//    _headerView.clipsToBounds = YES;
//    [_headerView addSubview:vLine];
    
    
    [bgImage addSubview:_headerView];

//    [self.view addSubview:bgImage];

    
    UIImage *sImage = [UIImage imageNamed:@"jiekuanSelectFriend"];
    CGFloat h = [YXBTool heightWithSize:sImage.size width:kDeviceWidth - 30];
    
    CGFloat x = 15, w = kDeviceWidth - 30,y = kDeviceHeight - 64 - h - 15;
    bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    bottomBtn.backgroundColor = [UIColor lightGrayColor];
    bottomBtn.frame = ccr(x, y, w, h);
    //    [bottomBtn setImage:[UIImage imageNamed:@"jiekuanSelectFriend"] forState:UIControlStateNormal];
    [bottomBtn setBackgroundImage:[UIImage imageNamed:@"jiekuanSelectFriend"] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];

    
    x = 0, w = kDeviceWidth, h = 30,y = bottomBtn.top - 40;

    UIButton *safeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    safeBtn.frame = CGRectMake(x, y, w, h);
    safeBtn.backgroundColor = [UIColor clearColor];
    [safeBtn setImage:[UIImage imageNamed:@"agree2"] forState:UIControlStateNormal];
    [safeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:safeBtn];
    
    

    w = kDeviceWidth;
    
    [self loadScrollView];

}


-(void)loadScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _headerView.superview.bottom, kDeviceWidth, kDeviceHeight - 64 - _headerView.superview.bottom - bottomBtn.height - 60)];
    _scrollView.scrollEnabled = NO;
    _scrollView.pagingEnabled = NO;
    _scrollView.contentSize = CGSizeMake(2 * kDeviceWidth, _scrollView.height);
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    
    JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];
    if (loanInstance.yxbLoan == nil) {
        loanInstance.yxbLoan = [[YXBLoan alloc] init];
        loanInstance.yxbLoan.loanType = YXBLoanTypeKuaiSuChangGuiJieKuan;
    }
    
    
    
    self.loanDetailVC = [[YXBJieChuGaoJiController alloc] init];
    _loanDetailVC.viewFrame = CGRectMake(kDeviceWidth, 0, kDeviceWidth, _scrollView.height);
    [_scrollView addSubview:_loanDetailVC.view];
    
    self.quickVC = [[YXBJieChuShanDianController alloc] init];
    _quickVC.viewFrame = CGRectMake(0, 0, kDeviceWidth, _scrollView.height);

//    _quickVC.friendID = _friendID;
//    _quickVC.view.frame = CGRectMake(0, 0, kDeviceWidth, _scrollView.height);
    [_scrollView addSubview:_quickVC.view];
    
    [self.view bringSubviewToFront:_headerView.superview];
}


//用户协议
-(void)agreeBtnClick:(UIButton *)btn{
    
    NSString *url = [NSString stringWithFormat:@"%@webView/helpcenter/agreement.jsp",YXB_IP_ADRESS];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"友借款服务协议"];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark HeaderViewDelegate
-(void)headerViewSelectedIndex:(NSInteger)index
{
    [self.view endEditing:YES];

    [UIView animateWithDuration:0.5 animations:^{
        
        if (index == 1) {
            _scrollView.contentOffset = CGPointMake(kDeviceWidth, 0);
        }
        else
        {
            _scrollView.contentOffset = CGPointMake(0, 0);
            
        }

    }];
    
    

    
}

-(BOOL)checkCondition
{
    BOOL isSucceed = YES;
    YXBLoan *loan = _quickVC.loan;
    if (_headerView.selectedIndex == 1) {
        loan = [JieKuanInstance shareInstance].yxbLoan;
    }
    if (loan.money != nil) {
        if ([loan.money integerValue] >= [YXBJieKuanMinMoney integerValue] &&
            [loan.money integerValue] <= [YXBJieKuanMaxMoney integerValue]) {
        }
        else
        {
//            [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"借款金额%@——%@元之间",YXBJieKuanMinMoney,YXBJieKuanMaxMoney]];
            if (_headerView.selectedIndex == 0) {
                if ([loan.money integerValue] < [YXBJieKuanMinMoney integerValue]) {
                    [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"救急金额不能小于100元"]];

                }

            }
            else
            {
                if ([loan.money integerValue] < [YXBJieKuanMinMoney integerValue]) {
                    [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"借款金额不能小于100元"]];
                    
                }


            }
            isSucceed = NO;
            return isSucceed;
        }
    }
    else
    {
        if (_headerView.selectedIndex == 0) {
            [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请输入救急金额"]];
            
        }
        else
        {
            [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请输入借款金额"]];
            
        }
        isSucceed = NO;
        return isSucceed;
    }
    
    
    //高级借出 附加条件
    if (_headerView.selectedIndex == 1) {
        if (loan.backTime == nil) {
            [ProgressHUD showSuccessWithStatus:@"还款时间有误!"];
            isSucceed = NO;
        }
        if (loan.interestType == YXBInterestTypeYES) {
            if ([loan.interest integerValue] <= 0) {
                
                [ProgressHUD showErrorWithStatus:@"利息输入有误,请重新输入!"];
                isSucceed = NO;
                
            }
            
        }

        
    }
    
    return isSucceed;

}

-(void)nextAction
{
    BOOL isSucceed = [self checkCondition];
    if (isSucceed) {
        [self jumpToFriendVC];

    }
    
}



-(void)jumpToFriendVC
{
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (_headerView.selectedIndex == 0) {
        //闪电放款
        if (_quickVC.loan.money != nil && [_quickVC.loan.money integerValue] > 0) {
            YXBLoan *loan = _quickVC.loan;
            loan.lenderId = userModel.user.t_id;
            //            loan.yxbToken = userModel.user.yxbToken;
            loan.loanType = LoanQuickTypeQuick;
            loan.loanFriendType = YXBPayDesFriend;
            loan.loanType = YXBLoanTypeKuaiShanDianJieKuan;
            FriendSelecteViewController *friendController = [[FriendSelecteViewController alloc] init];
            friendController.friendType = LoanNewFriendTypeJieChu;
            friendController.loanModel = loan;
            [self.navigationController pushViewController:friendController animated:YES];
            
        }
    }
    else
    {
        YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;

        if (loan.interestType == YXBInterestTypeYES) {
            
            //关闭利率不能超过100%限制
            //if ([_loanDetailVC.loanRate floatValue]>=100){
                //            [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"年化利率不能超过100.0%%"]];
            //    [ProgressHUD showWithStatus:@"利率不能超过100%请重新设置。"];
            //    return;
            //}
            if ([_loanDetailVC.loanRate floatValue]>24) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"根据国家法律规定，民间借贷的年利率超过24%的部分法律不予保护，超过36%的部分法院不予支持。" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:@"再想想", nil];
                alert.tag = 2300;
                [alert show];
                //            [YXBTool showAlertViewWithString:@"友情提示：根据国家法律规定，民间借贷的年利率超过24%的部分法律不予保护，超过36%的部分法院不予支持。"];
                return;
            }

            
        }
        if (loan.money != nil && loan.duration != nil) {
            FriendSelecteViewController *friendController = [[FriendSelecteViewController alloc] init];
            QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
            //                [self BorrowWithoperationType:APPLY];
            loan.loanFriendType = 1;
            loan.lenderId = userModel.user.t_id;
            //            loan.operationType = LOAN_QUICK_SEND_QUICK_LEND;
            //            loan.yxbToken = userModel.user.yxbToken;
  
            friendController.friendType = LoanNewFriendTypeJieChu;
            friendController.loanModel = loan;
            [self.navigationController pushViewController:friendController animated:YES];
            
        }
        
    }

}
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
        if (loan.money != nil && loan.duration != nil) {
            FriendSelecteViewController *friendController = [[FriendSelecteViewController alloc] init];
            QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
            //                [self BorrowWithoperationType:APPLY];
            loan.loanFriendType = 1;
            loan.lenderId = userModel.user.t_id;
            //            loan.operationType = LOAN_QUICK_SEND_QUICK_LEND;
            //            loan.yxbToken = userModel.user.yxbToken;
            
            friendController.friendType = LoanNewFriendTypeJieChu;
            friendController.loanModel = loan;
            [self.navigationController pushViewController:friendController animated:YES];
            
        }
    }
}

-(void)lendWithOperationType:(int)type
{
//    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
//    self.loan.lenderId = userModel.user.t_id;
//    
//    self.loan.operationType = type;
//    self.loan.yxbToken = userModel.user.yxbToken;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.view endEditing:YES];
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
