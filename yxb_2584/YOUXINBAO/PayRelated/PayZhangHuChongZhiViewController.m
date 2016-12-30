//
//  PayZhangHuChongZhiViewController.m
//  LotteryApp
//
//  Created by 程立彬 on 14-4-9.
//  Copyright (c) 2014年 windo. All rights reserved.
//  支付宝版本号

#import "PayZhangHuChongZhiViewController.h"
//#import "UPPayPlugin.h"
//#import "UPPayPluginDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import "RTLabel.h"
#import "PayButton.h"
#import "AppDelegate.h"
#import "YXBTool.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "payRequsestHandler.h"
#import "MyInfoViewController.h"
#import "ZhifuViewController.h"

#import "SPHTTPManager.h"
#import "SPConst.h"
#import "XMLReader.h"
#import "MBProgressHUD.h"
#import "SPayClient.h"


#define MoneyTag 100
#define AlertTag 1001
#define PayHintTime 2.0

#define kMode             @"00"
#define kResult           @"支付结果：%@"

typedef enum {
    JoinActionNo = 0,    // 不参与
    JoinActionYes = 1    // 参与
}JoinAction;


@interface PayZhangHuChongZhiViewController ()
{
    JoinAction join;//是否参加活动(是否已点击)
}



@property (nonatomic, retain) LLPaySdk *llSdk;//连连支付
//
//@property(nonatomic,retain)FLHttpRequestUtil *request_pay;
//@property(nonatomic,retain)FLHttpRequestUtil *request;


@property(nonatomic, retain)NSArray*        moneyArray;

@property(nonatomic, retain)UILabel*        moneyLabel;
@property (retain, nonatomic) IBOutlet UIView *backView;

@property (retain, nonatomic) IBOutlet UITextField *moneyText;
@property (retain, nonatomic) IBOutlet UIButton *songBtn;
@property (retain, nonatomic) IBOutlet UILabel *userNameLabel;

//@property (retain, nonatomic) IBOutlet UILabel *moneyLabel;
@property (retain, nonatomic) IBOutlet RTLabel *jingshiLabel;

@property (retain, nonatomic) IBOutlet UIView *txBackView;
@property (retain, nonatomic) IBOutlet UITapGestureRecognizer *keyBoardGesture;
@property (nonatomic,strong)  MBProgressHUD *hud;



@end

@implementation PayZhangHuChongZhiViewController

-(void)dealloc{
    NSLog(@"PayZhangHuChongZhiViewController is dealloc");
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
    NSLog(@"_isShowHuodong%d",_isShowHuodong);
//    [self setNavTitle:_payModeModel.logoTitle];
    [self setTitle:_payModeModel.logoTitle];
    [self setBackView];
    
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 0, 21)];
    _moneyLabel.font = [UIFont systemFontOfSize:13];
    _moneyLabel.textColor = rgb(176, 120, 42, 1);
    [self.backView addSubview:_moneyLabel];

    _keyBoardGesture.delegate = self;
    _moneyText.delegate = self;
    _moneyText.keyboardType = UIKeyboardTypeNumberPad;
//    _result = @selector(paymentResult:);
    
    [_songBtn setBackgroundImage:[UIImage imageNamed:@"song50.png"] forState:UIControlStateNormal];
    [_songBtn setBackgroundImage:[UIImage imageNamed:@"song50_highlight.png"] forState:UIControlStateSelected];
    _songBtn.layer.cornerRadius = 5.0;
    
    
    _txBackView.layer.borderWidth = 1.0;
    _txBackView.layer.borderColor = rgb(172, 172, 172, 1).CGColor;
    
    QCUserModel *user = [[QCUserManager sharedInstance]getLoginUser];
    
    NSString *userName = user.user.nickname;
    NSString *money = [NSString stringWithFormat:@"账户余额 ：%@ 元",user.user.totalMoney];
    NSMutableAttributedString *strLabel4 = [[NSMutableAttributedString alloc] initWithString:money];
    [strLabel4 addAttribute:NSForegroundColorAttributeName value:rgb(235, 0, 24, 1) range:[money rangeOfString:user.user.totalMoney]];
    _moneyLabel.attributedText = strLabel4;

//    money = [NSString stringWithFormat:@"<font size=13 color='#BB0000'>%@</font> <font size=13 color='#996629'>元</font>", money];
    //    _userNameLabel.text = userName;
    //    _moneyLabel.text = money;
    
    
//    NSString *jingshi = @"<font size=13 color='#BB0000'>注: </font><font size=13 color='#6C6C6C'>充值金额提现，需消费充值金额的</font> <font size=15 color='#BB0000'>20%</font><font size=13 color='#6C6C6C'>方可提现,信用卡暂不支持提现申请。</font>";
    NSString *jingshi=nil;
    if (kDeviceWidth==320) {
            jingshi = @"<font size=13 color='#BB0000'>注: <font size=13 color='#6C6C6C'>暂不支持信用卡充值,提现。如出现误充,将原路返还,并收取1%的手续费。\n      用户在大额不方便充值的情况下，可选择银行汇款到公司银行账户，再联系客服核实确认后，可直接在账户加款。</font>";
    }
    else{

            jingshi = @"<font size=13 color='#BB0000'>注: <font size=13 color='#6C6C6C'>暂不支持信用卡充值,提现。如出现误充,将原路返还,并收取1%的手续费。\n     用户在大额不方便充值的情况下，可选择银行汇款到公司银行账户，再联系客服核实确认后，可直接在账户加款。</font>";
    }
    _jingshiLabel.text = jingshi;
    _jingshiLabel.lineBreakMode = 0;

    
    if (userName != nil && [userName length] > 0) {
        _userNameLabel.text = userName;
        
    }
    else
    {
        _userNameLabel.text = @"==";
    }
    
