//
//  YXBLoanCenterViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 16/1/29.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CuiShouCenterViewController.h"
#import "YXBElectronicLoanViewController.h"
#import "QCBaseTableView.h"
#import "CTSegmentControl.h"
#import "MyLoanViewController.h"
#import "BillDetailViewController.h"
#import "YXBLoanCenterNoRecordView.h"
#import "CuiShouCell.h"
#import "OverdueManager.h"
#import "OverdueLoanData.h"
#import "YXBTool.h"
#import "HeaderView.h"
#import "Payment_payUrge.h"
@interface CuiShouCenterViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,CTSegmentControlDelegate,UIAlertViewDelegate>

@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (nonatomic,weak)QCBaseTableView *myTableView;
@property (nonatomic,weak)YXBLoanCenterNoRecordView * noRecordView;
@property (nonatomic,weak)OverdueLoanData * Model;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UIButton*CuiShouBtn;

// 数据请求类型0待催收 1催收中 2催收成功 3催收失败
@property (nonatomic,assign)NSInteger currentIndex;
/**
 记录选中框
 */
@property (nonatomic, assign) NSInteger previousSelectIndex;
@property (nonatomic, assign) NSInteger currentSelectIndex;


@property (nonatomic,assign)NSInteger PageNum;
@property (nonatomic,strong)HeaderView*headerView;
@end

@implementation CuiShouCenterViewController
-(void)dealloc{
    NSLog(@"CuiShouCenterViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"催收中心";
       [self initUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.dataArray = [[NSMutableArray alloc] init];
    _currentIndex = 0;
    _previousSelectIndex = 0;
    _currentSelectIndex = 0;
    _PageNum = 1;

    if (_myTableView) {
        [self.myTableView beginRefreshing];
    }
}


-(void)initUI{
    [self setBackView];
    self.view.backgroundColor = rgb(233, 233, 233, 1);
  
    [self createHeaderView];
    [self createTableView];
}
-(void)createHeaderView{
    
      NSArray *arr = @[@"待催收",@"催收中",@"催收结束"];
    CTSegmentControl *headerView = [[CTSegmentControl alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 34) andItems:arr andItemFont:[UIFont systemFontOfSize:25.61/2.0]];
    
    headerView.segmentTintColor = rgb(116, 116, 116, 1);
    headerView.rectColor = rgb(200, 200, 200, 1);
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.delegate = self;
    headerView.selectedIndex = 0;
    [self.view addSubview:headerView];
}
-(void)createTableView{

    QCBaseTableView *tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 34+1, kDeviceWidth, kDeviceHeight-64-34-1-kDeviceWidth/640*120) style:UITableViewStylePlain refreshFooter:YES];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.tableHeaderView = self.noRecordView;
    _noRecordView.clipsToBounds = YES;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.refreshDelegate = self;
    
    [self.view addSubview:tableView];
    self.myTableView = tableView;
    self.CuiShouBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, tableView.bottom+1, kDeviceWidth, kDeviceWidth/640*121)];
    [_CuiShouBtn setBackgroundImage:[UIImage imageNamed:@"CuiShouBtn"] forState:UIControlStateNormal];
    [self.view addSubview:_CuiShouBtn];
    [_CuiShouBtn addTarget:self action:@selector(CuiShouBtnAction) forControlEvents:UIControlEventTouchUpInside];

}
#pragma mark - 数据请求
-(void)httpRequest{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block CuiShouCenterViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        [this stopDefaultAnimation];
        
        //        [this layoutDefaultAnimation];
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        if (error == EHttp_Operator_Failed) {
            [ProgressHUD showErrorWithStatus:@"加载失败,请检查手机网络"];
            [this.myTableView reloadDeals];
        }
        
    } param:^(NSString *s) {
        OverdueManager *manager = (OverdueManager*)[assginHtttperator getAopInstance:[OverdueManager class] returnValue:[NSSkyArray class]];
        
        [manager getOverdueLoanList:this.PageNum usertoken:[YXBTool getUserToken]  state:_currentIndex];
        
        
    } complete:^(NSSkyArray *r, int taskid){
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}

