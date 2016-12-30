//
//  MyTuhaoLoanListViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/4/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyTuhaoLoanListViewController.h"
#import "DebtListCell.h"
#import "DebtDetailViewController.h"
#import "ISendLoanViewController.h"
#import "TuhaoLoanSetViewController.h"
#import "HttpOperator.h"
#import "BlankNoteData.h"
#import "LoanOrRepayWhiteLineCell.h"
#import "DebtScheduleViewController.h"
#import "DebtListViewController.h"
#import "UserState.h"

#define DebtListPageStartNO 1
@interface MyTuhaoLoanListViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate> {
    NSInteger indexpage;;
    UIButton *bottomBut;
}


@property (nonatomic,strong)QCBaseTableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)HttpOperator   *iHttpOperator;
@property(nonatomic,assign)NSInteger       pageNumber;
@property(nonatomic,strong)UILabel       *noLoanTextLabel;
@property(nonatomic,strong)UIImageView       *noLoanimg;
@end

@implementation MyTuhaoLoanListViewController
-(void)dealloc{
    NSLog(@"MyTuhaoLoanListViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNumber = DebtListPageStartNO;
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = rgb(237, 237, 246, 1);
//    [self requestData];
    [self initView];
    [self createBottomView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请登录账号使用土豪贷功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alter.tag = 20003;
        [alter show];
    }
    
    //判断返回是否需要刷新数据
    NSString *refreshFlag = [[NSUserDefaults standardUserDefaults] objectForKey:DebtLoanCreateBlankNoteNeedRefresh];
    if ([refreshFlag isEqualToString:@"YES"]) {
        [self QCBaseTableViewDidPullDownRefreshed:_tableView];
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:DebtLoanCreateBlankNoteNeedRefresh];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _segment.selectedSegmentIndex = 0;
        [self segmentchange:_segment];
        [_tableView setContentOffset:CGPointZero];
    }
}

#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 20003) {
        if (buttonIndex == 1) {
            [self toLogin];
        }
    }else if (alertView.tag == 30004){
        if (buttonIndex == 1) {
            self.segment.selectedSegmentIndex = 1;
            [self segmentchange:self.segment];
        }
    }else if (alertView.tag == 10086){
        if (buttonIndex == 1) {
            
            [self toAuthentication];
        }
    }
}


- (void)initView
{
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"我的土豪白条"];
    self.noLoanimg = [[UIImageView alloc] initWithFrame:CGRectMake(40, 180, 50, 50)];
    [self.noLoanimg setImage:[UIImage imageNamed:@"smile-gray-icon"]];
    [self.view addSubview:self.noLoanimg];
    self.noLoanTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.noLoanimg.right, self.noLoanimg.top, kDeviceWidth-90-40, 50)];
    self.noLoanTextLabel.textAlignment = NSTextAlignmentCenter;
    self.noLoanTextLabel.numberOfLines = 0;
    self.noLoanTextLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.noLoanTextLabel];
    
    NSArray *arr = [[NSArray alloc]initWithObjects:@"已发白条",@"借入白条", nil];
    self.segment = [[UISegmentedControl alloc]initWithItems:arr];
    [self.segment setTintColor:rgb(231, 27, 27, 1)];
    self.segment.backgroundColor = [UIColor whiteColor];
    self.segment.layer.cornerRadius = 5.0;
    self.segment.frame = CGRectMake(10, 10, kDeviceWidth-20, 40);
    if (self.isMy == YES) {
        self.segment.selectedSegmentIndex = 0;
//        [self.segment setWidth:60 forSegmentAtIndex:1];
//        [self.segment setWidth:kDeviceWidth-60-60 forSegmentAtIndex:0];
    }else {
        self.segment.selectedSegmentIndex = 1;
//        [self.segment setWidth:60 forSegmentAtIndex:0];
//        [self.segment setWidth:kDeviceWidth-60-60 forSegmentAtIndex:1];
    }
    [self.segment addTarget:self action:@selector(segmentchange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segment];
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0+self.segment.bottom, kDeviceWidth, kDeviceHeight-64-50-self.segment.bottom) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];//指定进度轮的大小
    self.activity.backgroundColor = rgb(0, 0, 0, 0.7);
    self.activity.layer.cornerRadius = 5;
    [self.activity setCenter:CGPointMake(160, 140)];//指定进度轮中心点
    self.activity.center = self.view.center;
    [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];//设置进度轮显示类型
    [self.view addSubview:self.activity];
}

