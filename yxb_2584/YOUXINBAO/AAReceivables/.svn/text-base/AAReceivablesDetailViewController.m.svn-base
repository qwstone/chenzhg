//
//  AAReceivablesDetailViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/6/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAReceivablesDetailViewController.h"
#import "HttpOperator.h"
#import "QCBaseTableView.h"
#import "AverageManager.h"
#import "AAReceivablesDetailCell.h"
#import "QCFriendsViewController.h"
#import "Payment_AveragePay.h"
#import "FriendDetailViewController.h"

@interface AAReceivablesDetailViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,LoanMessageTableViewCellDelegate>
@property(nonatomic,assign)BOOL isFromCreateAA;
@property (nonatomic,strong) HttpOperator * iHttpOperator;
@property (nonatomic,strong) QCBaseTableView *tableView;
@property (nonatomic,strong) AAReceivablesDetailHeaderView *headerView;

@end

@implementation AAReceivablesDetailViewController

-(void)dealloc{
    NSLog(@"AAReceivablesDetailViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    [self setTitle:@"AA收款"];
    self.view.backgroundColor = rgb(238, 236, 246, 1.0);
    [self initViews];
    self.isFromCreateAA=NO;
    if (_backModel != nil) {
        self.isFromCreateAA=YES;
        [self loadCreateAAModel];
    }
    // Do any additional setup after loading the view.
}


-(void)loadCreateAAModel
{
    
    _tableView.refreshDelegate = nil;
    [self reSetHeaderView];
    [_tableView reloadData];
    [_tableView reloadDeals];
    [_tableView setScrollEnabled:NO];


}



-(void)initViews
{
    CGFloat x = 0, y = 0, w = kDeviceWidth, h = kDeviceHeight - 64;
    self.tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

    
}

//重置headerView  frame
-(void)reSetHeaderView
{
    CGFloat height = 120;
    NSString *remark = _backModel.describe;
    CGSize remarkSize = [YXBTool getFontSizeWithString:remark font:[UIFont systemFontOfSize:12] constrainSize:CGSizeMake(kDeviceWidth - 104, kDeviceHeight)];
    if (remarkSize.height > 38) {
        height = 88 + remarkSize.height;
    }
    
    if (_headerView == nil) {
        //创建tableheaderView
     
        self.headerView = [[AAReceivablesDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, height + AAReceivablesDetailHeaderViewBottomHeight)];
        _headerView.isSelectFriend=self.isFromCreateAA;
        _headerView.delegate = self;
        _headerView.remarkHeight = remarkSize.height;
        _tableView.tableHeaderView  = _headerView;

    }
//    _headerView.backgroundColor = [UIColor greenColor];
    _headerView.model = _backModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestData
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak typeof(_iHttpOperator) assginHtttperator = _iHttpOperator;
    __weak typeof(self) this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        [this.tableView reloadDeals];

        
    } error:^(int d, THttpOperatorErrorCode e) {
        [this.tableView reloadDeals];
        [ProgressHUD showErrorWithStatus:@"请求失败"];
        [this httpLoadError:e];
    } param:^(NSString *s) {
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
        
    } complete:^(GatheringRecordDetail *r, int taskid) {

        [this httpLoadComplete:r];
    }];
    
    [self.iHttpOperator connect];
    
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    AverageManager *manager = (AverageManager *)[httpOperation getAopInstance:[AverageManager class] returnValue:[GatheringRecordDetail class]];
    NSString *userToken = [YXBTool getUserToken];
    if (userToken == nil) {
        return ;
    }
    if(_record != 0)
    {
        [manager getGatheringRecordDetail:userToken recordID:self.record];
        //            _record = 0;
    }
    else
    {
        [manager getGatheringRecordDetail:userToken recordID:self.model.recordId];
        
    }

}
//请求完成
-(void)httpLoadComplete:(GatheringRecordDetail *)r{
    self.backModel = r;
    [self.tableView reloadDeals];
    if (r.errCode == 0 || r.errCode == 7) {
        [self reSetHeaderView];
        [self.tableView reloadData];
    }
    else
    {
        NSLog(@"请求错误---");
    }

}
#pragma buttondelegate

- (void)ButtonClickDelegate:(NSInteger)tag{
    if (tag == 1000) {
        QCFriendsViewController * friendsViewController = [[QCFriendsViewController alloc]init];
        friendsViewController.isAAshoukuan = YES;
        [self.navigationController pushViewController:friendsViewController animated:YES];
    }else if (tag ==1001){
    
    }else if (tag == 1002){
    
    }

}




