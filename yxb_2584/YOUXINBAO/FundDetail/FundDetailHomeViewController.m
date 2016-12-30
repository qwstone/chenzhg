//
//  FundDetailHomeViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/12/15.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "FundDetailHomeViewController.h"
#import "FundDetailHeaderView.h"
#import "ProfitManagerV3.h"
#import "ProfitUserBuyDetail.h"
#import "YXBTool.h"
#import "FundDetailCell.h"
#import "KeyValueModel.h"
#import "FundDetailInfoView.h"
#import "TreasureMoneyProductViewController.h"

@interface FundDetailHomeViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,FundDetailCellDelegate>
{
    BOOL _hasBottom;
    UIView *kuangView;    //圈起来的正方形框

}
@property (nonatomic,strong)QCBaseTableView *tableView;
@property (nonatomic,strong)FundDetailHeaderView *headerView;
@property (retain, nonatomic)HttpOperator              * iHttpOperator;
@property (nonatomic,strong)ProfitUserBuyDetail *model;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation FundDetailHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    [self setTitle:@"理财详情"];
    [self createMyTableView];
//    [self requestData];
    self.dataArray = [NSMutableArray array];
    [self handleDataArrayWithModel];

}


-(void)requestData
{
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = self.iHttpOperator;
    __weak typeof(self) this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [self stopDefaultAnimation];
    } cancel:^(int d) {
        [this.tableView reloadDeals];

    } error:^(int d, THttpOperatorErrorCode error) {
        [this.tableView reloadDeals];

        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
        }
        [this.tableView reloadDeals];
        
    } param:^(NSString *s) {
        [this requestParamWithHttpOperation:assginHtttperator];
        
    } complete:^(ProfitUserBuyDetail* r, int taskid) {
        [this completeWithModel:r];
    }];
    [self.iHttpOperator connect];
    
    
}


//上传参数
- (void)requestParamWithHttpOperation:(HttpOperator *)httpOperation
{
    ProfitManagerV3* pm = (ProfitManagerV3*)  [httpOperation getAopInstance:[ProfitManagerV3 class] returnValue:[ProfitUserBuyDetail class]];
    
#pragma 0是写死的
    if (_regularId != 0) {
        [pm getProfitUserBuyDetail:[YXBTool getUserToken] userRegularID:_regularId];

    }
    else
    {
        [pm getProfitUserBuyDetail:[YXBTool getUserToken] userRegularID:1];

    }
}

-(void)completeWithModel:(ProfitUserBuyDetail *)model
{
    [self.tableView reloadDeals];
    if (model.errCode == 0) {
        self.model = model;
        self.headerView.model = _model;
        
        //小于等于2条，显示明细，否则是否显示明细根据上一次进行判断，默认不显示
        if ([_model.iProfitUserBuyDetailTips count] <= 2) {
            _hasBottom = YES;
        }
        
        [self handleDataArrayWithModel];
//        [self.tableView reloadData];
        [self refreshDataWithBottom:_hasBottom];
        
    }
    else
    {
        [ProgressHUD showErrorWithStatus:model.errString];
    }
}


-(void)createMyTableView
{
    
#define BottomHeight 74

    CGFloat x = 0, y = 0, w = kDeviceWidth-2*x, h = kDeviceHeight-64 - BottomHeight;
    self.tableView = [[QCBaseTableView alloc] initWithFrame:ccr(x, y, w, h)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];

    self.headerView = [[FundDetailHeaderView alloc] initWithFrame:ccr(0, 0, kDeviceWidth, 300)];
//    _headerView.backgroundColor = [UIColor lightGrayColor];
    _tableView.tableHeaderView = _headerView;
//    [self.view addSubview:_headerView];
    
//    底部继续购买
    
    x = 15;
    UIButton *continueBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [continueBuyBtn setTitle:@"继续购买" forState:UIControlStateNormal];
    continueBuyBtn.backgroundColor = kRGB(213, 37, 37);
    continueBuyBtn.layer.cornerRadius = 5.0;
    continueBuyBtn.clipsToBounds = YES;
    continueBuyBtn.frame = ccr(x, _tableView.bottom + 15, w-2*x, 44);
    [continueBuyBtn addTarget:self action:@selector(continueBuyAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:continueBuyBtn];
    
    //圈起来的正方形框
    kuangView = [[UIView alloc] initWithFrame:ccr(x, _headerView.height-5, kDeviceWidth-2*x, 0)];
    kuangView.userInteractionEnabled = NO;
    kuangView.layer.borderWidth = 1.0;
    kuangView.layer.borderColor = [YXBTool colorWithHexString:@"#d9d9d9"].CGColor;
    [_tableView addSubview:kuangView];

}

-(void)continueBuyAction:(UIButton *)sender
{
    NSLog(@"继续购买");
    
    TreasureMoneyProductViewController *TMPVC = [[TreasureMoneyProductViewController alloc] init];
    TMPVC.regularID = 0;//[_model[index][@"regularID"] integerValue];
    [self.navigationController pushViewController:TMPVC animated:YES];

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count = 1;
    if (_dataArray != nil) {
        count = [_dataArray count];

    }
    return (count == 0 ? 1 : count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellIdenti";
    FundDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == Nil) {
        cell = [[FundDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.clipsToBounds = YES;
    if (indexPath.row < [_dataArray count]) {
        
        KeyValueModel *model = _dataArray[indexPath.row];
        cell.detailModel = _model;
        cell.model = model;
        cell.delegate = self;
    }
//    cell.model = debtModel;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view  = [[UIView alloc] initWithFrame:ccr(0, 0, kDeviceWidth, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    FundDetailCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    if ([self isShowTips:indexPath]) {
        return 35+ LabelHeight *[_model.iProfitUserBuyDetailTips count];
    }
    return 35;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)handleDataArrayWithModel
{
    if (_model != nil) {
        
        if (_dataArray != nil && [_dataArray count] > 0) {
            [_dataArray removeAllObjects];
        }
        else
        {
            self.dataArray = [NSMutableArray array];
        }

        
        NSArray *keyArray = @[@"产品类型:",@"购买金额:",@"购买日期:",@"理财周期:",@"购买笔数:",@"结束日期:"];
        
        NSArray *valueArray = @[_model.name,[NSString stringWithFormat:@"%@元",_model.buyMoney],_model.startTime,_model.time,[NSString stringWithFormat:@"%ld笔",(long)[_model.iProfitUserBuyDetailTips count]],_model.endTime];
        for (int i = 0; i < 6; i ++) {
            KeyValueModel *model = [[KeyValueModel alloc] init];
            model.key = keyArray[i];
            model.value = valueArray[i];
            [self.dataArray addObject:model];
        }

    }
    
}

-(void)refreshDataWithBottom:(BOOL)hasBottom
{
    _hasBottom = hasBottom;
    [_tableView reloadData];
    CGSize size = [self preferredContentSize];
    
    kuangView.height = size.height - _headerView.height - 10;
}

-(CGSize)preferredContentSize
{
    [self.tableView layoutIfNeeded];
    return self.tableView.contentSize;
}

//是否显示详情
-(BOOL)isShowTips:(NSIndexPath *)indexPath
{
    BOOL isShow = NO;
    if (_model != nil && indexPath.row == 4 && _hasBottom)
    {
        isShow = YES;
    }
    
    return isShow;
}

@end
