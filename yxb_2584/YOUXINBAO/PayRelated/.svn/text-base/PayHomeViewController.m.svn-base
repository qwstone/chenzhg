//
//  PayHomeViewController.m
//  LotteryApp
//
//  Created by 程立彬 on 14-4-9.
//  Copyright (c) 2014年 windo. All rights reserved.
//

#import "PayHomeViewController.h"
#import "PayModeModel.h"
#import "PayModeCell.h"
#import "PayZhangHuChongZhiViewController.h"
#import "PayModel.h"
#import "HttpRequest.h"
#import "YXBTool.h"
#import "SBJSON.h"
#import "WXApi.h"
#import "QCBaseTableView.h"
#import "UILabel+CustomPackaging.h"
#import "PayInstance.h"
//#import "WXApi.h"
//#define NumberOfPay 5
#define CellHeight 60
#define SAFARI_CALL_BACK_KEY @"yxbaoback"

#define BankRequestUrl @"mobile/mobileRechargeSupport.jsp"
#define PayInfoHelpUrl @"webView/helpcenter/rechargeHelp.jsp"
@interface PayHomeViewController ()<QCBaseTableViewDelegate>
{
//    int join; //1--参加了   2---未参加
}
@property(nonatomic, retain)QCBaseTableView *tableView;
@property(nonatomic, retain)NSMutableArray     *modelArray;
//@property(nonatomic, retain)FLHttpRequestUtil *request;
@property(nonatomic, retain)ASIHTTPRequest *bankRequest;//请求支持的付款商家
@property(nonatomic, retain)PayModel * payModel;
@property (nonatomic,retain)HttpRequest *mRequest;
@property(nonatomic, assign)Pay_Mode selectedMode;
@property(nonatomic, retain)NSMutableArray *payModeArray;
@property(nonatomic, retain)NSMutableArray *currentAvailableArray;
@end

@implementation PayHomeViewController

-(void)dealloc
{

    /** 用微信登录的key重新初始化 微信支付的sdk */
    [PayInstance initializeWeifutongPaySDKWithWeChatAppid:YXBWeChatLoginKey];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [PayInstance initializeWeifutongPaySDKWithWeChatAppid:YXBWeChatPayKey];

    //设定支付的顺序
    self.payModeArray =  [NSMutableArray arrayWithCapacity:0];

//    [self requestData];
    [self requestBankData];
//    [self setNavTitle:@"选择充值方式"];
    [self setTitle:@"充值"];
    self.view.backgroundColor=[YXBTool colorWithHexString:@"f6f6f6"];
    [self setBackView];
    
//    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
//    right.frame = CGRectMake(0, 0, 60, 50);
//    [right setTitle:@"充值说明" forState:UIControlStateNormal];
//    right.titleLabel.font = [UIFont boldSystemFontOfSize:15];
//    [right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:right];
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    float x = 0, y = 44, w = self.view.frame.size.width;
    y = 0;
//    float h = CellHeight*([_payModeArray count]+2);
    float h = self.view.frame.size.height-44;
    //高度是六个支付方式加上footview(更多和电话)
    self.tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(x, y, w, kDeviceHeight-64-40) style:UITableViewStylePlain];
    _tableView.scrollEnabled = YES;
    _tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HistorySepLine.png"]];
    _tableView.backgroundColor=[UIColor clearColor];
    _tableView.refreshDelegate = self;
    [_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 80)];

    view.backgroundColor=[YXBTool colorWithHexString:@"f6f6f6"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kDeviceWidth-30, 80)];
//    label.backgroundColor = rgb(212, 211, 211, 1);
    label.textColor = [UIColor redColor];
    label.numberOfLines=0;
    [label setAdjustsFontSizeToFitWidth:YES];
    label.text = @"重要提示:\n本站不支持信用卡充值，如出现误充,将原路返还,并收取1%的手续费。";
    label.textLineSpaceing =6;
    label.font = [UIFont boldSystemFontOfSize:14];
    [view addSubview:label];
    _tableView.tableHeaderView = view;
    
    [self.view addSubview:_tableView];
    
    
    CGFloat height=[YXBTool countLabelHeightWithText:@"1.支付宝和微信充值:如出现限额提示,是您绑定银行卡的支付额限制,可联系银行客服或在银行官方网站上修改网上支付限额.\n2.银联支付:每天限额5000元~20000元,限额因绑定的银行卡而不同.\n3.充值银行卡姓名:必须与在本站绑定信息一致,以免影响您提现" font:[UIFont systemFontOfSize:12] labelWidth:kDeviceWidth-30];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kDeviceHeight-height-80)];
