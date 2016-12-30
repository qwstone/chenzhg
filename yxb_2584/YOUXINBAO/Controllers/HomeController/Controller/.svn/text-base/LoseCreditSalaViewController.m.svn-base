//
//  LoseCreditSalaViewController.m
//  YOUXINBAO
//
//  Created by pro on 16/9/23.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoseCreditSalaViewController.h"
#import "LoseCreditCell.h"
#import "CreditCenterManagerV2.h"
#import "DishonestUser.h"
#import "LoseCreditSalaHead.h"
@interface LoseCreditSalaViewController ()<UITableViewDelegate,UITableViewDataSource,QCBaseTableViewDelegate>


@property (strong, nonatomic) UISegmentedControl * segmentControl;

@property (strong, nonatomic) LoseCreditSalaHead * headView;

@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (strong, nonatomic) DishonestUser * model;

@property (nonatomic,strong)QCBaseTableView *myTableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) NSInteger pageNum;

@property (nonatomic,assign) NSInteger requestType;//数据请求类型1我附近的2我的好友 4搜索
@property (nonatomic,assign) NSInteger brforeSearchType;//搜索之前数据请求类型
@property(nonatomic,weak)UISearchBar *searchBar;
@property (nonatomic,strong) NSString*SearchStr;



@end

@implementation LoseCreditSalaViewController

- (void)viewDidLoad {
    
    //titleview不居中bug
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                     initWithTitle:@""
                                                     style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:nil];
    }
    
    
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    self.pageNum = 1;
    self.requestType = 0;
    [self createTableView];
    [self createSearchBar];
    [self initTopSegmentControlWithArray:[NSArray arrayWithObjects:@"全部", @"我附近的", @"我的好友", nil]];

}


-(void)viewWillAppear:(BOOL)animated{
    [self.myTableView reloadDeals];
    if (![YXBTool getLoginYesOrNo]) {
        _requestType = 0;
        [_segmentControl setSelectedSegmentIndex:0];
    }
    if (_myTableView) {
        [self.myTableView beginRefreshing];
    }

}




//添加选择器
-(void)initTopSegmentControlWithArray:(NSArray *)segArray{
    if (_segmentControl != nil) {
        [_segmentControl removeFromSuperview];
    }
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:segArray];
    _segmentControl.frame = CGRectMake(0, 0, kDeviceWidth/750*480, 30);
    _segmentControl.selectedSegmentIndex = 0;
    _segmentControl.layer.cornerRadius = 5.0;
    _segmentControl.backgroundColor = rgb(214, 37, 47, 1);
    _segmentControl.tintColor = [UIColor whiteColor];//rgb(221, 101, 115, 1.0);
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView =_segmentControl;
    
    //添加搜索按钮
//    UIImage *rightImg = [UIImage imageNamed:@"lose_Search"];
//    UIButton * SearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    SearchBtn.frame = CGRectMake(0, 0, rightImg.size.width, rightImg.size.height);
//    [SearchBtn addTarget:self action:@selector(SearchAction:) forControlEvents:UIControlEventTouchUpInside];
//    [SearchBtn setImage:rightImg forState:UIControlStateNormal];
//    UIBarButtonItem * navItem = [[UIBarButtonItem alloc]initWithCustomView:SearchBtn];
//    self.navigationItem.backBarButtonItem.style = UIBarButtonItemStylePlain;
//    self.navigationItem.rightBarButtonItem = navItem;

}

-(void)createTableView{
    
    self.headView = [[LoseCreditSalaHead alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 35)];
    [self.view addSubview:_headView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    QCBaseTableView *tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 75, kDeviceWidth, kDeviceHeight-64-35) style:UITableViewStylePlain refreshFooter:YES];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    self.myTableView = tableView;
    tableView.refreshDelegate = self;
    [self.view addSubview:tableView];
}
//系统自带搜索框
-(void)createSearchBar{
    UISearchBar *serBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 35, kDeviceWidth, 40)];
    serBar.barTintColor = [YXBTool colorWithHexString:@"#F2F1F6"];
    serBar.placeholder = @"搜索";
    //去掉黑线
    serBar.showsCancelButton = NO;
    serBar.layer.borderWidth = 1;
    serBar.layer.borderColor = [[UIColor whiteColor] CGColor];
    serBar.delegate = self;
    _searchBar = serBar;
    [self.view addSubview:_searchBar];
}
#pragma mark - QCSearchBar
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    _searchBar.showsCancelButton = YES;
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    [_searchBar endEditing:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if([searchText isEqualToString:@""]){
        [self.view endEditing:YES];
        [_searchBar endEditing:YES];
//        [self fileterFullModelArrayWithKey:@""];
//        [self loadSavedData];
        _searchBar.showsCancelButton = NO;
    }else{
//        [self fileterFullModelArrayWithKey:searchText];
        
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    [_searchBar endEditing:YES];
    _searchBar.text = @"";
    _requestType = _brforeSearchType;//还原之前的数据请求类型
    _searchBar.showsCancelButton = NO;
    [self.myTableView beginRefreshing];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    _requestType=4;
    _SearchStr=searchBar.text;
  
    NSLog(@"---------%@",_SearchStr);
    [self.view endEditing:YES];
    [_searchBar resignFirstResponder];
    [self.myTableView beginRefreshing];
//    [self httpRequest];
}
//根据搜索过滤数据

#pragma  mark ======  Action
//选择事件
-(void)segmentAction:(UISegmentedControl *)Seg

{   [self.view endEditing:YES];
    [_searchBar endEditing:YES];
    _searchBar.text = @"";
    _searchBar.showsCancelButton = NO;
    //根据条件筛选数据
    [self.view endEditing:YES];
    NSInteger index = Seg.selectedSegmentIndex;
    if (index == 0) {
        //全部
        _requestType = 0;
    }
    else if (index == 1){
        //我附近的
        _requestType = 1;
    }
    else{
        //我的好友
        _requestType = 2;
    }
    _brforeSearchType = _requestType;
    [self.myTableView beginRefreshing];



}
//搜索事件
-(void)SearchAction:(UIButton* )sender
{
    
}


#pragma mark  =======  QCBaseTableViewDelegate
-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView{
    //刷新
    [_dataArray removeAllObjects];
    _pageNum = 1;
     [self httpRequest:_pageNum];
}

//上拉加载
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.myTableView.isRefresh && _dataArray.count%4==0&&self.myTableView.hasFooter == YES) {
        _pageNum ++;
        [self httpRequest:_pageNum];

    }else {
        
    }
}