//    if (money != nil && [money length] > 0) {
//        _moneyLabel.text = money;
//        
//    }
//    else
//    {
//        _moneyLabel.text = @"==";
//    }
    
    [_moneyText addTarget:self action:@selector(tectFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.moneyArray = [NSArray arrayWithObjects:@"100",@"200",@"300",@"500",@"1000", nil];
    
    //    _songBtn.hidden = YES;
    
    
    if (_isShowHuodong == NO) {
        _txBackView.frame= CGRectMake(_txBackView.frame.origin.x, _txBackView.frame.origin.y, _txBackView.frame.size.width+_songBtn.frame.size.width+10, _txBackView.frame.size.height);
        _moneyText.frame= CGRectMake(_moneyText.frame.origin.x, _moneyText.frame.origin.y, _moneyText.frame.size.width+_songBtn.frame.size.width+10, _moneyText.frame.size.height);
        
        _songBtn.hidden = YES;
    }
    
    //设置textfield place
    [_moneyText setValue:[UIFont systemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
    
    
    //    _moneyText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _moneyText.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    
    //    _txBackView.hidden = YES;//数据请求回来之前隐藏输入金额的文本框，因为活动与否显示不一
    //    self.view.backgroundColor = tableCellBgColor;
    //--------------/////

    _moneyLabel.width = [YXBTool getFontSizeWithString:money font:[UIFont systemFontOfSize:13] constrainSize:CGSizeMake(10000, 21)].width;
    _moneyLabel.left = kDeviceWidth - _moneyLabel.width-10;
    // Do any additional setup after loading the view from its nib.
}
//



//充值成功返回上个页面
- (void)overPopToviewctr {
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)moneySelected:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"money---tag =  %ld",(long)sender.tag-100);
    [(PayButton *)sender valueChanged];
    
    for (int i = 101; i < 107; i++) {
        if (sender.tag != i) {
            PayButton *btn = (PayButton *)[sender.superview viewWithTag:i];
            btn.selected = NO;
            [btn valueChanged];
        }
        
        
    }
    NSInteger tag = sender.tag - MoneyTag;
    if (sender.selected) {
        if (_moneyArray != nil && [_moneyArray count]>0) {
            if (tag >= 0 && tag <= ([_moneyArray count])) {
                //                _moneyText.font = [UIFont systemFontOfSize:20];
                _moneyText.text = [_moneyArray objectAtIndex:tag-1];
                [_moneyText resignFirstResponder];
                //                _moneyText.text = [NSString stringWithFormat:@"%@  元",[_moneyArray objectAtIndex:tag-1]];
            }
            
        }
        
    }
    else
    {
        //        _moneyText.font = [UIFont systemFontOfSize:13];
        _moneyText.text = @"";
        [_moneyText resignFirstResponder];
    }
}

#pragma -mark 退出键盘
- (IBAction)cancelKeyBoard:(id)sender {
    [_moneyText resignFirstResponder];
}


#pragma -mark 确认付款
- (IBAction)payActionSure:(id)sender
{
//    [self getHomePageInfoRequest];

//    [self wxPay];
    [self.view endEditing:YES];
    if ([_moneyText.text integerValue] == 0) {
        [ProgressHUD showErrorWithStatus:@"输入金额错误!"];
        return;
    }
    
    if (join == JoinActionNo && [_moneyText.text intValue] >= 50 && _isShowHuodong) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"活动提示"
                                                        message:@"目前有充50送50活动，是否参与."
                                                       delegate:self
                                              cancelButtonTitle:@"不参与"
                                              otherButtonTitles:@"参与", nil];
        alert.tag = AlertTag+2;
        [alert show];
    }
    
    else
    {
        if (join == JoinActionYes && [_moneyText.text intValue] < 50) {
//            [ProgressHUD showErrorWithStatus:@"参加活动充值金额至少50元"];
            
        }
        else
        {
            
            if (join == JoinActionYes && [_moneyText.text intValue] >= 50)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"活动提示"
                                                                message:@"新用户首次充值满50送50元：充值完成即得20元，剩余30元将分三个月返还。参与活动充值，充值金额及网站赠送金额都转入红包帐户。"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"确定", nil];
                alert.tag = AlertTag+1;
                [alert show];
                
                
            }
            else
            {
                if ([_moneyText.text intValue] < 1) {
                    [self payAction];
                    if ([_moneyText isFirstResponder]) {
//                        [ProgressHUD showWithStatus:@"充值金额最少1元" maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeNone networkIndicator:NO];
                    }
                    else
                    {
//                        [ProgressHUD showErrorWithStatus:@"充值金额最少1元"];

                    }
                    
                }
                else
                {
                    [self payAction];
                }
                
            }
            
            
            
        }
        
    }
    
    
}


