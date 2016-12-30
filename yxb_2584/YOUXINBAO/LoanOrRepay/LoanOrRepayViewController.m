//
//  LoanOrRepayViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/8.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanOrRepayViewController.h"
#import "LoanOrRepayListViewController.h"
#import "QCLoanCenterViewController.h"
#import "LoanDetailsViewController.h"
#import "LoanOrRepayTableViewCell.h"
#import "DebtListViewController.h"
#import "CustomBadge.h"
#import "UserState.h"
#import "QCFriendpromptController.h"
#import "CPBTimerManager.h"
#import "QCAACollectMoneyController.h"
#import "LoanCenterViewController.h"
#import "YXBTool.h"
#import "LoanQuickTabViewController.h"
#import "QCLendDetailViewController.h"
#import "QCSecretaryViewController.h"
#import "MsgCenterMgr.h"
#import "MsgCenterMgr+Public.h"
#import "QCHomeDataManager.h"
#import "LoanDetailsNewViewController.h"
#import "YXBJieKuanController.h"
#import "YXBJieChuController.h"

#define GoodsDetailBaseUrl [NSString stringWithFormat:@"%@webView/goods/good.jsp?a=1",YXB_IP_ADRESS]

@interface LoanOrRepayViewController ()<CPBTimerDelegate,UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate>
{
    
    NSArray * array;
    NSArray * array1;
    NSInteger               postion;
}
@property(nonatomic,strong)CPBTimerManager              *timerManager;
@property(nonatomic,strong)CustomBadge *unReadView;
@property (nonatomic,strong)QCBaseTableView * tableView;
@end

@implementation LoanOrRepayViewController
- (void)dealloc {
    if (_timerManager != nil) {
    [_timerManager stop];
}
    NSLog(@"友LoanOrRepayViewController is dealloc");
}

- (void)leftClicked {

    [super leftClicked];
}
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:YES];
//        [_timerManager stop];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"友·借款"];

    postion = 0;
    [self setBackView];
    [self setNavigationItme];
    [self initView];
    [self requestData];
    NSLog(@"%ld",(long)kDeviceWidth);
}


- (void)setNavigationItme
{

   /*
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 30);
    [btn setImage:[UIImage imageNamed:@"index-notice-icon.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightNavigationItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"借款记录" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    UIBarButtonItem *createItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = createItem;
    */
    
    [self setNavigationButtonItrmWithiamge:@"index-notice-icon.png" withRightOrleft:@"right" withtargrt:self withAction:@selector(rightNavigationItemAction:)];

}

- (void)rightNavigationItemAction:(UIButton *)sender
{   /*
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有登录，请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alterView.tag = 10010;
        [alterView show];
        return;
    }
    LoanOrRepayListViewController * list = [[LoanOrRepayListViewController alloc]init];
    list.type = LoanOrRepayListBorrow;
    [self.navigationController pushViewController:list animated:YES];
     */
    
    NSString *url = [YXBTool getURL:@"webView/explain/friendExplain.jsp?t=1" params:nil];

    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"友借款说明"];
}

