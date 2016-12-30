//
//  QCZhongChouDetailViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/11/12.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCZhongChouDetailViewController.h"
#import "QCBaseTableView.h"
#import "ZCTableViewOneCell.h"
#import "ZCTableViewSecondCell.h"
#import "YXBTool.h"
#import "GuaranteeManager.h"
#import "CrowdfundingPerson.h"
#import "CrowdfundingData.h"
@interface QCZhongChouDetailViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate>

@property (nonatomic,weak)QCBaseTableView *tableView;
@property (nonatomic,weak)UIView *bottomView;
/** 已经参与众筹人员名单列表 */
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)CrowdfundingData *crowfundingData;
@end

@implementation QCZhongChouDetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self httpRequest];
}

#pragma mark - 创建UI
-(void)initUI{

    [self createTableView];
    [self createBackView];
    [self createBottomView];
}
-(void)createTableView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    QCBaseTableView  *tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-47) style:UITableViewStylePlain];
    tableView.backgroundColor = rgb(230, 230, 230, 1);
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.refreshDelegate = self;
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    _tableView = tableView;
    [self.view addSubview:_tableView];
    [_tableView reloadDeals];
}
-(void)createBottomView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(-1, kDeviceHeight-47-64, kDeviceWidth+2, 47)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.alpha = 0.8;
    bottomView.layer.borderWidth = 1;
    bottomView.layer.borderColor = [UIColor grayColor].CGColor;
    _bottomView = bottomView;
    [self.view addSubview:_bottomView];
    NSArray *array = @[@"补全金额",@"邀请好友"];
    for (int i = 0; i < 2; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(_bottomView.width/2*i, 0, _bottomView.width/2.0, _bottomView.height);
        [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitleColor:[YXBTool colorWithHexString:@"#2c91ec"] forState:UIControlStateNormal];
        
        btn.tag = 500+i;
        [btn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:btn];
    }
}
-(void)bottomBtnClick:(UIButton *)btn{
    if (btn.tag == 500) {
        
    }else if (btn.tag == 501){
    
    }
}
-(void)createBackView{
    self.title = @"众筹详情";
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
}
#pragma mark - 数据请求
-(void)httpRequest{
    if (self.iHttpOperater == nil) {
        self.iHttpOperater = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperater cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperater;
    __weak QCZhongChouDetailViewController *this = self;
    
    [self.iHttpOperater connetStart:^(int d) {
        
    } cancel:^(int d) {

    } error:^(int d, THttpOperatorErrorCode error) {
        [this httpLoadError:error];
    } param:^(NSString *s) {
        [this httpLoadParams:s httpOperation:assginHtttperator];
    } complete:^(CrowdfundingData *r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperater connect];
}
//上传参数
- (void)httpLoadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    GuaranteeManager *manager = (GuaranteeManager*)[httpOperation getAopInstance:[GuaranteeManager class] returnValue:[CrowdfundingData class]];
    
    [manager getCrowdfundingDetails:[YXBTool getUserToken] crowdfundingID:110];
    
}
//请求完成
-(void)httpLoadComplete:(CrowdfundingData *)r{

    if (r.errCode == 0) {
        self.crowfundingData = r;
        if (self.dataArray.count>0) {
            [self.dataArray removeAllObjects];
        }
        self.dataArray =[NSMutableArray arrayWithArray:[self.crowfundingData crowdfundingPerson]];
    }else{
        [ProgressHUD showErrorWithStatus:r.errString];
    }
    [self.tableView reloadDeals];
    [self.tableView reloadData];
}

#pragma mark - QCBaseTableViewDelegate
-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView{
    [self httpRequest];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0||section == 1){
        return 1;
    }else{
        return _dataArray.count>0?_dataArray.count:1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID;
    if (indexPath.section == 0) {
        cellID = @"FirstCellID";
    }else if (indexPath.section == 1){
        cellID = @"SecondCellID";
    }else if (indexPath.section == 2){
        if(_dataArray.count>0){
            cellID = @"ThirdCellRecordID";
        }else{
            cellID = @"ThirdCellDefaultID";
        }
        ZCTableViewSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[ZCTableViewSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        if (self.dataArray.count>0) {
            CrowdfundingPerson *personModel = [self.dataArray objectAtIndex:indexPath.row];
            cell.personModel = personModel;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    ZCTableViewOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZCTableViewOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.crowfundModel = self.crowfundingData;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 42)];
    view.backgroundColor = [YXBTool colorWithHexString:@"#f4f4f4"];
    if (section == 2) {
        [self createSecondSessionHeaderView:view];
    }
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        return 11;
    }
    return 75;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 205;
    }
    if (indexPath.section == 1) {
        return 100;
    }
    if (_dataArray.count >0) {
        return 51;
    }
    return 84;

}
//创建session2的头部视图
-(void)createSecondSessionHeaderView:(UIView*)view{
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 18, 2, 15)];
    lineImage.image = [UIImage imageNamed:@"redline"];
    
    [view addSubview:lineImage];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(lineImage.right+6, 17, kDeviceWidth-10, 17)];
    label.text = @"众筹记录";
    label.textColor = [YXBTool colorWithHexString:@"#161616"];
    label.font = [UIFont boldSystemFontOfSize:17];
    [view addSubview:label];
    NSArray *array = @[@"昵称",@"担保金额(元)",@"付款时间"];
    for (int i = 0; i < 3; i++) {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3.0*i, label.bottom+8, kDeviceWidth/3.0, 33)];
        label1.text = [array objectAtIndex:i];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = [YXBTool colorWithHexString:@"#AAAAAA"];
        label1.backgroundColor = [YXBTool colorWithHexString:@"#fbf9f9"];
        [view addSubview:label1];
        
    }
}


@end