#pragma mark -- 易宝 支付
//-----------------易宝 支付 begin-------------------------------
#if TARGET_IPHONE_SIMULATOR
//模拟器
#elif TARGET_OS_IPHONE
//真机
- (void)yiBaoPayWithDic:(NSDictionary *)dic {
    
    if ([_moneyText.text isEqualToString:@""] || _moneyText.text == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入金额" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
    }
    else {
        self.progressHUD = [PMCProgressViewHUD CHProgressViewHUDWithTitle:@"请稍候..." toView:self.view];
        
        NSString *requestString = [self payForNormal:dic];
        NSLog(@"下单接口：%@",requestString);
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *encodeString = [requestString stringByAddingPercentEscapesUsingEncoding:enc];
        NSData *requestData = [encodeString dataUsingEncoding:NSUTF8StringEncoding];
        [_orderRequest sendPOSTRequest:kOrderUrl parametersData:requestData withTag:@""];
        
    }
}
//易宝 支付 参数
- (NSString *) payForNormal:(NSDictionary *)dic
{
    //1 商户号
    NSString  *v_mid = dic[@"mid"];
    _shanghuhao = v_mid;
    //2 订单生成日期
    NSDate *date = [NSDate date];
    NSDateFormatter *formmater = [[NSDateFormatter alloc] init];
    formmater.dateFormat = @"yyyyMMdd";
    NSString  *v_ymd = [formmater stringFromDate:date];
    //3 订单编号
    NSString *v_oid = [NSString stringWithFormat:@"%@-%@-%@",v_ymd,v_mid,dic[@"orderId"]];
    //4 订单总金额
    NSString *v_amount = _moneyText.text;
    //5 币种  0人民币 1美元
    NSString *v_moneytype = @"0";
    //6 客户证件类型  01 身份证 02 护照 03 军人证  04 台胞证 05 港澳居民通行证
    NSString  *v_idtype =  @"00";
    //7 客户证件号码,长度不超过20位字符
    NSString  *v_idnumber = @"000000000000000";
    //8 终端机编号
    NSString *v_rcvname = v_mid;
    //9 收货人地址
    NSString  *v_rcvaddr = v_mid;
    //10 收货人电话 13600000000
    NSString  *v_rcvtel = @"00000000";
    //11 收货人邮编
    NSString  *v_rcvpost = @"123456";
    
    //12 订货人邮箱
    NSString  *v_ordmail = @"";
    //13 下单终端类型  0client 1：wap
    NSString  *v_orderstatus = @"0" ;
    //14 订货人姓名,总长不超过64个字符 掌中付用于客户验证码，统一采用:0000
    NSString  *v_ordername = @"0000";
    
    //15 返回商户页面地址
    NSString  *v_url = YXB_IP_address_web;
    //16 商户自定义参数，传操作员编号
    NSString  *v_merdata = @"admin";
    //24 订单数字指纹
    NSString *plainTest = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",v_moneytype,v_ymd,v_amount,v_rcvname,v_oid,v_mid,v_url];
    _orderMd5Info = [PMCHmacmd5AndDescrypt HMACMD5WithKey:@"test" andData:plainTest];
    //
    NSString *requestString = [NSMutableString stringWithFormat:@"v_mid=%@&v_oid=%@&v_rcvname=%@&v_rcvaddr=%@&v_rcvtel=%@&v_rcvpost=%@&v_ordmail=%@&v_idtype=%@&v_idnumber=%@&v_amount=%@&v_ymd=%@&v_orderstatus=%@&v_ordername=%@&v_moneytype=%@&v_url=%@&v_merdata=%@&v_md5info=%@",v_mid,v_oid,v_rcvname,v_rcvaddr,v_rcvtel,v_rcvpost,v_ordmail,v_idtype,v_idnumber,v_amount,v_ymd,v_orderstatus,v_ordername,v_moneytype,v_url,v_merdata,_orderMd5Info];
    return  requestString;
}
#pragma mark - PEOrderRequestDelegate
-(void)request:(PMCRequest *)request failed:(NSString *)errorMessage
{
    [self.progressHUD hide];
    UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                         message:errorMessage
                                                        delegate:nil
                                               cancelButtonTitle:@"确认"
                                               otherButtonTitles:nil];
    [alertView show];
}
- (void)request:(PMCRequest *)request success:(id)XMLData
{
    [self.progressHUD hide];
    NSLog(@"下订单接口返回数据：%@", XMLData);
    if (!_payeaseComPayment) {
        _payeaseComPayment = [[PayEaseComPayment alloc] init];
        _payeaseComPayment.delegate = self;
    }
    
    PMCMakeOrderInfo *makeOrderInfo = [[PMCMakeOrderInfo alloc] initWithXMLData:XMLData];
    if ([makeOrderInfo.status isEqualToString:@"0"]) {
        [_payeaseComPayment sendDataWithParentController:self orderID:makeOrderInfo.oid merchantID:_shanghuhao orderMd5Info:_orderMd5Info otherInfo:@{kBankCardNumKey:@"", kEnableEditBankNumTextKey:@(YES)}];
    }
    else
    {
        [ProgressHUD showErrorWithStatus:makeOrderInfo.statusDesc];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:makeOrderInfo.statusDesc delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
    }
}
#pragma mark - PayEaseComPaymentDelegate
-(void)PayEaseComResultStatus:(PayEaseComPayStatus)payStatus statusDescription:(NSString *)statusDesc
{
    [ProgressHUD showErrorWithStatus:statusDesc];
//    NSString *result = [NSString stringWithFormat:@"%d:%@",payStatus, statusDesc];
//    UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:nil message:result delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
//    [alertView show];
}

#endif
//-----------------易宝 支付 end-------------------------------



-(void)payAction
{
//    [self.iCPBaoCookie che]
    
    if ((_songBtn.selected && join == JoinActionYes) || (!_songBtn.selected && join == JoinActionNo))
    {
        switch (_payMode) {
            case E_LLWallet:
            case E_YiBaoPay:
            case E_UPPay:
            case E_AliPay:
            {
                [self generateTN];
                break;
                
            }
            case E_wechathird:
            {
                if (![WXApi isWXAppInstalled]) {
                    [ProgressHUD showSuccessWithStatus:@"请安装微信客户端后重试!"];
                    return;
                }
                [self generateTN];
                break;

            }
            case E_WeChatPay:
            {
                [self getHomePageInfoRequest];
                break;
                
            }
            case E_BaiduWallet:
            {
                ///mobile/cz-other_mobile.jsp?join=XXX&amount=XXXX
//                http://www.cpbao.com/mobile/baidurecharge.jsp?amount=&join=
                NSString *cookies = [[NSUserDefaults standardUserDefaults] objectForKey:@"COOKIES"];
                if (cookies == nil) {
                    cookies = @"";
                }
                
                NSString *urlStr = [NSString stringWithFormat:@"%@mobile/baidurecharge.jsp?amount=%@&join=%d&cookie=ZCLOGIN=%@",YXB_IP_ADRESS,_moneyText.text,join,cookies];
                [YXBTool jumpSafariWithUrl:urlStr];
                
                break;
                
            }
            case E_VisaCard:
            {
                ///mobile/cz-other_mobile.jsp?join=XXX&amount=XXXX
                
                NSString *cookies = [[NSUserDefaults standardUserDefaults] objectForKey:@"COOKIES"];
                if (cookies == nil) {
                    cookies = @"";
                }
                
                NSString *urlStr = [NSString stringWithFormat:@"%@mobile/cz-other_mobile.jsp?join=%d&amount=%@&cookie=ZCLOGIN=%@",YXB_IP_ADRESS,join,_moneyText.text,cookies];
                [YXBTool jumpSafariWithUrl:urlStr];
                
                break;
                
            }
            case E_MobileCard:
            {
                break;
                
            }
            case E_CCard:
            {
                break;
                
            }
                
                
            default:
                break;
        }
        
    }
}

