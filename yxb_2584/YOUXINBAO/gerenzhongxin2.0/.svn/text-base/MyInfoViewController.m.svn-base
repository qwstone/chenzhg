//
//  MyInfoViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/9/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyYXBHeaderView.h"
#import "MineViewNewCell.h"
#import "QCLoginOneViewController.h"
#import "YXBTool.h"
#import "UserManager.h"
#import "PayHomeViewController.h"
#import "QCMoneyListViewController.h"
#import "LoanCenterViewController.h"
#import "QRCodeGenerator.h"
#import "MyCodeViewController.h"
#import "UIScrollView+TwitterCover.h"

#import "QCPersonalProfileViewController.h"
#import "FMDeviceManager.h"
#import "SafeCenterController.h"
#import "SetNewViewController.h"
#import "MyOrderListController.h"
#import "GeRenZhongXinNavView.h"
#import "QCWuYouLiCaiViewController.h"

#import "ImagePickerViewController.h"

#import "OverdueModel.h"
#import "YXBLoanCenterViewController.h"


#define LeftViewControllerCouponUrl @"webView/user/couponList.jsp?t=1"
#define AboutWuyoujietiao [NSString stringWithFormat:@"%@webView/helpcenter/purse-rule.jsp?a=1",YXB_IP_address_web]


@interface MyInfoViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,MyYXBHeaderViewDelegate>
{
    GeRenZhongXinNavView *topNavView;
    
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)MyYXBHeaderView *headerView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *itemSectionArray;
@property (nonatomic,strong)HttpOperator *iHttpOperator;
@end

