//
//  MoreInfomationFootCell.h
//  YOUXINBAO
//
//  Created by Feili on 16/12/21.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanFundDetail.h"

@interface MoreInfomationCell : UITableViewCell

@property(nonatomic, strong)LoanFundDetail  *model;
@property(nonatomic, assign)NSInteger       index;

@end
