//
//  AmortizationHomeFirstCell.h
//  YOUXINBAO
//
//  Created by CH10 on 15/7/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AmortizationHomeFirstCell;

#define kAmortizationHomeFirstCellHeight getScreenFitSize(100)

@protocol AmortizationHomeFirstCellDelegate <NSObject>
@optional

- (void)amortizationHomeFirstCell:(AmortizationHomeFirstCell *)cell buttonDidClickedAtIndex:(NSInteger)index;

@end

@interface AmortizationHomeFirstCell : UITableViewCell

@property (nonatomic,assign) id<AmortizationHomeFirstCellDelegate> delegate;

@end
