//
//  PayViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "PayViewController.h"
#import "StatusHttp.h"
#import "InstallmentDetail.h"
#import "TInstallmentLoan.h"
#import "DebtDetailCell.h"
#import "LoanDetailsViewController.h"
#import "YXBWebNavViewController.h"
#import "PayJsonTools.h"
#import "YXBTool.h"
#import "LoanConfig.h"
#import "UserManager.h"
#import "QCBaseTableView.h"
#import "UIAlertView+Block.h"
#import "FMDeviceManager.h"

@interface PayViewController ()<StatusHttpDelegate,UITableViewDelegate,UITableViewDataSource,QCBaseTableViewDelegate>
{
    UILabel * moneyLoabel;
    StatusHttp * stausHttp;
    UIAlertView * alertView;
    UIView *bottomBGView;
}
@property (nonatomic,strong)HttpOperator *iHttpOperator;
@property(nonatomic,strong)QCBaseTableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)PayJsonTools   *iPayJsonTools;
@property(nonatomic,strong)NSString *remainMoney;//余额
@end

@implementation PayViewController
-(void)dealloc{
    NSLog(@"PayViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    [self setTitle:@"支付"];
    [self initView];
}

- (void)initView
{
//    moneyLoabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, kDeviceWidth-40, 40)];
//    moneyLoabel.text = @"账户余额:25元";
    
    
    CGFloat x = 0, y = 0, w = kDeviceWidth,h = kDeviceHeight - 64;
    self.tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(x, y, w, h) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];

    [self loadBottomView];
    [self.view addSubview:moneyLoabel];
//    [self divideModelsWithModelProperty];

    
    
    
}

-(void)loadBottomView
{
    bottomBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 200)];
    _tableView.tableFooterView = bottomBGView;
    
    UIButton * payBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, bottomBGView.height-100, kDeviceWidth-40, 40)];
    payBtn.tag = 111;
    [payBtn setTitle:@"账户余额支付" forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    payBtn.layer.cornerRadius = 5.0;
    payBtn.backgroundColor = rgb(51, 142, 250, 1.0);
    [bottomBGView addSubview:payBtn];
    
    
    UIButton * sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, bottomBGView.height-40, kDeviceWidth-40, 40)];
    sureBtn.tag = 222;
    sureBtn.layer.cornerRadius = 5.0;
    [sureBtn setTitle:@"其它方式打款" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.backgroundColor = rgb(51, 142, 250, 1.0);
    [bottomBGView addSubview:sureBtn];
    
}