#pragma TableViewDelegate&datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = [_backModel.iGatheringRecordFriend count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellID";
    AAReceivablesDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == Nil) {
        cell = [[AAReceivablesDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
//        cell.userInteractionEnabled = NO;
        
    }
    cell.delegate = self;
    GatheringRecordFriend * recordModel = [_backModel iGatheringRecordFriend][indexPath.row];
    
    cell.model = recordModel;
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        cell.backgroundColor = [UIColor clearColor];

    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 30)];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = rgb(56, 56, 56, 1.0);
    label.text = @"    AA好友列表";
    label.font = [UIFont systemFontOfSize:14.0];
    label.backgroundColor = rgb(238, 236, 246, 1.0);
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_backModel.recordId == -1) {
        return 0;
    }
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AAReceivablesDetailCellHeight;
}

-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    [self requestData];
}


#pragma -mark headerDelegate
//付款
-(void)payButtonClicked
{
    [self payAction];
    /*
    [ProgressHUD showSuccessWithStatus:@"付款"];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *userToken = userModel.user.yxbToken;
    NSString *urlstr = [NSString stringWithFormat:@"webView/user/AveragePay.jsp"];
    PayJsonTools *paytools = [[PayJsonTools alloc] init];
    paytools.iOnJsonStr = ^(NSString *s){
        NSLog(@"%@",s);
        NSString *dic = [NSString stringWithFormat:@"&money=%@&json=%@",_backModel.moneyPerPeople,s];
        
        NSString *urlstrs = [YXBTool getURL:urlstr params:dic];
        NSLog(@"%@",urlstrs);
        [YXBTool jumpInnerSafaryWithUrl:urlstrs hasTopBar:NO titleName:@"付款"];
    };
    AverageManager *manager = [paytools getAopInstance:[AverageManager class]];
    
    
//    [manager createAAAverage:userToken title:self.abctitle sumPeople:self.useridArray.count sumMoney:thirdCell.textView.text.integerValue descript:_textView.text mode:2 tokenArr:str];
    [manager payAAAverage:userToken recordID:_backModel.recordId];
    */

}

-(void)payAction
{
    Payment_AveragePay *payModel = [[Payment_AveragePay alloc] init];
    payModel.money = _backModel.moneyPerPeople;
    payModel.recordId = [NSString stringWithFormat:@"%ld",(long)_backModel.recordId] ;
    NSString *url = [YXBPaymentUtils getFullWebUrl:payModel];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];
}

//关闭aa收款
-(void)closeAAPay
{
    if (_iHttpOperator == nil) {
        _iHttpOperator = [[HttpOperator alloc] init];
    }
    [_iHttpOperator cancel];
    
    __weak typeof(_iHttpOperator) assginHtttperator = _iHttpOperator;
    __weak typeof(self) this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
        
    } error:^(int d, THttpOperatorErrorCode e) {
        [this closeAAPayHttpLoadError:e];
        
        
    } param:^(NSString *s) {
        
        [this closeAAPayHttpLOadParams:s httpOperation:assginHtttperator];
        
    } complete:^(TResultSet *r, int taskid) {
        [this closeAAPayHttpLoadComplete:r];
    }];
    
    [self.iHttpOperator connect];

}
-(void)closeAAPayHttpLoadError:(THttpOperatorErrorCode)error{
    if (error == EHttp_Operator_Failed) {
        //服务器挂了
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        [self.tableView reloadDeals];
    }
}
//上传参数
- (void)closeAAPayHttpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    AverageManager *manager = (AverageManager *)[httpOperation getAopInstance:[AverageManager class] returnValue:[TResultSet class]];
    NSString *userToken = [YXBTool getUserToken];
    if (userToken == nil) {
        [ProgressHUD showSuccessWithStatus:@"登录信息错误！"];
        return ;
    }
    [manager closeAAAverage:userToken recordID:_backModel.recordId];
}
//请求完成
-(void)closeAAPayHttpLoadComplete:(TResultSet *)r{
    NSLog(@"r=  %@",r);
    [self.tableView reloadDeals];
    if (r.errCode == 0 || r.errCode == 7) {
        
        [self QCBaseTableViewDidPullDownRefreshed:self.tableView];
    }
    else
    {
        NSLog(@"请求错误---");
    }
}



-(void)userImageClickedWithUserId:(NSInteger)uId
{
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.user.t_id == uId) {
        NSLog(@"%ld---%ld",(long)userModel.user.t_id,(long)uId);
        return;
    }
    
    User *user = [[User alloc] init];
    user.t_id = uId;
    
    FriendDetailViewController *controller = [[FriendDetailViewController alloc] init];
    controller.user = user;
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self QCBaseTableViewDidPullDownRefreshed:_tableView];
    [super viewWillAppear:YES];
}

@end
