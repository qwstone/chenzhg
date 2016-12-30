//
//  LoanOrRepayListViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/8.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanOrRepayListViewController.h"
#import "LoanOrRepayListTableViewCell.h"
#import "LoanManagerV2.h"
//#import "LoanDetailsViewController.h"
#import "LoanOrRepayMessageViewController.h"
#import "HeaderView.h"
#import "LoanOrRepayWhiteLineCell.h"
#import "DebtScheduleViewController.h"
#import "AppBlankNoteManager.h"
#import "NoteSummary.h"
//#import "RCIM.h"
//#import "RCIMClient.h"

#define LoanOrRepayListViewLeftAlign 15
//@interface LoanOrRepayListViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,HeaderViewDelegate>
@interface LoanOrRepayListViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,HeaderViewDelegate>
{
    
    NSMutableArray * _dateArray;
    NSInteger indexpage;
    NSArray * statusArray;
    HeaderView * headerView;
}

@property (nonatomic,strong)QCBaseTableView * tableView;
@property (nonatomic,strong)UISegmentedControl *segmentControl;

@end

@implementation LoanOrRepayListViewController

-(void)dealloc
{
    NSLog(@"LoanOrRepayListViewController is dealloc");
//    [_iHttpOperator cancel];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"借款记录"];
    // Do any additional setup after loading the view.
    _dateArray = [[NSMutableArray alloc]init];
    indexpage = 1;
    [self initView];
    [self refreshData];
}

- (void)initView
{
//    headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40) WithArray:@[@"借入记录",@"借出记录"]];
//    headerView.delegate =self;
//    [self.view addSubview:headerView];
    [self initTopSegmentControl];
//    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, headerView.size.height, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain];
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, _segmentControl.size.height + 2*LoanOrRepayListViewLeftAlign, kDeviceWidth, kDeviceHeight-64-_segmentControl.size.height - 2*LoanOrRepayListViewLeftAlign) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
    
    if (self.type == LoanOrRepayListBorrow) {
        statusArray = @[@"待对方同意",@"(待同意)待确认",@"待对方打款",@"(待打款)待确认",@"(待打款)待确认",@"待录制视频",@"待对方确认视频",@"",@"线下打款确认",@"待还款",@"待还款-超时",@"冻结",@"冻结-超时",@"申请修改-待对方确认",@"申请修改-待确认",@"线下还款确认",@"线下还款确认-超时还款",@"按时还款成功",@"超时还款成功",@"已取消",@"已拒绝",@"已关闭"];
    }else if (self.type == LoanOrRepayListLend){
        statusArray = @[@"待同意",@"(待同意)待对方确认",@"待打款",@"(待打款)待对方确认",@"(待打款)待对方确认",@"待对方录制视频",@"待确认视频",@"线下打款确认",@"待对方还款",@"待对方还款-超时",@"冻结",@"冻结-超时",@"申请修改-待确认",@"申请修改-待对方确认",@"线下还款确认",@"线下还款确认-超时还款",@"按时还款成功",@"超时还款成功",@"已取消",@"已拒绝",@"已关闭"];
    }else {
        
    }
}


-(void)initTopSegmentControl
{
    //    CGFloat ySpace = 15;
    //    CGFloat xSpace = 10;
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"借入记录",@"借出记录", nil]];
    _segmentControl.frame = CGRectMake(LoanOrRepayListViewLeftAlign, LoanOrRepayListViewLeftAlign, kDeviceWidth-2*LoanOrRepayListViewLeftAlign, 40);
    _segmentControl.selectedSegmentIndex = 0;
    _segmentControl.layer.cornerRadius = 5.0;
    _segmentControl.backgroundColor = [UIColor whiteColor];
    _segmentControl.tintColor = rgb(221, 101, 115, 1.0);
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"SnellRoundhand-Bold" size:16],NSFontAttributeName ,nil];
    
    [_segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    
    
    [self.view addSubview:_segmentControl];
    
    //    [self.view addSubview:_segmentControl];
    
}

