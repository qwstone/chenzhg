 //
//  SubscribeViewController.m
//  YOUXINBAO
//
//  Created by pro on 16/7/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "SubscribeViewController.h"
#import "YXBTool.h"
#import "PayHomeViewController.h"
#import "FinancialManagerV2.h"
#import "Payment_payFinance.h"
#import "QCBaseTextField.h"
#import "UIAlertView+Block.h"
@interface SubscribeViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) QCBaseTextField * investField;
@property (strong, nonatomic) UILabel * yueLabel;
@property (strong, nonatomic) UIButton * agreenBtn;
@property(nonatomic,strong)FinanceBuyData *buyDataModel;
@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buyDataModel = [[FinanceBuyData alloc] init];
    self.title = @"认购金额";
    self.view.backgroundColor = rgb(237, 237, 237, 1);
    [self initView];
    [self initExplainView];
}
-(void)viewWillAppear:(BOOL)animated{
    [self httpRequest];
}

-(void)initView
{
    //输入框
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/750*30, kDeviceWidth/750*20, kDeviceWidth - kDeviceWidth/750*30*2, 44)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kDeviceWidth/750*246, 44)];
    title.text = @"投资金额 :";
//    title.font = [UIFont systemFontSize]
    title.textColor = rgb(51, 51, 51, 1);
    [view addSubview:title];
    
    self.investField = [[QCBaseTextField alloc] initWithFrame:CGRectMake(title.right, 0, kDeviceWidth, 44)];
    _investField.textAlignment = NSTextAlignmentLeft;
    _investField.keyboardType = UIKeyboardTypeNumberPad;
//    [_investField addTarget:self action:@selector(textHasChanged:) forControlEvents:UIControlEventEditingChanged];
//    _investField.font = [UIFont systemFontOfSize:15];
    [view addSubview:_investField];
    
    
    //现金金额
    self.yueLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*30, view.bottom + kDeviceWidth/750*30, kDeviceWidth/2+50, 30)];
    _yueLabel.textColor = rgb(51, 51, 51, 1);
    _yueLabel.text = [NSString stringWithFormat:@"现金金额:%@",@"0.00"];
    _yueLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:_yueLabel];
    
    
    //充值按钮
    UIButton * RechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    RechargeBtn.frame = CGRectMake(kDeviceWidth- kDeviceWidth/750*200, view.bottom, kDeviceWidth/750*170, kDeviceWidth/750*30*2 + 30);
    //设置button下划线
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"去充值"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSForegroundColorAttributeName value:rgb(87, 150, 232, 1) range:strRange];  //设置颜色
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [RechargeBtn setAttributedTitle:str forState:UIControlStateNormal];
    [RechargeBtn addTarget:self action:@selector(RechargeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:RechargeBtn];
}

-(void)initExplainView
{
    //说明书View
    UIView * explainView = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/750*110, kDeviceHeight-kDeviceWidth/750*300 - 64, kDeviceWidth - kDeviceWidth/750*110*2, kDeviceWidth/750*38*2)];
    [self.view addSubview:explainView];
    
    
    //说明书
    self.agreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _agreenBtn.frame = CGRectMake(0, 0, kDeviceWidth/750*38, kDeviceWidth/750*38);
    [_agreenBtn setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    
    [explainView addSubview:_agreenBtn];
    
    
    UILabel * explain = [[UILabel alloc] initWithFrame:CGRectMake(_agreenBtn.right, 0, kDeviceWidth - kDeviceWidth/750*38, kDeviceWidth/750*38*2)];
    explain.textColor = rgb(112, 112, 112, 1);
    explain.numberOfLines = 0;
    explain.lineBreakMode = YES;
    explain.font = [UIFont systemFontOfSize:kDeviceWidth/750*30];
    NSMutableString * explainStr = [[NSMutableString alloc] initWithString:@"我已阅读并同意《风险提示书》和\n      《债权转让与服务协议》"];
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:explainStr];
    //设置单位颜色
    [attributedStr addAttribute:NSForegroundColorAttributeName value:rgb(38, 131, 239, 1) range:[explainStr rangeOfString:@"《风险提示书》"]];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:rgb(38, 131, 239, 1) range:[explainStr rangeOfString:@"《债权转让与服务协议》"]];
    explain.attributedText = attributedStr;
    [explainView addSubview:explain];
    
    
    UIButton * explainBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    explainBtn1.frame = CGRectMake(_agreenBtn.right + kDeviceWidth/750*30*7, 0, kDeviceWidth/750*30*7, kDeviceWidth/750*38);
    //    explainBtn1.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0.3 alpha:0.4];
    explainBtn1.tag = 10100;
    [explainBtn1 addTarget:self action:@selector(expainDetail:) forControlEvents:UIControlEventTouchUpInside];
    [explainView addSubview:explainBtn1];
    
    
    UIButton * explainBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    explainBtn2.frame = CGRectMake(_agreenBtn.right + kDeviceWidth/750*30*2,  kDeviceWidth/750*38, kDeviceWidth/750*30*11, kDeviceWidth/750*38);
    //    explainBtn2.backgroundColor = [UIColor colorWithRed:0.3 green:0.8 blue:0.3 alpha:0.4];
    explainBtn2.tag = 10101;
    [explainBtn2 addTarget:self action:@selector(expainDetail:) forControlEvents:UIControlEventTouchUpInside];
    [explainView addSubview:explainBtn2];
    
    
    //下一步按钮
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(kDeviceWidth/750*40, explainView.bottom + kDeviceWidth/750*18, kDeviceWidth - kDeviceWidth/750*40*2, 44);
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"jiekuanNext"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(NextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}








