//
//  LoanFriendTypeViewController.h
//  YOUXINBAO
//
//  Created by Feili on 15/11/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "Loan.h"
#import "LoanCenterConfig.h"
#import "QCFriendsViewController.h"
#import "YXBLoan.h"
#import "JieKuanConfig.h"
@interface LoanFriendTypeViewController : QCBaseViewController
@property(nonatomic,strong)Loan *loanModel;
@property(nonatomic,strong)YXBLoan *yxbLoanModel;
@property(nonatomic,assign)LoanNewFriendType friendType;//好友来源类型
@property (nonatomic,assign)id<QCFriendsViewControllerBackDelegate>delegate;
@property(nonatomic,assign)id<YXBJieKuanControllerDelegate>jiekuanDelegate;
@property (nonatomic,assign) AmorOrderPayType payType;//订单详情，选好友来源类型


@end
