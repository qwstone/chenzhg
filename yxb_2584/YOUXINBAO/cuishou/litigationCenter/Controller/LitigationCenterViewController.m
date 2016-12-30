//
//  LitigationCenterViewController.m
//  YOUXINBAO
//
//  Created by pro on 2016/12/7.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LitigationCenterViewController.h"
#import "CTSegmentControl.h"
#import "LoanManagerV10.h"
#import "LitigationCell.h"
#import "OverdueLoanData.h"
#import "OverdueManager.h"
#import "YXBLoanCenterNoRecordView.h"
#import "MyLoanViewController.h"
#import "Payment_payLawsuit.h"
@interface LitigationCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,CTSegmentControlDelegate,QCBaseTableViewDelegate>

@property (retain, nonatomic) HttpOperator  *   iHttpOperator;
@property (weak, nonatomic) QCBaseTableView *   litigationTable;
@property(strong,nonatomic)OverdueLoanData*Model;


/**
 底部申请按钮
 */
@property (weak, nonatomic) UIButton        *   ApplicationBtn;


/**
 底部按钮高度
 */
@property (assign, nonatomic) NSInteger applicationHiget;

/**
 数据
 */
@property (strong, nonatomic) NSMutableArray*   dataArray;

/**
 页码
 */
@property (assign, nonatomic) NSInteger         PageNum;
/**
 数据请求类型0待诉讼 1诉讼中 2诉讼结束
 */
@property (nonatomic, assign) NSInteger         requestType;



/**
 记录选中框
 */
@property (nonatomic, assign) NSInteger previousSelectIndex;
@property (nonatomic, assign) NSInteger currentSelectIndex;


@end

@implementation LitigationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self initUI];
    [self setTitle:@"诉讼中心"];
}


- (void)viewWillAppear:(BOOL)animated{
    self.dataArray = [[NSMutableArray alloc] init];
    _requestType = 0;
    _previousSelectIndex = 0;
    _currentSelectIndex = 0;
    _PageNum = 1;

    [super viewWillAppear:animated];
    if (_litigationTable) {
        [self.litigationTable beginRefreshing];
    }
}


-(void)initUI{
    [self setBackView];
    self.view.backgroundColor = rgb(233, 233, 233, 1);
    [self createHeaderView];
    [self createTableView];
}

/**
 初始化选择权
 */
-(void)createHeaderView{
    NSArray *arr = @[@"待诉讼",@"诉讼中",@"诉讼结束"];
    CTSegmentControl *headerView = [[CTSegmentControl alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 34) andItems:arr andItemFont:[UIFont systemFontOfSize:25.61/2.0]];
    
    headerView.segmentTintColor = rgb(116, 116, 116, 1);
    headerView.rectColor = rgb(200, 200, 200, 1);
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.delegate = self;
    headerView.selectedIndex = 0;
    [self.view addSubview:headerView];
}


/**
 初始化Tableview
 */
-(void)createTableView{
    
    //诉讼列表
    QCBaseTableView *tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 34+1, kDeviceWidth, kDeviceHeight-64-34-1 - kDeviceWidth/640*121) style:UITableViewStylePlain refreshFooter:YES];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _litigationTable.clipsToBounds = YES;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.refreshDelegate = self;
    
    [self.view addSubview:tableView];
    self.litigationTable = tableView;
    
    //底部申请按钮
    UIButton * tApplicationBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, tableView.bottom+1, kDeviceWidth, kDeviceWidth/640*121)];
    [tApplicationBtn setBackgroundImage:[UIImage imageNamed:@"CuiShouBtn"] forState:UIControlStateNormal];
    [tApplicationBtn addTarget:self action:@selector(ApplicationBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tApplicationBtn];
    self.ApplicationBtn = tApplicationBtn;
    
}



#pragma mark - 数据请求
-(void)httpRequestLigationCenter{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block LitigationCenterViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        [this stopDefaultAnimation];
        
        //        [this layoutDefaultAnimation];
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        if (error == EHttp_Operator_Failed) {
            [ProgressHUD showErrorWithStatus:@"加载失败,请检查手机网络"];
            [this.litigationTable reloadDeals];
        }
        
    } param:^(NSString *s) {
        OverdueManager *overduemanager = (OverdueManager*)[assginHtttperator getAopInstance:[OverdueManager class] returnValue:[NSSkyArray class]];
        
        
        [overduemanager getLawsuitLoanList:_PageNum usertoken:[YXBTool getUserToken] state:_requestType];
        
        
    } complete:^(NSSkyArray *r, int taskid){
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}

