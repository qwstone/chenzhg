//
//  LoanDetailLiXiDetailCell.h
//  YOUXINBAO
//
//  Created by Feili on 15/8/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseCell.h"
#import "LoanConfig.h"
@interface LoanDetailLiXiDetailCell : QCBaseCell
@property (nonatomic,strong)Loan *loan;
@property (nonatomic,assign)id<LoanDetailValueChangedDelegate>delegate;
@end