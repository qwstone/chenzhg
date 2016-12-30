//
//  YXBElectronicLoanViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 16/3/18.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBElectronicLoanViewController.h"
#import "QCBaseTableView.h"
#import "MyLoanViewController.h"
#import "BillDetailViewController.h"
#import "YXBLoanCenterNoRecordView.h"
#import "YXBLoanCenterCell.h"
#import "LoanManagerV10.h"
#import "LoanListItem.h"
#import "YXBTool.h"
@interface YXBElectronicLoanViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate>
@property (nonatomic,weak)QCBaseTableView *myTableView;
@property (nonatomic,weak)YXBLoanCenterNoRecordView *noRecordView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,assign)NSInteger PageNum;
@end

@implementation YXBElectronicLoanViewController
-(void)dealloc{
    NSLog(@"YXBLoanCenterViewController is dealloc");
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] init];
        self.currentIndex = 4;
        self.PageNum = 1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电子借条";
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
    [self createTableView];
}
-(void)createTableView{
    
    YXBLoanCenterNoRecordView *tNoRecordView = [[YXBLoanCenterNoRecordView alloc] initWithFrame:CGRectMake(0, 1, kDeviceWidth, 0)];
    tNoRecordView.type = 2;
    self.noRecordView = tNoRecordView;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    QCBaseTableView *tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 1, kDeviceWidth, kDeviceHeight-64-1) style:UITableViewStylePlain refreshFooter:YES];
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
    
}
#pragma mark - 数据请求
-(void)httpRequest:(NSInteger)index{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block YXBElectronicLoanViewController *this = self;
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
        LoanManagerV10 *managerV3 = (LoanManagerV10*)[assginHtttperator getAopInstance:[LoanManagerV10 class] returnValue:[NSSkyArray class]];
        
        [managerV3 getLoanListData:[YXBTool getUserToken] pageNum:this.PageNum loanType:index+1];
        
        
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
        [self.dataArray removeAllObjects];
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
    static NSString *cellName = @"cellID";
    YXBLoanCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[YXBLoanCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    if (indexPath.row%2==0) {
        cell.backgroundColor = [YXBTool colorWithHexString:@"#f2f5f7"];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArray.count) {
        cell.model =[_dataArray objectAtIndex:indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 121.0f+10.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LoanListItem *model = nil;
    if (_dataArray.count>indexPath.row) {
        model = [_dataArray objectAtIndex:indexPath.row];

        BillDetailViewController *billVC = [[BillDetailViewController alloc] init];
        billVC.loanID = model.loanID;
        [self.navigationController pushViewController:billVC animated:YES];
        
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
