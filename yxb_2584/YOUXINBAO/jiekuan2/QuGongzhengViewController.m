//
//  QuGongzhengViewController.m
//  YOUXINBAO
//
//  Created by Walice on 16/3/23.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QuGongzhengViewController.h"
#import "NSSkyArray.h"
#import "QuGongzhengCell.h"
#import "LoanManagerV10.h"
#import "YXBTool.h"
#define MessageCenterPageNOStart 1

@interface QuGongzhengViewController ()
@property (nonatomic,weak)UILabel *noRecordLabel;
@end

@implementation QuGongzhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page=MessageCenterPageNOStart;
    self.title=@"保全证书";
    self.dataArray=[NSMutableArray new];
    [self initView];
    
}
- (void)initView{
 
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(10, 10, kDeviceWidth-20, kDeviceHeight-64-10) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.refreshDelegate = self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UILabel *label= [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2-40, 0, kDeviceWidth, _tableView.height)];
    label.text=@"暂无内容";
    label.contentMode=UIViewContentModeCenter;
    label.textColor=[UIColor blueColor];
    _noRecordLabel = label;
    [self.view addSubview:_noRecordLabel];
}
#pragma mark - 数据请求
- (void)httpDowloadWithListStyle
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QuGongzhengViewController *this = self;
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
    LoanManagerV10 *_activityM = (LoanManagerV10 *)[httpOperation getAopInstance:[LoanManagerV10 class] returnValue:[NSSkyArray class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {
        
        [_activityM getPreserveCer:userToken pageNum:page loanID:_loanId];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
}
//请求完成
-(void)httpLoadComplete:(NSSkyArray *)r{
    [self.tableView reloadDeals];
   
    if (r.errCode == 0) {
        //发送成功
        if (r.iArray.count>0) {
            [self.dataArray addObjectsFromArray:r.iArray];
        }
        _noRecordLabel.hidden = YES;
        if(page==1&&r.iArray.count==0){//无数据
            
            _noRecordLabel.hidden = NO;
            
            return;
        }
        if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
            self.tableView.hasFooter = YES;
        }else {
            self.tableView.hasFooter = NO;
        }
        if(r.iArray.count&&r.iArray.count%20!=0){
            UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
            footer.text = @"所有数据都在这了";
            footer.textColor = rgb(160, 160, 160, 1);
            footer.font = [UIFont systemFontOfSize:15];
            footer.textAlignment = NSTextAlignmentCenter;
            
            self.tableView.tableFooterView = footer;
        }
        [self.tableView reloadData];
    }else{
        [self.dataArray removeAllObjects];
        [ProgressHUD showErrorWithStatus:r.errString];
    }
    
    

}

#pragma mark  --------------------------- refresh
//下拉刷新

- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
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
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"cellID";
    QuGongzhengCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[QuGongzhengCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
  
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArray.count) {
        cell.model =[_dataArray objectAtIndex:indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 160;
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
