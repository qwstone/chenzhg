//
//  QCMoneyListViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCMoneyListViewController.h"
#import "HeaderView.h"
#import "QCMoneyListCell.h"
#import "QCCheckDetailViewController.h"
#import "TFundDetailManager.h"
#import "YXBTool.h"
#import "UserManager.h"

#define QCMoneyListViewControllerPageStartNO 1


@interface QCMoneyListViewController ()<HeaderViewDelegate,UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,UIActionSheetDelegate> {

    NSInteger _indexPage;
}

@property (nonatomic,strong)QCBaseTableView *tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) NSMutableArray * cellHeightArray;
@property(nonatomic,strong)UISegmentedControl *segmentControl;
//资金类型 0 资金明细  1理财资金   2法院诉讼    3催收资金   4视频冻结资金
@property (nonatomic,assign) QCMoneyType navSelect;
@property (nonatomic,strong) UIButton *titleBtn;//nav的标题按钮
@property (nonatomic,strong) NSArray *titleArray; //title类型数组
@property (nonatomic,strong) NSArray *segArray; //第二行类型数组


@end

@implementation QCMoneyListViewController

-(void)leftClicked
{
    if (_titleBtn != nil) {
        [_titleBtn removeFromSuperview];
    }
    
    [super leftClicked];
}

-(void)dealloc{
    if (_titleBtn != nil) {
        [_titleBtn removeFromSuperview];
    }
    
    [super leftClicked];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createData];
    [self createNav];

    [self createUI];
}
-(void)viewWillAppear:(BOOL)animated{
    UIView *titleBtn = [self.navigationController.navigationBar viewWithTag:NavigationBarTitleBtnTag];
    if (titleBtn != nil) {
        titleBtn.hidden = NO;
    }
    [super viewWillAppear:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    UIView *titleBtn = [self.navigationController.navigationBar viewWithTag:NavigationBarTitleBtnTag];
    if (titleBtn != nil) {
        titleBtn.hidden = YES;
    }
    [super viewWillDisappear:YES];
}
/**
 *  数据初始化 jintoo
 */
-(void)createData{
    _dataArray = [NSMutableArray new];
    self.cellHeightArray = [NSMutableArray array];
    self.style = QCMoneyListStyleAll;
    self.segArray = [NSArray arrayWithObjects:@"全部",@"转入",@"转出", nil];
    self.titleArray = [NSArray arrayWithObjects:@"资金明细", @"理财资金", @"法院诉讼", @"催收资金", @"视频冻结金额",nil];
}
/**
 *  设置导航控制器
 */
-(void)createNav{
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@""];

    self.titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_titleBtn addTarget:self action:@selector(selectTitleClicked) forControlEvents:UIControlEventTouchUpInside];
    _titleBtn.frame = ccr((kDeviceWidth - 200)/2.0, 0, 200, self.navigationController.navigationBar.height);
    _titleBtn.tag = NavigationBarTitleBtnTag;
    [self.navigationController.navigationBar addSubview:_titleBtn];
    [self navTitleRight:YES];
    
    self.navSelect = QCMoneyTypeMoneyList;
}

/**
 *  UI创建
 */
-(void)createUI{
    
    //添加顶部选择栏
    [self initTopSegmentControlWithArray:_segArray];
    
    //创建tableView
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, _segmentControl.frame.origin.y + _segmentControl.height + QCMoneyListViewLeftAlign, kDeviceWidth, kDeviceHeight-64-_segmentControl.height-2*QCMoneyListViewLeftAlign) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
}