- (void)initView
{
     self.view.backgroundColor = rgb(238, 236, 246, 1.0);
    array = @[@"土豪放款区",@"向好友借入",@"向好友借出"];
    array1 = @[@"yjyh-navhao",@"yjyh-navjr",@"yjyh-navjc"];
//    NSArray * subArray = @[@"借入记录",@"借出记录"];

//    for (NSInteger i= 0; i < array.count; i++) {
//        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20+90*i, kDeviceWidth-20, 80)];
//        btn.backgroundColor = [UIColor redColor];
//        [btn setTitle:array[i] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(btnAciton:) forControlEvents:UIControlEventTouchUpInside];
//        btn.tag = i +1;
//        [self.view addSubview:btn];
    
//        if (i < 2) {
//            UIButton * subbtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-120, btn.frame.origin.y+btn.frame.size.height+20, 100, 20)];
//            subbtn.backgroundColor = [UIColor greenColor];
//            [subbtn setTitle:subArray[i] forState:UIControlStateNormal];
//            [subbtn addTarget:self action:@selector(btnAciton:) forControlEvents:UIControlEventTouchUpInside];
//            subbtn.tag = i +4;
//            [self.view addSubview:subbtn];
//        }
        
//    }
    
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0,0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, (kDeviceWidth-40)/3/180*216+180)];
    NSArray *imgarray = @[@"yjyh-ms-1",@"yjyh-sk-1",@"yjyh-jieju-1"];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(-1, kDeviceWidth/320*26, kDeviceWidth+2, (kDeviceWidth-40)/3/180*130+20)];
    view1.layer.borderColor = [YXBTool colorWithHexString:@"#d0d0d0"].CGColor;
    view1.layer.borderWidth = 0.5f;;
    view1.backgroundColor = [UIColor whiteColor];
    [view addSubview:view1];
    for (int i = 0; i < imgarray.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10*(i+1)+i*(kDeviceWidth-40)/3, view1.top+10, (kDeviceWidth-40)/3, (kDeviceWidth-40)/3/180*130)];
        [button setBackgroundImage:[UIImage imageNamed:imgarray[i]] forState:UIControlStateNormal];
        button.tag = i+10010;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        if (i == 2) {
            
            self.hasNewfbut = [[UIButton alloc] initWithFrame:button.bounds];
            self.hasNewfbut.userInteractionEnabled = NO;
            [self.hasNewfbut setBackgroundImage:[UIImage imageNamed:@"yjyh-jiejunew"] forState:UIControlStateNormal];
            [button addSubview:self.hasNewfbut];
        }
    }
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/320*26)];
    imgView.image = [UIImage imageNamed:@"wyjk"];
    [view addSubview:imgView];
    self.loanbotview = [[LoanBottomView alloc ]initWithFrame:CGRectMake(0, view1.bottom+17, kDeviceWidth, 175)];
    [view addSubview:self.loanbotview];
    _tableView.tableFooterView = view;
    
}

- (void)createTimer {
    _timerManager = [[CPBTimerManager alloc]initWithTimeInterval:3 userInfo:Nil repeats:YES];
    _timerManager.delegate = self;
}

- (void)buttonAction:(UIButton *)sender {
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有登录，请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 10010;
//        [alterView show];
        [self toLogin];
        return;
    }

    if (sender.tag == 10010) {
        QCSecretaryViewController *secretary=[[QCSecretaryViewController alloc]init];
        [self.navigationController pushViewController:secretary animated:YES];
        

    }else if (sender.tag == 10011) {
        

        QCAACollectMoneyController *collectMoney=[[QCAACollectMoneyController alloc]init];
        collectMoney.isCreate=YES;
        [self.navigationController pushViewController:collectMoney animated:YES];
//        QCFriendpromptController *friend=[[QCFriendpromptController alloc]init];
//        [self.navigationController pushViewController:friend animated:YES];
        
    }else if (sender.tag == 10012) {
        /*
        QCLoanCenterViewController *loanCenterVC = [[QCLoanCenterViewController alloc] init];
        [self.navigationController pushViewController:loanCenterVC animated:YES];
         */
        [QCHomeDataManager sharedInstance].ishasNewLoanMess = NO;
        LoanCenterViewController *controller = [[LoanCenterViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
#pragma mark -- CPBTimerDelegate
- (void)CPBTimerManagerAction:(CPBTimerManager *)timer {
    NSLog(@"友借款 - 定时器 ing");
        postion++;
        
        if (postion >= [self.loanbotview.iTLoanIndexPersonRank count]-1) {
            postion = 0;
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:postion inSection:0];
            [self.loanbotview.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            postion++;
            NSIndexPath *scrollIndexPath1 = [NSIndexPath indexPathForRow:postion inSection:0];
            [self.loanbotview.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath1 atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }else {
            
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:postion inSection:0];
            [self.loanbotview.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }

}

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self requestData];
}

#pragma mark --- 数据请求
-(void)requestData
{

    //    [self.activity startAnimating];
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak LoanOrRepayViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this stopDefaultAnimation];
        
    } cancel:^(int d) {
        
        
    } error:^(int d, THttpOperatorErrorCode e) {
        if (e == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
        }
        
    } param:^(NSString *s) {
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(TLoanIndexInfo *r, int taskid) {
        
        
        [this httpLoadComplete:r];
    }];
    
    [self.iHttpOperator connect];
    
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    LoanManagerV2* blankNote = (LoanManagerV2 *)  [httpOperation getAopInstance:[LoanManagerV2 class] returnValue:[TLoanIndexInfo class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.user.yxbToken == nil) {
        [blankNote getLoanIndexInfo:@""];
    }else {
        [blankNote getLoanIndexInfo:userModel.user.yxbToken];
    }

}
//请求完成
-(void)httpLoadComplete:(TLoanIndexInfo *)r{
    NSLog(@"r=  %@",r);
    if (r.errCode == 0) {
        self.model = r;
        self.loanbotview.iTLoanIndexPersonRank = r.iTLoanIndexPersonRank;
        self.loanbotview.participantsNum = r.participantsNum;
        
    }else {
        
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }
    [self.tableView reloadData];
    [self.tableView reloadDeals];
}


- (void)setModel:(TLoanIndexInfo *)model {
    _model = model;
    if (_model.iTLoanIndexPersonRank != nil && _model.iTLoanIndexPersonRank.count > 3 && _timerManager == nil) {
        [self createTimer];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 10;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"CELLID";
    LoanOrRepayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LoanOrRepayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSString * imageName = array1[indexPath.row];
    
    cell.rowImage.image = [UIImage imageNamed:imageName];
    cell.titleLabel.text = array[indexPath.row];
    cell.titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    if (indexPath.row == 0) {
//        cell.stitleLabel.text = self.model.documentsOfLoan;
//    }else if (indexPath.row == 1) {
//        cell.stitleLabel.text = self.model.documentsOfStorm;
//    }else if (indexPath.row == 2) {
//        cell.stitleLabel.text = self.model.documentsOfTuHao;
//    }
    
    if (indexPath.row == 0) {
        cell.stitleLabel.text = self.model.documentsOfTuHao;
    }else if (indexPath.row == 1) {
        cell.stitleLabel.text = self.model.documentsOfLoan;
    }else if (indexPath.row == 2) {
        cell.stitleLabel.text = self.model.documentsOfStorm;
    }


//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有登录，请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 10010;
//        [alterView show];
        [self toLogin];
        return;
    }

    if (indexPath.row == 1) {
        if ([UserState isLv1] == E_NO_OPERATE) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"为了更快的借入（借出）款项，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alterView.tag = 10086;
            [alterView show];
            return;
        }else if ([UserState isLv1] == E_IN_REVIEW) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alterView show];
            return;
        }else if ([UserState isLv1] == E_FAIL_UserStateRes) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"您的身份认证失败，请从新认证" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alterView show];
            return;
        }
