//
//  CTreasureMoneyHeaderView.h
//  YOUXINBAO
//
//  Created by zjp on 15/12/14.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfitHomeDataV3.h"
@interface CTreasureMoneyHeaderView : UIImageView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView        *HomeLiseTableView;//滑动列表

@property(nonatomic,strong)NSMutableArray       *listData;

@property(nonatomic,strong)ProfitHomeDataV3       *model;
@property(nonatomic,strong)UILabel *userNumberLabel;
@property(nonatomic,strong)UILabel *moneyLabel;

@end