//    [footerView setBackgroundColor:[UIColor redColor]];
    _tableView.tableFooterView = footerView;
//    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //574*66
    UIButton *otherPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    [otherPayBtn addTarget:self action:@selector(morePayMethods) forControlEvents:UIControlEventTouchUpInside];
    [otherPayBtn setTitle:[NSString stringWithFormat:@"客服电话： %@",YXBCompanyTelephoneNO] forState:UIControlStateNormal];
    otherPayBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [otherPayBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    x = 16.5,y = y+h+15,w = self.view.size.width-2*x,h = w/574*66;
//    otherPayBtn.backgroundColor = kRGB(217, 217, 217);
    otherPayBtn.frame = CGRectMake(x, kDeviceHeight-64-50, w,h );
    [self.view addSubview:otherPayBtn];
    
////    y = self.view.frame.size.height - 40;
//    y = y + 50;
//    w = 136, h = 13;
//    x = (320-w)/2.0;
//    UIImageView *kefudianhua = [[UIImageView alloc] initWithFrame:CGRectMake(x, 60, w, h)];
//    kefudianhua.image = [UIImage imageNamed:@"newUserKefu.png"];
//    [footerView addSubview:kefudianhua];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, kDeviceWidth-30, 15)];
    label1.text=@"充值说明:";
    label1.textColor=[UIColor blackColor];
    label1.font=[UIFont systemFontOfSize:15];
    [footerView addSubview:label1];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(15, label1.bottom+10, kDeviceWidth-30, height)];
//    label2.text=@"1.支付宝和微信充值:2.银联支付:3.充值银行卡姓名:";
    label2.numberOfLines=0;
    label2.font=[UIFont systemFontOfSize:12];
    [footerView addSubview:label2];
    
    
    NSMutableAttributedString *string=[[NSMutableAttributedString alloc]initWithString:@"1.支付宝和微信充值:2.银联支付:3.充值银行卡姓名:" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:13]}];
    
    NSMutableAttributedString *str1=[[NSMutableAttributedString alloc]initWithString:@"如出现限额提示,是您绑定银行卡的支付额限制,可联系银行客服或在银行官方网站上修改网上支付限额.\n" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:13]}];
      NSMutableAttributedString *str2=[[NSMutableAttributedString alloc]initWithString:@"每天限额5000元~20000元,限额因绑定的银行卡而不同.\n" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:13]}];
      NSMutableAttributedString *str3=[[NSMutableAttributedString alloc]initWithString:@"必须与在本站绑定信息一致,以免影响您提现" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [string appendAttributedString:str3];
    
    NSString *subStr = @"1.支付宝和微信充值:2.银联支付:";
    [string insertAttributedString:str2 atIndex:subStr.length];
    NSString *subStr2 = @"1.支付宝和微信充值:";
    [string insertAttributedString:str1 atIndex:subStr2.length];
    
    
    label2.attributedText =string;
    label2.textLineSpaceing =6;
    [label2 customWidth:NO andHeight:YES withSize:CGSizeMake(kDeviceWidth-30, 10000000)];
}
#pragma -mark 充值说明
- (void)rightClick{

    NSString *url = [YXBTool getURL:PayInfoHelpUrl params:nil];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"充值说明"];

}

#pragma -mark 更多充值方式
-(void)morePayMethods
{
//    NSString *cookies = [[NSUserDefaults standardUserDefaults] objectForKey:@"COOKIES"];
    //http://www.cpbao.com/mobile/caijinka.jsp?pt=ios&cookie=XXXX
//    NSString *urlStr = [NSString stringWithFormat:@"%@mobile/chongzhika.jsp?pt=ios&cookie=%@&cb=%@",YXB_IP_ADRESS,cookies, SAFARI_CALL_BACK_KEY];
    /*
    NSString * urlStr = [YXBTool getURL:@"mobile/chongzhika.jsp?" params:nil];
    [YXBTool jumpSafariWithUrl:urlStr];
*/
    [YXBTool callTelphoneWithNum:YXBCompanyTelephoneNO];
//    [CPB_SysUtil goToSafariToChongzhi];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [_currentAvailableArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIndentifier";
    //查找是否有重用cell
    PayModeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[PayModeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
//    _tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HistorySepLine.png"]];
        cell.payModel = [_currentAvailableArray objectAtIndex:indexPath.row];
    return  cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //用户选择的支付方式
    PayModeModel *model = [_currentAvailableArray objectAtIndex:indexPath.row];
    self.selectedMode = model.payMode;
    [self jumpPayDetail:model];

}



#pragma -mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    [self requestBankData];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    [super viewWillAppear:YES];
}