#pragma mark  =======  UITableViewDataSource
//设置foot大小
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == _dataArray.count - 1) {
        return 0;
    }
    return 10;
}
//设置foot颜色
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
//行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray * numArr = _dataArray[section];
    return numArr.count;
}
//区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoseCreditCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LoseCreditCell"];
    if (cell == nil) {
        cell = [[LoseCreditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoseCreditCell"];
    }
    if (_dataArray.count) {
        
        NSMutableArray * data = [_dataArray objectAtIndex:indexPath.section];
        DishonestUser * model = [data objectAtIndex:indexPath.row];
        if (indexPath.row != data.count - 1) {
            model.isShow = YES;
        }
        cell.model = model;
    }
    return cell;
}



#pragma mark - 数据请求
//根据类型请求数据   0全部数据 1我附近的  2我的好友 4搜索
-(void)httpRequest:(NSInteger)index{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block LoseCreditSalaViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        [this stopDefaultAnimation];
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        if (error == EHttp_Operator_Failed) {
            [ProgressHUD showErrorWithStatus:@"加载失败, 请检查手机网络"];
            [this.myTableView reloadDeals];
        }
        
    } param:^(NSString *s) {
        CreditCenterManagerV2 * manager = (CreditCenterManagerV2*)[assginHtttperator getAopInstance:[CreditCenterManagerV2 class] returnValue:[NSSkyArray class]];
        //根据类型请求数据
        if (_requestType == 0) {
            [manager getDishonestCenterDate:_pageNum];
        }
        else if (_requestType == 4) {
            [manager getDishonestCenterDateByCondition:_SearchStr pageNo:_pageNum];
        }
        else{
            QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
            if (!userModel.isLogin) {
                
                
                [this.myTableView reloadDeals];
                [self toLogin];
                return;
            }
            else{
               

            [manager getDishonestCenterDateByUserInfo:[YXBTool getUserToken] pageNum:_pageNum andType:_requestType];
            }
        }
        
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
            [self.dataArray addObjectsFromArray:[self disposeArrayData:r.iArray]];
        }
    }
    else{
        [self.dataArray removeAllObjects];
        
    }
    
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.myTableView.hasFooter = YES;
    }
    else {
        self.myTableView.hasFooter = NO;
           }
    
    if(r.iArray.count&&r.iArray.count%20!=0){
        UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
        footer.text = @"所有失信名单都在这了";
        footer.textColor = rgb(160, 160, 160, 1);
        footer.font = [UIFont systemFontOfSize:15];
        footer.textAlignment = NSTextAlignmentCenter;
        self.myTableView.tableFooterView = footer;
    }
    else{
        self.myTableView.tableFooterView = nil;
    }
    [self.myTableView reloadData];}


//跳出登陆页面
- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    //    loginNav.navigationBar.barTintColor = rgb(231, 27, 27, 1);
    //    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    loginView.modalPresentationStyle = UIModalPresentationPopover;
    [[YXBTool getCurrentNav] presentViewController:loginNav animated:YES completion:nil ];
}



//一维数组转换为二维数组
-(NSMutableArray *)disposeArrayData:(NSMutableArray *)data
{
    NSMutableArray * sectionArray = [[NSMutableArray alloc] init];
    NSMutableArray * numberArray = [[NSMutableArray alloc] init];
    //数据重新梳理
    for (NSInteger i = 1; i <= data.count; i++) {
        [numberArray addObject:[data objectAtIndex:i-1]];
        if (i % 5 == 0 || i == data.count) {
            [sectionArray addObject:numberArray];
            numberArray = [[NSMutableArray alloc] init];
        }
    }
    return sectionArray;
    
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
