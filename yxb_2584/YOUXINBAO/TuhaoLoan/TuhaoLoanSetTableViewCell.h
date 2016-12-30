//
//  TuhaoLoanSetTableViewCell.h
//  YOUXINBAO
//
//  Created by zjp on 15/4/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteSummary.h"
@interface TuhaoLoanSetTableViewCell : UITableViewCell


@property(nonatomic,strong)NoteSummary   *Model;
@property (nonatomic, assign) NSInteger repaymentType;
@property (nonatomic, assign) NSInteger repaymentMonth;
@end