-(void)segmentAction:(UISegmentedControl *)segmentControl
{
    if (segmentControl.selectedSegmentIndex == 0) {
        //        self.isLoan = YES;
        self.type = LoanOrRepayListBorrow;
        //        [self refreshData];
        //        [self QCBaseTableViewDidPullDownRefreshed:_tableView];
        
    }else if (segmentControl.selectedSegmentIndex == 1){
        //        self.isLoan = NO;
        self.type = LoanOrRepayListLend;
        //        [self refreshData];
        //        [self QCBaseTableViewDidPullDownRefreshed:_tableView];
        
    }else{
        self.type = LoanOrRepayListWhiteLine;
    }
    //    [self QCBaseTableViewDidPullDownRefreshed:_tableView];
    [_dateArray removeAllObjects];
    [_tableView reloadDeals];
    [self.tableView beginRefreshing];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (void)headerBtnAction:(UIButton *)sender
{
    if (sender.tag == 1000) {
//        self.isLoan = YES;
        self.type = LoanOrRepayListBorrow;
//        [self refreshData];
//        [self QCBaseTableViewDidPullDownRefreshed:_tableView];

    }else if (sender.tag == 1+1000){
//        self.isLoan = NO;
        self.type = LoanOrRepayListLend;
//        [self refreshData];
//        [self QCBaseTableViewDidPullDownRefreshed:_tableView];

    }else{
        self.type = LoanOrRepayListWhiteLine;
    }
//    [self QCBaseTableViewDidPullDownRefreshed:_tableView];
    [_dateArray removeAllObjects];
    [self.tableView beginRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dateArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == LoanOrRepayListBorrow || self.type == LoanOrRepayListLend) {
        static NSString * cellID  =@"cellID";
        LoanOrRepayListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == Nil) {
            cell = [[LoanOrRepayListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        if (_dateArray.count != 0) {
            Loan * loanModel = _dateArray[indexPath.row];
            /*
            NSInteger unReadCount = [[RCIM sharedRCIM] getUnreadCount:ConversationType_GROUP targetId:loanModel.chatId];
            loanModel.unReadCount = unReadCount;
            
            */
            [cell setLoanModel:loanModel];

            //清空消息
//            [[RCIM sharedRCIM] clearMessages:ConversationType_GROUP targetId:loanModel.chatId];
            //设为已读
//            [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:ConversationType_GROUP targetId:loanModel.chatId];

//            NSLog(@"未读消息数--%ld 聊天id:---%@",unReadCount,loanModel.chatName);
            //    if (loanModel.status <=NEEDRECEIVE_DELAY) {
//            cell.subStatusLabel.text = statusArray[loanModel.status];
            
        }
        
        //    }
        return cell;
        
    }else {
        static NSString *identifier = @"whiteLine";
        LoanOrRepayWhiteLineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[LoanOrRepayWhiteLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (_dateArray.count != 0) {
            cell.model = [_dateArray objectAtIndex:indexPath.row];
            
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LoanOrRepayMessageViewController * messageViewController = [[LoanOrRepayMessageViewController alloc]init];
    if (self.type == LoanOrRepayListBorrow) {
        messageViewController.bOrL = BORROWER;
    }else if (self.type == LoanOrRepayListLend){
        messageViewController.bOrL = LENDERS;
    }else if (self.type == LoanOrRepayListWhiteLine){
        DebtScheduleViewController *controller = [[DebtScheduleViewController alloc] init];
        if (indexPath.row < [_dateArray count]) {
            BlankNoteData *model = _dateArray[indexPath.row];
            
            NoteSummary *noteSummary = [[NoteSummary alloc] init];
            noteSummary.repaymentNoteID = model.blankNoteID;
            noteSummary.debtorName = model.nickName;
            
            controller.noteSummary = noteSummary;
            [self.navigationController pushViewController:controller animated:YES];

        }
        return;

    }
    if (indexPath.row < [_dateArray count]) {
        messageViewController.loan = _dateArray[indexPath.row];
        [self.navigationController pushViewController:messageViewController animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return  UITableViewCellEditingStyleNone;
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//      if (editingStyle == UITableViewCellEditingStyleDelete) {
//    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}



#pragma mark -----------------------------------------------HttpDownLoad
- (void)getTLoanListByBorrowerInfoAndQueryType:(NSInteger)page
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak LoanOrRepayListViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this stopDefaultAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            [this.tableView reloadDeals];
        }
        
    } param:^(NSString *s) {
        
        [this httpLOad_GetTLoanListByBorrowerInfoAndQueryParams:s httpOperation:assginHtttperator type:page];
    } complete:^(NSSkyArray* r, int taskid) {
       
        [this httpLoad_GetTLoanListByBorrowerInfoAndQueryComplete:r type:page];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOad_GetTLoanListByBorrowerInfoAndQueryParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation type:(NSInteger)page
{
    LoanManagerV2* _Loanmanger = (LoanManagerV2*)  [httpOperation getAopInstance:[LoanManagerV2 class] returnValue:[NSSkyArray class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    [_Loanmanger getTLoanListByBorrowerInfoAndQueryType:userModel.user.t_id query_type:0 page:page];
}
//请求完成
-(void)httpLoad_GetTLoanListByBorrowerInfoAndQueryComplete:(NSSkyArray *)r type:(NSInteger)page{
    [self stopDefaultAnimation];
    if (r.errCode == 0) {
        
        if (page == 1) {
            [_dateArray removeAllObjects];
            _dateArray = r.iArray;
            if ([_dateArray count] == 0) {
                UILabel *nullImage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _tableView.height)];
                nullImage.text = @"暂无数据";
                nullImage.textColor = [UIColor blueColor];
                nullImage.textAlignment = NSTextAlignmentCenter;
                _tableView.tableFooterView = nullImage;
                
            }
            else
            {
                _tableView.tableFooterView = [UIView new];
                
            }
        }else{
            [_dateArray addObjectsFromArray:r.iArray];
            _tableView.tableFooterView = [UIView new];
            
        }
        
        
        
    }else{
        
        if (r.errCode == 7) {
            if ([_dateArray count] == 0) {
                UILabel *nullImage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _tableView.height)];
                nullImage.text = @"暂无数据";
                nullImage.textColor = [UIColor blueColor];
                nullImage.textAlignment = NSTextAlignmentCenter;
                _tableView.tableFooterView = nullImage;
                
            }
            
        }
        else
        {
            NSLog(@"%@",r.errString);
            UIView * view = [[UIView alloc]initWithFrame:CGRectZero];
            _tableView.tableFooterView = view;
            
        }
    }
    
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.tableView.hasFooter = YES;
    }else {
        self.tableView.hasFooter = NO;
    }
    
    [_tableView reloadData];
    if (self.tableView.isRefresh) {
        [self.tableView reloadDeals];
    }

}
#pragma mark -----------------------------------------------HttpDownLoad
- (void)getTLoanListByLenderInfoAndQueryType:(NSInteger)page
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak LoanOrRepayListViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            [this.tableView reloadDeals];
        }
        
    } param:^(NSString *s) {
        
        [this httpLOad_GetTLoanListByLenderInfoAndQueryParams:s httpOperation:assginHtttperator Type:page];
    } complete:^(NSSkyArray* r, int taskid) {
        
        [this httpLoad_GetTLoanListByLenderInfoAndQueryComplete:r Type:page];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOad_GetTLoanListByLenderInfoAndQueryParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation Type:(NSInteger)page
{
    LoanManagerV2* _Loanmanger = (LoanManagerV2*)  [httpOperation getAopInstance:[LoanManagerV2 class] returnValue:[NSSkyArray class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    [_Loanmanger getTLoanListByLenderInfoAndQueryType:userModel.user.t_id query_type:0 page:page];
    

}
//请求完成
-(void)httpLoad_GetTLoanListByLenderInfoAndQueryComplete:(NSSkyArray *)r Type:(NSInteger)page{
    if (r.errCode == 0) {
        
        if (page == 1) {
            [_dateArray removeAllObjects];
            _dateArray = r.iArray;
            if ([_dateArray count] == 0) {
                UILabel *nullImage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _tableView.height)];
                nullImage.text = @"暂无数据";
                nullImage.textColor = [UIColor blueColor];
                nullImage.textAlignment = NSTextAlignmentCenter;
                _tableView.tableFooterView = nullImage;
                
            }
            else
            {
                _tableView.tableFooterView = [UIView new];
                
            }
            
        }else{
            [_dateArray addObjectsFromArray:r.iArray];
            _tableView.tableFooterView = [UIView new];
            
        }
        
    }else{
        if (r.errCode == 7) {
            UILabel *nullImage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _tableView.height)];
            nullImage.text = @"暂无数据";
            nullImage.textColor = [UIColor blueColor];
            nullImage.textAlignment = NSTextAlignmentCenter;
            _tableView.tableFooterView = nullImage;
            
        }
        else
        {
            _tableView.tableFooterView = [UIView new];
            
        }
        
        NSLog(@"%@",r.errString);
    }
    
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.tableView.hasFooter = YES;
    }else {
        self.tableView.hasFooter = NO;
    }
    
    [_tableView reloadData];
    if (self.tableView.isRefresh) {
        [self.tableView reloadDeals];
    }

}
#pragma mark -----------------------------------------------HttpDownLoad
- (void)getTLoanListByWhiteLineAndQueryType:(NSInteger)page {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak LoanOrRepayListViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            [this.tableView reloadDeals];
        }
        
    } param:^(NSString *s) {
        
        [this httpLOad_GetTLoanListByWhiteLineAndQueryParams:s httpOperation:assginHtttperator Type:page];
        
    } complete:^(NSSkyArray* r, int taskid) {
        
        [this httpLoad_GetTLoanListByWhiteLineAndQueryComplete:r Type:page];
    }];
    [self.iHttpOperator connect];
}
//上传参数
- (void)httpLOad_GetTLoanListByWhiteLineAndQueryParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation Type:(NSInteger)page{
    AppBlankNoteManager * _blankNotemanger = (AppBlankNoteManager*)  [httpOperation getAopInstance:[AppBlankNoteManager class] returnValue:[NSSkyArray class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    [_blankNotemanger getAllNotesByToken:userModel.user.yxbToken pageNum:page];
}
//请求完成
-(void)httpLoad_GetTLoanListByWhiteLineAndQueryComplete:(NSSkyArray *)r Type:(NSInteger)page{
    if (r.errCode == 0) {
        
        if (page == 1) {
            [_dateArray removeAllObjects];
            _dateArray = r.iArray;
        }else{
            [_dateArray addObjectsFromArray:r.iArray];
        }
        
    }else{
        NSLog(@"%@",r.errString);
    }
    
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.tableView.hasFooter = YES;
    }else {
        self.tableView.hasFooter = NO;
    }
    
    [_tableView reloadData];
    if (self.tableView.isRefresh) {
        [self.tableView reloadDeals];
    }

}

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self refreshData];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>=scrollView.frame.size.height && !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        if (_dateArray.count%20==0) {
            indexpage ++;
            if (self.type == LoanOrRepayListBorrow) {
                [self getTLoanListByBorrowerInfoAndQueryType:indexpage];

            }else if (self.type == LoanOrRepayListLend){
                [self getTLoanListByLenderInfoAndQueryType:indexpage];
            }else if (self.type == LoanOrRepayListWhiteLine) {
                [self getTLoanListByWhiteLineAndQueryType:indexpage];
            }
        }
    }
}

//刷新数据
- (void)refreshData {
    indexpage = 1;
    if (self.type == LoanOrRepayListBorrow) {
        [self getTLoanListByBorrowerInfoAndQueryType:indexpage];

    }else if (self.type == LoanOrRepayListLend) {
        [self getTLoanListByLenderInfoAndQueryType:indexpage];
    }else if (self.type == LoanOrRepayListWhiteLine){
        [self getTLoanListByWhiteLineAndQueryType:indexpage];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [self refreshData];
    [super viewWillAppear:YES];
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
