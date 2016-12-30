//
//  ProductListViewController.m
//  YOUXINBAO
//
//  Created by pro on 16/7/20.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "InvestListViewController.h"
#import "FinancialManagerV2.h"
#import "AssetListItem.h"
#import "QCBaseTableView.h"
#import "InvestDetailViewController.h"
#import "InvestListCell.h"
#import "QCTouZiJiLuViewController.h"
@interface InvestListViewController ()<UITableViewDelegate,UITableViewDataSource,QCBaseTableViewDelegate>
@property (retain, nonatomic) HttpOperator* iHttpOperator;

@property (nonatomic,weak)QCBaseTableView *myTableView;
@property (nonatomic,weak)AssetDetails *AssetDetailsMode;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger PageNum;

@end

@implementation InvestListViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] init];
        self.PageNum = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"全部产品";
    [self initUI];
    [self createRightBar];
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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    QCBaseTableView *tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 1, kDeviceWidth, kDeviceHeight-64-1) style:UITableViewStylePlain refreshFooter:YES];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    self.myTableView = tableView;
    tableView.refreshDelegate = self;
    
    [self.view addSubview:tableView];
}


-(void)createRightBar{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 75, 40);
    [btn setTitle:@"投资记录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(void)rightClick{
    QCTouZiJiLuViewController * tzjlVC = [[QCTouZiJiLuViewController alloc] init];
    [self.navigationController pushViewController:tzjlVC animated:YES];
}

#pragma mark  =======  QCBaseTableViewDelegate
-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView{
    [_dataArray removeAllObjects];
    _PageNum = 1;
    [self httpRequest:self.PageNum];
}

//上拉加载
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.myTableView.isRefresh && _dataArray.count%20==0&&self.myTableView.hasFooter == YES) {
        _PageNum ++;
    [self httpRequest:self.PageNum];
//        [self httpRequest:self.currentIndex];
    }else {
        
    }
}

#pragma mark  =======  UITableViewDataSource


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 103;//9+35+58+1
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    InvestListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InvestListCell"];
    if (cell == nil) {
        cell = [[InvestListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InvestListCell"];
    }
    if (_dataArray.count) {
        AssetListItem * model = [_dataArray objectAtIndex:indexPath.row];
        cell.model = model;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AssetListItem * model = nil;
    if (_dataArray.count > indexPath.row) {
        model = [_dataArray objectAtIndex:indexPath.row];
    }
    InvestDetailViewController * investVC = [[InvestDetailViewController alloc] init];
    investVC.assetItemModel = model;
    [self.navigationController pushViewController:investVC animated:YES];
}




#pragma mark - 数据请求
-(void)httpRequest:(NSInteger)index{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block InvestListViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        [this stopDefaultAnimation];
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        if (error == EHttp_Operator_Failed) {
            [ProgressHUD showErrorWithStatus:@"加载失败,请检查手机网络"];
            [this.myTableView reloadDeals];
        }
        
    } param:^(NSString *s) {
        
        FinancialManagerV2 * manager = (FinancialManagerV2*)[assginHtttperator getAopInstance:[FinancialManagerV2 class] returnValue:[NSSkyArray class]];
        [manager getAllAssetList:[YXBTool getUserToken] pageNum:index];
    
    } complete:^(NSSkyArray *r, int taskid){
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}

-(void)httpLoadComplete:(NSSkyArray *)r{
    [self.myTableView reloadDeals];
    if (r.errCode == 0) {
        //发送成功
        if (r.iArray.count>0) {
            [self.dataArray addObjectsFromArray:r.iArray];
        }
    }
    else{
        [self.dataArray removeAllObjects];
        //        [ProgressHUD showErrorWithStatus:r.errString];
    }
    
//    if(_PageNum==1&&r.iArray.count==0){//无数据
//        self.noRecordView.height = kDeviceHeight-64-34-1;
//    }
    
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.myTableView.hasFooter = YES;
    }
    else {
        self.myTableView.hasFooter = NO;
    }
    
    if(r.iArray.count&&r.iArray.count%20!=0){
        UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
        footer.text = @"所有产品都在这了";
        footer.textColor = rgb(160, 160, 160, 1);
        footer.font = [UIFont systemFontOfSize:15];
        footer.textAlignment = NSTextAlignmentCenter;
        self.myTableView.tableFooterView = footer;
    }
    else{
        self.myTableView.tableFooterView = nil;
    }
    [self.myTableView reloadData];
    
    
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