-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark --- Button Action

//跳转到说明书详情
-(void)expainDetail:(UIButton *)btn
{
    NSString *url = nil;
    if (btn.tag == 10100) {
        //跳转到风险提示书
        url = [NSString stringWithFormat:@"%@%@",YXB_IP_ADRESS,self.buyDataModel.noticUrl];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"风险提示书"];
    }
    else{
        //跳转到债权转让与服务协议
        url = [NSString stringWithFormat:@"%@%@&buyMoney=%@",YXB_IP_ADRESS,self.buyDataModel.serviceAgreementUrl,_investField.text?_investField.text:@""];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"债权转让与服务协议"];
    }
}


//去充值
-(void)RechargeAction
{
    PayHomeViewController *payhome = [[PayHomeViewController alloc] init];
    [self.navigationController pushViewController:payhome animated:YES];
}

//下一步
-(void)NextBtnAction
{
    
    [_investField resignFirstResponder];
    //跳转Web信息确认
    if ([self judgeInfo]) {
        Payment_payFinance *payModel = [[Payment_payFinance alloc] init];
        payModel.assetID = self.assetID;
        payModel.money=self.investField.text;
        if (self.assetID == nil) {
            self.assetID = @"";
        }
        NSString *url = [YXBPaymentUtils getFullWebUrl:payModel];
        
        NSString *title = @"信息确认";
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:title];
//        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:title type:3];
    }
    
}
-(BOOL)judgeInfo{
    long long inputRemainMoney = [_investField.text longLongValue];
    long long minMoney = [self.buyDataModel.minMoney longLongValue];
    long long asssetRemainMoney = [_buyDataModel.assetRemainMoney longLongValue];
    //判断是否整百
    if ((inputRemainMoney%100)||(inputRemainMoney<minMoney)) {
        [ProgressHUD showWithStatus:[NSString stringWithFormat:@"%@元起头,整百递增",self.buyDataModel.minMoney]];
        return NO;
    }
    //判断余额
    
    if (inputRemainMoney>[self.buyDataModel.remainMoney longLongValue]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"您的余额不足，请充值后完成认购!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去充值", nil];
        __weak SubscribeViewController *weakSelf = self;
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [weakSelf RechargeAction];
            }
            
        }];
        return NO;
    }

    if (inputRemainMoney>asssetRemainMoney) {
        [ProgressHUD showWithStatus:@"可投金额不足!"];
        
        return NO;
    }
    return YES;
}
//-(void)textHasChanged:(UITextField*)textField{
//    NSLog(@"textField---%@",textField.text);
//    NSInteger money = [textField.text integerValue];
//    NSInteger asssetRemainMoney = [_buyDataModel.assetRemainMoney integerValue];
//    if (money>asssetRemainMoney) {
//        [YXBTool showAlertViewWithString:@"可投金额不足!"];
//    }
//}

#pragma mark - 数据请求
-(void)httpRequest{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block SubscribeViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        [this stopDefaultAnimation];
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        [this httpLoadError:error];
    } param:^(NSString *s) {
        [this httpLoadParagram:assginHtttperator];
    } complete:^(FinanceBuyData *r, int taskid){
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
-(void)httpLoadParagram:(HttpOperator*)assginHtttperator{
    FinancialManagerV2 * manager = (FinancialManagerV2*)[assginHtttperator getAopInstance:[FinancialManagerV2 class] returnValue:[FinanceBuyData class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *userToken = nil;
    if (userModel.user.yxbToken == nil) {
        userToken = @"";
    }else{
        userToken = userModel.user.yxbToken;
    }
    NSString *assetID = (self.assetID==nil?@"":self.assetID);
    [manager getFinanceBuyData:userToken assetID:assetID];
}
-(void)httpLoadComplete:(FinanceBuyData *)r{
    if (r.errCode == 0) {
        self.buyDataModel = r;
        self.yueLabel.text = [NSString stringWithFormat:@"现金金额:%@",self.buyDataModel.remainMoney];
        self.investField.placeholder = [NSString stringWithFormat:@"%@元起投，整百递增",self.buyDataModel.minMoney];
    }
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
