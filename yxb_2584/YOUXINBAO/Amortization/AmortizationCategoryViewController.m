//
//  AmortizationCategoryViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/5/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AmortizationCategoryViewController.h"
#import "CategoryTitleView.h"
#import "AmortizationTableViewCell.h"
#import "CommerceManager.h"
#import "QCPopupView.h"
#import "AmortizationProduceDetailViewController.h"
#import "GoodsResume.h"
#import "AmortizationTopSelectView.h"
#import "YXBTool.h"


#define GoodsDetailBaseUrl [NSString stringWithFormat:@"%@webView/goods/good.jsp?a=1",YXB_IP_ADRESS]   
@interface AmortizationCategoryViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,AmortizationTopSelectViewDelegate> {
    UIControl *_preference;
    QCPopupView *_popupView;
    NSString *_titleStr;
 
}

//@property (nonatomic,strong)CategoryTitleView *titleView;
@property (nonatomic,strong)QCBaseTableView *tableView;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,strong) CommerceList *data;
@property (nonatomic,strong)NSMutableArray *goodsList;
@property (nonatomic,copy)NSString *secondary;  //2级筛选
@property (nonatomic,strong) AmortizationTopSelectView *topView;    //顶部选择视图


@end

@implementation AmortizationCategoryViewController
-(void)dealloc{
    NSLog(@"AmortizationCategoryViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setBackView];
    
    [self initData];
    
    [self initViews];
}

- (void)initData {
    _goodsList = [NSMutableArray new];
    _currentPage = 1;
    self.secondary = @"全部";
    
    _titleStr = nil;
    switch (self.commerceCategory) {
        case CommerceCategoryProduce:
            _titleStr = @"时尚电子";
            break;
        case CommerceCategoryStudy:
            _titleStr = @"教育培训";
            break;
        case CommerceCategoryPainting:
            _titleStr = @"美妆护肤";
            break;
        case CommerceCategoryFashion:
            _titleStr = @"时尚潮品";
            break;
            
    }
}

- (void)initViews {
    
//    _titleView = [[CategoryTitleView alloc] initWithFrame:kCategoryTitleRect];
//    [_titleView setSelected:NO];
//    [_titleView addTarget:self action:@selector(actionNavTitle:) forControlEvents:(UIControlEventTouchUpInside)];
//    [_titleView resetTitle:[NSString stringWithFormat:@"%@-%@",_titleStr,self.secondary]];
//    self.navigationItem.titleView = _titleView;
    [self setTitle:_titleStr];
    
    _topView = [[AmortizationTopSelectView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 45) andArray:@[@"全部",@"手机",@"平板",@"电脑",@"相机"]];
    _topView.delegate =self;
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topView];
    
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, _topView.bottom, kDeviceWidth, kDeviceHeight-64-_topView.height) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [YXBTool colorWithHexString:@"#D0D0D0"];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
    
    _preference = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 39)];
    _preference.backgroundColor = rgb(252, 237, 197, 1);
    [_preference addTarget:self action:@selector(preferenceAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *horn = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_preference.height-16)/2, 14.5, 16)];
    horn.image = [UIImage imageNamed:@"laba-icon"];
    [_preference addSubview:horn];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(horn.right+8, (_preference.height-15)/2, kDeviceWidth-30, 15)];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.textColor = rgb(59, 158, 182, 1);
    topLabel.text = @"小提示：您有一个优惠券尚未领取，点击领取";
    topLabel.font = [UIFont systemFontOfSize:15];
    [_preference addSubview:topLabel];
}

//调整tableview分割线
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark  -- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.goodsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return getScreenFitSize(10);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, getScreenFitSize(10))];
    sectionHeader.backgroundColor = [YXBTool colorWithHexString:@"#F7F7F7"];
    sectionHeader.layer.borderColor = [YXBTool colorWithHexString:@"#D0D0D0"].CGColor;
    sectionHeader.layer.borderWidth = 1.0;
    return sectionHeader;
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
        cell.contentView.backgroundColor = [UIColor clearColor];
        
    }
    if (indexPath.section < [self.goodsList count]) {
        cell.data = [self.goodsList objectAtIndex:indexPath.section];

    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    GoodsResume *resume = [self.goodsList objectAtIndex:indexPath.row];
    AmortizationProduceDetailViewController *detail = [[AmortizationProduceDetailViewController alloc] init];
    detail.commerceID = resume.commerceID;
    [self.navigationController pushViewController:detail animated:YES];
    */
    GoodsResume *resume = [self.goodsList objectAtIndex:indexPath.section];

//    NSString *url = [YXBTool getURL:GoodsDetailBaseUrl params:[NSString stringWithFormat:@"pid=%ld",resume.commerceID]];

    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",(long)resume.commerceID] forKey:@"pid"];
    NSString *url = [YXBTool getURL:GoodsDetailBaseUrl params:[YXBTool jsonEqualWithDic:dic]];

    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"商品详情"];
}