-(void)httpLoadComplete:(NSSkyArray *)r{
    [self.myTableView reloadDeals];
    _noRecordView.height = 0;
    if (r.errCode == 0) {
        //发送成功
        if (r.iArray.count>0) {
            [self.dataArray addObjectsFromArray:r.iArray];
        }
        
    }else{
       
    }
    
    if(_PageNum==1&&r.iArray.count==0){//无数据
        self.noRecordView.height = kDeviceHeight-64-34-1;
    }
    
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.myTableView.hasFooter = YES;
    }else {
        self.myTableView.hasFooter = NO;
    }
    if(r.iArray.count&&r.iArray.count%20!=0){
        UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
        footer.text = @"所有借条都在这了";
        footer.textColor = rgb(160, 160, 160, 1);
        footer.font = [UIFont systemFontOfSize:15];
        footer.textAlignment = NSTextAlignmentCenter;
        
        self.myTableView.tableFooterView = footer;
    }
    [self.myTableView reloadData];
}
#pragma mark - CTSegmentControlDelegate
-(void)segmentControlDidSelectedIndex:(NSInteger)index{
    self.currentIndex = index;
    //待诉讼显示底部申请按钮  其他情况隐藏申请按钮
    if (_currentIndex == 0) {
        _CuiShouBtn.hidden = NO;
        self.myTableView.frame = CGRectMake(0, 34+1, kDeviceWidth, kDeviceHeight-64-34-1 - kDeviceWidth/640*121);
    }else{
        _CuiShouBtn.hidden = YES;
        self.myTableView.frame = CGRectMake(0, 34+1, kDeviceWidth, kDeviceHeight-64-34-1);
    }
    
    if([self.myTableView isRefresh]){
        [self.myTableView reloadDeals];
    }
    self.myTableView.tableFooterView = nil;
    [self.myTableView beginRefreshing];
}
#pragma mark - QCBaseTableViewDelegate
-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView{
    [_dataArray removeAllObjects];
    _PageNum = 1;
    [self httpRequest];
}
//上拉加载
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.myTableView.isRefresh && _dataArray.count%20==0&&self.myTableView.hasFooter == YES) {
        _PageNum ++;
        [self httpRequest];
    }else {
        
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CuiShouCell *cell = [CuiShouCell CuiShouCellWithTableView:tableView];
    cell.selectBtn.tag = indexPath.row + 10;
    if (_dataArray.count) {
        cell.model =[_dataArray objectAtIndex:indexPath.row];
    }
    //选中框更换   刷新cell
    cell.backselectBtnIndex = ^(NSInteger current){
        _previousSelectIndex = _currentSelectIndex;
        _currentSelectIndex = current;
        
        if (_currentSelectIndex == _previousSelectIndex) {
            return ;
        }
        
        //刷新之前选中cell和当前选中cell
        NSIndexPath * prPath = [NSIndexPath indexPathForRow:_previousSelectIndex-10 inSection:0];
        NSIndexPath * cupath = [NSIndexPath indexPathForRow:_currentSelectIndex-10 inSection:0];
        [_myTableView reloadRowsAtIndexPaths:@[prPath,cupath] withRowAnimation:UITableViewRowAnimationNone];
    };
    //更新按钮状态
    [cell updateSelectBtnWithCurrentIndex:_currentSelectIndex];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121+10.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.Model = nil;
    if (_dataArray.count>indexPath.row) {
        self.Model = [_dataArray objectAtIndex:indexPath.row];
        MyLoanViewController *myLoanListVC = [[MyLoanViewController alloc] init];
        myLoanListVC.loanID = self.Model.loanID;
        [self.navigationController pushViewController:myLoanListVC animated:YES];
    }
}

-(void)CuiShouBtnAction{
       if (_dataArray!=nil) {
           self.Model=[_dataArray objectAtIndex:_currentSelectIndex-10];
        if ([self.Model.money intValue]>=10000 ) {
            [self AlertViewSuccess];
        }
        else{
            [self AlertViewFailure];
        }
    }
}
#pragma mark - UIAlterView PaySuccess
-(void)AlertViewSuccess
{
    UIAlertView*alert = [[UIAlertView alloc] initWithTitle:nil message:@"1.催收服务采取预付佣金方式，拒绝受理或催收失败，将全款退还到您现金账户\n2.合同期间委托人收到欠款，均被认定为无忧借条催款成功\n3.请仔细阅读《专业催收服务条款》内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",  nil];
    alert.tag=89898989;
    [alert show];
}
#pragma mark - UIAlterView PayFailure
-(void)AlertViewFailure
{
    UIAlertView*alert = [[UIAlertView alloc] initWithTitle:nil message:@"目前只接受借款金额10000及以上的借款单！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil,  nil];
    alert.tag=89898988;
    [alert show];
}

#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==89898989){

        if(buttonIndex==1){
        if (_dataArray!=nil) {
        self.Model=[_dataArray objectAtIndex:_currentSelectIndex-10];
        Payment_payUrge*Payment_payUrgeModel = [[Payment_payUrge alloc] init];
            Payment_payUrgeModel.loanIds=[NSString stringWithFormat:@"%ld",(long)self.Model.loanID];
            Payment_payUrgeModel.loanNums=[NSString stringWithFormat:@"1"];
            NSString *url = [YXBPaymentUtils getFullWebUrl:Payment_payUrgeModel];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"预支付"];
        }
    }
        
    else if(buttonIndex==0){
        NSLog(@"kkkkk！！！！！！！！！！！！！！！！！！！");

    }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
