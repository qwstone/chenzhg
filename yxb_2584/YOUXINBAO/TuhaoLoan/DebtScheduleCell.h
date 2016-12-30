//
//  DebtScheduleCell.h
//  YOUXINBAO
//
//  Created by Feili on 15/4/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstallmentDetail.h"

@interface DebtScheduleCell : UITableViewCell
@property(nonatomic,strong)InstallmentDetail *model;
@property(nonatomic,assign)NSInteger         number;//期数
@property(nonatomic,assign)NSInteger         isTuhao;//是否是土豪
@end
