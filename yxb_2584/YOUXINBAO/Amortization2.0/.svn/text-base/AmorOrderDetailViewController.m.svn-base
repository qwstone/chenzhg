//
//  AmorOrderDetailViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/9/16.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AmorOrderDetailViewController.h"
#import "OrderOneCell.h"
#import "OrderTwoCell.h"
#import "OrderThirdCell.h"
#import "CommerceDetailV2.h"
#import "CommerceManagerV2.h"
#import "YXBTool.h"
#import "OrderDetailPayCell.h"
#import "OrderFourCell.h"
#import "OrderDetailWebviewCell.h"
#import "OrderFiveCell.h"
#import "AmorPayCell.h"
#import "OrderTwoSecond.h"
#import "Payment_producutPay.h"
#import "UIAlertView+Block.h"
#import "CommerceManager.h"
#import "LoanOrRepayFriendsViewController.h"
#import "LoanFriendTypeViewController.h"
#import "QCZhongChouDetailViewController.h"
#define PayViewHeight 50
#define RootViewControllerRightInfoUrl @"webView/helpcenter/service.jsp?"


@interface AmorOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,QCBaseTableViewDelegate,OrderDetailWebviewCellDelegate,AmorPayViewDelegate,QCFriendsViewControllerBackDelegate>
{
    NSInteger loadTimes;// %2==0时重新加载，为了计算webview的高度
    CGFloat webviewHeight;//webview高度
    NSString *_guaranteeId;
    AmorOrderPayType currentPayType;//当前选择的下面的按钮类型
}
@property (nonatomic,strong)QCBaseTableView *tableView;
@property (retain, nonatomic)HttpOperator* iHttpOperator;
@property (nonatomic,strong) CommerceDetailV2 *commerceDetail;
@property (nonatomic,strong) AmorPayView *payView;//footerView

@end