- (void)generateTN
{
//    self.request_pay = [[[FLHttpRequestUtil alloc] init] autorelease];
//    CGFloat money = [[_moneyText text] floatValue];
//    NSString *money = _moneyText.text;
//    NSString *money = @"0.01";

    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak PayZhangHuChongZhiViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        [ProgressHUD dismiss];

    } error:^(int d, THttpOperatorErrorCode error) {
        [ProgressHUD dismiss];

        if (error == EHttp_Operator_StatusCodeError) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(TResultSet* r, int taskid) {
        
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    [ProgressHUD showWithStatus:@"正在请求，请稍后..." maskType:ProgressHUDMaskTypeGradient tipsType:ProgressHUDTipsTypeLongBottom];

}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    UserManager* _currUser = (UserManager*)  [httpOperation getAopInstance:[UserManager class] returnValue:[TResultSet class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    //        NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:userModel.user.pwd]]];

    if (_payMode == E_LLWallet) {
        [_currUser lianlian_recharge:userModel.user.yxbToken money:_moneyText.text];
    }else if (_payMode == E_AliPay){
        [_currUser alipay_recharge:userModel.user.yxbToken money:_moneyText.text];
    }else if (_payMode == E_UPPay){
        [_currUser gainUnionPayTn:userModel.user.yxbToken money:_moneyText.text];
    }else if (_payMode == E_YiBaoPay){
        [_currUser gainPayEaseString:userModel.user.yxbToken money:_moneyText.text];
    }else if (_payMode == E_wechathird){
        
        [_currUser gainWeicaiPayTn:userModel.user.yxbToken money:_moneyText.text];
    }

}

//请求完成
-(void)httpLoadComplete:(TResultSet *)r{
    [ProgressHUD dismiss];
    if (r.errCode == 0) {
        /*
         [[AlipaySDK defaultService] payOrder:r.errString fromScheme:@"yxbaoback" callback:^(NSDictionary *resultDic) {
         
         [self alipayResultWithResponse:resultDic];
         }];
         */
        NSString *orderString = nil;

        
        switch (_payMode) {
            case E_YiBaoPay:
            {
#if TARGET_IPHONE_SIMULATOR
                [ProgressHUD showErrorWithStatus:@"请使用iPhone手机！"];
#elif TARGET_OS_IPHONE
                _orderRequest = [[PMCRequest alloc] init];
                [_orderRequest setDelegate:self];
                NSData *jsonData = [r.resString dataUsingEncoding:NSUTF8StringEncoding];
                NSError *err;
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:&err];
                [self yiBaoPayWithDic:dic];
#endif
                
                break;
            }
            case E_LLWallet:
            {
                NSData *jsonData = [r.errString dataUsingEncoding:NSUTF8StringEncoding];
                NSError *err;
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:&err];
                [self pay:dic];
                
                break;
            }
            case E_UPPay:
            {
                if (r.resString != nil && [r.resString length] > 1) {
                    orderString = r.resString;
//                    [UPPayPlugin startPay:orderString mode:kMode viewController:self delegate:self];
                    [[UPPaymentControl defaultControl] startPay:orderString fromScheme:@"uppayback" mode:kMode viewController:self];
                }
                else
                {
                    [ProgressHUD show];
                    [ProgressHUD dismissWithSuccess:@"订单错误，请重试" afterDelay:PayHintTime];
                    //        [ProgressHUD showErrorWithStatus:@"请求订单失败！请重试"];
                }

                
                
                
                break;
                
            }
            case E_AliPay:
            {
                [[AlipaySDK defaultService] payOrder:r.errString fromScheme:@"yxbaoback" callback:^(NSDictionary *resultDic) {
                    
                    [self alipayResultWithResponse:resultDic];
                }];
                
                break;
            }
            case E_WeChatPay:
            {
                //                    /*
                //                    NSDictionary *object = [NSDictionary dictionary];
                //                    PayReq *request = [[PayReq alloc] init];
                //                    request.partnerId = [object objectForKey:@"partnerid"];
                //                    request.prepayId= [object objectForKey:@"prepayid"];
                //                    request.package = [object objectForKey:@"package"];
                //                    request.nonceStr= [object objectForKey:@"noncestr"];
                //                    request.timeStamp= [[object objectForKey:@"timestamp"] unsignedIntValue];
                //                    request.sign= [object objectForKey:@"sign"];
                //                    //以前版本使用 safeSendSeq
                //                    [WXApi sendReq:request];
                //                    */
                //                    //默认为分 转换为元
                //                    double yMoney = [money doubleValue] * 100;
                //                    NSString *sMoney = [NSString stringWithFormat:@"%ld",(long)yMoney];
                ////                    [self wxPay:sMoney];
                //                    [self getHomePageInfoRequest];
                
                break;
            }
            case E_wechathird:
            {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[r.resString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
                NSLog(@"paydic---%@",dic);
                __block typeof(self) weakSelf = self;
                
                NSMutableDictionary *post = [NSMutableDictionary dictionaryWithDictionary:dic];
                [post removeObjectForKey:@"state"];
                //                [post removeObjectForKey:@"sign"];
                //                NSDictionary * postData = [self packingRequestForm:post];
                
                
                //调用支付预下单接口
                [[SPHTTPManager sharedInstance] post:kSPconstWebApiInterface_spay_pay_gateway
                                            paramter:post
                                             success:^(id operation, id responseObject) {
                                                 
                                                 
                                                 //返回的XML字符串,如果解析有问题可以打印该字符串
//                                                 NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
                                                 
                                                 NSError *erro;
                                                 //XML字符串 to 字典
                                                 //!!!! XMLReader最后节点都会设置一个kXMLReaderTextNodeKey属性
                                                 //如果要修改XMLReader的解析，请继承该类然后再去重写，因为SPaySDK也是调用该方法解析数据，如果修改了会导致解析失败
                                                 NSDictionary *info = [XMLReader dictionaryForXMLData:(NSData *)responseObject error:&erro];
                                                 
                                                 NSLog(@"预下单接口返回数据-->>\n%@",info);
                                                 
                                                 
                                                 //判断解析是否成功
                                                 if (info && [info isKindOfClass:[NSDictionary class]]) {
                                                     
                                                     NSDictionary *xmlInfo = info[@"xml"];
                                                     
                                                     NSInteger status = [xmlInfo[@"status"][@"text"] integerValue];
                                                     
                                                     //判断SPay服务器返回的状态值是否是成功,如果成功则调起SPaySDK
                                                     if (status == 0) {
                                                         
                                                         [weakSelf.hud hide:YES];
                                                         
                                                         //获取SPaySDK需要的token_id
                                                         NSString *token_id = xmlInfo[@"token_id"][@"text"];
                                                         
                                                         //获取SPaySDK需要的services
                                                         NSString *services = xmlInfo[@"services"][@"text"];
                                                         
                                                         {
                                                             NSNumber *amount = [NSNumber numberWithInteger:[_moneyText.text integerValue]];
                                                             //调起SPaySDK支付
                                                             [[SPayClient sharedInstance] pay:self
                                                                                       amount:amount
                                                                            spayTokenIDString:token_id
                                                                            payServicesString:services
                                                                                       finish:^(SPayClientPayStateModel *payStateModel,
                                                                                                SPayClientPaySuccessDetailModel *paySuccessDetailModel) {
                                                                                           
                                                                                           //更新订单号
                                                                                           //                                                                                           weakSelf.out_trade_noText.text = [NSString spay_out_trade_no];
                                                                                           
                                                                                           
                                                                                           if (payStateModel.payState == SPayClientConstEnumPaySuccess) {
                                                                                               
                                                                                               NSLog(@"支付成功");
                                                                                               NSLog(@"支付订单详情-->>\n%@",[paySuccessDetailModel description]);
                                                                                           }else{
                                                                                               NSLog(@"支付失败，错误号:%d",payStateModel.payState);
                                                                                           }
                                                                                           
                                                                                       }];
                                                             
                                                             
                                                         }
                                                         
                                                         //                                                         else{
                                                         
                                                         //                                                             [weakSelf swiftlyPay:amount spayTokenIDString:token_id payServicesString:services];
                                                         //                                                             NSLog(@"swift used");
                                                         //                                                         }
                                                         
                                                     }else{
                                                         weakSelf.hud.labelText = xmlInfo[@"message"][@"text"];
                                                         [weakSelf.hud hide:YES afterDelay:2.0];
                                                     }
                                                 }else{
                                                     weakSelf.hud.labelText = @"预下单接口，解析数据失败";
                                                     [weakSelf.hud hide:YES afterDelay:2.0];
                                                 }
                                                 
                                                 
                                             } failure:^(id operation, NSError *error) {
                                                 
                                                 weakSelf.hud.labelText = @"调用预下单接口失败";
                                                 [weakSelf.hud hide:YES afterDelay:2.0];
                                                 NSLog(@"调用预下单接口失败-->>\n%@",error);
                                             }];
                
                break;
            }
                
            default:
                break;
        }
        
        
    }else{
        NSString * string = r.errString;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }

}
-(void)wxPay:(NSString *)money
{
    //{{{
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    
    //创建支付签名对象
    payRequsestHandler *req = [payRequsestHandler alloc];
    //初始化支付签名对象
    [req init:YXBWeChatLoginKey mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    
    //}}}
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demoWithMoney:money];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
//        [self alert:@"提示信息" msg:debug];
        [YXBTool showAlertViewWithString:debug];
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }
}


