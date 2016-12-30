//
//  YXBLoanCenterCell.h
//  YOUXINBAO
//
//  Created by CH10 on 16/1/29.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanListItem.h"
@interface YXBLoanCenterCell : UITableViewCell

@property (nonatomic,strong)LoanListItem *model;
+(instancetype)YXBLoanCenterCellWithTableView:(UITableView *)tableView;
@end
