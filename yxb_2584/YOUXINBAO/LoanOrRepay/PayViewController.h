//
//  PayViewController.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanOrRepayBaseViewController.h"
#import "Loan.h"
#import "OpLoan.h"
#import "LoanConfig.h"

/*
typedef NS_ENUM(NSInteger, YXBPayWay)
{
    YXBPayWayFukuan = 0, //付款 (一次性放款)
    YXBPayWayHuankuan = 1,//还款（按期）
    
};

*/

@interface PayViewController : LoanOrRepayBaseViewController

@property (nonatomic,retain)Loan * loan;

@property (nonatomic,assign)YXBPayWay payWay;//是付款还是还款

//@property (nonatomic,strong)NSString *periodNOList;//还款的期数 逗号分隔(2,4,5)
//
//@property (nonatomic,strong)NSString *totalMoney;//总还款额
@property (nonatomic,strong)NSMutableArray *selectedArray;//选择的期数数组

@property (nonatomic,assign)BOOL isQuickLend;//是否是快速放款

@end