#pragma mark -- 数据请求
-(void)getHomePageInfoRequest
{
    QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];

//    NSString *money = @"0.01";
    NSString *money = _moneyText.text;
    NSString *url=[NSString stringWithFormat:@"userId=%ld&money=%@",(long)model.user.t_id,money];
    url = [NSString stringWithFormat:@"mobile/wechatrecharge.jsp?%@",url];
    NSString *URLString = [NSString stringWithFormat:@"%@", url];
    URLString = [YXBTool getURL:url params:nil];
    NSURL *requestURL = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *postData = [@"{}" dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"urlstr---%@",URLString);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:requestURL];
    [request setPostBody:[NSMutableData dataWithData:postData]];
    [request setCompletionBlock:^{
        [ProgressHUD dismiss];
//        NSLog(@"pay response---%@",request.responseString);
        if ([request.responseString length]) {
            
            NSError* error = nil;
            id object = [NSJSONSerialization JSONObjectWithData:[request.responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
            if (object != nil &&  [[object objectForKey:@"errCode"] integerValue] == 0)
            {
                PayReq *request = [[PayReq alloc] init];
                request.openID              = [object objectForKey:@"appId"];
                request.partnerId = [object objectForKey:@"partnerId"];
                request.prepayId= [object objectForKey:@"prepayId"];
                request.package = [object objectForKey:@"packageValue"];
                request.nonceStr= [object objectForKey:@"nonceStr"];
                request.timeStamp= [[object objectForKey:@"timeStamp"] unsignedIntValue];
                request.sign= [object objectForKey:@"sign"];
                //以前版本使用 safeSendSeq
                BOOL b = [WXApi sendReq:request];
                if (b == YES) {

                }

            }
            else
            {
                [ProgressHUD showErrorWithStatus:[object objectForKey:@"errString"]];
            }
            
        }
    }];
    
    [request setFailedBlock:^{
//        NSLog(@"pay failed response---%@",request.responseString);

        [ProgressHUD showErrorWithStatus:@"对不起，服务器繁忙！"];
//        NSLog(@"首页请求失败");
        
    }];
    
    [request startAsynchronous];
    [ProgressHUD showWithStatus:@"正在请求，请稍后..." maskType:ProgressHUDMaskTypeGradient tipsType:ProgressHUDTipsTypeLongBottom];

}



//-(void)requestPayFinished:(NSDictionary *)request
//{
//    NSLog(@"dict---%@",request);
//    
//    if ([self.moneyText isFirstResponder]) {
//        [self.moneyText resignFirstResponder];
//    }
//    
//    NSDictionary *dic = request;
//    NSString *orderString = nil;
//    if (dic == nil) {
//        return;
//    }
//    switch (_payMode)
//    {
//        case E_LLWallet:
//        {
//            if ([[dic objectForKey:@"state"] isEqualToString:@"success"])
//            {
//                NSDictionary *order =[dic objectForKey:@"json"];
//                NSLog(@"order:  %@",order);
//                [self pay:order];
//            }
//            
//            else
//            {
////                [ProgressHUD show];
////                [ProgressHUD dismissWithSuccess:@"订单错误，请重试" afterDelay:PayHintTime];
//                //        [ProgressHUD showErrorWithStatus:@"请求订单失败！请重试"];
//            }
//            break;
//
//        }
//        case E_UPPay:
//        {
//            if ([[dic objectForKey:@"success"] intValue] == 1) {
//                orderString =[dic objectForKey:@"tn"];
////                [UPPayPlugin startPay:orderString mode:kMode viewController:self delegate:self];
//            }
//            
//            else
//            {
////                [ProgressHUD show];
////                [ProgressHUD dismissWithSuccess:@"订单错误，请重试" afterDelay:PayHintTime];
//                //        [ProgressHUD showErrorWithStatus:@"请求订单失败！请重试"];
//            }
//            
//
//            
//            break;
//            
//        }
//        case E_AliPay:
//        {
//            if ([[dic objectForKey:@"success"] intValue] == 1) {
//                orderString =[dic objectForKey:@"urlStr"];
//                NSString *appScheme = @"caipiao";
//#ifdef SAFARI_CALL_BACK_KEY
//                appScheme = SAFARI_CALL_BACK_KEY;
//#endif
//                
////                [AlixLibService payOrder:orderString AndScheme:appScheme seletor:f_result target:self];
////                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
////                
////                    [self alipayResultWithResponse:resultDic];
////                }];
//            }
//            else
//            {
////                [ProgressHUD show];
////                [ProgressHUD dismissWithSuccess:@"订单错误，请重试" afterDelay:PayHintTime];
//                //        [ProgressHUD showErrorWithStatus:@"请求订单失败！请重试"];
//            }
//            
//            break;
//            
//
//        }
//            
//        case E_WeChatPay:
//        {
////           
////            if (([dic objectForKey:@"retcode"] != nil) && ([[dic objectForKey:@"retcode"] intValue] == 0)) {
////                PayReq *request = [[[PayReq alloc] init] autorelease];
////                request.partnerId = [dic objectForKey:@"partnerid"];
////                request.prepayId= [dic objectForKey:@"prepayid"];
////                request.package = [dic objectForKey:@"package"];
////                request.nonceStr= [dic objectForKey:@"noncestr"];
////                request.timeStamp= [[dic objectForKey:@"timestamp"] unsignedIntValue];
////                request.sign= [dic objectForKey:@"sign"];
////                BOOL b = [WXApi safeSendReq:request];
////                if (b == YES) {
//////                    int i = 0;
////                }
////            }
////            else
////            {
////                [ProgressHUD show];
////                [ProgressHUD dismissWithSuccess:@"订单错误，请重试" afterDelay:PayHintTime];
////                //        [ProgressHUD showErrorWithStatus:@"请求订单失败！请重试"];
////            }
//            
//            break;
//            
//            
//        }
//             
//
//            
//        default:
//            break;
//    }
//
//    
//    NSLog(@"payRequestFinished---%@",orderString);
//    
//    
//    
//    
//}

//-(void)requestPayFailed:(NSDictionary *)request
//{
////    [ProgressHUD show];
////    [ProgressHUD dismissWithSuccess:@"请求订单失败！请重试" afterDelay:PayHintTime];
//    NSLog(@"payRequestFailed ----: %@",request);
//    
//}

#pragma -mark 支付宝回调
//支付宝新版已改为block回调

-(void)alipayResultWithResponse:(NSDictionary *)resultDic
{
    NSLog(@"result = %@", resultDic);
    NSLog(@"memo --%@",[resultDic objectForKey:@"memo"]);
    NSString *result = [resultDic objectForKey:@"result"];
    NSInteger resultStatus = [[resultDic objectForKey:@"resultStatus"] integerValue];
    if (result) {
        switch (resultStatus) {
            case 9000:
            {
//                [[SHAREDAPP getCurrentUINavigationController] popToRootViewControllerAnimated:YES];
                [self overPopToviewctr];
                [ProgressHUD showSuccessWithStatus:@"支付成功！"];
                
            }
                break;
                
            default:
            {
                //交易失败
                [ProgressHUD showErrorWithStatus:@"支付宝充值失败！"];
                
            }
                break;
        }
        
    }
    else
    {
        //交易失败
        [ProgressHUD showErrorWithStatus:@"支付宝充值失败！"];
        
    }
    
    
}

/*
-(void)paymentResult:(NSString *)originResult
{
        //结果处理
    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:originResult] autorelease];
 
    if (result)
    {
 
		if (result.statusCode == 9000)
        {
            [[(AppDelegate *)[UIApplication sharedApplication].delegate getCurrentUINavigationController] popToRootViewControllerAnimated:YES];

            [ProgressHUD showSuccessWithStatus:@"订单支付成功！"];
 
        }
        else
        {
            //交易失败

            [ProgressHUD showErrorWithStatus:@"交易失败！"];

            
        }
    }
    else
    {
        //交易失败
        
        [ProgressHUD showErrorWithStatus:@"交易失败！"];

        
    }
    
}

*/

#pragma -mark 银联回调
-(void)UPPayPluginResult:(NSString*)result
{
    NSLog(@"UPPayResult--- %@",result);
    NSString *resultTitle = nil;
    if ([result isEqualToString:@"success"]) {
        resultTitle = @"支付成功";
        for (UIViewController* controller in [YXBTool getCurrentNav].viewControllers) {
            if ([controller isKindOfClass:[ZhifuViewController class]]) {
                [(ZhifuViewController*)controller showAlert];
            }
        }
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count] -3)] animated:YES];
//        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//        if( [[userDefaultes objectForKey:@"user111"] isEqualToString:@"111"]){
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"您已充值成功，立即支付给好友，完成借款操作吧！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//            [alert show];
//            
//            
//        }

        NSString* msg = [NSString stringWithFormat:kResult, resultTitle];
        [ProgressHUD showSuccessWithStatus:msg];
       
        