- (void)buttonAction:(UIButton *)sender
{
    
    stausHttp = [[StatusHttp alloc]init];
    stausHttp.delegate = self;
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    CgLoan * cgloan = [[CgLoan alloc]init];
    cgloan.yxbToken = userModel.user.yxbToken;
    cgloan.userId = userModel.user.t_id;
    cgloan.mainId = _loan.t_id;
//    if (_loan.interestType == 1) {
//        cgloan.totalMoney = [NSString stringWithFormat:@"%ld",[_loan.money integerValue]-[_loan.interest integerValue]];
    /*
    cgloan.totalMoney = _loan.money;
    if (_loan.interestType == POST_INTEREST) {
        CGFloat money = [_loan.money floatValue] - [_loan.interest floatValue];
        cgloan.totalMoney = [NSString stringWithFormat:@"%ld",(long)money];
    }
    
    */
    DebtItemModel *model = _dataArray[[_dataArray count] - 2];

    cgloan.totalMoney = [model.debtValue substringToIndex:[model.debtValue length] - 2];
//    }

    //支付
    if (_payWay == YXBPayWayFukuan) {
        
        //快速放款 支付
        if (_isQuickLend) {
            if (sender.tag == 222) {
                [YXBTool showAlertViewWithString:@"快速放款不支持其它方式打款"];
                return;
            }
            
            //判断账户余额
            /*
            NSInteger needPayMoney = [self getFukuanMoney];
            
            if([self.remainMoney integerValue] <= needPayMoney)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您账户余额不够此次支付" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去充值", nil];
                [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                    if (buttonIndex == 1)
                    {
                        //跳转支付
                        [YXBTool jumpToPayVC];
                        return;

                    }
                }];
            }
            */
            if (NO) {
                
            }
            else
            {
                NSString *url = [YXBPaymentUtils getFullWebUrl:self.loan];
                NSLog(@"url ---%@",url);
                [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];

            }
            
            /*
            //新添加 支付 跳转浏览器
            NSString *urlstr = [NSString stringWithFormat:@"webView/user/loanPay.jsp"];
            PayJsonTools *paytools = [[PayJsonTools alloc] init];
            paytools.iOnJsonStr = ^(NSString *s){
                NSLog(@"%@",s);

//                NSString *dic = [NSString stringWithFormat:@"money=%@&a=23&json=%@",self.loan.money,s];

                NSString *dic = [NSString stringWithFormat:@"operationType=%d&repayType=%ld&money=%@&a=23&loanType=%ld&json=%@",LOAN_QUICK_SEND_QUICK_LEND,(long)self.loan.repayType,self.loan.money,(long)self.loan.loanType,s];

                NSString *urlstrs = [YXBTool getURL:urlstr params:dic];
                NSLog(@"%@",urlstrs);
                [YXBTool jumpInnerSafaryWithUrl:urlstrs hasTopBar:NO titleName:@"支付"];
            };
            LoanManager *manager = [paytools getAopInstance:[LoanManager class]];
            if(self.loan.loanType == LoanQuickTypeQuick)
            {
                [manager createLightningLoanOut:userModel.user.yxbToken money:self.loan.money friendID:self.loan.borrowerId];
            }
            else
            {
                [manager __yxb_service__createAndModifyTLoan:self.loan];

            }
            
            */
            
              //老请求
//            [stausHttp __yxb_service__createAndModifyTLoan:self.loan];
            
            
            
            
            return;
            
        }

        
        if (sender.tag == 111) {
            
            cgloan.operationType =LOAN_PAY_YXB;
            cgloan.repayType = self.loan.repayType;

            //判断账户余额
            /*
            NSInteger needPayMoney = [self getFukuanMoney];
            
            if([self.remainMoney integerValue] <= needPayMoney)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您账户余额不够此次支付" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去充值", nil];
                [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                    if (buttonIndex == 1)
                    {
                        //跳转支付
                        [YXBTool jumpToPayVC];
                        return;
                        
                    }
                }];
            }

            */
            if (NO) {
                
            }
            else
            {
                NSString *url = [YXBPaymentUtils getFullWebUrl:cgloan];
                NSLog(@"url ---%@",url);
                [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];

            }
            
            //        [stausHttp __yxb_service__operateTLoan:LOAN_REPAY_YXB withTloan:_loan];
            //                    [http __yxb_service__createAndModifyTLoan:self.loanModel];

            
            /*
                //新添加 支付 跳转浏览器
                NSString *urlstr = [NSString stringWithFormat:@"webView/user/loanPay.jsp"];
                PayJsonTools *paytools = [[PayJsonTools alloc] init];
                paytools.iOnJsonStr = ^(NSString *s){
                NSLog(@"%@",s);

//                    NSString *dic = [NSString stringWithFormat:@"money=%@&a=23&json=%@",cgloan.totalMoney,s];

                    NSString *dic = [NSString stringWithFormat:@"operationType=%d&repayType=%ld&money=%@&a=23&json=%@",cgloan.operationType,(long)self.loan.repayType,cgloan.totalMoney,s];

                 NSString *urlstrs = [YXBTool getURL:urlstr params:dic];
                NSLog(@"%@",urlstrs);
                [YXBTool jumpInnerSafaryWithUrl:urlstrs hasTopBar:NO titleName:@"支付"];
            };
            LoanManager *manager = [paytools getAopInstance:[LoanManager class]];
            [manager __yxb_service__chargeTLoan:cgloan];
            
            
            */

                //老请求
//            [stausHttp __yxb__chargeTLoanwithTloan:cgloan];
            
        }else{
//            [stausHttp __yxb_service__operateTLoan:LOAN_REPAY_NOTYXB withTloan:_loan];
            //        cgloan.operationType =LOAN_REPAY_NOTYXB;
            
            cgloan.operationType =LOAN_PAY_NOTYXB;
            cgloan.repayType = self.loan.repayType;

            
            [stausHttp __yxb__chargeTLoanwithTloan:cgloan];
            
            
            /*
            NSString *url = [YXBPaymentUtils getFullWebUrl:cgloan];
            NSLog(@"url ---%@",url);
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];

            */
            
        }

    }
    //按期还款
    else
    {
        
        
        NSMutableString *periodNoList = [[NSMutableString alloc] init];
        for (TInstallmentLoan *detail in _selectedArray)
        {
        
            if ((detail.status == NEEDREPAY_ONTIME) ||
                (detail.status == NEEDREPAY_DELAY) ||
                (detail.status == NEEDRECEIVE_ONTIME)||
                (detail.status == NEEDRECEIVE_DELAY))
            {
                [periodNoList appendFormat:@"%ld,",(long)detail.periodNo];
                
            }
        }
        if ([periodNoList length] > 0) {
            [periodNoList deleteCharactersInRange:NSMakeRange([periodNoList length] - 1, 1)];

        }
        
        if (sender.tag == 111) {
            cgloan.operationType =LOAN_REPAY_YXB;
            cgloan.repayType = self.loan.repayType;

            if (_loan.repayType == 1) {
                cgloan.periodNoList = periodNoList;

            }
            else
            {
                cgloan.periodNoList = @"1";
            }
            DebtItemModel *model = _dataArray[[_dataArray count] - 2];
            
            cgloan.totalMoney = [model.debtValue substringToIndex:[model.debtValue length] - 2];

            //判断账户余额
            /*
            NSInteger needPayMoney = [self getFukuanMoney];

            if([self.remainMoney integerValue] <= needPayMoney)
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您账户余额不够此次支付" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去充值", nil];
                [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                    if (buttonIndex == 1)
                    {
                        //跳转支付
                        [YXBTool jumpToPayVC];
                        return;
                        
                    }
                }];
                
            }
            */
            if (NO) {
                //取消上面账户余额的判断
            }
            else
            {
                NSString *url = [YXBPaymentUtils getFullWebUrl:cgloan];
                NSLog(@"url ---%@",url);
                [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];

            }

            /*
            //新添加 支付 跳转浏览器
            NSString *urlstr = [NSString stringWithFormat:@"webView/user/loanPay.jsp"];
            
            PayJsonTools *paytools = [[PayJsonTools alloc] init];
            paytools.iOnJsonStr = ^(NSString *s){
                NSLog(@"%@",s);

//                NSString *dic = [NSString stringWithFormat:@"money=%@&a=23&json=%@",cgloan.totalMoney,s];

                NSString *dic = [NSString stringWithFormat:@"operationType=%d&repayType=%ld&money=%@&a=23&json=%@",cgloan.operationType,(long)self.loan.repayType,cgloan.totalMoney,s];

                NSString *urlstrs = [YXBTool getURL:urlstr params:dic];
                NSLog(@"%@",urlstrs);
                [YXBTool jumpInnerSafaryWithUrl:urlstrs hasTopBar:NO titleName:nil];
            };
            LoanManager *manager = [paytools getAopInstance:[LoanManager class]];
            [manager __yxb_service__chargeTLoan:cgloan];
            
            */
            
            //新添加 0706
            

            //老请求
//            [stausHttp __yxb__chargeTLoanwithTloan:cgloan];
            
        }else{
            
            //以下为线下还款
//            if(_loan.loanType == LoanQuickTypeQuick || _loan.loanType == LoanQuickTypeNormal)
//            {
//                [ProgressHUD showSuccessWithStatus:@"快速放款不支持线下支付"];
//                return;
//            }
            
            if (_loan.repayType == 1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付提示" message:@"分期还款不支持其它方式打款" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];

            }
            else
            {
                DebtItemModel *model = _dataArray[[_dataArray count] - 2];
                

//                 [stausHttp __yxb_service__operateTLoan:LOAN_REPAY_NOTYXB withTloan:_loan];
                
                 cgloan.operationType =LOAN_REPAY_NOTYXB;
                 cgloan.periodNoList = periodNoList;
//                 cgloan.totalMoney = model.debtValue;
                 cgloan.totalMoney = [model.debtValue substringToIndex:[model.debtValue length] - 2];
                cgloan.repayType = self.loan.repayType;

                /*
                //新添加 支付 跳转浏览器
                NSString *urlstr = [NSString stringWithFormat:@"webView/user/loanPay.jsp"];
                
                PayJsonTools *paytools = [[PayJsonTools alloc] init];
                paytools.iOnJsonStr = ^(NSString *s){
                    NSLog(@"%@",s);

//                    NSString *dic = [NSString stringWithFormat:@"money=%@&a=23&json=%@",cgloan.totalMoney,s];

                    NSString *dic = [NSString stringWithFormat:@"operationType=%d&repayType=%ld&money=%@&a=23&json=%@",cgloan.operationType,(long)self.loan.repayType,cgloan.totalMoney,s];

                    NSString *urlstrs = [YXBTool getURL:urlstr params:dic];
                    NSLog(@"%@",urlstrs);
                    [YXBTool jumpInnerSafaryWithUrl:urlstrs hasTopBar:NO titleName:@"支付"];
                };
                LoanManager *manager = [paytools getAopInstance:[LoanManager class]];
                [manager __yxb_service__chargeTLoan:cgloan];
                
                
                */
                
//                NSString *url = [YXBPaymentUtils getFullWebUrl:cgloan];
//                NSLog(@"url ---%@",url);
//                [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];

                //老请求
                 [stausHttp __yxb__chargeTLoanwithTloan:cgloan];
                
                

            }
            
            
        }

    }
}

