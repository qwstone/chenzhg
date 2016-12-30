//
//  CreditHallTuhaoListCell.h
//  YOUXINBAO
//
//  Created by zjp on 15/6/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "TCreditCenter.h"
#import "YXBLevelView.h"
@interface CreditHallTuhaoListCell : UITableViewCell



@property(nonatomic,strong) CreditCenter  *model;
@property(nonatomic,strong)YXBLevelView        *levelView;
@end