-(void)segmentchange:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %ld", (long)Index);
    switch (Index) {
        case 0:
            if (self.isMy == NO) {
                _pageNumber = DebtListPageStartNO;
            }
            bottomBut.hidden = NO;
            self.tableView.height = kDeviceHeight-64-50-self.segment.bottom;
            self.isMy = YES;
            [self.tableView beginRefreshing];
            break;
        case 1:
            if (self.isMy == YES) {
                _pageNumber = DebtListPageStartNO;
            }
            bottomBut.hidden = YES;
            self.tableView.height = kDeviceHeight-64-self.segment.bottom;
            self.isMy = NO;
            [self.tableView beginRefreshing];
            break;
    }
}

- (void)createBottomView {

    bottomBut = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.bottom-50-64, kDeviceWidth, 50)];
    bottomBut.backgroundColor = [UIColor whiteColor];
    [bottomBut setTitle:@"添加新白条" forState:UIControlStateNormal];
    [bottomBut setTitleColor:rgb(52, 142, 250, 1) forState:UIControlStateNormal];
    [bottomBut addTarget:self action:@selector(bottomButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBut];
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
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息正在审核中..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        //        alterView.tag = 10086;
//        [alterView show];
//        return;
//    }else if (userModel.user.accountStatus == 4) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名信息已提交" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
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
        __weak MyTuhaoLoanListViewController *this = self;

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
    if (r.errCode == 0) {
        ISendLoanViewController *iSend = [[ISendLoanViewController alloc] init];
        [self.navigationController pushViewController:iSend animated:YES];
    }else {
        
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",r.errString] delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"查看借入白条", nil];
        alter.tag = 30004;
        [alter show];
    }
}
#pragma mark --- 数据请求
-(void)requestData
{
    _tableView.hidden = YES;
    self.noLoanTextLabel.hidden = YES;
    self.noLoanimg.hidden = YES;
//    [self.activity startAnimating];
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak MyTuhaoLoanListViewController *this = self;
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
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(id r, int taskid) {
        [this httpLoadComplete:r];
    }];
    
    [self.iHttpOperator connect];
    
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    AppBlankNoteManager* blankNote = (AppBlankNoteManager *)  [httpOperation getAopInstance:[AppBlankNoteManager class] returnValue:[NSSkyArray class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (self.isMy == YES) {
        
        if (userModel.user.yxbToken != nil) {
            [blankNote getAllNotesByToken:userModel.user.yxbToken pageNum:_pageNumber];
        }else {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"请登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alter show];
        }
    }else {
        //                [blankNote getAllNotesByToken:userModel.user.yxbToken pageNum:_pageNumber];
        [blankNote getClaimNotesByToken:userModel.user.yxbToken pageNum:_pageNumber];
    }

}
//请求完成
-(void)httpLoadComplete:(id)r{
    NSLog(@"r=  %@",r);
    //        [self.activity stopAnimating];
    if (self.isMy == YES) {
        
        if (self.pageNumber == DebtListPageStartNO) {
            if (self.dataArray.count > 0) {
                [self.dataArray removeAllObjects];
            }
        }
        [self.dataArray addObjectsFromArray:((NSSkyArray *)r).iArray];
        if (self.dataArray.count == 0) {
            self.tableView.hidden = YES;
            self.noLoanTextLabel.hidden = NO;
            self.noLoanimg.hidden = NO;
            self.noLoanTextLabel.left = self.noLoanimg.right;
            self.noLoanTextLabel.text = @"您还没有发起过白条，马上发白条成为土豪吧！";
        }else {
            self.tableView.hidden = NO;
            self.noLoanTextLabel.hidden = YES;
            self.noLoanimg.hidden = YES;
        }
        [self.tableView reloadData];
        [self.tableView reloadDeals];
        if (self.dataArray.count != 0 && self.dataArray.count%20 == 0) {
            self.tableView.hasFooter = YES;
        }else {
            self.tableView.hasFooter = NO;
        }
    }else {
        if (((NSSkyArray*)r).errCode == 0) {
            
            if (_pageNumber == 1) {
                [_dataArray removeAllObjects];
                _dataArray = ((NSSkyArray*)r).iArray;
            }else{
                [_dataArray addObjectsFromArray:((NSSkyArray*)r).iArray];
            }
            
        }else{
            NSLog(@"%@",((NSSkyArray*)r).errString);
        }
        
        if (((NSSkyArray*)r).iArray.count != 0 && ((NSSkyArray*)r).iArray.count%20 == 0) {
            self.tableView.hasFooter = YES;
        }else {
            self.tableView.hasFooter = NO;
        }
        
        if (self.dataArray.count == 0) {
            self.tableView.hidden = YES;
            self.noLoanTextLabel.hidden = NO;
            self.noLoanimg.hidden = YES;
            self.noLoanTextLabel.left = (self.noLoanimg.left+self.noLoanimg.width/2);
            self.noLoanTextLabel.text = @"暂无借入白条，您可到白条大厅看看";
        }else {
            self.tableView.hidden = NO;
            self.noLoanTextLabel.hidden = YES;
            self.noLoanimg.hidden = YES;
        }
        
        [_tableView reloadData];
        if (self.tableView.isRefresh) {
            [self.tableView reloadDeals];
        }
        
        
    }

}
#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    _pageNumber = DebtListPageStartNO;
    [self requestData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>=scrollView.frame.size.height+30 && !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        if (_dataArray.count%20==0) {
            _pageNumber ++;
            [self requestData];
        }
        else
        {
            [self.tableView reloadDeals];
        }
    }
    
}