//        if (userModel.user.accountStatus == 1) {
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息正在审核中..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            //        alterView.tag = 10086;
//            [alterView show];
//            return;
//        }else if (userModel.user.accountStatus == 2) {
//            //通过
//        }else if (userModel.user.accountStatus == 3) {
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息，审核失败，请重新进行实名认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            alterView.tag = 10086;
//            [alterView show];
//            return;
//        }else if (userModel.user.accountStatus == 4) {
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名信息已提交" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alterView show];
//            return;
//        }else if (userModel.user.accountStatus == 0) {
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"为了更快的借入（借出）款项，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            alterView.tag = 10086;
//            [alterView show];
//            return;
//        }
        
        /*
        LoanDetailsViewController * loanDetails = [[LoanDetailsViewController alloc]init];
        loanDetails.bOrL = NEWLOAN;
        [self.navigationController pushViewController:loanDetails animated:YES]
        
        */
        YXBJieKuanController *controller = [[YXBJieKuanController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
        
        
//        LoanDetailsNewViewController * loanDetails = [[LoanDetailsNewViewController alloc]init];
//        [self.navigationController pushViewController:loanDetails animated:YES];

        
    }else if (indexPath.row == 2)
    {
        if ([UserState isLv2] == E_NO_OPERATE) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"为了更快的借入（借出）款项，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alterView.tag = 10086;
            [alterView show];
            return;
        }else if ([UserState isLv2] == E_IN_REVIEW) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alterView show];
            return;
        }else if ([UserState isLv2] == E_FAIL_UserStateRes) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"您的身份认证失败，请从新认证" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alterView show];
            return;
        }
        //        if (userModel.user.accountStatus == 1) {
        //            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息正在审核中..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        //            //        alterView.tag = 10086;
        //            [alterView show];
        //            return;
        //        }else if (userModel.user.accountStatus == 2) {
        //            //通过
        //        }else if (userModel.user.accountStatus == 3) {
        //            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息，审核失败，请重新进行实名认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //            alterView.tag = 10086;
        //            [alterView show];
        //            return;
        //        }else if (userModel.user.accountStatus == 4) {
        //            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名信息已提交" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        //            [alterView show];
        //            return;
        //        }else if (userModel.user.accountStatus == 0) {
        //            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"为了更快的借入（借出）款项，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //            alterView.tag = 10086;
        //            [alterView show];
        //            return;
        //        }
        /*
        LoanDetailsViewController * loanDetails = [[LoanDetailsViewController alloc]init];
        loanDetails.bOrL = BorrowerORLendersQuickLend;
        [self.navigationController pushViewController:loanDetails animated:YES];
        */
