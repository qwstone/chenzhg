//
//  LoanDetailShiJianCell.h
//  YOUXINBAO
//
//  Created by Feili on 15/8/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseCell.h"
#import "LoginModel.h"
#import "AATimePickerView.h"
#import "LoanConfig.h"
//@protocol LoanDetailShiJianCellDelegate <NSObject>
//
//-(void)updateDetailLoanWithShiJian:(NSString *)time;
//
//@end

@interface LoanDetailShiJianCell : QCBaseCell

@property(nonatomic,strong)LoginModel *model;
@property(nonatomic,assign)id<LoanDetailValueChangedDelegate>delegate;
@property(nonatomic,strong)Loan *loan;
@end
