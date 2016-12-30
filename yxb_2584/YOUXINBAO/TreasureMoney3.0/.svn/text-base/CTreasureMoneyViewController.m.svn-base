//
//  CTreasureMoneyViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/12/14.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CTreasureMoneyViewController.h"
#import "CTreasureMoneyHeaderView.h"
#import "TreasureMoneyNewCell.h"
#import "ProfitManagerV3.h"
#import "ProfitHomeDataV3.h"
#import "CTreasureMoneyNewCell.h"
#import "MyzhangbenViewController.h"
@interface CTreasureMoneyViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,CTreasureMoneyNewCellDelegate>
@property (nonatomic,strong)ProfitHomeDataV3 *data;
@property (nonatomic,strong)QCBaseTableView *tableView;
@property (nonatomic,strong)CTreasureMoneyHeaderView  *headerView;

@end

@implementation CTreasureMoneyViewController
- (void)dealloc {
    if (_timerManager != nil) {
        [_timerManager stop];
    }
    NSLog(@"宝赚钱 dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    
    [self createView];
    
}

#pragma mark -----------------------------------------------Http
- (void)httpLoading
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak CTreasureMoneyViewController *this = self;
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
    ProfitManagerV3* manager = (ProfitManagerV3*)  [assginHtttperator getAopInstance:[ProfitManagerV3 class] returnValue:[ProfitHomeDataV3 class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [manager getProfitHomeData:userModel.user.yxbToken];
    
    
}
- (void)httpLoadComplete:(ProfitHomeDataV3 *)r{
    
    if (r.errCode == 0) {
        self.data = r;
        self.headerView.model = r;
        if (_timerManager == nil) {
            [self createTimer];            
        }

        
    }else{
        NSString * string = r.errString;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    
    [self.tableView reloadDeals];
    [self.tableView reloadData];
    
}


- (void) createNav {
    [self setBackView];
    
    [self setTitle:@"宝·赚钱"];
    
    [self setNavigationButtonItrmWithiamge:@"zb" withRightOrleft:@"right" withtargrt:self withAction:@selector(NavRightAction)];
}
#pragma mark --- NavItemAcion 导航栏点击事件
- (void)NavRightAction {
    MyzhangbenViewController *zhangben=[[MyzhangbenViewController alloc]init];
    [self.navigationController pushViewController:zhangben animated:YES];
}


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
    _headerView = [[CTreasureMoneyHeaderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/750*430)];
    _tableView.tableHeaderView = _headerView;
}

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self httpLoading];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//}
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
    CTreasureMoneyNewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CTreasureMoneyNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    cell.model = self.data;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
