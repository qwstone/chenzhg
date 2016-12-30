//
//  AmortizationHomeNewViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/7/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AmortizationHomeNewViewController.h"
#import "QCBaseTableView.h"
#import "AmortizationHomeProductCell.h"
#import "CommerceManager.h"
#import "AmortizationHomeProductCell.h"
#import "QCCycleScrollView.h"
#import "YXBTool.h"
#import "CommerceBanner.h"
#import "UIImageView+WebCache.h"
#import "AmortizationCategoryViewController.h"
#import "MyOrderListController.h"
#import "UIButton+WebCache.h"
#import "AmortizationHomeFirstCell.h"
#import "AmortizationCategoryViewController.h"
#import "LoanOrRepayViewController.h"
#import "QCLoginOneViewController.h"
#import "AmortizationHomeSecondCell.h"

#define GoodsDetailBaseUrl [NSString stringWithFormat:@"%@webView/goods/good.jsp?a=1",YXB_IP_ADRESS]

@interface AmortizationHomeNewViewController ()<UITableViewDelegate,UITableViewDataSource,QCBaseTableViewDelegate,QCCycleScrollViewDatasource,QCCycleScrollViewDelegate,AmortizationHomeProductCellDelegate,AmortizationHomeFirstCellDelegate,loginViewDelegate,AmortizationHomeSecondCellDelegate> {
    CGRect initialFrame;
    CGFloat defaultViewHeight;
    CGFloat defaultViewWidth;
}

@property (nonatomic,strong) QCBaseTableView *tableView;
@property (nonatomic,strong) QCCycleScrollView *topScrollView;

@end

@implementation AmortizationHomeNewViewController

-(void)dealloc{
    NSLog(@"AmortizationHomeNewViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackView];
    [self setTitle:@"信·分期"];
    self.view.backgroundColor = rgb(239, 239, 239, 1);
    
    //我的订单
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 30);
    [btn addTarget:self action:@selector(indentAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:@"我的订单" forState:UIControlStateNormal];
    UIBarButtonItem *indentItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = indentItem;
    
    
    [self initViews];
    //    [self.tableView reload
}

- (void)initViews {
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = rgb(221, 221, 221, 1);
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
    
    _topScrollView = [[QCCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/320*150)];
    //    scrollView.backgroundColor = [UIColor orangeColor];
    _topScrollView.delegate = self;
    _topScrollView.datasource = self;
    _tableView.tableHeaderView = _topScrollView;
    
    initialFrame = _topScrollView.frame;
    defaultViewHeight  = _topScrollView.size.height;
    defaultViewWidth   = _topScrollView.size.width;
}

- (void)adAction:(UIButton *)button {
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
        [self toLogin];
        return;
    }
    LoanOrRepayViewController * loanViewController = [[LoanOrRepayViewController alloc]init];
    [self.navigationController pushViewController:loanViewController animated:YES];
}
- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    loginView.delegte = self;
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //    loginView.modalPresentationStyle = UIModalPresentationPopover;
    [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
}

- (void)indentAction:(UIButton *)button {
    //我的订单
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
        [self toLogin];
        return;
    }
    
    MyOrderListController *orderListController=[[MyOrderListController alloc]init];
    [self.navigationController pushViewController:orderListController animated:YES];
}

#pragma mark ---delegate 登录成功
- (void)loginSucceed {
    
}

#pragma mark  -- UITableViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//        //表示图头部拉伸
//        CGRect f = _topScrollView.frame;
//        f.size.width = _tableView.frame.size.width;
//        _topScrollView.frame = f;
//    
//        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
//        if(offsetY > 0) {
//    
//            initialFrame.origin.y = offsetY * -1;
//            initialFrame.size.height = defaultViewHeight + offsetY;
//            initialFrame.size.width = defaultViewWidth + offsetY/defaultViewHeight*defaultViewWidth;
//            initialFrame.origin.x = offsetY/defaultViewHeight*defaultViewWidth/2*-1;
//    
//            _topScrollView.frame = initialFrame;
//
//        }
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return kAmortizationHomeFirstCellHeight;
    }else if (indexPath.section == 1) {
        return kAmortizationHomeSecondCellHeight;
    }else if (indexPath.section == 2) {
        return getScreenFitSize(50.0);
    }else if (indexPath.section == 3) {
        return kAmortizationHomeProductCellHeight;
    }else {
        return 0;
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return _data.hasSeckill.boolValue ? 1:0;
    }else if (section == 2) {
        return [_data.hasAD isEqualToString:@"1"] ? 1:0;
    }else if (section == 3) {
        return 4;
    }else {
        return 0;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"oneCell";
        AmortizationHomeFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[AmortizationHomeFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.delegate =self;
        }
        return cell;
    }else if (indexPath.section == 1) {
        static NSString *identifier = @"twoCell";
        AmortizationHomeSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[AmortizationHomeSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.delegate = self;
        }
        cell.flashList = _data.flashSaleList;
        cell.seckillTimeDosplay = _data.seckillTimeDosplay;
        return cell;
    }else if (indexPath.section == 2) {
        static NSString *identifier = @"threeCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //广告
            UIButton *adImage = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, getScreenFitSize(50.0))];
            adImage.tag = 30037;
            [adImage addTarget:self action:@selector(adAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:adImage];
        }
        UIButton *adImage = (UIButton *)[cell.contentView viewWithTag:30037];
        if (_data.adImageUrl.length == 0 || _data.adImageUrl == nil) {
            adImage.hidden = YES;
        }else {
            adImage.hidden = NO;
            [adImage sd_setImageWithURL:[NSURL URLWithString:_data.adImageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"xfqnavimg"]];
        }
        return cell;
    }else {
        static NSString *identifier = @"fourCell";
        AmortizationHomeProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[AmortizationHomeProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        }

        if (indexPath.row == 0) {
            cell.type = AmortizationHomeProductCellElectry;
            cell.resumes = _data.electronicsList;
        }else if (indexPath.row == 1) {
            cell.type = AmortizationHomeProductCellTrain;
            cell.resumes = _data.trainingList;
        }else if (indexPath.row == 2) {
            cell.type = AmortizationHomeProductCellBeauty;
            cell.resumes = _data.beautyList;
        }else if (indexPath.row == 3) {
            cell.type = AmortizationHomeProductCellFashion;
            cell.resumes = _data.fashionList;
        }
        cell.delegate = self;
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)amortizationHomeSecondCell:(AmortizationHomeSecondCell *)cell buttonDidClickedAtIndex:(NSInteger)index {
//    NSString *url = @"webView/goods/seckill.jsp?t=1";
    NSString *url = @"webView/goods/purchase.jsp";
    [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:url params:nil] hasTopBar:NO titleName:@"商品秒杀"];
    
}