-(void)httpLoadComplete:(NSSkyArray *)r{
    [self.litigationTable reloadDeals];
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
        //无数据提示
    }
    
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.litigationTable.hasFooter = YES;
    }else {
        self.litigationTable.hasFooter = NO;
    }
    if(r.iArray.count&&r.iArray.count%20!=0){
        UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
        switch (_requestType) {
            case 0:
                footer.text = @"所有逾期借条都在这了！";
                break;
            case 1:
                footer.text = @"正在诉讼的逾期借条都在这了！";
                break;
            case 2:
                footer.text = @"诉讼结束的逾期借条都在这了！";
                break;
                
            default:
                break;
        }
        footer.textColor = rgb(160, 160, 160, 1);
        footer.font = [UIFont systemFontOfSize:15];
        footer.textAlignment = NSTextAlignmentCenter;
        
        self.litigationTable.tableFooterView = footer;
    }
    [self.litigationTable reloadData];
}
#pragma mark - CTSegmentControlDelegate
-(void)segmentControlDidSelectedIndex:(NSInteger)index{
    self.requestType = index;
    //待诉讼显示底部申请按钮  其他情况隐藏申请按钮
    if (_requestType == 0) {
        _ApplicationBtn.hidden = NO;
        self.litigationTable.frame = CGRectMake(0, 34+1, kDeviceWidth, kDeviceHeight-64-34-1 - kDeviceWidth/640*121);
    }else{
        _ApplicationBtn.hidden = YES;
        self.litigationTable.frame = CGRectMake(0, 34+1, kDeviceWidth, kDeviceHeight-64-34-1);
    }
    
    if([self.litigationTable isRefresh]){
        [self.litigationTable reloadDeals];
    }
    self.litigationTable.tableFooterView = nil;
    [self.litigationTable beginRefreshing];
}
#pragma mark - QCBaseTableViewDelegate
//下拉加载
-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView{
    [_dataArray removeAllObjects];
    _PageNum = 1;
    _litigationTable.tableFooterView = nil;
    [self httpRequestLigationCenter];
}
//上拉加载
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.litigationTable.isRefresh && _dataArray.count%20==0&&self.litigationTable.hasFooter == YES) {
        _PageNum ++;
        [self httpRequestLigationCenter];
    }else {
        
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * IdentifierStr = @"LitigationCell";
    LitigationCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierStr];
    if (cell == nil) {
        cell = [[LitigationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.selectBtn.tag = indexPath.row + 10;
    if (_dataArray.count) {
        OverdueLoanData * model = _dataArray[indexPath.row];
        cell.model = model;
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
        [_litigationTable reloadRowsAtIndexPaths:@[prPath,cupath] withRowAnimation:UITableViewRowAnimationNone];
    };
    //更新按钮状态
    [cell updateSelectBtnWithCurrentIndex:_currentSelectIndex];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 131.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OverdueLoanData * model = nil;
    if (_dataArray.count>indexPath.row) {
        model = [_dataArray objectAtIndex:indexPath.row];
        MyLoanViewController *myLoanListVC = [[MyLoanViewController alloc] init];
        myLoanListVC.loanID = model.loanID;
        
        [self.navigationController pushViewController:myLoanListVC animated:YES];
    }
}


#pragma mark == Action


/**
 申请诉讼
 */
-(void)ApplicationBtnAction{
    if (_currentSelectIndex == 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择要申请的逾期借条" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
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
}
#pragma mark - UIAlterView PaySuccess
-(void)AlertViewSuccess
{
    UIAlertView*alert = [[UIAlertView alloc] initWithTitle:nil message:@"1.法律诉讼服务采取预付佣金方式，法院或我方拒绝受理，将全款退还到您现金账户\n2.请认真填写诉讼材料，方便我们与您及时沟通，并给债务人送达法院“传票”\n3.请仔细阅读《专业诉讼服务条款》内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",  nil];
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
                Payment_payLawsuit*Payment_payLawsuitModel = [[Payment_payLawsuit alloc] init];
                Payment_payLawsuitModel.loanIds=[NSString stringWithFormat:@"%ld",(long)self.Model.loanID];
                Payment_payLawsuitModel.loanNums=[NSString stringWithFormat:@"1"];
                NSString *url = [YXBPaymentUtils getFullWebUrl:Payment_payLawsuitModel];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