//        for (UIViewController *controller in [[YXBTool getCurrentNav] viewControllers]) {
//            if ([controller isKindOfClass:[MyInfoViewController class]]) {
//                [[YXBTool getCurrentNav] popToViewController:controller animated:YES];
//            }
//        }
//
//        [self overPopToviewctr];
        
    }
    else if ([result isEqualToString:@"fail"])
    {
        resultTitle = @"支付失败";
        NSString* msg = [NSString stringWithFormat:kResult, resultTitle];
        [ProgressHUD showErrorWithStatus:msg];

        
    }
    else if ([result isEqualToString:@"cancel"])
    {

        resultTitle = @"用户取消支付";
        
        NSString* msg = [NSString stringWithFormat:kResult, resultTitle];
        //交易失败
        [ProgressHUD showErrorWithStatus:msg];

        
    }
    
    
    
}



#pragma -mark 连连支付
- (void)pay:(NSDictionary *)llOrder
{
    self.llSdk = [[LLPaySdk alloc] init];
    [LLPaySdk switchToTestServer:NO];
    _llSdk.sdkDelegate = self;
    [self.llSdk presentPaySdkInViewController:self withTraderInfo:llOrder];
}

#pragma -mark 连连支付回调
 //订单支付结果返回，主要是异常和成功的不同状态
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic
{
    NSString *msg = @"支付异常";
    switch (resultCode) {
        case kLLPayResultSuccess:
        {
            msg = @"支付成功";
            
            NSString* result_pay = dic[@"result_pay"];
            if ([result_pay isEqualToString:@"SUCCESS"])
            {
                msg = @"支付成功";
                [self overPopToviewctr];
            }
            else if ([result_pay isEqualToString:@"PROCESSING"])
            {
                msg = @"支付单处理中";
            }
            else if ([result_pay isEqualToString:@"FAILURE"])
            {
                msg = @"支付单失败";
            }
            else if ([result_pay isEqualToString:@"REFUND"])
            {
                msg = @"支付单已退款";
            }
        }
            break;
        case kLLPayResultFail:
        {
            msg = @"支付失败";
        }
            break;
        case kLLPayResultCancel:
        {
            msg = @"支付取消";
        }
            break;
        case kLLPayResultInitError:
        {
            msg = @"钱包初始化异常";
        }
            break;
            
        default:
            break;
    }
    [ProgressHUD showSuccessWithStatus:msg];
}


