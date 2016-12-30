//
//  LoanMessageSecondTypeTableViewCell.h
//  YOUXINBAO
//
//  Created by CH10 on 15/9/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLoanWithLog.h"
@interface LoanMessageSecondTypeTableViewCell : UITableViewCell

@property (nonatomic,retain)UIImageView *jingImageView;
@property (nonatomic,retain)UILabel *desLabel;
@property (nonatomic,retain)TLoanLog * loanLog;
@property (nonatomic,retain)TLoanWithLog * loanWithLog;
@end