@implementation AmorOrderDetailViewController
-(void)dealloc{
    NSLog(@"AmorOrderDetailViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    loadTimes = 2;
    webviewHeight = 1;
    [self setTitle:@"订单详情"];
    [self createMyTableView];
    
    [self setNavigationButtonItrmWithiamge:@"index-notice-icon.png" withRightOrleft:@"right" withtargrt:self withAction:@selector(rightClicked)];

    
//    [self.tableView reloadDeals];
    // Do any additional setup after loading the view.
}

-(void)leftClicked
{
    [ProgressHUD dismiss];
    if (self.pushType == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void)rightClicked
{
    
    NSString *url = [YXBTool getURL:RootViewControllerRightInfoUrl params:nil];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"首页说明"];
    
    //    NSLog(@"首页右上角");
}

-(void)viewWillAppear:(BOOL)animated
{
    if (currentPayType == AmorOrderPayTypeFukuan ||
        currentPayType == AmorOrderPayTypeHuankuan ||
        currentPayType == AmorOrderPayTypeHuankuanFull)
    {
        [self requestData];
    }
    [super viewWillAppear:YES];
}

-(void)createMyTableView
{
    CGFloat payViewHeight = PayViewHeight;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGFloat x = 0, y = 0, w = kDeviceWidth, h = kDeviceHeight - 64 - payViewHeight;
    self.tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    x = 0, y = _tableView.bottom, w = kDeviceWidth, h = payViewHeight;
    self.payView = [[AmorPayView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    //    _payView.payTypeArray = array;
    _payView.backgroundColor = [UIColor whiteColor];
    _payView.userInteractionEnabled = YES;
    _payView.delegate = self;
    [self.view addSubview:_payView];
}

#pragma mark - 数据请求
-(void)requestData
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AmorOrderDetailViewController *this = self;

    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
        [ProgressHUD dismiss];
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(CommerceDetailV2* r, int taskid) {

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
    CommerceManagerV2* manager = (CommerceManagerV2*)  [httpOperation getAopInstance:[CommerceManagerV2 class] returnValue:[CommerceDetailV2 class]];
    if (_orderId != 0) {
        
        [manager getCommerceDetailV2:[YXBTool getUserToken] commerceID:self.orderId];
    }
    else
    {
        [ProgressHUD showErrorWithStatus:@"订单号为空！"];
        //            [manager getCommerceDetailV2:[YXBTool getUserToken] commerceID:123];
    }

}
//请求完成
-(void)httpLoadComplete:(CommerceDetailV2*)r{
    if (r.errCode == 0) {
        
        self.commerceDetail = r;
        self.payView.buttonType = self.commerceDetail.buttonType;
        self.commerceDetail.commerceID = r.commerceID;
        
        if(self.commerceDetail.buttonType == 0)
        {
            self.payView.height = 0;
            self.payView.hidden = YES;
        }
        else
        {
            self.payView.height = PayViewHeight;
            self.payView.hidden = NO;
            
        }
        self.tableView.height = kDeviceHeight - 64 - self.payView.height;
        
        
    }
    else {
        [ProgressHUD showSuccessWithStatus:r.errString];
        
    }
    [self.tableView reloadDeals];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSourceDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    NSInteger count = 7;
    
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 1;
    if ( section == 4 && [self.commerceDetail.needDisplayDetails integerValue] == 0)
    {

        number = 0;
    }
    if ( section == 5 && [self.commerceDetail.needDisplayStages integerValue] == 0) {
        number = 0;
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section == 0) {
            //订单状态

            static NSString * cellID  =@"conCellId1";
            OrderOneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == Nil) {
            cell = [[OrderOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            }
            cell.model = self.commerceDetail;
            return cell;
        }else if (indexPath.section == 1){
            if (self.commerceDetail.isCommonTrade.integerValue==1) {
                
                static NSString * cellID  =@"cell11";
                OrderTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell == Nil) {
                    cell = [[OrderTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.commerceDetail;
                return cell;
                
            }
            else{
            
                static NSString * cellID  =@"cell";
                OrderTwoSecond * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell == Nil) {
                    cell = [[OrderTwoSecond alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.commerceDetail;
                return cell;
    
            }
           

        }else if (indexPath.section == 2){
            //商品信息

            static NSString * cellID  =@"conCellIdd2";
            OrderThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == Nil) {
                cell = [[OrderThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.model = self.commerceDetail;
            return cell;
        }else if (indexPath.section == 3){
            //webview

            static NSString * cellID  =@"webcell";
            OrderDetailWebviewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == Nil) {
                cell = [[OrderDetailWebviewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.clipsToBounds = YES;
            cell.delegate = self;
            //webview内部 获取高度之后 回调刷新
            cell.htmls = self.commerceDetail.htmlStr;
            loadTimes ++;

            return cell;
        }else if (indexPath.section == 4){
            //还款详情

            static NSString * cellID  =@"detailViewCell";
            OrderFiveCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == Nil) {
                cell = [[OrderFiveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.model = self.commerceDetail;
            return cell;
        }
        else if (indexPath.section == 5){
            //横着的还款日期scrollview

            static NSString * cellID  =@"detailViewCell2";
            OrderDetailPayCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == Nil) {
                cell = [[OrderDetailPayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.model = self.commerceDetail;
            return cell;
        }
        else if (indexPath.section == 6){
            //各种时间

            static NSString * cellID  =@"detailViewCell3";
            OrderFourCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == Nil) {
                cell = [[OrderFourCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                
            }
            cell.backgroundColor=rgb(244, 244, 244, 1);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.model = self.commerceDetail;
            return cell;
 
        
        }
        else{
            static NSString * cellID  =@"cellID4";
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell == Nil) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                    
                }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        
        }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    if (indexPath.section == 0) {
        //订单状态
        height = 110;
    }else if (indexPath.section == 1)
    {
//        地址栏
        CGSize hei=[self getHeight];
        height = 100+hei.height;
    }else if (indexPath.section == 2)
    {
        //商品信息
        height = 155;
    }else if (indexPath.section == 3)
    {
        //webview
        height = webviewHeight;
    }
    else if (indexPath.section == 4)
    {
        //还款详情
        height = 100;
        if ([self.commerceDetail.needDisplayDetails integerValue] == 0) {
            height = 0;
        }
    }
    else if (indexPath.section == 5)
    {
        //横着的还款日期scrollview
        height = 140;
        if ([self.commerceDetail.needDisplayStages integerValue] == 0) {
            height = 0;
        }
        
    }else if (indexPath.section == 6)
    {
        //各种时间
        height = 70;
//        NSLog(@"timeDes===%@",self.commerceDetail.timeDes);
        CGSize size = [YXBTool getFontSizeWithString:self.commerceDetail.timeDes font:[UIFont systemFontOfSize:14.0] constrainSize:CGSizeMake(kDeviceWidth, kDeviceHeight)];
        height = size.height + OrderFourCellLabelSpaceTopBottom; //上下各空 10
        
    }
    

    
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 10)];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (CGSize)getHeight{


    CGSize size=[YXBTool getFontSizeWithString:[NSString stringWithFormat:@"%@",self.commerceDetail.adress] font:[UIFont systemFontOfSize:13] constrainSize:CGSizeMake(kDeviceWidth-50, CGFLOAT_MAX)];
    return size;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 10;
    
    if(section==0||section==6||section==5)
    {
    
        height = 0;
    }
    
    if (section == 4 && [self.commerceDetail.needDisplayDetails integerValue] == 0)
    {
        height = 0;
    }
    if (section == 5 && ([self.commerceDetail.needDisplayStages integerValue] == 0))
    {
        height = 0;
    }
    

    
    return height;
}
#pragma mark - QCBaseTableViewDelegate
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    
    [self requestData];
    [self requestData];

}

#pragma mark - OrderDetailWebviewCellDelegate
-(void)zcxqBtnClick{
    QCZhongChouDetailViewController *zcDetailVC = [[QCZhongChouDetailViewController alloc] init];
    [self.navigationController pushViewController:zcDetailVC animated:YES];
}
-(void)needRefreshTableViewWithHeight:(NSInteger)height
{
    if(loadTimes % 2 == 1 || webviewHeight < 10)
    {
        webviewHeight = height;
        [self.tableView reloadData];

    }
}

#pragma mark - AmorPayViewDelegate
-(void)amorPayViewPayButtonSelectedWithAmorType:(AmorOrderPayType)payType
{

//    [ProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%ld",(long)payType]];
    currentPayType = payType;
    switch (payType) {
        case AmorOrderPayTypeFukuan://付款
        {
            //首付
            Payment_producutPay *productPay = [[Payment_producutPay alloc] init];
            productPay.money = self.commerceDetail.theMoney;
            productPay.type = @"1";
            productPay.qici = @"-2";
            productPay.orderId = [NSString stringWithFormat:@"%ld",(long)self.orderId];
            NSString *url = [YXBPaymentUtils getFullWebUrl:productPay];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"去支付"];

        }
            break;
        case AmorOrderPayTypeHuankuan://还款当前期
        {
            
            Payment_producutPay *productPay = [[Payment_producutPay alloc] init];
            productPay.money = self.commerceDetail.theMoney;
            productPay.type = @"2";
            productPay.qici = self.commerceDetail.thePeriodId; //当前期次
            productPay.orderId = [NSString stringWithFormat:@"%ld",(long)self.orderId];
            NSString *url = [YXBPaymentUtils getFullWebUrl:productPay];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"去还款"];
            
        }
            break;
            
        case AmorOrderPayTypeHuankuanFull://全部还款
        {
            Payment_producutPay *productPay = [[Payment_producutPay alloc] init];
            productPay.money = self.commerceDetail.allMoney;
            productPay.type = @"2";
            productPay.qici = @"0"; //当前期次
            productPay.orderId = [NSString stringWithFormat:@"%ld",(long)self.orderId];
            NSString *url = [YXBPaymentUtils getFullWebUrl:productPay];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"全额还款"];

        }
            break;
        case AmorOrderPayTypeCancelOrder://取消订单
        case AmorOrderPayTypeConfirmGoods://确认收货

        {
            
            [self requestData:payType gid:nil];
        }
            break;
        case AmorOrderPayTypeOtherPay://代付当前期
        {
            LoanFriendTypeViewController *controller = [[LoanFriendTypeViewController alloc] init];
            controller.delegate = self;
            controller.payType = payType;
            controller.friendType = LoanNewFriendTypeDaiFuDangQianQi;
            [self.navigationController pushViewController:controller animated:YES];

            break;
        }
        case AmorOrderPayTypeOtherPayAll://代付全部
        {
            LoanFriendTypeViewController *controller = [[LoanFriendTypeViewController alloc] init];
            controller.delegate = self;
            controller.payType = payType;
            controller.friendType = LoanNewFriendTypeDaiFuQuanBu;
            [self.navigationController pushViewController:controller animated:YES];
            
            break;
        }
        case AmorOrderPayTypeSelectPeople: //选择担保人
        {
//            QCFriendsViewController *friendVC = [[QCFriendsViewController alloc] init];
//            friendVC.isSelectPeople = YES;
//            friendVC.delegate = self;
//            friendVC.payType = AmorOrderPayTypeOtherPay;
//            [self.navigationController pushViewController:friendVC animated:YES];
            
            LoanFriendTypeViewController *controller = [[LoanFriendTypeViewController alloc] init];
            controller.delegate = self;
            controller.payType = payType;
            controller.friendType = LoanNewFriendTypeDanBao;
            [self.navigationController pushViewController:controller animated:YES];
            
            /*
            LoanOrRepayFriendsViewController *friendVC = [[LoanOrRepayFriendsViewController alloc] init];
            friendVC.isSelectPeople = YES;
            friendVC.delegate = self;
            friendVC.payType = payType;
            [self.navigationController pushViewController:friendVC animated:YES];
            */
            
        }
            break;
        default:
            break;
    }
    
}
#pragma mark - QCFriendsViewControllerBackDelegate


/**
 *  @author chenglibin
 *
 *  选择担保人接口
 *
 *  @param payType 类型
 *  @param gid     担保人id  ,分隔多个担保人
 */
-(void)requestData:(AmorOrderPayType)payType gid:(NSString *)gid
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AmorOrderDetailViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpLOad_SecondParams:s httpOperation:assginHtttperator payType:payType gid:gid];
        
    } complete:^(CommerceDetailV2* r, int taskid) {
        
        [this httpLoad_SecondComplete:r];
        //        [this.tableView reloadData];
    }];
    [self.iHttpOperator connect];
    
    
}
//上传参数
- (void)httpLOad_SecondParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation payType:(AmorOrderPayType)payType gid:(NSString *)gid
{
    CommerceManagerV2* manager = (CommerceManagerV2*)  [httpOperation getAopInstance:[CommerceManagerV2 class] returnValue:[CommerceDetailV2 class]];
    if (_orderId != 0) {
        if(payType == AmorOrderPayTypeSelectPeople)
        {
            [manager guaranteeCommerceDetailV2:[YXBTool getUserToken] commerceID:_orderId guaranteeId:gid];
            
        }
        else if (payType == AmorOrderPayTypeOtherPay)
        {
            if (self.commerceDetail.thePeriodId != nil && [self.commerceDetail.thePeriodId length] > 0)
            {
                [manager otherPayCommerceDetailV2:[YXBTool getUserToken] commerceID:_orderId periodId:self.commerceDetail.thePeriodId guaranteeId:gid];
                
            }
            else
            {
                [ProgressHUD showErrorWithStatus:@"还款期次获取错误!"];
                return;
            }
            
        }
        else if (payType == AmorOrderPayTypeOtherPayAll)
        {
            [manager otherPayCommerceDetailV2:[YXBTool getUserToken] commerceID:_orderId periodId:@"0" guaranteeId:gid];
            
        }
        else if (payType == AmorOrderPayTypeCancelOrder) {
            [manager cancelCommerceDetailV2:[YXBTool getUserToken] commerceID:self.orderId];
            
        }else if (payType == AmorOrderPayTypeConfirmGoods){
            [manager confirmCommerceDetailV2:[YXBTool getUserToken] commerceID:self.orderId];
            
        }
        
        [ProgressHUD showWithStatus:@"正在请求..." maskType:ProgressHUDMaskTypeGradient tipsType:ProgressHUDTipsTypeLongBottom];
        
        
    }
    else
    {
        [ProgressHUD showErrorWithStatus:@"订单号为空！"];
        //            [manager getCommerceDetailV2:[YXBTool getUserToken] commerceID:123];
    }
}
//请求完成
-(void)httpLoad_SecondComplete:(CommerceDetailV2*)r{
    if (r.errCode == 0) {
        
        self.commerceDetail = r;
        self.payView.buttonType = self.commerceDetail.buttonType;
        self.commerceDetail.commerceID = r.commerceID;
        if(self.commerceDetail.buttonType == 0)
        {
            self.payView.height = 0;
            self.payView.hidden = YES;
        }
        else
        {
            self.payView.height = 50;
            self.payView.hidden = NO;
            
        }
        self.tableView.height = kDeviceHeight - 64 - self.payView.height;
        [ProgressHUD showSuccessWithStatus:r.errString];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [ProgressHUD showSuccessWithStatus:r.errString];
        
    }
    
    [self.tableView reloadDeals];
    [self.tableView reloadData];
}
-(void)amorOrderDetailCallBackWithType:(AmorOrderPayType)payType gid:(NSString *)gid
{
    [self requestData:payType gid:gid];
}

//选择好友微信回调
-(void)callWeChatWithLoanId:(NSInteger)loanId
{
//    http://60.195.254.33:8083/wap/guarantee/index.jsp?orderId=XXXXX
    NSString *url = [NSString stringWithFormat:@"%@wap/guarantee/index.jsp?orderId=%ld",YXB_IP_ADRESS,(long)self.orderId];
    [YXBTool shareToWeixinSessionContent:@"商品都选好了，就等你帮我担保付款啦~好货不等人，拜托拜托....." imgName:[UIImage imageNamed:@"shareImg"] url:url title:@"一次雪中送炭胜过百次锦上添花。帮好友，有惊喜！" callBackBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
