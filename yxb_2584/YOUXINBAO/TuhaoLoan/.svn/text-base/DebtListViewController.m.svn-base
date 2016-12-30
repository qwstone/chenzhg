//
//  DebtListViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DebtListViewController.h"
#import "DebtListCell.h"
#import "DebtDetailViewController.h"
#import "ISendLoanViewController.h"
#import "MyTuhaoLoanListViewController.h"
#import "AppBlankNoteManager.h"
#import "HttpOperator.h"
#import "BlankNoteData.h"
#import "QCBaseTableView.h"
#import "DebtDetailNewViewController.h"
#import "DebtScheduleViewController.h"
#import "UserState.h"

#define DebtListPageStartNO 1

@interface DebtListViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate>

@property(nonatomic,strong)QCBaseTableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)HttpOperator   *iHttpOperator;
@property(nonatomic,assign)NSInteger        pageNo;
@property(nonatomic,strong)NSSkyArray               *err;
@property(nonatomic,strong)UILabel          *emptyLabel;

@end

@implementation DebtListViewController

-(void)dealloc
{
//    [_iHttpOperator cancel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
//    [self loadDefaultData];
    _pageNo = DebtListPageStartNO;
    [self addRightNavigationItem];
    [self initView];
    [self createBottomView];
    [_tableView reloadData];
//    [self requestData];
    // Do any additional setup after loading the view.
}


- (void)initView
{
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"找土豪借白条"];

    
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-50) style:UITableViewStylePlain refreshFooter:YES] ;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.hasFooter = YES;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    _tableView.hidden = YES;
    [self.view addSubview:_tableView];
    
    self.emptyLabel = [[UILabel alloc] initWithFrame:_tableView.frame];
    _emptyLabel.text = @"暂无记录";
    _emptyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_emptyLabel];
    _emptyLabel.hidden = YES;

    
    
}

- (void)createBottomView {
    
    UIButton *bottomBut = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bottom-50-64, kDeviceWidth, 50)];
    bottomBut.backgroundColor = [UIColor whiteColor];
    [bottomBut setTitleColor:rgb(52, 142, 250, 1) forState:UIControlStateNormal];
    [bottomBut setTitle:@"我要发白条" forState:UIControlStateNormal];
    [bottomBut addTarget:self action:@selector(bottomButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBut];
}

#pragma mark --- bottomAction
- (void)bottomButAction {
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    if (!userModel.isLogin) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请登录账号使用土豪贷功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alter.tag = 20003;
        [alter show];
        return;
    }
    
    if ([UserState isLv3] == E_NO_OPERATE) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"为保障您的资金安全，发白条前请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alterView.tag = 10086;
        [alterView show];
        return;
    }else if ([UserState isLv3] == E_IN_REVIEW) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
        return;
    }else if ([UserState isLv3] == E_FAIL_UserStateRes) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"您的身份认证失败，请从新认证" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
        return;
    }
    
//    if (userModel.user.accountStatus == 1) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        //        alterView.tag = 10086;
//        [alterView show];
//        return;
//    }else if (userModel.user.accountStatus == 4) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alterView show];
//        return;
//    }else if (userModel.user.accountStatus == 2) {
//        //通过
//    }else if (userModel.user.accountStatus == 3) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息，审核失败，请重新进行实名认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 10086;
//        [alterView show];
//        return;
//    }else if (userModel.user.accountStatus == 0) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"为保障您的资金安全，发白条前请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 10086;
//        [alterView show];
//        return;
//    }

    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak typeof(self) this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
        
    } error:^(int d, THttpOperatorErrorCode e) {
        
        
    } param:^(NSString *s) {
        
        [this httpLOad_BottomParams:s httpOperation:assginHtttperator];
    } complete:^(TResultSet *r, int taskid) {
        [this httpLoad_BottomComplete:r];
    }];
    
    [self.iHttpOperator connect];
}
//上传参数
- (void)httpLOad_BottomParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    AppBlankNoteManager* blankNote = (AppBlankNoteManager *)  [httpOperation getAopInstance:[AppBlankNoteManager class] returnValue:[TResultSet class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [blankNote checkUserCreateBlankNote:userModel.user.yxbToken];

}
//请求完成
-(void)httpLoad_BottomComplete:(TResultSet *)r{
    self.view.backgroundColor = rgb(238, 236, 246, 1.0);
    
    if (r.errCode == 0) {
        ISendLoanViewController *iSend = [[ISendLoanViewController alloc] init];
        [self.navigationController pushViewController:iSend animated:YES];
    }else {
        
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",r.errString] delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"查看借入白条", nil];
        alter.tag = 30003;
        [alter show];
    }

}
-(void)addRightNavigationItem
{
    //发白条
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn addTarget:self action:@selector(publishMoney:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"我要发白条" forState:UIControlStateNormal];
    UIBarButtonItem *createItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = createItem;
    [btn setTitle:@"我的白条" forState:UIControlStateNormal];
}



-(void)publishMoney:(UIButton *)sender
{
    NSLog(@"%@",sender.titleLabel.text);
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    if (!userModel.isLogin) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请登录账号使用土豪贷功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alter.tag = 20003;
        [alter show];
        return;
    }
    
    if (userModel.user.accountStatus == 1) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息正在审核中..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        //        alterView.tag = 10086;
        [alterView show];
        return;
    }else if (userModel.user.accountStatus == 2) {
        //通过
    }else if (userModel.user.accountStatus == 3) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息，审核失败，请重新进行实名认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alterView.tag = 10086;
        [alterView show];
        return;
    }else if (userModel.user.accountStatus == 0) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"为保障您的资金安全，发白条前请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alterView.tag = 10086;
        [alterView show];
        return;
    }
    MyTuhaoLoanListViewController *myiSend = [[MyTuhaoLoanListViewController alloc] init];
    myiSend.isMy = YES;
    [self.navigationController pushViewController:myiSend animated:YES];
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
    if (alertView.tag == 20003) {
        if (buttonIndex == 1) {
            [self toLogin];
        }
    }else if (alertView.tag == 30003){
        if (buttonIndex == 1) {
            MyTuhaoLoanListViewController *myiSend = [[MyTuhaoLoanListViewController alloc] init];
            myiSend.isMy = NO;
            [self.navigationController pushViewController:myiSend animated:YES];
        }
    } else if (alertView.tag == 10086){
        if (buttonIndex == 1) {
            
            [self toAuthentication];
        }
    }
}

