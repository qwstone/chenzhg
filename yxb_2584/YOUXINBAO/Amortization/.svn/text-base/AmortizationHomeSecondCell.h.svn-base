//
//  AmortizationHomeSecondCell.h
//  YOUXINBAO
//
//  Created by CH10 on 15/7/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashSale.h"

@class AmortizationHomeSecondCell;

#define kAmortizationHomeSecondCellHeight getScreenFitSize(170)

@protocol AmortizationHomeSecondCellDelegate <NSObject>
@optional

- (void)amortizationHomeSecondCell:(AmortizationHomeSecondCell *)cell buttonDidClickedAtIndex:(NSInteger)index;

@end

@interface AmortizationHomeSecondCell : UITableViewCell

@property (nonatomic,strong) NSArray *flashList;

@property (nonatomic,strong) NSString *seckillTimeDosplay;

@property (nonatomic,assign) id<AmortizationHomeSecondCellDelegate> delegate;

@end

@interface AmortizationHomeSecondButton : UIButton
@property (nonatomic,strong) FlashSale *flashSale;
@end
