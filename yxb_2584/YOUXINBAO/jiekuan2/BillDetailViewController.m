//
//  BillDetailViewController.m
//  YOUXINBAO
//
//  Created by Walice on 16/2/1.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BillDetailViewController.h"
#import "IOUDetailsHeaderView.h"
#import "LoanManagerV10.h"
#import "BillDetailCell.h"
#import "LoanMoreInfoDetail.h"
#import "QuGongzhengViewController.h"

@interface BillDetailViewController ()
{
    
    int page;
    IOUDetailsHeaderView *view;
}

@end

@implementation BillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"借条详情";
    _tableView=[[QCBaseTableView alloc]initWithFrame:CGRectMake(15, 13, kDeviceWidth-30, kDeviceHeight-64-15)style:UITableViewStylePlain refreshFooter:NO];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_tableView];
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _tableView.width, 9)];
    image.image=[UIImage imageNamed:@"morexx-foot"];
    _tableView.tableFooterView=image;
    
    view = [[[NSBundle mainBundle] loadNibNamed:@"IOUDetailsHeaderView" owner:self options:nil] lastObject];;
    view.delegate=self;
    view.frame = CGRectMake(0, 0, kDeviceWidth-30, 313);
    view.clipsToBounds = YES;
    _tableView.tableHeaderView=view;
    
    _dataArray=[NSMutableArray new];
    _gongzhang=[[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth-30-63, 270, 63, 61)];
    _gongzhang.image=[UIImage imageNamed:@"jiekuan2_CA"];
    [_tableView addSubview:_gongzhang];
}
#pragma mark -----------------------------------------------HttpDownLoad
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self httpDowloadWithListStyle];

}
- (void)httpDowloadWithListStyle
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak BillDetailViewController *this = self;
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
        
    } complete:^(LoanCertificate * r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    LoanManagerV10 *_activityM = (LoanManagerV10 *)[httpOperation getAopInstance:[LoanManagerV10 class] returnValue:[LoanCertificate class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    //如果是从首页跳转过来  则调用PublicLoanCertificate接口
    if (_isHideInfo) {
        [view.qugongzheng setImage:[UIImage imageNamed:@"xq_gongzheng_gray"] forState:UIControlStateNormal];
        view.qugongzheng.enabled=NO;
        [_activityM getPublicLoanCertificate:_encryptionID];
    }
    else{
        [view.qugongzheng setImage:[UIImage imageNamed:@"xq_gongzheng_red"] forState:UIControlStateNormal];
        [view.qugongzheng setImage:[UIImage imageNamed:@"xq_gongzheng_red"] forState:UIControlStateHighlighted];
        NSString *userToken = userModel.user.yxbToken;
        if ((userToken != nil) && [userToken length] > 0)
        {
            
            [_activityM getLoanCertificate:userToken loanID:self.loanID];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }

    }
    
    
}
//请求完成
-(void)httpLoadComplete:(LoanCertificate *)r{
    if (r.errCode==0) {

        self.detail=r;
        view.model=r;
        //如果刷新的是第一页,则需要将之前刷新的移除掉,不然第一页的数据会反复出
        self.dataArray=_detail.participants;
        [self.tableView reloadData];
        [self.tableView reloadDeals];
        
    }
    else{
        //提示信息
        [ProgressHUD showErrorWithStatus:r.errString];
        [self.tableView reloadDeals];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"BillDetailCell";
    BillDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        
        cell = [[BillDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.index=indexPath.row+1;
    }
    if(_dataArray.count > 0){
        LoanMoreInfoDetail *model=_dataArray[indexPath.row];
        cell.model=model;
      
    }
    return cell;
}
- (void)buttonDidClick{
    [YXBTool jumpSafariWithUrl:_detail.acUrl];
//    QuGongzhengViewController *qugongzheng=[[QuGongzhengViewController alloc]init];
//    qugongzheng.loanId=self.loanID;
//    [self.navigationController pushViewController:qugongzheng animated:YES];

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