#pragma mark - QCBaseTableView delegate
//下拉刷新
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self httpLoad];
}

#pragma mark - QCCycleScrollView delegate
- (NSInteger)numberOfPages
{
    return self.data.commerceBannerList.count;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    UIImageView *image = [[UIImageView alloc] initWithFrame:_topScrollView.bounds];
    CommerceBanner *banner = [self.data.commerceBannerList objectAtIndex:index];
    [image sd_setImageWithURL:[NSURL URLWithString:banner.imageUrl] placeholderImage:[UIImage imageNamed:@"bann1"]];
    
    return image;
}

- (void)didClickPage:(QCCycleScrollView *)csView atIndex:(NSInteger)index
{
    CommerceBanner *banner = [_data.commerceBannerList objectAtIndex:index];
    [YXBTool typeToJump:banner.type info:banner.val];
}

#pragma mark - Http
- (void)httpLoad {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AmortizationHomeNewViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this stopDefaultAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(CommerceIndexPageData* r, int taskid) {
        
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}

#pragma mark - AmortizationHomeFirstCell delegate
- (void)amortizationHomeFirstCell:(AmortizationHomeFirstCell *)cell buttonDidClickedAtIndex:(NSInteger)index {
    //    0, 时尚电子 .1学习加油站 。2， 美妆护肤。 3，时尚潮品。
    AmortizationCategoryViewController *category = [[AmortizationCategoryViewController alloc] init];
    switch (index) {
        case 0:
            category.commerceCategory = CommerceCategoryProduce;
            break;
        case 1:
            category.commerceCategory = CommerceCategoryStudy;
            break;
        case 2:
            category.commerceCategory = CommerceCategoryPainting;
            break;
        case 3:
            category.commerceCategory = CommerceCategoryFashion;
            break;
    }
    
    [self.navigationController pushViewController:category animated:YES];
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
    CommerceManager *_commerceM = (CommerceManager *)[httpOperation getAopInstance:[CommerceManager class] returnValue:[CommerceIndexPageData class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    if ([userModel isLogin])
    {
        [_commerceM getCommerceIndexPageData:userModel.user.yxbToken];
        
    }
    else
    {
        //            未登录可使用
        [_commerceM getCommerceIndexPageData:@""];
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        //            [alert show];
    }

}
//请求完成
-(void)httpLoadComplete:(CommerceIndexPageData *)r{
    if (r.errCode == 0) {
        if (r != nil) {
            self.data = r;
        }
        
    }else  {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
    
    [self.tableView reloadDeals];
    [self.tableView reloadData];
    [self.topScrollView reloadData];

}
#pragma mark ---- AmortizationHomeProductCell delegate
- (void)amortizationHomeProductCellmoreButtonDidClicked:(AmortizationHomeProductCell*)cell type:(AmortizationHomeProductCellType)type {
    //    1, 时尚电子 .2学习加油站 。3， 美妆护肤。 4，时尚潮品。
    //index : 1.时尚电子 2美妆护肤 3时尚潮品 4学习加油站
    AmortizationCategoryViewController *category = [[AmortizationCategoryViewController alloc] init];
    if (type == AmortizationHomeProductCellElectry) {//时尚电子
        category.commerceCategory = CommerceCategoryProduce;
    }else if (type == AmortizationHomeProductCellTrain) { //学习培训
        category.commerceCategory = CommerceCategoryStudy;
    }else if (type == AmortizationHomeProductCellBeauty) {//美妆护肤
        category.commerceCategory = CommerceCategoryPainting;
    }else if (type == AmortizationHomeProductCellFashion) {//时尚潮品
        category.commerceCategory = CommerceCategoryFashion;
    }
    [self.navigationController pushViewController:category animated:YES];
}
- (void)amortizationHomeProductCell:(AmortizationHomeProductCell *)cell productButtonDidClickedAtIndex:(NSInteger)index model:(GoodsResume *)model {
    NSLog(@"%@",model);
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",(long)model.commerceID] forKey:@"pid"];
    NSString *url = [YXBTool getURL:GoodsDetailBaseUrl params:[YXBTool jsonEqualWithDic:dic]];
    
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"商品详情"];
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