- (void)httpCompleteWithResultSet:(TResultSet *)set withHttpTag:(NSInteger)tag
{
    if (tag == 999) {
        if (set.errCode == 0) {
            [ProgressHUD showSuccessWithStatus:set.errString];
            [self.navigationController popViewControllerAnimated:YES];
        }
        if (alertView == nil) {
            alertView = [[UIAlertView alloc]initWithTitle:nil message:set.errString delegate:set cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
        }
        
        [alertView show];


    }
    
    if (_isQuickLend) {
        if (set.errCode == 0) {
            [ProgressHUD showSuccessWithStatus:set.errString];

            alertView = [[UIAlertView alloc]initWithTitle:nil message:set.errString delegate:set cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            [self.navigationController popToRootViewControllerAnimated:YES];
//            for (UIViewController *vc in [self.navigationController viewControllers]) {
//                if ([vc isKindOfClass:[LoanDetailsViewController class]]) {
//                    [self.navigationController popToViewController:vc animated:YES];
//                    return;
//
//                }
//            }
        }
        if (alertView == nil) {
            alertView = [[UIAlertView alloc]initWithTitle:nil message:set.errString delegate:set cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
        }
        
        [alertView show];

    }

}


#pragma -mark tableviewDatasource & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellID";
    DebtDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[DebtDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.width = _tableView.width;
    cell.height = DebtDetailCellHeight;
    [cell reSetFrameIfNeed];
    if (indexPath.row < [_dataArray count]) {
        DebtItemModel * debtModel = _dataArray[indexPath.row];
        cell.model = debtModel;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = rgb(221, 101, 115, 1.0);
    titleLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    titleLabel.layer.borderWidth = 0.5;
    titleLabel.font = [UIFont systemFontOfSize:16.0];
    titleLabel.text = @"     订单详情:";
    return titleLabel;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 50;
}

-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    [self httpLogin];
}


#pragma -mark 将model拆分成tableView的数据源
-(void)divideModelsWithModelProperty
{
//    NSInteger numberOfItems = 3;
    NSMutableArray *keysArray = [NSMutableArray array];
    [keysArray addObject:@"项目名称:"];
    [keysArray addObject:@"所选期次:"];
    [keysArray addObject:@"付款金额:"];
    [keysArray addObject:@"账户余额:"];
    
//    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];

    NSMutableArray *valuesArray = [NSMutableArray array];
    [valuesArray addObject:[NSString stringWithFormat:@"%@",[self getMoneyTitle]]];
    [valuesArray addObject:[NSString stringWithFormat:@"%@",[self periodArrayWithSelected]]];
    [valuesArray addObject:[NSString stringWithFormat:@"%ld 元",(long)[self getFukuanMoney]]];
    [valuesArray addObject:[NSString stringWithFormat:@"%@ 元",self.remainMoney]];
    
    self.dataArray = [NSMutableArray array];
    [_dataArray removeAllObjects];
    for (int i = 0; i < [keysArray count]; i ++) {
        DebtItemModel *itemModel = [[DebtItemModel alloc] init];
        itemModel.debtName = keysArray[i];
        itemModel.debtValue = valuesArray[i];
        [_dataArray addObject:itemModel];
    }
    
    if (_payWay == YXBPayWayFukuan) {
        [_dataArray removeObjectAtIndex:1];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)getFukuanMoney
{
    NSInteger money = 0;
    if (_payWay == YXBPayWayFukuan) {
        money = [_loan.money integerValue];
        if (_loan.interestType == POST_INTEREST) {
            money = [_loan.money floatValue] - [_loan.interest floatValue];
        }

    }
    else
    {
        for (TInstallmentLoan *detail in _selectedArray)
        {
            
            money = money + [detail.money integerValue];
            
        }
        
        //全额还款
        if (_loan.repayType == 0) {
            money = [_loan.needRepayMoney integerValue];
            NSInteger buchangjin = [_loan.sumCompensation integerValue];
            if (buchangjin > 0) {
                money = money + buchangjin;
            }
        }

    }
    return money;
}

-(NSString *)periodArrayWithSelected
{
    NSMutableString *mStr = [[NSMutableString alloc] init];
    [mStr appendString:@"第 "];
    
    _selectedArray = [NSMutableArray arrayWithArray:[_selectedArray sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(TInstallmentLoan *obj1, TInstallmentLoan *obj2) {
        return obj1.periodNo > obj2.periodNo;
        
    }]];
    
    for (TInstallmentLoan *detail in _selectedArray)
    {
        
        [mStr appendFormat:@"%ld-",(long)detail.periodNo];
        
    }
    [mStr replaceCharactersInRange:NSMakeRange([mStr length] - 1, 1) withString:@"期"];
    
    if (_loan.repayType == 0) {
        mStr = [[NSMutableString alloc] initWithString:@"全额"];
    }
    return mStr;

}

//对所选的其次进行排序


//获取订单项目名称
-(NSString *)getMoneyTitle
{
    NSString *title = @"交易";
    if (_payWay == YXBPayWayFukuan)
    {
        if (_isQuickLend) {
            if(_loan.loanType == LoanQuickTypeQuick)
            {
                
                title = @"快速放款-闪电无息付款";
            }
            else if(_loan.loanType == LoanQuickTypeNormal)
            {
                title = @"快速放款-高级借出付款";
                
            }
            
            UIButton *sureBtn = (UIButton *)[bottomBGView viewWithTag:222];
            sureBtn.backgroundColor = [UIColor lightGrayColor];
        }
        else
        {
            title = @"普通放款——付款";

        }
    }
    else
    {
        if (_loan.repayType == 0) {
            title = @"普通借款-全额还款";
        }
        else
        {
            title = @"普通借款—分期还款";
            UIButton *sureBtn = (UIButton *)[bottomBGView viewWithTag:222];
            sureBtn.backgroundColor = [UIColor lightGrayColor];

        }

        /*
        if (_isQuickLend) {
        
            if (_loan.operationType == LOAN_QUICK_SEND_QUICK_LEND) {
                if(_loan.loanType == LoanQuickTypeQuick)
                {
                    
                    title = @"快速放款-闪电无息-全额还款";
                    if(_loan.repayType == 1)
                    {
                        title = @"快速放款-闪电无息-分期还款";
                    }
                }
                else if(_loan.loanType == LoanQuickTypeNormal)
                {
                    title = @"快速放款-高级借出还款";
                    if(_loan.repayType == 1)
                    {
                        title = @"快速放款-高级借出-分期还款";
                    }
                    
                }

            }

        }

        else
        {
            if (_loan.repayType == 0) {
                title = @"普通借款-全额还款";
            }
            else
            {
                title = @"普通借款—分期还款";
            }
        }
        
        */
        
    }
    return title;
}


- (void)httpLogin
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak typeof(self) this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_StatusCodeError) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        [this httpLOadParams:s httpOperation:assginHtttperator];
        
    } complete:^(User* r, int taskid) {
        
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    UserManager* _currUser = (UserManager*)  [httpOperation getAopInstance:[UserManager class] returnValue:[User class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    //        NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:userModel.user.pwd]]];
    if (userModel != nil && userModel.user.username != nil && userModel.user.pwd != nil) {
        // 获取设备管理器实例
        NSString *blackBox = [YXBTool getFMString];
        [_currUser userLoginWithFraudmetrix:userModel.user.username pwd:userModel.user.pwd fraudmetrixToken:blackBox];
//        [_currUser userLogin:userModel.user.username pass:userModel.user.pwd];
        
    }
}
//请求完成
-(void)httpLoadComplete:(User *)r{
    [self.tableView reloadDeals];
    if (r.errCode == 0) {
        self.remainMoney = r.totalMoney;
        [self divideModelsWithModelProperty];
        
    }else{
        
        [ProgressHUD showSuccessWithStatus:@"登录失败"];
        QCUserModel * currUser = [[QCUserModel alloc]init];
        currUser.isLogin = NO;
        
    }

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