@implementation MyInfoViewController
-(void)dealloc{
    [self.iHttpOperator cancel];
//    self.iHttpOperator = nil;
    NSLog(@"MyInfoViewController is dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    [self setTitle:@"个人中心"];
//    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setMyYXBData];
    [self createMyTableView];
    self.view.backgroundColor = kRGB(238, 236, 246);
//    [self.tableView reloadDeals];

    
    // Do any additional setup after loading the view.
}



#pragma -mark 初始化信息
-(void)setMyYXBData
{
    self.dataArray = [NSMutableArray array];
    //初始数据
    //每一个section里的row数
    self.itemSectionArray = [NSMutableArray arrayWithObjects:@"2",@"5",@"2", nil];
    NSMutableArray *itemTitleArray = [NSMutableArray arrayWithObjects:
                                      @"资金明细",
                                      @"安全中心(身份验证)",
                                      
                                      @"借条中心",
                                      @"无忧理财",
                                      @"分期订单",
                                      @"优惠券",
                                      @"任务中心",
                                      
                                      @"设置",
                                      @"关于无忧借条",nil];
    
    NSMutableArray *itemImageArray = [NSMutableArray arrayWithObjects:
                                      @"nav925-1.png",
                                      @"nav925-2.png",

                                      @"nav925-3.png",
                                      @"nav925-2.png",
                                      @"nav925-4.png",
                                      @"nav925-5.png",
                                      @"nav925-6.png",
                                      
                                      @"nav925-7.png",
                                      @"nav925-8.png",
                                       nil];
    
    NSMutableArray *itemTypeArray = [NSMutableArray arrayWithObjects:
                                     [NSNumber numberWithInteger:MyInfoItemTypeMoney],
                                     [NSNumber numberWithInteger:MyInfoItemTypeSafeCenter],
                                     
                                     [NSNumber numberWithInteger:MyInfoItemTypeLoanCenter],
                                     [NSNumber numberWithInteger:MyInfoItemTypeLiCai],
                                     [NSNumber numberWithInteger:MyInfoItemTypeTimeOrder],
                                     [NSNumber numberWithInteger:MyInfoItemTypeCoupon],
                                     [NSNumber numberWithInteger:MyInfoItemTypeTaskCenter],
                                     
                                     [NSNumber numberWithInteger:MyInfoItemTypeSettings],
                                     [NSNumber numberWithInteger:MyInfoItemTypeAboutUs],
                                     
                                    nil
                                     ];
    
    
    if ((self.dataArray != nil) &&([self.dataArray count] > 0)) {
        [self.dataArray removeAllObjects];
    }
    
    
    for (int i = 0; i < [itemTitleArray count]; i ++)
    {
        MineViewModel *model = [[MineViewModel alloc] initWithTitle:itemTitleArray[i] imageName:itemImageArray[i] type:[itemTypeArray[i] integerValue]];
        [self.dataArray addObject:model];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self requestData];
//    self.navigationController.navigationBarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
//    self.navigationController.navigationBarHidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:YES];
}

-(void)createMyTableView
{
    
    CGFloat x = 0, y = 0, w = kDeviceWidth, h = kDeviceHeight;
    self.tableView = [[UITableView alloc] initWithFrame:ccr(x, y, w, h) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    if (KDeviceOSVersion >= 7.0) {
        [_tableView setSeparatorInset:(UIEdgeInsetsMake(0, 55, 0, 0))];

    }
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    //添加可拉伸顶部图片start/////////
    
    [self.tableView addTwitterCoverWithImage:[YXBTool imageWithColor:kRGB(213, 37, 37)]];
    
    
    ///添加可拉伸顶部图片end/////

    x = 0, y = 0, w = kDeviceWidth, h = 272 + 15;
    self.headerView = [[MyYXBHeaderView alloc] initWithFrame:ccr(x, y, w, h)];
    _headerView.delegate = self;
    QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
    _headerView.userInfo = model.user;
    _tableView.tableHeaderView = _headerView;
    
    topNavView = [[GeRenZhongXinNavView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 64)];
    topNavView.backgroundColor = rgb(213, 37, 37, 1.0);
    topNavView.delegate = self;
    [self.view addSubview:topNavView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    NSInteger count = [self.itemSectionArray count];
    if (count == 0) {
        count = 1;
    }
    return count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = [_itemSectionArray[section] integerValue];
    NSLog(@"rows--%ld",(long)rows);
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellID";
    MineViewNewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == Nil) {
        cell = [[MineViewNewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSInteger itemIndex = 0;
    for (int i = 0; i < indexPath.section; i++) {
        
        itemIndex = itemIndex + [self.itemSectionArray[i] integerValue];
    }
    
    itemIndex = itemIndex + indexPath.row;
    MineViewModel *model = [self.dataArray objectAtIndex:itemIndex];
    model.itemAddImageName = nil;

    if (model.itemType == MyInfoItemTypeLoanCenter) {
        //
        OverdueModel *overdueModel = [OverdueModel shareOverdueModel];
        if ([[overdueModel showNewLoan] integerValue] > -1) {
            model.itemAddImageName = @"red-jieju.png";

        }
    }
    cell.model = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (section == [self.itemSectionArray count] - 1) {
        height = 10;
    }

    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger itemIndex = 0;
    for (int i = 0; i < indexPath.section; i++) {
        
        itemIndex = itemIndex + [self.itemSectionArray[i] integerValue];
    }
    
    itemIndex = itemIndex + indexPath.row;
    MineViewModel *model = [self.dataArray objectAtIndex:itemIndex];

    switch (model.itemType) {
        case MyInfoItemTypeMoney:
        {
            //资金明细
            QCMoneyListViewController *moneyVC = [[QCMoneyListViewController alloc] init];
            //        [rootNav pushViewController:moneyVC animated:YES];
            [self.navigationController pushViewController:moneyVC animated:YES];

        }
            break;
        case MyInfoItemTypeSafeCenter:
        {
            //安全中心
            SafeCenterController *safe=[[SafeCenterController alloc]init];
            [self.navigationController pushViewController:safe animated:YES];
            
        }
            break;
        case MyInfoItemTypeLoanCenter:
        {
            //借条中心
            /*
            OverdueModel *model = [OverdueModel shareOverdueModel];
            
//            LoanCenterViewController *loanCenter= [[LoanCenterViewController alloc] init];
//            loanCenter.
//            [self.navigationController pushViewController:loanCenter animated:YES];
            if ((model.showNewLoan != nil) && [model.showNewLoan integerValue] >= 0) {
                NSString *info = [NSString stringWithString:model.showNewLoan];
                model.showNewLoan = @"-1";

                [YXBTool typeToJump:@"myLoan" info:info];



            }
            else
            {
                [YXBTool typeToJump:@"myLoan" info:@"0"];

            }
            */

            YXBLoanCenterViewController *loanCenterVC = [[YXBLoanCenterViewController alloc] init];
            loanCenterVC.hidesBottomBarWhenPushed = YES;
            [[YXBTool getCurrentNav] pushViewController:loanCenterVC animated:YES];

            
        }
            break;
        case MyInfoItemTypeLiCai:
        {
//            //无忧理财
//             QCWuYouLiCaiViewController*licai=[[QCWuYouLiCaiViewController alloc]init];
//            [self.navigationController pushViewController:licai animated:YES];
            QCMoneyListViewController *moneyVC = [[QCMoneyListViewController alloc] init];
            [self.navigationController pushViewController:moneyVC animated:YES];
            
        }
            break;

        case MyInfoItemTypeTimeOrder:
        {
            //分期订单
            MyOrderListController *orderListController=[[MyOrderListController alloc]init];
            [self.navigationController pushViewController:orderListController animated:YES];

        }
            break;
            
        case MyInfoItemTypeCoupon:
        {
            //优惠券
            NSString *url = [YXBTool getURL:LeftViewControllerCouponUrl params:nil];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"我的优惠券"];
            
        }
            break;
        case MyInfoItemTypeTaskCenter:
        {
            //任务中心
            NSString *url = [YXBTool getURL:@"webView/user/invite/task.jsp" params:nil];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"任务中心"];

        }
            break;
        case MyInfoItemTypeSettings:
        {
            //设置
            SetNewViewController *set=[[SetNewViewController alloc]init];
            [self.navigationController pushViewController:set animated:YES];
            

        }
            break;
        case MyInfoItemTypeAboutUs:
        {
            //关于无忧借条
          
            NSString *url = [YXBTool getURL:AboutWuyoujietiao params:nil];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"关于无忧借条"];
            
        }
            break;
            
        default:
            break;
    }
    
    
}


-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    [self requestData];
}

/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIColor *color=rgb(213, 37, 37, 1);
    CGFloat offset=scrollView.contentOffset.y;
    if (offset < 116) {
        topNavView.backgroundColor = [color colorWithAlphaComponent:0];
    }else {
//        CGFloat alpha=1-((64-offset)/64);
        [UIView animateWithDuration:0.3 animations:^{
            
            topNavView.backgroundColor=[color colorWithAlphaComponent:1];

        }];
    }
}