#pragma -mark 点击送50按钮
- (IBAction)songBtnSelected:(UIButton *)sender
{
    
    
    if ([_payModel.isWanShan isEqualToString:@"true"]) {
        sender.selected = !sender.selected;
        if ([_moneyText.text intValue] < 50 && sender.selected) {
//            [ProgressHUD showErrorWithStatus:@"充值金额大于等于50元才能参与本活动."];
        }
        
        if (sender.selected) {
            [_songBtn setBackgroundImage:[UIImage imageNamed:@"song50_highlight.png"] forState:UIControlStateNormal|UIControlStateHighlighted];
            join = JoinActionYes;
            
        }
        else
        {
            join = JoinActionNo;
        }
        
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"参与活动"
                                                        message:@"参与本活动需完善资料."
                                                       delegate:self
                                              cancelButtonTitle:@"放弃参与"
                                              otherButtonTitles:@"去完善", nil];
        alert.tag = AlertTag;
        [alert show];
        
    }
    
    
    
    
    
    
}

#pragma -mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    if (alertView.tag == AlertTag) {
    //        if (buttonIndex == 0) {
    //
    //            [_moneyText becomeFirstResponder];
    //        }
    //
    //        else
    //        {
    //
    //        }
    //    }
    
    if (alertView.tag == AlertTag) {
        if (buttonIndex == 1) {
            
//            if ([_payModel.isWanShan isEqualToString:@"false"]) {
//                MyInfoController* con = [[MyInfoController alloc] initWithNibName:@"MyInfoController" bundle:nil];
//                [self.navigationController setNavigationBarHidden:YES animated:NO];
//                [con setHidesBottomBarWhenPushed:YES];
//                [self.navigationController pushViewController:con animated:YES];
//                [con release];
//                
//            }
            
        }
        else
        {
            
        }
        
    }
    else if (alertView.tag == AlertTag + 1) {
        if (buttonIndex == 1) {
            [self payAction];
        }
        
    }
    else if (alertView.tag == AlertTag + 2) {
        if (buttonIndex == 0) {
            [self payAction];
        }
        else
            if (buttonIndex == 1)
            {
                if ([_payModel.isWanShan isEqualToString:@"true"]) {
                    _songBtn.selected = YES;
                    if (_songBtn.selected) {
                        [_songBtn setBackgroundImage:[UIImage imageNamed:@"song50_highlight.png"] forState:UIControlStateNormal|UIControlStateHighlighted];
                        join = JoinActionYes;
                        
                    }
                    else
                    {
                        join = JoinActionNo;
                    }
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"活动提示"
                                                                    message:@"新用户首次充值满50送50元：充值完成即得20元，剩余30元将分三个月返还。参与活动充值，充值金额及网站赠送金额都转入红包帐户。"
                                                                   delegate:self
                                                          cancelButtonTitle:@"取消"
                                                          otherButtonTitles:@"确定", nil];
                    alert.tag = AlertTag+1;
                    [alert show];
                    
                    
                    
                    
                }
                
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"参与活动"
                                                                    message:@"参与本活动需完善资料."
                                                                   delegate:self
                                                          cancelButtonTitle:@"放弃参与"
                                                          otherButtonTitles:@"去完善", nil];
                    alert.tag = AlertTag+3;
                    [alert show];
                    
                }
                
                
                
                
                
                
            }
        
    }
    else if (alertView.tag == AlertTag + 3)
    {
        if (buttonIndex == 1) {
            
            if ([_payModel.isWanShan isEqualToString:@"false"]) {
//                MyInfoController* con = [[MyInfoController alloc] initWithNibName:@"MyInfoController" bundle:nil];
//                [self.navigationController setNavigationBarHidden:YES animated:NO];
//                [con setHidesBottomBarWhenPushed:YES];
//                [self.navigationController pushViewController:con animated:YES];
//                
            }
            
        }
        else
        {
            [self payAction];
        }
        
    }
    
    else if (alertView.tag == AlertTag + 4)
    {
        if (buttonIndex == 1) {
            
            if ([_payModel.isWanShan isEqualToString:@"false"]) {
//                MyInfoController* con = [[MyInfoController alloc] initWithNibName:@"MyInfoController" bundle:nil];
//                [self.navigationController setNavigationBarHidden:YES animated:NO];
//                [con setHidesBottomBarWhenPushed:YES];
//                [self.navigationController pushViewController:con animated:YES];
//                [con release];
                
            }
            
        }
        else
        {
//            [self payAction];
        }
        
    }

    
}



