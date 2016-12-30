//
//  YXBLoanCenterViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 16/1/29.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBLoanCenterViewController.h"
#import "YXBElectronicLoanViewController.h"
#import "QCBaseTableView.h"
#import "CTSegmentControl.h"
#import "MyLoanViewController.h"
#import "BillDetailViewController.h"
#import "YXBLoanCenterNoRecordView.h"
#import "YXBLoanCenterCell.h"
#import "LoanManagerV10.h"
#import "LoanListItem.h"
#import "YXBTool.h"
@interface YXBLoanCenterViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,CTSegmentControlDelegate>
@property (nonatomic,weak)QCBaseTableView *myTableView;
@property (nonatomic,weak)YXBLoanCenterNoRecordView *noRecordView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,assign)NSInteger PageNum;
@end

@implementation YXBLoanCenterViewController
-(void)dealloc{
    NSLog(@"YXBLoanCenterViewController is dealloc");
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] init];
        self.currentIndex = self.loanType;
        self.PageNum = 1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentIndex = self.loanType;

    self.title = @"借条中心";

    UIImage *rightImg = [UIImage imageNamed:@"loancenter_dianziJIetiao"];
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, rightImg.size.width, rightImg.size.height);
    [right setImage:rightImg forState:UIControlStateNormal];
    [right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    NSArray *arr = @[@"谁欠我钱",@"我欠谁钱",@"待确认",@"已还清",@"已失效"];
    CTSegmentControl *headerView = [[CTSegmentControl alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 34) andItems:arr andItemFont:[UIFont systemFontOfSize:25.61/2.0]];

    headerView.segmentTintColor = rgb(116, 116, 116, 1);
    headerView.rectColor = rgb(200, 200, 200, 1);
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.delegate = self;
    headerView.selectedIndex = self.loanType;
    [self.view addSubview:headerView];
}
-(void)createTableView{
    
    YXBLoanCenterNoRecordView *tNoRecordView = [[YXBLoanCenterNoRecordView alloc] initWithFrame:CGRectMake(0, 34+1, kDeviceWidth, 0)];
    tNoRecordView.type = 0;
    self.noRecordView = tNoRecordView;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    QCBaseTableView *tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 34+1, kDeviceWidth, kDeviceHeight-64-34-1) style:UITableViewStylePlain refreshFooter:YES];
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
}
-(void)rightClick{
    //跳转电子借条
    YXBElectronicLoanViewController *eleVC = [[YXBElectronicLoanViewController alloc] init];
    [self.navigationController pushViewController:eleVC animated:YES];
}
#pragma mark - 数据请求
-(void)httpRequest:(NSInteger)index{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block YXBLoanCenterViewController *this = self;
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
        LoanManagerV10 *managerV5 = (LoanManagerV10*)[assginHtttperator getAopInstance:[LoanManagerV10 class] returnValue:[NSSkyArray class]];
        
        [managerV5 getLoanListData:[YXBTool getUserToken] pageNum:this.PageNum loanType:index+1];
        
        
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
//        [self.dataArray removeAllObjects];
//        [ProgressHUD showErrorWithStatus:r.errString];
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
    if([self.myTableView isRefresh]){
        [self.myTableView reloadDeals];
    }
    if (index == 4) {
        self.currentIndex =5;
    }else{
        self.currentIndex = index;
    }
    if (self.currentIndex == 3) {
        _noRecordView.type = 1;
    }else if(self.currentIndex == 4){
        _noRecordView.type = 3;
    }else{
        _noRecordView.type = 0;
    }
    self.myTableView.tableFooterView = nil;
    [self.myTableView beginRefreshing];
}
#pragma mark - QCBaseTableViewDelegate
-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView{
    [_dataArray removeAllObjects];
    _PageNum = 1;
    [self httpRequest:self.currentIndex];
}
//上拉加载
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.myTableView.isRefresh && _dataArray.count%20==0&&self.myTableView.hasFooter == YES) {
        _PageNum ++;
        [self httpRequest:self.currentIndex];
    }else {
        
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    YXBLoanCenterCell *cell = [YXBLoanCenterCell YXBLoanCenterCellWithTableView:tableView];
    if (_dataArray.count) {
        cell.model =[_dataArray objectAtIndex:indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121+10.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LoanListItem *model = nil;
    if (_dataArray.count>indexPath.row) {
        model = [_dataArray objectAtIndex:indexPath.row];
        MyLoanViewController *myLoanListVC = [[MyLoanViewController alloc] init];
        myLoanListVC.loanID = model.loanID;
        myLoanListVC.loanListItemDescript = model.descript;
        myLoanListVC.type = self.loanType;
        [self.navigationController pushViewController:myLoanListVC animated:YES];
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
