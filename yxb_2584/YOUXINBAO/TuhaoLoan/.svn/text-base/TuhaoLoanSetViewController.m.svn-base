 //
//  TuhaoLoanSetViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/4/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TuhaoLoanSetViewController.h"
#import "TuhaoLoanSetTableViewCell.h"
#import "AppBlankNoteManager.h"
#import "HttpOperator.h"
#import "DebtDetailViewController.h"
#import "TuhaoLoanSetDetailTableViewCell.h"
#import "DebtScheduleViewController.h"
#import "TResultSet.h"
#import "NoteSummary.h"
#import "ActivityStatusView.h"

#define DebtListPageStartNO 1
@interface TuhaoLoanSetViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,QCBaseTableViewDelegate> {
    ActivityStatusView * activityStatusView;;
}

@property(nonatomic,strong)QCBaseTableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)HttpOperator   *iHttpOperator;
@property(nonatomic,assign)NSInteger       pageNumber;
@property(nonatomic,strong)UIView           *bottomView;
@end

@implementation TuhaoLoanSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNumber = DebtListPageStartNO;
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = rgb(237, 237, 246, 1);
    [self requestData:NO];
    [self initView];
    [self createBottomView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    if (!userModel.isLogin) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请登录账号查看白条详情" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alter.tag = 20002;
        [alter show];
    }
    
}

- (void)createBottomView {
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bottom-50-64, kDeviceWidth, kDeviceWidth/640*90)];
    [self.view addSubview:self.bottomView];
    UIButton *bottomBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
    bottomBut.backgroundColor = [UIColor whiteColor];
    [bottomBut setTitle:@"取消剩余白条" forState:UIControlStateNormal];
    [bottomBut setTitleColor:rgb(52, 142, 250, 1) forState:UIControlStateNormal];
    [bottomBut addTarget:self action:@selector(bottomButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:bottomBut];
}

#pragma mark --- bottomButtonAction
- (void)bottomButAction {
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"是否确认取消剩余白条(%ld个)？",(long)(self.detailModel.borrowNumber - self.model.loanNumber)] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alter.tag = 10001;
    [alter show];
}

#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 20002) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else if (alertView.tag == 10001){
    
        if (buttonIndex == 0) {
            NSLog(@"取消");
        }else if (buttonIndex == 1){
            NSLog(@"确定");
            [self requestData:YES];
        }
    }
}


- (void)initView
{
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"土豪白条设置"];
    
    
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-50) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
    
    
}

-(void)requestData:(BOOL)isCanel//判断是不是取消时用的请求
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak TuhaoLoanSetViewController *this = self;
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
        
        [this httpLoadParams:assginHtttperator isCanel:isCanel];
    } complete:^(id r, int taskid) {
        NSLog(@"r=  %@",r);
        [this httpLoadComplete:r isCanel:isCanel];
       
    }];
    
    [self.iHttpOperator connect];

}

- (void)httpLoadParams:(HttpOperator *)assginHtttperator isCanel:(BOOL)isCanel{

    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (isCanel == YES) {
        AppBlankNoteManager * blankNote = (AppBlankNoteManager *)  [assginHtttperator getAopInstance:[AppBlankNoteManager class] returnValue:[TResultSet class]];
        if (userModel.user.yxbToken != nil) {
            [blankNote cancelRemainNote:userModel.user.yxbToken noteId:self.model.blankNoteID];
        }else {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"请登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alter show];
        }
    }else {
        AppBlankNoteManager * blankNote = (AppBlankNoteManager *)  [assginHtttperator getAopInstance:[AppBlankNoteManager class] returnValue:[BlankNoteData class]];
        if (userModel.user.yxbToken != nil) {
            [blankNote getNoteSetting:userModel.user.yxbToken blankNoteDataID:self.model.blankNoteID];
        }else {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"请登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alter show];
        }
    }

}

- (void)httpLoadComplete:(id)r isCanel:(BOOL)isCanel{

    if (isCanel == YES) {
        if (((TResultSet *)r).errCode == 0) {
            [self requestData:NO];//取消成功，请求刷新数据
            //                [self stateView:YES];
        }
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"%@",((TResultSet *)r).errString] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }else {
        
        if (_pageNumber == 1) {
            if (self.dataArray.count > 0) {
                [self.dataArray removeAllObjects];
            }
        }else {
            
        }
        
        //详情数据
        if (self.detailModel == nil) {
            self.detailModel = [[BlankNoteData alloc] init];
        }
        self.detailModel = r;
        
        //列表数据
        [self.dataArray addObjectsFromArray:((BlankNoteData *)r).noteSummaryList];
        
        //可取消数量为0 隐藏下部取消按钮
        if (self.detailModel.state == 150 || self.detailModel.state == 200) {
            self.bottomView.hidden = YES;
        }else {
            self.bottomView.hidden = NO;
        }
        
        //下部取消按钮隐藏后，讲tableview的高度增加self.bottomView.height
        if (self.bottomView.hidden == YES) {
            self.tableView.height = kDeviceHeight-64;
        }else {
            self.tableView.height = kDeviceHeight-64-self.bottomView.height;
        }
        
        [self.tableView reloadData];
        [self.tableView reloadDeals];
        if (self.dataArray.count != 0 && self.dataArray.count%20 == 0) {
            self.tableView.hasFooter = YES;
        }else {
            self.tableView.hasFooter = NO;
        }
        if (self.detailModel.state == 150) {//全部借出
            [self stateView:NO];
        }
        if (self.detailModel.state == 200) {//已经取消了
            [self stateView:YES];
        }
    }



}