#pragma mark - Http
- (void)httpLoad {
    //
    self.tableView.tableHeaderView = nil;
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AmortizationCategoryViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
        
        
    } complete:^(CommerceList* r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//请求失败
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
    CommerceManager *_commerceM = (CommerceManager *)[httpOperation getAopInstance:[CommerceManager class] returnValue:[CommerceList class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    //        if (style == L_myList) {
    NSString *userToken = userModel.user.yxbToken;
    if (userToken == nil)
    {
        userToken = @"";
        
    }
    
    [_commerceM getCommerceList:userToken pageNum:self.currentPage commerceCategory:self.commerceCategory secondaryCategory:self.secondary];

}
//请求完成
-(void)httpLoadComplete:(CommerceList *)r{
    if (r.errCode == 0) {
        if (r != nil) {
            self.data = r;
            if (self.currentPage>1) {
                [self.goodsList addObjectsFromArray:r.goodsResumeList];
            }else{
                self.goodsList = r.goodsResumeList ;
            }
            
            if (r.hasCoupon.boolValue) {
                self.tableView.tableHeaderView = _preference;
            }
            
            self.topView.array = r.categoryArray;
            //                [this.titleView resetTitle:[NSString stringWithFormat:@"%@-%@",_titleStr,r.currentCategoryName]];
        }
        
    }else if (r.errCode == 7) {
        
    }else {
        [self.goodsList removeAllObjects];
    }
    
    
    if (r.goodsResumeList.count != 0 && r.goodsResumeList.count%20 == 0) {
        self.tableView.hasFooter = YES;
    }else {
        self.tableView.hasFooter = NO;
    }
    
    
    [self.tableView reloadData];
    [self.tableView reloadDeals];
}
#pragma mark - QCBaseTableView delegate
//下拉刷新
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self httpLoad];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        if (_data.goodsResumeList.count%20==0) {
            _currentPage ++;
            [self httpLoad];
        }else {
            
        }
    }
    
}

#pragma mark -  AmortizationTopSelectView delegate
- (void)AmortizationTopSelectView:(AmortizationTopSelectView *)selectView selectedAtIndex:(NSInteger)index {
    [self.goodsList removeAllObjects];
    self.secondary = [self.data.categoryArray objectAtIndex:index];
    _currentPage = 1;
    [self.tableView beginRefreshing];
}

//#pragma mark - QCPopupView delegate
//- (void)QCPopupViewDismissTapAction:(QCPopupView *)popupView {
//    _titleView.selected = NO;
//}
//
//- (void)QCPopupView:(QCPopupView *)popupView buttonDidClickAtIndex:(NSInteger)index {
//    _titleView.selected = NO;
//    self.secondary = [self.data.categoryArray objectAtIndex:index];
//    [self.tableView beginRefreshing];
//}
//
//// 点击标题栏
//- (void)actionNavTitle:(CategoryTitleView *)sender
//{
//    if (self.data.categoryArray.count == 0) {
//        return;
//    }
//    
//    if (_popupView == nil) {
//        _popupView = [[QCPopupView alloc] initWithArray:self.data.categoryArray withColumnCount:5];
//        _popupView.delegate = self;
//    }
//    
//    if (_popupView.superview == nil) {
//        [self.view addSubview:_popupView];
////        [self.view bringSubviewToFront:_popupView];
//    }
//    if (!sender.selected) {
//        [_popupView show];
//    }else{
//        [_popupView dismiss];
//    }
//    sender.selected = !sender.selected;
//}

- (void)leftClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)preferenceAction:(UIButton *)button {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.data.couponUrl]];
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