#pragma mark --- tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isMy == YES) {
        return DebtCellHeight;
    }else {
        return 70;
    }
    return 0;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    if (self.isMy == YES) {
        return [_dataArray count];
    }
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isMy != YES) {
        return [_dataArray count];
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isMy == YES) {
        
        static NSString * cellID  =@"cellID";
        DebtListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == Nil) {
            cell = [[DebtListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            cell.className = @"我的";
        }
        BlankNoteData * debtModel = _dataArray[indexPath.section];
        cell.model = debtModel;
        return cell;
    }else {
        static NSString *identifier = @"whiteLine";
        LoanOrRepayWhiteLineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[LoanOrRepayWhiteLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (_dataArray.count != 0) {
            cell.model = [_dataArray objectAtIndex:indexPath.row];
            
        }
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.isMy == YES) {
        BlankNoteData * debtModel = _dataArray[indexPath.section];
        TuhaoLoanSetViewController *myiSend = [[TuhaoLoanSetViewController alloc] init];
        myiSend.model = debtModel;
        [self.navigationController pushViewController:myiSend animated:YES];
    }else {
        BlankNoteData * debtModel = _dataArray[indexPath.row];
        DebtScheduleViewController *controller = [[DebtScheduleViewController alloc] init];
        NoteSummary *noteSummary = [[NoteSummary alloc] init];
        noteSummary.repaymentNoteID = debtModel.blankNoteID;
        noteSummary.debtorName = debtModel.nickName;
        controller.noteSummary = noteSummary;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

#pragma mark - UITableView 编辑单元格的协议方法
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isMy != YES)
    {
        return UITableViewCellEditingStyleNone;
    }
    
    return UITableViewCellEditingStyleNone;
}
////单元格上面的删除、插入被点击调用的协议方法
////此协议方法实现后，单元格左滑会出现删除按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //1.删除数组中的消息对象
        [self.dataArray removeObjectAtIndex:indexPath.row];

        //从tableView 中删除一个单元格
        [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *str = @"删除";
    return str;
}

-(void)leftClicked
{
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[DebtListViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
//    MyTuhaoLoanListViewController *mytuhao = [[MyTuhaoLoanListViewController alloc] init];
//    [self.navigationController popToViewController:mytuhao animated:YES];
}

@end