- (void)stateView:(BOOL)isCanl {
    if (activityStatusView != nil) {
        [activityStatusView removeFromSuperview];
    }
   
    if (isCanl == YES) {
        activityStatusView = [[ActivityStatusView alloc]initWithFrame:CGRectMake(0, -150, 200, 80)];
        [activityStatusView.zhuangBtn setImage:[UIImage imageNamed:@"canclegaiz"] forState:UIControlStateNormal];
        [_tableView addSubview:activityStatusView];
        [activityStatusView startAnimationWithPoint:_tableView.center];
        activityStatusView.transform = CGAffineTransformMakeTranslation(0, -60);
    }else {
        activityStatusView = [[ActivityStatusView alloc]initWithFrame:CGRectMake(0, -150, 200, 80)];
        [activityStatusView.zhuangBtn setImage:[UIImage imageNamed:@"borrowallgz"] forState:UIControlStateNormal];
        [_tableView addSubview:activityStatusView];
        [activityStatusView startAnimationWithPoint:_tableView.center];
        activityStatusView.transform = CGAffineTransformMakeTranslation(0, -60);
    }

}

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    _pageNumber = DebtListPageStartNO;
    [self requestData:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>=scrollView.frame.size.height+30 && !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        if (_dataArray.count%20==0) {
            _pageNumber ++;
            [self requestData:NO];
        }
        else
        {
            [self.tableView reloadDeals];
            
        }
    }
    
}


#pragma mark -- tableViewDelagate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kDeviceWidth/320*125;
    }
    return kDeviceWidth/640*75;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    if (indexPath.section == 0) {
        static NSString * cellID  =@"celltuhaoSetDetail";
        TuhaoLoanSetDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == Nil) {
            cell = [[TuhaoLoanSetDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = self.detailModel;
        return cell;
    }else {
        static NSString * cellID  =@"celltuhaoSetList";
        TuhaoLoanSetTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == Nil) {
            cell = [[TuhaoLoanSetTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            UIView *viewline3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0.5f)];
            viewline3.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:viewline3];
        }
        NoteSummary *noteList = self.dataArray[indexPath.row];
        cell.repaymentType = self.detailModel.repaymentType;
        cell.repaymentMonth = self.detailModel.repaymentMonth;
        cell.Model = noteList;
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        NoteSummary *model = self.dataArray[indexPath.row];
        DebtScheduleViewController *detail = [[DebtScheduleViewController alloc] init];
        detail.noteSummary = model;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kDeviceWidth, kDeviceWidth*43/320-2)];
        label.font = [UIFont systemFontOfSize:19];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"白条详情";
        [view addSubview:label];
        UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, label.bottom, kDeviceWidth, 0.5f)];
        viewline.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:viewline];
        return view;
    }else if (section == 1){
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kDeviceWidth, kDeviceWidth*43/320-2)];
        label.font = [UIFont systemFontOfSize:19];
        label.text = @"借出记录";
        [view addSubview:label];

        UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, label.bottom, kDeviceWidth, 0.5f)];
        viewline.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:viewline];
        
        NSArray *labelTitle = @[@"日期",@"借款人",@"状态"];
        for (int i = 0; i < labelTitle.count ; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3.5*i, viewline.bottom, kDeviceWidth/3.5, kDeviceWidth/320*27)];
            if (i == 1) {
                label.width = kDeviceWidth/3.5*1.5;
            }else if (i == 2){
                label.left = kDeviceWidth/3.5*2.5;
            }
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor whiteColor];
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:13];
            label.text = labelTitle[i];
            [view addSubview:label];
        }
        
        UIView *viewline1 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3.5*2.5, viewline.bottom+kDeviceWidth/320*9, 0.5, kDeviceWidth/320*9)];
        viewline1.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:viewline1];
        
        UIView *viewline2 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/3.5, viewline.bottom+kDeviceWidth/320*9, 0.5, kDeviceWidth/320*9)];
        viewline2.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:viewline2];

        return view;
    
    }

    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return kDeviceWidth*43/320;
    }else if (section == 1){
        return kDeviceWidth*43/320+kDeviceWidth/320*27;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }
    return 0;
}
-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