#pragma -mark 支付详情页面
-(void)jumpPayDetail:(PayModeModel *)payModeModel
{
    switch (self.selectedMode) {
        case E_WeChatPay:
        {
//            if(![WXApi isWXAppInstalled])
            
            if ([WXApi isWXAppInstalled] == NO) {
                [ProgressHUD showErrorWithStatus:@"请安装微信后重试!"];
                break;
            }
        }
        case E_LLWallet:
        case E_UPPay:
        case E_AliPay:
        case E_VisaCard:
        case E_YiBaoPay:
        case E_wechathird:
        {
            NSLog(@"isCanyu  %@",_payModel.isCanyu);
            PayZhangHuChongZhiViewController *payVC = [[PayZhangHuChongZhiViewController alloc] initWithNibName:@"PayZhangHuChongZhiViewController" bundle:nil];
            payVC.payModeModel = payModeModel;
            payVC.hidesBottomBarWhenPushed = YES;
            payVC.payMode = self.selectedMode;
            payVC.isShowHuodong = NO;
            if ([_payModel.isHuoDong isEqualToString:@"false"])
            {
                payVC.isShowHuodong = NO;
            }
            else
            {
                if ([_payModel.isCanyu isEqualToString:@"true"]) {
                    payVC.isShowHuodong = YES;

                }
            }
            [self.navigationController pushViewController:payVC animated:YES];
            
            break;
        }
            //支付宝
        case E_MobileCard:
        {
//            NSString *cookies = [[NSUserDefaults standardUserDefaults] objectForKey:@"COOKIES"];
//            cookies = [YXBTool getYxbCookie];
            
            //http://www.cpbao.com/mobile/caijinka.jsp?pt=ios&cookie=XXXX
            NSString *url = [YXBTool getURL:@"webView/user/cz/cz.jsp?" params:nil];
            NSLog(@"pay url---%@",url);
            [YXBTool jumpSafariWithUrl:url];
//            NSString *urlStr = [NSString stringWithFormat:@"%@webView/user/cz/cz.jsp?t=1&pt=ios&cookie=%@&cb=%@",YXB_IP_ADRESS,cookies, SAFARI_CALL_BACK_KEY];
//            [YXBTool jumpSafariWithUrl:urlStr];
            break;
        }
        //其他充值方式(先往支付宝跳转)
        case E_BaiduWallet:
        {
            NSString *url = [YXBTool getURL:@"webView/user/cz/cz.jsp?" params:nil];
            NSLog(@"pay url---%@",url);
            [YXBTool jumpSafariWithUrl:url];

            break;
        }
        case E_KuaiJiePay:
        {
            NSString *url = [YXBTool getURL:@"webView/user/cz/bankList.jsp?a=1" params:nil];
            NSLog(@"pay url---%@",url);
            [YXBTool jumpSafariWithUrl:url];
            
            break;
        }

        case E_CCard:
        {
            ///mobile/cz-other_mobile.jsp?join=XXX&amount=XXXX
            
//            NSString *cookies = [[NSUserDefaults standardUserDefaults] objectForKey:@"COOKIES"];
            //http://www.cpbao.com/mobile/caijinka.jsp?pt=ios&cookie=XXXX
//            NSString *urlStr = [NSString stringWithFormat:@"%@mobile/caijinka.jsp?pt=ios&cookie=%@&cb=%@",YXB_IP_ADRESS,cookies, SAFARI_CALL_BACK_KEY];
            NSString *url = [YXBTool getURL:@"mobile/caijinka.jsp?" params:nil];
            [YXBTool jumpSafariWithUrl:url];
            
            break;
            
        }
        default:
            break;
    }
}