-(void)viewWillAppear:(BOOL)animated
{
    //请求完善资料相关数据
//    NSArray *titleArray = [NSArray arrayWithObjects:@"银行卡快捷支付",@"银行卡支付",@"支付宝快捷支付",@"信用卡支付",@"手机充值卡充值",@"彩金卡充值", nil];
//    NSArray *keyArray  = [NSMutableArray arrayWithObjects:
//                          [NSNumber numberWithInt:E_LLWallet],
//                          [NSNumber numberWithInt:E_UPPay],
//                          [NSNumber numberWithInt:E_AliPay],
//                          [NSNumber numberWithInt:E_VisaCard],
//                          [NSNumber numberWithInt:E_MobileCard],
//                          [NSNumber numberWithInt:E_CCard],
//                          nil];
//    NSDictionary *titleDictionary = [NSDictionary dictionaryWithObjects:titleArray forKeys:keyArray];
    
//    [self setNavTitle:[titleDictionary objectForKey:[NSNumber numberWithInt:_payMode]]];
    
    [self requestData];
    [super viewWillAppear:YES];
}


#pragma -mark 请求是否参与活动数据

-(void)requestData
{
//    self.request = [[FLHttpRequestUtil alloc] init];
    NSString *urlString = @"mobile/checkUserPayActive.jsp";
//    [_request requestByGetWithURL31:urlString target:self finish:@selector(activeFinished:) failed:@selector(activeFailed:)];
    //    [ProgressHUD showWithStatus:@"正在加载.." networkIndicator:NO];
//    [_request release];
    
#pragma mark --- 修改请求
    urlString = [NSString stringWithFormat:@"%@%@",YXB_IP_ADRESS,urlString];
//    [self httpPostUrl:urlString postBody:nil finishSelector:@selector(activeFinished:) failSelector:@selector(activeFailed:) subClass:[self class]];
}

-(void)activeFinished:(NSDictionary *)request
{
//    self.payModel = [[[PayModel alloc] initWithDictionary:request] autorelease];
    _userNameLabel.text = _payModel.yhm;
    
    NSString * money = [NSString stringWithFormat:@"<font size=13 color='#BB0000'>%@</font> <font size=13 color='#996629'>元</font>",_payModel.yue];
    _moneyLabel.text = money;
    //    [ProgressHUD showSuccessWithStatus:@"加载成功"];
    
}
-(void)activeFailed:(NSDictionary *)request
{
//    [ProgressHUD showErrorWithStatus:@"网络连接失败！"];
    
}

#pragma -mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //禁止用户输入字母
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    for (int i = 0; i < [string length]; i++) {
        unichar c = [string characterAtIndex:i];
        if (![myCharSet characterIsMember:c]) {
            return NO;
        }
    }
    
    //处理第一个数字为小数点或者0的情况
    NSString *text = theTextField.text;
    NSString *passcode = [text stringByReplacingCharactersInRange:range withString:string];
    if ([passcode hasPrefix:@"."])
    {
//        [ProgressHUD showErrorWithStatus:@"充值金额最少1元!"];
//        [ProgressHUD showWithStatus:@"充值金额最少1元!" maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeNone networkIndicator:NO];
        
        return NO;
    }

    
    //处理小数点两位后的情况
    
//    if ([theTextField.text containsString:@"."])
    
    if (!([theTextField.text rangeOfString:@"."].location == NSNotFound)) {
        NSArray *comArray = nil;
        comArray = [passcode componentsSeparatedByString:@"."];
        if (([comArray count] > 1) && ([comArray[1] length] > 2))
        {
//            [ProgressHUD showWithStatus:@"充值金额精确到分!" maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeNone networkIndicator:NO];

            return NO;
            
        }

    }

    //处理两个以上小数点的情况
    if ([string isEqualToString:@"."])
    {
//        if ([text containsString:@"."])
        if(!([text rangeOfString:@"."].location == NSNotFound))
        {
//            [ProgressHUD showErrorWithStatus:@"输入格式错误!"];
//            [ProgressHUD showWithStatus:@"输入格式错误!" maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeNone networkIndicator:NO];

            return NO;
        }
    }
    
    return YES;
}

-(void)tectFieldValueChanged:(UITextField *)tf
{
    for (int i = 101; i < 107; i++) {
        PayButton *btn = (PayButton *)[tf.superview.superview viewWithTag:i];
        btn.selected = NO;
        [btn valueChanged];
        
        if (i == 106) {
            btn.selected = YES;
            [btn valueChanged];
            
        }
        
    }
    
    
    
}



- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    if (!textField.window.isKeyWindow) {
        
        [textField.window makeKeyAndVisible];
        
    }
    
}


#pragma -mark 其它金额 点击事件


- (IBAction)otherButtonClicked:(PayButton *)sender
{
    sender.selected = !sender.selected;
    
    [(PayButton *)sender valueChanged];
    
    for (int i = 101; i < 107; i++) {
        if (sender.tag != i) {
            PayButton *btn = (PayButton *)[sender.superview viewWithTag:i];
            btn.selected = NO;
            [btn valueChanged];
        }
        
        
    }
    if (sender.selected) {
        _moneyText.text =@"";
        [_moneyText becomeFirstResponder];
    }
    else
    {
        [_moneyText resignFirstResponder];
        
    }
    
}

#pragma -mark gestureDelegate
//解决 ios5.0 UIButton 点击不了
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ! ([touch.view isKindOfClass:[UIControl class]]);
}


// return NO to disallow editing.

-(void)setPayModeModel:(PayModeModel *)payModeModel
{
    if (_payModeModel != payModeModel) {
        _payModeModel = payModeModel;
        NSLog(@"_payModeModel.logoTitle---%@",_payModeModel.logoTitle);
//        [self setNavTitle:_payModeModel.logoTitle];
        [self setTitle:_payModeModel.logoTitle];
    }
}

- (void)viewDidUnload {
    [self setMoneyText:nil];
    [self setBackView:nil];
    [self setSongBtn:nil];
    [self setUserNameLabel:nil];
    [self setMoneyLabel:nil];
    [self setMoneyLabel:nil];
    [self setJingshiLabel:nil];
    [self setTxBackView:nil];
    [self setKeyBoardGesture:nil];
    [super viewDidUnload];
}
@end
