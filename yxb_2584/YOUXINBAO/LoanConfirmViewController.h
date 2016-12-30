//
//  LoanConfirmViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "YXBLoan.h"
@interface LoanConfirmViewController : QCBaseViewController
@property(nonatomic,strong) YXBLoan *yxbLoanModel;
@property (nonatomic,strong)NSString *loanRate;

@end