#pragma -mark checkCookies
- (void)checkCookies
{
    //    NSString* urlString = @"/user/user!checkLogin.action";
 //   NSString* urlString =@"mobile/phoneCheckLogin.jsp";
//    self.mRequest = [HttpUtl request:self.mRequest url:urlString data:@"{}"
//                              finish:@selector(checkCookiesFinished:) failed:@selector(checkCookiesFailed:)
//                            delegete:self];
}

- (void)checkCookiesFinished:(HttpRequest *)request
{
    if( [self returnSuccessTrue:request.responseString ] ) {
        
        //需要调查
//        [self jumpPayDetail];
        
    } else {
//        //check失败则重新登陆
//        [[LotteryAcountInfo getInstance] requestLogin];
    }
}




- (void)checkCookiesFailed:(HttpRequest *)request
{
    NSLog(@"checkCookiesFailed");
}

#pragma mark -- 判断登陆数据是否登陆成功
-(BOOL) returnSuccessTrue:(NSString*) jsonString{
//    SBJSON *json = [[SBJSON alloc] init];
//    id object = [json objectWithString:jsonString];
//    [json release];
//    
//    NSNumber* value= [object objectForKey:@"success"];
//    if( value.boolValue ){
//        return YES;
//    }
    return NO;
}



#pragma -mark 请求是否参与活动数据

//-(void)requestData
//{
//    self.request = [[[FLHttpRequestUtil alloc] init
//                    ] autorelease];
//    NSString *urlString = @"mobile/checkUserPayActive.jsp";
//    [_request requestByGetWithURL3:urlString target:self finish:@selector(activeFinished:) failed:@selector(activeFailed:)];
////    [ProgressHUD showWithStatus:@"正在加载.." networkIndicator:NO];
////    [_request release];
//}

//-(void)activeFinished:(FLHttpRequestUtil *)request
//{
//    self.payModel = [[[PayModel alloc] initWithDictionary:request.responseDict] autorelease];
//    
////    [ProgressHUD showSuccessWithStatus:@"加载成功"];
//    
//    
//    
//}
//-(void)activeFailed:(FLHttpRequestUtil *)request
//{
//    [ProgressHUD showErrorWithStatus:@"网络连接失败！"];
//    
//}

