//
//  AmortizationHomeViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/5/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AmortizationHomeViewController.h"
#import "QCBaseTableView.h"
#import "AmortizationTableViewCell.h"
#import "AmortizationHeaderView.h"
#import "CommerceManager.h"
#import "MyOrderListController.h"
#import "AmortizationCategoryViewController.h"
#import "QCLoginOneViewController.h"
#import "AppDelegate.h"
//
#define GoodsDetailBaseUrl [NSString stringWithFormat:@"%@webView/goods/good.jsp?a=1",YXB_IP_ADRESS]

@interface AmortizationHomeViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,AmortizationHeaderViewDelegate>

@property (nonatomic,strong) QCBaseTableView *tableView;
@property (nonatomic,strong)AmortizationHeaderView *header;

@end

@implementation AmortizationHomeViewController
-(void)dealloc{
    NSLog(@"AmortizationHomeViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"信·分期"];
    self.view.backgroundColor = rgb(239, 239, 239, 1);
    
    //发起AA
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 30);
    [btn addTarget:self action:@selector(indentAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:@"我的订单" forState:UIControlStateNormal];
    UIBarButtonItem *indentItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = indentItem;

    
    [self initViews];
//    [self.tableView reloadDeals];
}

- (void)initViews {
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = rgb(221, 221, 221, 1);
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
    
    _header = [[AmortizationHeaderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAmortizationHeaderHeight)];
    _header.delegate = self;
    _tableView.tableHeaderView = _header;

}

#pragma mark  -- UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 45)];
        bgView.backgroundColor = self.view.backgroundColor;
        UILabel *partyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 70, 15)];
//            partyLabel.center = bgView.center;
        partyLabel.text = @"人气商品";
        partyLabel.textAlignment = NSTextAlignmentCenter;
        partyLabel.backgroundColor = [UIColor clearColor];
        partyLabel.textColor = rgb(130, 130, 130, 1);
        partyLabel.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:partyLabel];

        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0,0, kDeviceWidth, 0.5)];
        line1.backgroundColor = rgb(209, 207, 209, 1);
        [bgView addSubview:line1];

        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, kDeviceWidth, 0.5)];
        line2.backgroundColor = rgb(209, 207, 209, 1);
        [bgView addSubview:line2];
        return bgView;
        
    }
    return Nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 45;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homePageData.goodsResumeList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AmortizationCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    AmortizationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AmortizationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = self.view.backgroundColor;
        
    }
    cell.data = [self.homePageData.goodsResumeList objectAtIndex:indexPath.row];
    
       
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsResume *resume = [self.homePageData.goodsResumeList objectAtIndex:indexPath.row];
    
    //    NSString *url = [YXBTool getURL:GoodsDetailBaseUrl params:[NSString stringWithFormat:@"pid=%ld",resume.commerceID]];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",(long)resume.commerceID] forKey:@"pid"];
    NSString *url = [YXBTool getURL:GoodsDetailBaseUrl params:[YXBTool jsonEqualWithDic:dic]];
    
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"商品详情"];
}

#pragma mark - Http
- (void)httpLoad {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];

    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AmortizationHomeViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this stopDefaultAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(CommerceHomePageData* r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];

}
//请求出错
-(void)httpLoadError:(THttpOperatorErrorCode)error{
    if (error == EHttp_Operator_Failed) {
        //服务器挂了
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        [self.tableView reloadDeals];
    }
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    CommerceManager *_commerceM = (CommerceManager *)[httpOperation getAopInstance:[CommerceManager class] returnValue:[CommerceHomePageData class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    //        if (style == L_myList) {
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {
        [_commerceM getHomePageData:userToken];
        
    }
    else
    {
        //            未登录可使用
        [_commerceM getHomePageData:@""];
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        //            [alert show];
    }

}
//请求完成
-(void)httpLoadComplete:(CommerceHomePageData *)r{
    if (r.errCode == 0) {
        if (r != nil) {
            self.header.data = r;
            self.homePageData = r;
        }
        
    }else  {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
    
    [self.tableView reloadDeals];
    [self.tableView reloadData];
}
#pragma mark - AmortizationHeaderView delegate
- (void)amortizationHeaderView:(AmortizationHeaderView *)view categoryButtonDidClickAtIndex:(NSInteger)index {
//    1, 时尚电子 .2学习加油站 。3， 美妆护肤。 4，时尚潮品。
//index : 1.时尚电子 2美妆护肤 3时尚潮品 4学习加油站
    AmortizationCategoryViewController *category = [[AmortizationCategoryViewController alloc] init];
    switch (index) {
        case 1:
            category.commerceCategory = CommerceCategoryProduce;
            break;
        case 2:
            category.commerceCategory = CommerceCategoryPainting;
            break;
        case 3:
            category.commerceCategory = CommerceCategoryFashion;
            break;
        case 4:
            category.commerceCategory = CommerceCategoryStudy;
            break;
    }
    
    [self.navigationController pushViewController:category animated:YES];
}

- (void)amortizationHeaderView:(AmortizationHeaderView *)view scrollViewDidClickAtPage:(NSInteger)page {
    CommerceBanner *banner = [self.header.data.commerceBannerList objectAtIndex:page];
    [YXBTool typeToJump:banner.type info:banner.val];
}

//秒杀点击事件
- (void)amortizationHeaderViewSecondsClicked
{
    NSString *url = @"webView/goods/seckill.jsp?t=1";
    [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:url params:nil] hasTopBar:NO titleName:@"商品秒杀"];
}


#pragma mark - QCBaseTableView delegate
//下拉刷新
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self httpLoad];
}

- (void)leftClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10010) {
        if (buttonIndex == 1) {
            [self toLogin];
        }
    }
}

- (void)toLogin {
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
}

- (void)indentAction:(UIButton *)button {
    //我的订单
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有登录，请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alterView.tag = 10010;
        [alterView show];
        return;
    }
    
    MyOrderListController *orderListController=[[MyOrderListController alloc]init];
    [self.navigationController pushViewController:orderListController animated:YES];
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