-(void)initTopSegmentControlWithArray:(NSArray *)segArray{
    
    if (_segmentControl != nil) {
        [_segmentControl removeFromSuperview];
    }
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:segArray];
    _segmentControl.frame = CGRectMake(0, 1, kDeviceWidth, 40);
    _segmentControl.selectedSegmentIndex = 0;//215 57 46
    _segmentControl.backgroundColor = rgb(215, 57, 46, 1);
    _segmentControl.tintColor = rgb(215, 57, 46, 1);
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [_segmentControl setDividerImage:[UIImage imageNamed:@"segmentcontroll_line"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];//间隔线
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"SnellRoundhand-Bold" size:16],NSFontAttributeName , [YXBTool colorWithHexString:@"#ffa4a7"],NSForegroundColorAttributeName,nil];
    [_segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    [_segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    
    
    [self.view addSubview:_segmentControl];
    
}

-(void)setNavSelect:(QCMoneyType)navSelect{
    if (_navSelect != navSelect) {
        _navSelect = navSelect;
        _indexPage = QCMoneyListViewControllerPageStartNO;
        [self navTitleRight:YES];
        if (_navSelect == QCMoneyTypeFreezenMoney) {
            //冻结金额，改变为 转入  转出
            self.segArray = [NSArray arrayWithObjects:@"全部",@"转入",@"转出", nil];
            
        }else{
            self.segArray = [NSArray arrayWithObjects:@"全部",@"收入",@"支出", nil];
        }
        for (int i = 0;i<self.segArray.count;i++) {
            NSString *segTitle =[self.segArray objectAtIndex:i];
            [self.segmentControl setTitle:segTitle forSegmentAtIndex:i];
        }
        self.segmentControl.selectedSegmentIndex = 0;
        [self segmentAction:_segmentControl];
    }
}
- (void)setStyle:(QCMoneyListStyle)style {
    _style = style;
    [self.tableView beginRefreshing];
}
#pragma mark ------------------------------------Action
//导航栏标题按钮被点击
-(void)selectTitleClicked{
    [self navTitleRight:NO];
    UIActionSheet *titleSheet = [[UIActionSheet alloc] initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:_titleArray[0],_titleArray[1],_titleArray[2],_titleArray[3],_titleArray[4], nil];
    [titleSheet showInView:self.view];
}
//分段控制器被点击
-(void)segmentAction:(UISegmentedControl *)Seg{
    NSInteger index = Seg.selectedSegmentIndex;
    switch (index) {
        case 0://全部
            self.style = QCMoneyListStyleAll;
            break;
        case 1://收入
            self.style = QCMoneyListStyleEarning;
            break;
        case 2://支出
            self.style = QCMoneyListStyleExpend;
            break;
        default:
            break;
    }
    [self.tableView beginRefreshing];
}
#pragma mark -- actionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex >= 5 || _navSelect == buttonIndex) {
        //取消
        [self navTitleRight:YES];
    }else{
        self.navSelect = (QCMoneyType)buttonIndex;
        
    }
}

#pragma mark  --------------------------- QCBaseTableViewDelegate
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    _indexPage = QCMoneyListViewControllerPageStartNO;
    [self.dataArray removeAllObjects];
    [_cellHeightArray removeAllObjects];
    [self httpDowloadWithListStyle:self.style];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.tableView.isRefresh && _dataArray.count%20 == 0 && self.tableView.hasFooter == YES) {
        _indexPage ++;
        [self httpDowloadWithListStyle:self.style];
    }else {
    }
}

