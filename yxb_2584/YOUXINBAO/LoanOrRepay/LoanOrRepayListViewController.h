//
//  LoanOrRepayListViewController.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/8.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

typedef enum {
    LoanOrRepayListBorrow,//借入
    LoanOrRepayListLend,  //借出
    LoanOrRepayListWhiteLine, //白条
    LoanOrRepayQuick,//极速借出
}LoanOrRepayListType;

#import "LoanOrRepayBaseViewController.h"
#import "HttpOperator.h"

@interface LoanOrRepayListViewController : LoanOrRepayBaseViewController


@property (retain, nonatomic) HttpOperator* iHttpOperator;

//@property (nonatomic, assign) BOOL isLoan;
@property (nonatomic, assign) LoanOrRepayListType type;

@end
