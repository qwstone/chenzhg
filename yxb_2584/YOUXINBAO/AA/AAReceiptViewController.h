//
//  AAReceiptViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/7/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"

@interface AAReceiptViewController : QCBaseViewController

@property (nonatomic,assign) NSInteger loanId;  //借款单id

@property (nonatomic,strong) HttpOperator * iHttpOperator;

@property (weak, nonatomic) IBOutlet UILabel *number;   //单据编号
@property (weak, nonatomic) IBOutlet UIButton *repayIcon;   //还款按钮


@property (weak, nonatomic) IBOutlet UIView *jieJuDetail;

@property (weak, nonatomic) IBOutlet UILabel *borrowName;   //借款人
@property (weak, nonatomic) IBOutlet UILabel *borrowTel;    //借款电话
@property (weak, nonatomic) IBOutlet UILabel *borrowId;     //借款身份证
@property (weak, nonatomic) IBOutlet UILabel *loanName;     //放款人
@property (weak, nonatomic) IBOutlet UILabel *loanTel;      //放款点话
@property (weak, nonatomic) IBOutlet UILabel *loanIdentify;       //放款身份证
@property (weak, nonatomic) IBOutlet UILabel *repayTime;    //打款时间

@property (weak, nonatomic) IBOutlet UILabel *borrowMoney;  //借款金额
@property (weak, nonatomic) IBOutlet UILabel *acitivityTime;    //活动时间

@property (weak, nonatomic) IBOutlet UIImageView *effectiveImage;   //有效

- (void)capture;

@end
