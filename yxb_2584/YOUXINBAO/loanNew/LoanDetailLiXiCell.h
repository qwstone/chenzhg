//
//  LoanDetailLiXiCell.h
//  YOUXINBAO
//
//  Created by Feili on 15/8/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseCell.h"
#import "LoanDetailInterestView.h"
#import "LoginModel.h"
@class Loan;
@protocol LoanDetailValueChangedDelegate;



@interface LoanDetailLiXiCell : QCBaseCell
@property(nonatomic,assign)id<HeaderViewDelegate>delegate;
@property(nonatomic,assign)id<LoanDetailValueChangedDelegate>updateDelegate;
@property(nonatomic,strong)LoginModel   *model;
@property(nonatomic,strong)Loan        *loan;
@end
