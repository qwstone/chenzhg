//
//  MoreInformationViewController.m
//  YOUXINBAO
//
//  Created by zjp on 16/1/30.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MoreInformationViewController.h"
#import "MoreInformationHeaderView.h"
#import "LoanManagerV10.h"
#import "MoreInfomationCell.h"
#import "MyLoanViewController.h"
#import "YXBTool.h"
#import "LoanFundDetail.h"
#import "MoreInfoTableBGView.h"

//@class MyLoanViewController;
#define MoreInfoRightURL [NSString stringWithFormat:@"%@webView/helpcenter/purse-rule.jsp?a=1",YXB_IP_address_web]
@interface MoreInformationViewController ()
{

    int page;
    MoreInformationHeaderView *headerView;
    MoreInfoTableBGView * tableBG;
    UIImageView *nullImg;
    UIImageView *wanimage;
    UIView *foot;
}

@end

@implementation MoreInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftView];
    [self createNavBar];
    self.title=@"更多信息";
   
    self.view.backgroundColor = [YXBTool colorWithHexString:@"#ededed"];

    //header
    headerView = [[MoreInformationHeaderView alloc] initWithFrame:CGRectMake(15, 15, kDeviceWidth-30, kDeviceWidth/640*325)];
    headerView.backgroundColor = [YXBTool colorWithHexString:@"#ededed"];
    [self.view addSubview:headerView];
    
    
    //tableviewBG
    tableBG = [[MoreInfoTableBGView alloc] initWithFrame:CGRectMake(15, headerView.bottom + 15, kDeviceWidth-30, kDeviceHeight - 64 - headerView.bottom - 30 - kDeviceWidth/640*85)];
    tableBG.layer.borderColor = [YXBTool colorWithHexString:@"#dadada"].CGColor;
    tableBG.layer.borderWidth = 1;
    tableBG.layer.cornerRadius = 6;
    tableBG.layer.masksToBounds = YES;
    tableBG.backgroundColor = [YXBTool colorWithHexString:@"#ffffff"];
    [self.view addSubview:tableBG];
    
    
    //tableview
    _tableView=[[QCBaseTableView alloc]initWithFrame:CGRectMake(0, kDeviceWidth/640*85, kDeviceWidth-30, tableBG.size.height - kDeviceWidth/640*85)style:UITableViewStylePlain refreshFooter:NO];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.showsVerticalScrollIndicator=NO;
    [tableBG addSubview:_tableView];
    
    
    
    
    _dataArray=[NSMutableArray new];
    
    
    foot=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableView.width, 200)];
    nullImg=[[UIImageView alloc]initWithFrame:CGRectMake((_tableView.width-210)/2, 40, 210, 90)];
    nullImg.image=[UIImage imageNamed:@"morexx_weizhang"];
    [foot addSubview:nullImg];
   
    
   wanimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _tableView.width, 9)];
   // wanimage.image=[UIImage imageNamed:@"morexx-foot"];
    
}
-(void)leftClicked{
  
    NSArray *arr = self.navigationController.viewControllers;
    MyLoanViewController *myvc=nil;
    for (QCBaseViewController *vc in arr) {
        if ([vc isKindOfClass:[MyLoanViewController class]]) {
             myvc= (MyLoanViewController *)vc;
            myvc.isFromVideo = NO;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
  
}
- (void)createNavBar {
  
    [self setNavigationButtonItrmWithiamge:@"MoreInfoRight3" withRightOrleft:@"right" withtargrt:self withAction:@selector(navkefurightAction)];
}
-(void)navkefurightAction {
    NSString *url = [YXBTool getURL:MoreInfoRightURL params:nil];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"分期规则"];
}
#pragma mark -----------------------------------------------HttpDownLoad

- (void)httpDowloadWithListStyle
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak MoreInformationViewController *this = self;
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
        
    } complete:^(LoanMoreInfo * r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    LoanManagerV10 *_activityM = (LoanManagerV10 *)[httpOperation getAopInstance:[LoanManagerV10 class] returnValue:[LoanMoreInfo class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {
        
        
        [_activityM getLoanMoreInfoV2:userToken loanID:_loanId pageNo:page];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
}
//请求完成
-(void)httpLoadComplete:(LoanMoreInfo *)r{
    
    [self.tableView reloadDeals];
    if (r.errCode == 0) {
        headerView.model=r;
        tableBG.loanId = _detail.lastLoanId;
        //发送成功
        if (r.loanFundDetails.count>0) {
            [self.dataArray addObjectsFromArray:r.loanFundDetails];
        }
    }
    else{
        [self.dataArray removeAllObjects];
        
    }
    
    if (r.loanFundDetails.count != 0 && r.loanFundDetails.count%8 == 0) {
        self.tableView.hasFooter = YES;
    }
    else {
        self.tableView.hasFooter = NO;
    }
    
    if(r.loanFundDetails.count&&r.loanFundDetails.count%8!=0){
        UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
        footer.text = @"已加载所有数据";
        footer.textColor = rgb(160, 160, 160, 1);
        footer.font = [UIFont systemFontOfSize:15];
        footer.textAlignment = NSTextAlignmentCenter;
        self.tableView.tableFooterView = footer;
    }
    else{
        self.tableView.tableFooterView = nil;
    }
    [self.tableView reloadData];
    
    
    
    
//    if (r.errCode==0) {
//
//        self.detail=r;
//        headerView.model=r;
//        tableBG.loanId = _detail.lastLoanId;
//        self.dataArray = _detail.loanFundDetails;
//        [self.tableView reloadData];
//        [self.tableView reloadDeals];
//        
//    }
   
}


#pragma mark  --------------------------- refresh
//下拉刷新

- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [_dataArray removeAllObjects];
    page = MessageCenterPageNOStart;
    [self httpDowloadWithListStyle];
    
}
//加载更多
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        if (_dataArray.count%8==0) {
            page ++;
            [self httpDowloadWithListStyle];
        }else {
            
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kDeviceWidth/640*85;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"MoreInfomationCell";
    MoreInfomationCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MoreInfomationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(_dataArray.count > 0){
        LoanFundDetail *model=_dataArray[indexPath.row];
        cell.model=model;
        cell.index = indexPath.row;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
