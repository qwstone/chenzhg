//
//  QCMainLoanReceiptViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/5/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"
#import "TLoanCenterBrief.h"

@interface QCMainLoanReceiptViewController : QCBaseViewController

@property (nonatomic,strong) TLoanCenterBrief *brief;

@property (nonatomic,strong) HttpOperator * iHttpOperator;

@end
