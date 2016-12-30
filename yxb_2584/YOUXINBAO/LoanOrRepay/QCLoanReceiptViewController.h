//
//  QCLoanReceiptViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/4/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"
#import "LoanCenter.h"

@interface QCLoanReceiptViewController : QCBaseViewController
@property (weak, nonatomic) IBOutlet UIView *jieJuDan;
@property (weak, nonatomic) IBOutlet UIView *jieJuDetail;

@property (weak, nonatomic) IBOutlet UILabel *borrowName;   //借款人
@property (weak, nonatomic) IBOutlet UILabel *borrowTel;    //借款电话
@property (weak, nonatomic) IBOutlet UILabel *borrowId;     //借款身份证
@property (weak, nonatomic) IBOutlet UILabel *loanName;     //放款人
@property (weak, nonatomic) IBOutlet UILabel *loanTel;      //放款点话
@property (weak, nonatomic) IBOutlet UILabel *loanId;       //放款身份证
@property (weak, nonatomic) IBOutlet UILabel *borrowTime;      //借款时间
@property (weak, nonatomic) IBOutlet UILabel *repayTime;    //打款时间
@property (weak, nonatomic) IBOutlet UILabel *interestType; //扣息方式
@property (weak, nonatomic) IBOutlet UILabel *borrowLong;   //借款时长
@property (weak, nonatomic) IBOutlet UILabel *repayType;    //换矿方式
@property (weak, nonatomic) IBOutlet UILabel *borrowMoney;  //借款金额
@property (weak, nonatomic) IBOutlet UILabel *interestMoney;    //利息
@property (weak, nonatomic) IBOutlet UILabel *compensation;     //补偿金



@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) LoanCenter *loanCenter;

//获取借款单图片
- (UIImage *)capture;

@end