*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestData
{
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.isLogin == YES) {
        [self httpLogin];
    }else {
        [self toLogin];
    }

}

//跳出登陆页面
- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    //    loginNav.navigationBar.barTintColor = rgb(231, 27, 27, 1);
    //    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    loginView.modalPresentationStyle = UIModalPresentationPopover;
    [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
}

- (void)httpLogin
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak MyInfoViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        UserManager* _currUser = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[User class]];
        QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
        //        NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:userModel.user.pwd]]];
//        [_currUser userLogin:userModel.user.username pass:userModel.user.pwd];
        NSString *blackBox = [YXBTool getFMString];
        [_currUser userLoginWithFraudmetrix:userModel.user.username pwd:userModel.user.pwd fraudmetrixToken:blackBox];
//        [this httpLoadParams:assginHtttperator];
        
    } complete:^(User* r, int taskid) {
        if (r.errCode == 0) {
            QCUserModel * currUser = [[QCUserModel alloc]init];
            currUser.isLogin = YES;
            currUser.user = r;
            QCUserManager * um  = [QCUserManager sharedInstance];
            QCUserModel * oldUser = [um getLoginUser];
            if (![oldUser.user.username isEqualToString:r.username]) {
                currUser.gestureOpen = NO;
                [YXBTool setGesturePassWord:nil];
                
            }
            else
            {
                currUser.gestureOpen = oldUser.gestureOpen;
                
            }
            
            [um setLoginUser:currUser];
            
            self.headerView.userInfo = currUser.user;
        }else{
            [self toLogin];
        }
        
        [self.tableView reloadData];
//        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{

            UserManager* _currUser = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[User class]];
            QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
            //        NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:userModel.user.pwd]]];
//            [_currUser userLogin:userModel.user.username pass:userModel.user.pwd];
    NSString *blackBox = [YXBTool getFMString];
    [_currUser userLoginWithFraudmetrix:userModel.user.username pwd:userModel.user.pwd fraudmetrixToken:blackBox];

}
//请求完成
-(void)httpLoadComplete:(User *)r{
    if (r.errCode == 0) {
        QCUserModel * currUser = [[QCUserModel alloc]init];
        currUser.isLogin = YES;
        currUser.user = r;
        QCUserManager * um  = [QCUserManager sharedInstance];
        QCUserModel * oldUser = [um getLoginUser];
        if (![oldUser.user.username isEqualToString:r.username]) {
            currUser.gestureOpen = NO;
            [YXBTool setGesturePassWord:nil];
            
        }
        else
        {
            currUser.gestureOpen = oldUser.gestureOpen;
            
        }
        
        [um setLoginUser:currUser];
        
        self.headerView.userInfo = currUser.user;
    }else{
        [self toLogin];
    }

}

#pragma -mark HeaderViewDelegate
//充值
-(void)chongzhi
{
    PayHomeViewController *payhome = [[PayHomeViewController alloc] init];
    [self.navigationController pushViewController:payhome animated:YES];

}

//提现
-(void)tixian
{
    NSString *payUrl=[NSString stringWithFormat:@"%@webView/user/withdraw.jsp?a=23",YXB_IP_ADRESS];
    
    [YXBTool jumpSafariWithUrl:[YXBTool getURL:payUrl params:nil]];

}

//二维码事件
-(void)getQuickMark
{
    
}

-(void)moneySelected
{
    
}

-(void)qrCodeAction
{
    //二维码跳转
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *url = [NSString stringWithFormat:@"%@webView/qrCode/qrCodeJump.jsp?id=%@%04ld",YXB_IP_ADRESS,userModel.user.yxbId,(long)rand()%10000];
    UIImage *image = [QRCodeGenerator qrImageForString:url imageSize:kDeviceWidth];
    
    MyCodeViewController *code = [[MyCodeViewController alloc] init];
    code.image = image;
    [self.navigationController pushViewController:code animated:YES];
    
    
}

-(void)headerToSettings
{

    QCPersonalProfileViewController *personProfileVC = [[QCPersonalProfileViewController alloc] init];
    [self.navigationController pushViewController:personProfileVC animated:YES];
}

//-(void)leftClicked
//{
//    [super leftClicked];
//}


@end
