//
//  LoanDetailsViewController.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanOrRepayBaseViewController.h"
#import "HttpOperator.h"
#import "Loan.h"
#import "User.h"
#import "QCLoginOneViewController.h"
#import "AuthenticationViewController.h"
#import "LoanConfig.h"



@interface LoanDetailsViewController : LoanOrRepayBaseViewController

@property (nonatomic,assign)BorrowerORLenders bOrL;

@property (retain, nonatomic) HttpOperator* iHttpOperator;

@property (nonatomic,retain) Loan * loan;

@property (nonatomic,strong) User *fromFriendUser;//向指定好友快速借款

@property (nonatomic,strong) User *lendMyFriend;//向指定好友放款

@property (nonatomic,assign) BOOL isShowTimer;//是否显示倒计时  极速借出需显示
//@property (nonatomic,assign) BOOL isFromJieju;//来于借条
//@property (nonatomic,assign) BOOL isSubLoan;//是否是子单;
@property (nonatomic,assign) NSInteger segmentHeight;

@property (nonatomic,assign) BOOL isShowVedioCertifict;//是否显示视频认证
@end
