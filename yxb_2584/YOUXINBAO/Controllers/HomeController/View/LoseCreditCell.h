//
//  LoseCreditCell.h
//  YOUXINBAO
//
//  Created by pro on 16/9/23.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DishonestUser.h"

@interface LoseCreditCell : UITableViewCell
@property (strong, nonatomic) DishonestUser * model;
@property (assign, nonatomic) BOOL isShowDashed;//是否添加虚线

@end
