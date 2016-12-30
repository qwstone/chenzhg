//
//  BaoHongLiViewController.m
//  YOUXINBAO
//
//  Created by zjp on 16/1/28.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BaoHongLiViewController.h"
#import "BaoHongLiView.h"
#import "ProfitHomeDataV3.h"
#import "ProfitManagerV3.h"
#import "YXBTool.h"
#import "MyzhangbenViewController.h"
#import "UIScrollView+TwitterCover.h"
#import "ShouYiMingXiViewController.h"
#import "QCHomeDataManager.h"
@interface BaoHongLiViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate>
@property (nonatomic,strong)QCBaseTableView *tableView;
@property (nonatomic,strong)BaoHongLiView   *baohongliview;
@property(nonatomic,strong)HttpOperator *iHttpOperator;
@property(nonatomic,strong)ProfitHomeDataV3 *data;
@end

@implementation BaoHongLiViewController
- (void)dealloc {
    if (_timerManager != nil) {
        [_timerManager stop];
    }
    NSLog(@"宝赚钱 dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    [self setTitle:@"签到红包"];
    [self createView];
}

- (void)createView {
    [self setNavigationButtonItrmWithiamge:@"zb" withRightOrleft:@"right" withtargrt:self withAction:@selector(NavRightAction)];
    
    self.view.backgroundColor = rgb(239, 239, 239, 1);
    _tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    _tableView.delaysContentTouches =NO;
    _baohongliview = [[BaoHongLiView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/640*1030)];
//    _baohongliview.backgroundColor = [UIColor brownColor];
    _tableView.tableHeaderView = _baohongliview;


}
#pragma mark --- NavItemAcion 导航栏点击事件
- (void)NavRightAction {
    ShouYiMingXiViewController *shouyi=[[ShouYiMingXiViewController alloc]init];
    [self.navigationController pushViewController:shouyi
                                         animated:YES];
}
#pragma mark -----------------------------------------------Http
- (void)httpLoading
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak BaoHongLiViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        [this httpLoadParams:assginHtttperator];
    } complete:^(ProfitHomeDataV3* r, int taskid) {
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
        self.baohongliview.model = r;
        [QCHomeDataManager sharedInstance].zuorishouyi = r.yestodayMoney;
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

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self httpLoading];
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
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
        [self.baohongliview.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        postion++;
        NSIndexPath *scrollIndexPath1 = [NSIndexPath indexPathForRow:postion inSection:0];
        [self.baohongliview.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath1 atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }else {
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:postion inSection:0];
        [self.baohongliview.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
