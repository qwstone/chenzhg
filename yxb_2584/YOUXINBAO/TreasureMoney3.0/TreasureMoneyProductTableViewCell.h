//
//  TreasureMoneyProductTableViewCell.h
//  YOUXINBAO
//
//  Created by CH10 on 15/12/14.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfitRegularDetail.h"
@protocol TreasureMoneyProductTableViewCellDelegate <NSObject>

-(void)chongZhiAction;
-(void)detailBtnAction;
@end

@interface TreasureMoneyProductTableViewCell : UITableViewCell
@property (nonatomic,assign)id<TreasureMoneyProductTableViewCellDelegate>delegate;
@property (nonatomic,strong)ProfitRegularDetail *model;
@property (nonatomic,assign)NSInteger buyMoney;
@property (nonatomic,assign)NSString *remainingMoney;
@end