//        LoanQuickTabViewController *controller = [[LoanQuickTabViewController alloc] init];
        YXBJieChuController *controller = [[YXBJieChuController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];


    }else if (indexPath.row == 0){//        if (userModel.user.accountStatus == 1) {
        //            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息正在审核中..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        //            //        alterView.tag = 10086;
        //            [alterView show];
        //            return;
        //        }else if (userModel.user.accountStatus == 2) {
        //            //通过
        //        }else if (userModel.user.accountStatus == 3) {
        //            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息，审核失败，请重新进行实名认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //            alterView.tag = 10086;
        //            [alterView show];
        //            return;
        //        }else if (userModel.user.accountStatus == 0) {
        //            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"为保障您的资金安全，使用土豪贷功能前，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //            alterView.tag = 10086;
        //            [alterView show];
        //            return;
        //        }
        
        /*
        DebtListViewController *vc = [[DebtListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        */
        NSDictionary *dic = [NSDictionary dictionaryWithObject:DebtDetailID forKey:@"pid"];
        NSString *url = [YXBTool getURL:GoodsDetailBaseUrl params:[YXBTool jsonEqualWithDic:dic]];
        
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"白条详情"];

        
    }
//    else if (indexPath.row==3){
////
////        QCFriendpromptController *friendPromptVC=[[QCFriendpromptController alloc]init];
////        [self.navigationController pushViewController:friendPromptVC animated:YES];
//    
//    }
//    else if (indexPath.row == 4){
//        QCLoanCenterViewController *loanCenterVC = [[QCLoanCenterViewController alloc] init];
//        [self.navigationController pushViewController:loanCenterVC animated:YES];
//        
//    }
}
- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
}

- (void)toAuthentication {
    AuthenticationViewController *authentic = [[AuthenticationViewController alloc] init];
    [self.navigationController pushViewController:authentic animated:YES];
}

#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10010) {
        if (buttonIndex == 1) {
            [self toLogin];
        }
    } else if (alertView.tag == 10086){
        if (buttonIndex == 1) {
            
            [self toAuthentication];
        }
    }
}

- (void)btnAciton:(UIButton *)sender
{
    if (sender.tag == 1) {

        
       
    }else if (sender.tag == 2){
        
    }else if (sender.tag == 3){
    
    }else if (sender.tag == 4){
    
    }else if (sender.tag == 5){

        
        
    }else if (sender.tag == 4){
        LoanOrRepayListViewController * list = [[LoanOrRepayListViewController alloc]init];
        list.type = LoanOrRepayListBorrow;
        [self.navigationController pushViewController:list animated:YES];
    }else if (sender.tag == 5){

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if ([QCHomeDataManager sharedInstance].ishasNewLoanMess == YES) {
        self.hasNewfbut.hidden = NO;
    }else {
        self.hasNewfbut.hidden = YES;
    }
}
/*
-(void)viewWillAppear:(BOOL)animated
{
    NSInteger count = [[RCIM sharedRCIM] getTotalUnreadCount];
    if (count > 0) {
        if (_unReadView != nil && _unReadView.superview) {
            [_unReadView removeFromSuperview];
        }
        NSString *text = @"";
        if (count < 0) {
            text =[NSString stringWithFormat:@"%ld",count];

        }
        else
        {
            text = @"new";
        }
        self.unReadView = [CustomBadge customBadgeWithString:text withStyle:[BadgeStyle oldStyle]];
        _unReadView.frame = CGRectMake(kDeviceWidth - 35,0, 30, 15);
        
//        [_unReadView autoBadgeSizeWithString:text];
        [self.navigationController.navigationBar addSubview:_unReadView];

    }

    [super viewWillAppear:YES];
}


-(void)viewWillDisappear:(BOOL)animated
{
    if (_unReadView != nil && _unReadView.superview) {
        [_unReadView removeFromSuperview];
    }

    [super viewWillDisappear:animated];
}

*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
