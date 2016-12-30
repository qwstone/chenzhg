//
//  TreasureMoneyNewViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/9/22.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TreasureMoneyNewViewController.h"
#import "TreasureMoneyNewHeaderView.h"
#import "SelectView.h"
#import "ProfitManagerV2.h"
#import "TreasureMoneyNewCell.h"
#import "ProfitHomeDataV2.h"
#import "ShouYiMingXiViewController.h"
#import "QCCarouselItem.h"
#import "iCarousel.h"
#import "PayHomeViewController.h"
#import "MyzhangbenViewController.h"
@interface TreasureMoneyNewViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,TreasureMoneyNewCellDelegate>
@property (nonatomic,strong)ProfitHomeDataV2 *data;
@property (nonatomic,strong)QCBaseTableView *tableView;
@property (nonatomic,strong)TreasureMoneyNewHeaderView  *headerView;

@end

#define headerViewHight     (kDeviceWidth/640*321)
@implementation TreasureMoneyNewViewController
- (void)dealloc {
    NSLog(@"宝赚钱 dealloc");
}

- (void)leftClicked {
    if (_timerManager != nil) {
        [_timerManager stop];
    }
    [super leftClicked];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"宝·赚钱";
    [self setBackView];
    [self createNavView];
    [self createView];
    
}

//导航栏视图
- (void)createNavView {
    [self setNavigationButtonItrmWithiamge:@"newbzq-user-icon" withRightOrleft:@"right" withtargrt:self withAction:@selector(userAction)];
}
//导航栏按钮点击事件
- (void)userAction {
//    ShouYiMingXiViewController *mingxi = [[ShouYiMingXiViewController alloc] init];
//    [self.navigationController pushViewController:mingxi animated:YES];
    MyzhangbenViewController *zhangben=[[MyzhangbenViewController alloc]init];
    [self.navigationController pushViewController:zhangben animated:YES];
    
}



//UI
- (void)createView {
    self.view.backgroundColor = rgb(239, 239, 239, 1);
    _tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    _tableView.delaysContentTouches =NO;
    _headerView = [[TreasureMoneyNewHeaderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, headerViewHight)];
    _tableView.tableHeaderView = _headerView;

}

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self httpLoading];
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return kDeviceWidth/375*380;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cells";
    TreasureMoneyNewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TreasureMoneyNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    cell.model = self.data;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


//#pragma celldelegate
//- (void)TreasureMoneyNewCell:(NSInteger)index {
//    if (index == 0) {
//        
//    }else if (index == 1){
//    
//    }
//}

-(void)chongzhi
{
    PayHomeViewController *controller = [[PayHomeViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{     
    return 0;
}


#pragma mark -----------------------------------------------Http
- (void)httpLoading
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak TreasureMoneyNewViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        [this httpLoadParams:assginHtttperator];
    } complete:^(ProfitHomeDataV2* r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    ProfitManagerV2* manager = (ProfitManagerV2*)  [assginHtttperator getAopInstance:[ProfitManagerV2 class] returnValue:[ProfitHomeDataV2 class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [manager getProfitHomeData:userModel.user.yxbToken];


}
- (void)httpLoadComplete:(ProfitHomeDataV2 *)r{
    
            if (r.errCode == 0) {
                self.data = r;
                self.headerView.model = r;
    
            }else{
                NSString * string = r.errString;
                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
    
            [self.tableView reloadDeals];
            [self.tableView reloadData];

}
- (void)setData:(ProfitHomeDataV2 *)data {
    if (_data != data) {
        _data = data;
        if (_timerManager == nil) {
            [self createTimer];
        }
    }
}

#pragma
- (void)createTimer {
    _timerManager = [[CPBTimerManager alloc]initWithTimeInterval:2 userInfo:Nil repeats:YES];
    _timerManager.delegate = self;
}

#pragma mark -- CPBTimerDelegate
- (void)CPBTimerManagerAction:(CPBTimerManager *)timer {
//    NSLog(@"定时器方法 - indexPath.row:%ld",(long)postion);
    NSLog(@"宝赚钱 - 定时器 Ing");
    postion++;
    if (postion >= self.data.iProfitBannerData.count-1) {
        postion = 0;
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:postion inSection:0];
        [self.headerView.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        postion++;
        NSIndexPath *scrollIndexPath1 = [NSIndexPath indexPathForRow:postion inSection:0];
        [self.headerView.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath1 atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }else {
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:postion inSection:0];
        [self.headerView.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    
}
@end
