//
//  QCCollectMoneyListController.m
//  YOUXINBAO
//
//  Created by Walice on 15/6/18.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCCollectMoneyListController.h"
#import "BonusListCell.h"
#import "AverageManager.h"
#import "GatheringRecord.h"
#import "AAReceivablesDetailViewController.h"
#define MessageCenterPageNOStart 1

@interface QCCollectMoneyListController ()
{
    NSInteger page;
}

@end

@implementation QCCollectMoneyListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"收款记录"];
    [self _initViews];
    // Do any additional setup after loading the view.
}

- (void)_initViews{
    _dataArray=[NSMutableArray array];
    
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    
    [self.view addSubview:_tableView];


}
#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    page=MessageCenterPageNOStart;
    [self httpDowloadWithListStyle];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.tableView.isRefresh && _dataArray.count%20 == 0 && self.tableView.hasFooter == YES) {
        page ++;
        [self httpDowloadWithListStyle];
    }else {
               // [self reloadDeals];
    }
}


#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpDowloadWithListStyle
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCCollectMoneyListController *this = self;
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
        [this httpLoadParams:assginHtttperator];
    } complete:^(NSSkyArray * r, int taskid) {

        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    AverageManager *manager = (AverageManager *)[assginHtttperator getAopInstance:[AverageManager class] returnValue:[NSSkyArray class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    //        if (style == L_myList) {
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {
        
        [manager getGatheringRecordList:userToken pageNum:page];
        
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    

}
- (void)httpLoadComplete:(NSSkyArray *)r{
    
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.tableView.hasFooter = YES;
    }else {
        //数据加载不足一页的事后,将加载更多取消掉
        self.tableView.hasFooter = NO;
    }
    
    [self.tableView reloadDeals];
    
    //判断如果没有数据的时候,显示的图片
    if (page==1&&r.iArray.count==0) {
        
        UILabel *label= [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2-40, 0, kDeviceWidth, _tableView.height)];
        label.text=@"暂无数据";
        label.contentMode=UIViewContentModeCenter;
        label.textColor=[UIColor blueColor];
        label.backgroundColor=[UIColor clearColor];
        self.tableView.tableFooterView=label;
        [self.view addSubview:label];
        self.tableView.tableFooterView=label;
        return ;
    }
    
    self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    
    
    //如果刷新的是第一页,则需要将之前刷新的移除掉,不然第一页的数据会反复出现
    if (page==MessageCenterPageNOStart) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:r.iArray];
    [self.tableView reloadData];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    BonusListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[BonusListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isCollectMoney=YES;
        
    }


    cell.collectModel=_dataArray[indexPath.row];
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GatheringRecord *model = [_dataArray objectAtIndex:indexPath.row];
    AAReceivablesDetailViewController *controller = [[AAReceivablesDetailViewController alloc] init];
//    controller.model = model;
    controller.record = model.recordId;
    [self.navigationController pushViewController:controller animated:YES];
    
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
