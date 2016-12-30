//
//  LoanDetailsInstallmentView.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanConfig.h"
typedef enum {
    DoNotChoose,//不可选
    CanChoose,//可选
    HasChosen,//已选
}InstallmentStatus;

@protocol loanDetailsInstallmentViewDelegate <NSObject>

- (void)InstallmentViewButtonAction:(UIButton *)sender;
@optional
- (void)selectedArrayInstallmentView:(NSMutableArray *)selectedArray;//选中的数组

@end

@interface LoanDetailsInstallmentView : UIView

@property (nonatomic,assign)InstallmentStatus installmentStatus;
// 数据数组
@property (nonatomic,retain)NSArray * array;

//选中的数组
@property (nonatomic,retain)NSMutableArray * selecedArray;

@property (nonatomic,assign)id<loanDetailsInstallmentViewDelegate>delegate;

@property (nonatomic,strong)Loan *model;

@property (nonatomic,assign)NSInteger repayType;//0——全额  1——分期

- (void)refreshWith:(LoanPeriod)loanPeriod;

//分期数据计算
+ (NSArray *)installmentArrayWithMoney:(NSString *)money withInterest:(NSString *)interest withUserTime:(NSString *)userTime withTimeLong:(LoanPeriod)loanPeriod kouxifangshi:(InterestType)kouxifangshi;

//定期数据计算
+ (NSArray *)installmentArrayWithMoney:(NSString *)money withInterest:(NSString *)interest withUserTime:(NSString *)userTime withTimeLong:(LoanPeriod)loanPeriod repayType:(NSInteger)repayType kouxifangshi:(InterestType)kouxifangshi;

/**
 *  @author chenglibin
 *
 *  借条跳转而来
 *
 *  @param loanPeriod <#loanPeriod description#>
 */
- (void)refreshFromReceiptWith:(LoanPeriod)loanPeriod;

@end
