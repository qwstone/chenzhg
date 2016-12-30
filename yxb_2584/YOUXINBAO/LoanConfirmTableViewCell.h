//
//  LoanConfirmTableViewCell.h
//  YOUXINBAO
//
//  Created by CH10 on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXBLoan.h"
@interface LoanConfirmTableViewCell : UITableViewCell

@property (nonatomic,weak)YXBLoan *model;
@property (nonatomic,copy)NSString *loanRateStr;
@end