#pragma -mark 请求支持的付款渠道
-(void)requestBankData
{
    [self.bankRequest clearDelegatesAndCancel];
    self.bankRequest = nil;
//    NSString *urlString = [NSString stringWithFormat:@"%@mobile/payList.jsp?pt=plant",YXB_IP_ADRESS];

    NSString *param = [NSString stringWithFormat:@"pt=ios&v=%@",YXB_VERSION_CODE];
    //企业版
//    NSString *urlString = [YXBTool getURL:@"mobile/payList.jsp?show=1" params:param];
    //上传版
    NSString *urlString = [YXBTool getURL:@"mobile/payList.jsp" params:param];

    NSLog(@"pay urlstr---%@",urlString);
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    self.bankRequest = [[ASIHTTPRequest alloc] initWithURL:url];
    [self.bankRequest setPostBody:[NSMutableData dataWithData:[@"{}" dataUsingEncoding:NSUTF8StringEncoding]]];
    [self.bankRequest setNumberOfTimesToRetryOnTimeout:1];
    [self.bankRequest setTimeOutSeconds:10];
    self.bankRequest.delegate = self;
    [QCConfigTool setHttpSystemHeaderWithRequest:_bankRequest];
    [self.bankRequest startAsynchronous];
//    NSLog(@"hh%@",_bankRequest.requestHeaders);
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    [self.tableView reloadDeals];
    //数据源 图片数组
    NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:
                                  @"llWalletPay.png",
                                  @"upPay.png",
                                  @"aliPay.png",
                                  @"visaPay.png",
                                  @"WeChatPay.png",
                                  @"aliPay.png",//百度钱包，需要改
                                  @"aliPay.png",
                                  @"ccardPay.png",
                                  @"Icon.png",
                                  @"kuaijiepay.png",
                                  @"ic_launcher.png",
                                  @"WeChatPay.png",
                                  nil];
    //数据源 标题数组
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:
                                  @"银行卡快捷支付",
                                  @"银行卡支付",
                                  @"支付宝钱包支付",
                                  @"信用卡支付",
                                  @"微信支付 ",
                                  @"支付宝转账",
                                  @"支付宝转账",
                                  @"彩金卡充值",
                                  @"联通充值",
                                  @"快捷支付",
                                  @"易支付",
                                  @"微信支付",
                                  nil];
    //数据源 简介数组
    NSMutableArray *detailArray = [NSMutableArray arrayWithObjects:
                                   @"无需网银、无手续费、快速安全、支持储蓄卡",
                                   @"简单，安全快捷，无需开通网银",
                                   @"支付宝余额和银行卡支付",
                                   @"无需开通网银，支持全国信用卡",
                                   @"微信支付充值，安全快捷",
                                   @"推荐支付宝用户使用",
                                   @"推荐支付宝用户使用",
                                   @"彩票宝彩金卡充值",
                                   @"联通话费充值",
                                   @"快捷支付",
                                   @"易支付支付充值，安全快捷",
                                   @"微信支付充值，安全快捷",
                                   nil];
    //数据源 支付方式数组(枚举)
    NSMutableArray *payModeArray =  [NSMutableArray arrayWithObjects:
                                     [NSNumber numberWithInt:E_LLWallet],
                                     [NSNumber numberWithInt:E_UPPay],
                                     [NSNumber numberWithInt:E_AliPay],
                                     [NSNumber numberWithInt:E_VisaCard],
                                     [NSNumber numberWithInt:E_WeChatPay],
                                     [NSNumber numberWithInt:E_BaiduWallet],
                                     [NSNumber numberWithInt:E_MobileCard],
                                     [NSNumber numberWithInt:E_CCard],
                                     [NSNumber numberWithInt:E_UniPay],
                                     [NSNumber numberWithInt:E_KuaiJiePay],
                                     [NSNumber numberWithInt:E_YiBaoPay],
                                     [NSNumber numberWithInt:E_wechathird],
                                     nil];
    
    NSMutableArray *valueArray = [NSMutableArray arrayWithCapacity:0];//
    
    for (NSInteger i = 0; i < [titleArray count]; i ++)
    {
        PayModeModel *model = [[PayModeModel alloc] initWithImageName:imageArray[i] title:titleArray[i] detail:detailArray[i] payMode:[payModeArray[i] integerValue]];
        [valueArray addObject:model];
    }
    
    
    NSMutableArray *keyArray = [NSMutableArray arrayWithObjects:
                                @"lianlian",
                                @"unClient",
                                @"alipayClient",
                                @"visapay",
                                @"wxClient",
                                @"other",
                                @"alipayWebTransfer",
                                @"caijincardpay",
                                @"unipay",
                                @"kuaijie",
                                @"payEaseClient",
                                @"weicaiClient",
                                nil];
    
    NSMutableDictionary *judgeDic = [NSMutableDictionary dictionaryWithObjects:valueArray forKeys:keyArray];
    
    SBJsonParser * parser = [[SBJsonParser alloc]init];
    
    NSMutableArray *bankArray = [parser objectWithString:request.responseString];;
//    [bankArray addObject:@"other"];
    NSLog(@"request.responseArray = %lu",(unsigned long)bankArray.count);
     NSLog(@"request.responseArray = %@",bankArray);
    
    //判断数组是否为空
    if (_payModeArray == nil) {
        self.payModeArray = [NSMutableArray arrayWithCapacity:0];
    }
    else
    {
        [self.payModeArray removeAllObjects];
    }
    
    //当前的可以显示的渠道
    if (_currentAvailableArray == nil) {
        self.currentAvailableArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    else
    {
        [_currentAvailableArray removeAllObjects];
    }
//    for (NSDictionary *dic in bankArray) {
//        if ([[dic objectForKey:@"ios"] integerValue] == 1) {
//            PayModeModel *model = [judgeDic objectForKey:[dic objectForKey:@"payway"]];
//            [_currentAvailableArray addObject:model];
//            
//        }
//    }
//#warning kuaijie
//    bankArray = [NSArray arrayWithObject:@"kuaijie"];
    for (NSString *str in bankArray) {
            PayModeModel *model = [judgeDic objectForKey:str];

            [_currentAvailableArray addObject:model];

    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.tableView reloadData];
    NSLog(@"_currentAvailableArray:--%@",_currentAvailableArray);
}
- (void)requestFailed:(ASIHTTPRequest *)request {
    [self.tableView reloadDeals];

    //    NSLog(@"%@",request.responseString);
        [ProgressHUD showErrorWithStatus:@"网络连接失败"];
}




@end
