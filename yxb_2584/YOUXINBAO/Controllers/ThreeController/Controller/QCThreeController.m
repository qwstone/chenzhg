//
//  QCThreeController.m
//  YOUXINBAO
//
//  Created by zjp on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCThreeController.h"
#import "QCBaseTableView.h"
#import "QCMessageCell.h"
#import "AppUserManager.h"
#import "QCUtils.h"
#import "TResultSet.h"
#import "SetMessageReadManager.h"
#import "MsgCenterMgr+Public.h"
#import "HeaderView.h"


#define MessageCenterPageNOStart 1
@interface QCThreeController ()<HeaderViewDelegate>
{
    NSInteger tag;
    UILabel *selectedLabel;
    
}


@property (nonatomic,strong)QCBaseTableView *tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation QCThreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    page = MessageCenterPageNOStart;
    [self setTitle:@"消息中心"];
    _dataArray=[NSMutableArray array];
    [self _createUI];
}

- (void)_createUI{
    
    
    self.headerView=[[HeaderView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 48) WithArray:[NSArray arrayWithObjects:@"全部",@"未读",@"已读",@"系统", nil]];
    
    [_headerView setHeaderViewColorsWithUnSelectedBgColor:rgb(248, 248, 248, 1) selectedBgColor:rgb(248, 248, 248, 1) unSelectedTextColor:rgb(97, 97, 97, 1.0) selectedTextColor:rgb(217, 30, 61, 1.0)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _headerView.layer.borderColor = rgb(218, 218, 218, 1.0).CGColor;
    _headerView.delegate = self;
    _headerView.layer.borderWidth = 1.0;
    //_headerView.selectedIndex = _selectedIndex;
    [self.view addSubview:_headerView];
    
    
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, _headerView.bottom, kDeviceWidth, kDeviceHeight-64-48-49) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark -----------------------------------------------HttpDownLoad

- (void)httpDowloadWithListStyle
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCThreeController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            //            [this.tableView reloadDeals];
            [ProgressHUD dismiss];
        }
        
    } param:^(NSString *s) {
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
        
    } complete:^(NSSkyArray * r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    AppUserManager *_activityM = (AppUserManager *)[httpOperation getAopInstance:[AppUserManager class] returnValue:[NSSkyArray class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {
        
        [_activityM getMessageCenterDataV2:userModel.user.yxbToken pageNum:page messageType:self.headerView.selectedIndex];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
}
//请求完成
-(void)httpLoadComplete:(NSSkyArray *)r{
    if (r.errCode==0) {
        
        NSInteger num = [r.errString integerValue];
        [[MsgCenterMgr sharedInstance] setNewMessageNumber:num];
        
        if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
            self.tableView.hasFooter = YES;
        }else {
            //数据加载不足一页的事后,将加载更多取消掉
            self.tableView.hasFooter = NO;
        }
        
        [self.tableView reloadDeals];
        
        //判断如果没有数据的时候,显示的图片
        if (page==1&&r.iArray.count==0) {
            
            _label= [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2-40, 0, kDeviceWidth, _tableView.height)];
            _label.text=@"暂无消息";
            _label.contentMode=UIViewContentModeCenter;
            _label.textColor=[UIColor blueColor];
            //_label.backgroundColor=[UIColor redColor];
            
            // return ;
        }
        
        
        self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
        
        //如果刷新的是第一页,则需要将之前刷新的移除掉,不然第一页的数据会反复出现
        if (page==MessageCenterPageNOStart) {
            [self.dataArray removeAllObjects];
        }
        
        [self.dataArray addObjectsFromArray:r.iArray];
        if (page==1&&r.iArray.count==0) {
            _tableView.tableFooterView=_label;
        }
        else{
            
            _tableView.tableFooterView.hidden=YES;
        }
        
        [self.tableView reloadData];
        
    }
    
}
#pragma -mark HeaderViewDelegate
-(void)headerViewSelectedIndex:(NSInteger)index
{
    //[ProgressHUD showWithStatus:@"正在加载..." maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeLongBottom];
    page = MessageCenterPageNOStart;
    [self.dataArray removeAllObjects];
    //        [_tableView reloadDeals];
    [self QCBaseTableViewDidPullDownRefreshed:_tableView];
}



#pragma mark  --------------------------- refresh
//下拉刷新

- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    //    [self.dataArray removeAllObjects];
    page = MessageCenterPageNOStart;
    [self httpDowloadWithListStyle];
    
}
//加载更多
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        if (_dataArray.count%20==0) {
            page ++;
            [self httpDowloadWithListStyle];
        }else {
            
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
/*
 //viewForHeader与heightForHeader搭配使用可以调整section的高度
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
 UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 20)];
 return view;
 
 }
 
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
 
 return 20;
 
 }
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"messageCell";
    QCMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[QCMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(_dataArray.count > 0){
        cell.model = [_dataArray objectAtIndex:indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (_dataArray.count>0) {
        MessageCenterItem *model=[_dataArray objectAtIndex:indexPath.row];
        //    NSLog(@"%@",model.type);
        [[SetMessageReadManager sharedInstance]setMessageRead:model.messageID];
        self.hidesBottomBarWhenPushed = YES;
        [YXBTool typeToJump:model.type info:model.val];
        
        
        if ([model.hasRead isEqualToString:@"0"]) {
            [[MsgCenterMgr sharedInstance] removeMessgae];
        }
        
        
        model.hasRead = @"1";
    }
    //红点消失
    QCMessageCell *cell =(QCMessageCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.img.hidden=YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.hidesBottomBarWhenPushed = NO;
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.isLogin == YES) {
    }else {
//        [self toLogin];
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