#pragma mark  - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_cellHeightArray.count) {
        return [_cellHeightArray[indexPath.row] floatValue] + 40;
    }
    return 0.000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"moneyCell";
    QCMoneyListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[QCMoneyListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if ((indexPath.row < [_dataArray count]) && (indexPath.row < [_cellHeightArray count])) {
        cell.model = [_dataArray objectAtIndex:indexPath.row];
        cell.detailHeight = [_cellHeightArray[indexPath.row] floatValue];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FundDetail *model = [_dataArray objectAtIndex:indexPath.row];
    QCCheckDetailViewController *checkVC = [[QCCheckDetailViewController alloc] init];
    checkVC.fundId = model.t_id;
    [self.navigationController pushViewController:checkVC animated:YES];
}

#pragma mark - Private Methods

-(void)makeCellHeightArrayWithArray:(NSMutableArray *)dataArray
{
    
    CGFloat width = kDeviceWidth - 150;
    if (_indexPage == QCMoneyListViewControllerPageStartNO) {
        [_cellHeightArray removeAllObjects];
    }
    for (FundDetail *detail in dataArray) {
        NSString *detailStr = detail.title;
        CGSize size = [YXBTool getFontSizeWithString:detailStr font:[UIFont systemFontOfSize:QCMoneyListCellFont] constrainSize:CGSizeMake(width, CGFLOAT_MAX)];
        
        [_cellHeightArray addObject:[NSString stringWithFormat:@"%f",size.height]];
    }
    
}

-(void)navTitleRight:(BOOL)isRight
{
    if (isRight) {
        NSString *title = _titleArray[_navSelect];
        title = [NSString stringWithFormat:@"%@▶︎",title];
        [_titleBtn setTitle:title forState:UIControlStateNormal];

    }
    else
    {
        NSString *title = _titleArray[_navSelect];
        title = [NSString stringWithFormat:@"%@▼",title];
        [_titleBtn setTitle:title forState:UIControlStateNormal];

    }
}


#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpDowloadWithListStyle:(QCMoneyListStyle)style{
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCMoneyListViewController *this = self;
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
        [this httpLoadParams:assginHtttperator style:style];
        
    } complete:^(NSSkyArray* r, int taskid) {
        [this httpLoadComplete:r];
        
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator style:(QCMoneyListStyle)style{
    
    UserManager *_fundM = (UserManager *)[assginHtttperator getAopInstance:[UserManager class] returnValue:[NSSkyArray class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    if (_navSelect == QCMoneyTypeMoneyList) {
        //资金明细
        NSLog(@"请求资金明细");
        
        [_fundM getFundDetail:userModel.user.yxbToken mode:style pageNum:_indexPage];
        
    }else if (_navSelect == QCMoneyTypeFreezenMoney){
        NSLog(@"请求冻结金额");
        [_fundM getFrozenDetail:userModel.user.yxbToken mode:style pageNum:_indexPage];
        
    }else if(_navSelect == QCMoneyTypeLiCai){
        NSLog(@"请求理财资金");
        [_fundM getFinanceFundDetail:userModel.user.yxbToken mode:style pageNum:_indexPage];
    }else if (_navSelect == QCMoneyTypeCuishou){
        //请求催收资金明细
        [_fundM getUrgeFundDetail:userModel.user.yxbToken mode:style pageNum:_indexPage];
    }else if (_navSelect == QCMoneyTypeSusong){
        //请求诉讼资金明细
        [_fundM getLawsuitFundDetail:userModel.user.yxbToken mode:style pageNum:_indexPage];
    }
    
    
    
    
}
- (void)httpLoadComplete:(NSSkyArray *)r{
    
    if (r.errCode == 0) {
        if (r.iArray.count>0) {
            [self makeCellHeightArrayWithArray:r.iArray];
            
            if (_indexPage>1) {
                [self.dataArray addObjectsFromArray:r.iArray];
                
            }else{
                self.dataArray = r.iArray ;
            }
            
            _tableView.tableFooterView = [UIView new];
            
            
        }else{
            if (_indexPage == 1) {
                UILabel *nullImage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _tableView.height)];
                nullImage.text = @"暂无数据";
                nullImage.textColor = [UIColor blueColor];
                nullImage.textAlignment = NSTextAlignmentCenter;
                _tableView.tableFooterView = nullImage;
                
            }else{
                _tableView.tableFooterView = [UIView new];
                
            }
        }
        
    }else if (r.errCode == 7) {
        if (_indexPage == 1) {
            UILabel *nullImage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _tableView.height)];
            nullImage.text = @"暂无数据";
            nullImage.textColor = [UIColor blueColor];
            nullImage.textAlignment = NSTextAlignmentCenter;
            _tableView.tableFooterView = nullImage;
            
        }else{
            _tableView.tableFooterView = [UIView new];
            
        }
        
    }else {
        [self.dataArray removeAllObjects];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.tableView.hasFooter = YES;
    }else {
        self.tableView.hasFooter = NO;
    }
    [self.tableView reloadData];
    [self.tableView reloadDeals];
    
    
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