-(void)requestData
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak DebtListViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
        
    } error:^(int d, THttpOperatorErrorCode e) {
        if (e == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            [this.tableView reloadDeals];
        }

        
    } param:^(NSString *s) {
        
        [self httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(NSSkyArray *r, int taskid) {
        [self httpLoadComplete:r];
    }];
    
    [self.iHttpOperator connect];


}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    AppBlankNoteManager* blankNote = (AppBlankNoteManager *)  [httpOperation getAopInstance:[AppBlankNoteManager class] returnValue:[NSSkyArray class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [blankNote getNoteListData:userModel.user.yxbToken pageNum:self.pageNo];
}
//请求完成
-(void)httpLoadComplete:(NSSkyArray *)r{
    self.view.backgroundColor = rgb(238, 236, 246, 1.0);
    
    NSLog(@"r=  %@",r);
    self.err = r;
    NSSkyArray *backArray = (NSSkyArray *)r;
    if (_pageNo == DebtListPageStartNO && _dataArray != nil && [_dataArray count] > 0) {
        [_dataArray removeAllObjects];
    }
    if ([backArray.iArray count] > 0) {
        //            _tableView.hidden = NO;
        _emptyLabel.hidden = YES;
    }
    else
    {
        //            _tableView.hidden = YES;
        _emptyLabel.hidden = NO;
        
    }
    [self.dataArray addObjectsFromArray:backArray.iArray];
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.tableView.hasFooter = YES;
    }else {
        self.tableView.hasFooter = NO;
    }
    
    [self.tableView reloadData];
    [self.tableView reloadDeals];
    if (backArray.errCode == 3) {
        
    }
    else if(backArray.errCode == 2)
    {
        NSLog(@"%@==%@",[self class],backArray.errString);
    }
    else if(backArray.errCode == 1)
    {
        NSLog(@"%@==%@",[self class],backArray.errString);
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DebtCellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellID";
    DebtListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == Nil) {
        cell = [[DebtListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.width = _tableView.width;
    cell.height = DebtCellHeight;
    
    BlankNoteData * debtModel = _dataArray[indexPath.section];

    cell.model = debtModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    BlankNoteData *model = [self.dataArray objectAtIndex:indexPath.section];
    DebtDetailNewViewController *controller = [[DebtDetailNewViewController alloc] init];
    controller.model = model;
    [self.navigationController pushViewController:controller animated:YES];
    
    
    /*
    BlankNoteData * debtModel = _dataArray[indexPath.row];
    DebtScheduleViewController *controller = [[DebtScheduleViewController alloc] init];
    NoteSummary *noteSummary = [[NoteSummary alloc] init];
    noteSummary.repaymentNoteID = debtModel.blankNoteID;
    noteSummary.debtorName = debtModel.nickName;
    controller.noteSummary = noteSummary;
    [self.navigationController pushViewController:controller animated:YES];
    */

    
}

//下拉刷新
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    _pageNo = DebtListPageStartNO;
    [self requestData];
}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>=scrollView.frame.size.height && !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        if (_dataArray.count%20==0) {
            _pageNo ++;
            [self requestData];
        }
        else
        {
            [self.tableView reloadDeals];

        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    

    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.width, 15)];
    return topView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 15;
}

-(void)leftClicked
{
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

-(void)viewWillDisappear:(BOOL)animated
{
    [_iHttpOperator cancel];
    [super viewWillDisappear:YES];
}

@end
