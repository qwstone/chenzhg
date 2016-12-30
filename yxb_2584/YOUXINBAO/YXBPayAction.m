//
//  YXBPayAction.m
//  YOUXINBAO
//
//  Created by Feili on 15/7/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBPayAction.h"
#import "Loan.h"
#import "CgLoan.h"
//#import "StatusHttp.h"
#import "LoanConfig.h"
#import "QCUserManager.h"
#import "DebtItemModel.h"
#import "YXBTool.h"
#import "TInstallmentLoan.h"

@implementation YXBPayAction


//- (void)payActionWithTloan:(TLoan *)loan payWay:(YXBPayWay)payWay selectedArray:(NSMutableArray *)selectedArray isQuickLend:(BOOL) isQuickLend
-(void)payAction
{
    
//    stausHttp = [[StatusHttp alloc]init];
//    stausHttp.delegate = self;
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    CgLoan * cgloan = [[CgLoan alloc]init];
    cgloan.yxbToken = userModel.user.yxbToken;
    cgloan.userId = userModel.user.t_id;
//    cgloan.mainId = _loan.t_id;
    cgloan.mainId = _loan.loanId;

//    DebtItemModel *model = _dataArray[[_dataArray count] - 2];
    
    cgloan.totalMoney = [NSString stringWithFormat:@"%ld",(long)[self getFukuanMoney]];
    
    //支付
    if (_payWay == YXBPayWayFukuan) {
        
        //快速放款 支付
        if (_isQuickLend) {
//            if (sender.tag == 222) {
//                [YXBTool showAlertViewWithString:@"快速放款不支持其它方式打款"];
//                return;
//            }
            
            if (NO) {
                
            }
            else
            {
                NSString *url = [YXBPaymentUtils getFullWebUrl:self.loan];
                NSLog(@"url ---%@",url);
//                [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];
                [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"付款单" type:2];
                
            }
            
            
            return;
            
        }
        
        
        if (YES) {
            
            cgloan.operationType =LOAN_PAY_YXB;
            cgloan.repayType = self.loan.repayType;
            
            
            if (NO) {
                
            }
            else
            {
                NSString *url = [YXBPaymentUtils getFullWebUrl:cgloan];
                NSLog(@"url ---%@",url);
                [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];
                
            }
            
        }else{
            /*
            cgloan.operationType =LOAN_PAY_NOTYXB;
            cgloan.repayType = self.loan.repayType;
            
            
            [stausHttp __yxb__chargeTLoanwithTloan:cgloan];
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
        
        if (YES) {
            cgloan.operationType =LOAN_REPAY_YXB;
            cgloan.repayType = self.loan.repayType;
            
            if (_loan.repayType == 1) {
                cgloan.periodNoList = periodNoList;
                
            }
            else
            {
                cgloan.periodNoList = @"1";
            }
//            DebtItemModel *model = _dataArray[[_dataArray count] - 2];
//            
//            cgloan.totalMoney = [model.debtValue substringToIndex:[model.debtValue length] - 2];
            cgloan.totalMoney = [NSString stringWithFormat:@"%ld",(long)[self getFukuanMoney]];
            if (NO) {
                //取消上面账户余额的判断
            }
            else
            {
                NSString *url = [YXBPaymentUtils getFullWebUrl:cgloan];
                NSLog(@"url ---%@",url);
                [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];
                
            }
            
            
        }else{
            /*
            if (_loan.repayType == 1) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付提示" message:@"分期还款不支持其它方式打款" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                
            }
            else
            {
//                DebtItemModel *model = _dataArray[[_dataArray count] - 2];
                cgloan.operationType =LOAN_REPAY_NOTYXB;
                cgloan.periodNoList = periodNoList;
                //                 cgloan.totalMoney = model.debtValue;
//                cgloan.totalMoney = [model.debtValue substringToIndex:[model.debtValue length] - 2];
                cgloan.totalMoney = [NSString stringWithFormat:@"%ld",(long)[self getFukuanMoney]];
                cgloan.repayType = self.loan.repayType;
                
                [stausHttp __yxb__chargeTLoanwithTloan:cgloan];
                
                
                
            }
            
            */
            
            
        }
        
    }
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
//            money = [_loan.needRepayMoney integerValue];
//            NSInteger buchangjin = [_loan.sumCompensation integerValue];
//            if (buchangjin > 0) {
//                money = money + buchangjin;
//            }
        }
        
    }
    return money;
}

@end
