//
//  AmortizationHomeProductCell.h
//  YOUXINBAO
//
//  Created by CH10 on 15/7/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsResume.h"
@class AmortizationHomeProductCell;

typedef enum {
    AmortizationHomeProductCellElectry, //时尚电子
    AmortizationHomeProductCellTrain,   //学习培训
    AmortizationHomeProductCellBeauty,  //美妆护肤
    AmortizationHomeProductCellFashion  //时尚潮品
}AmortizationHomeProductCellType;

#define kAmortizationHomeProductCellHeight 180

@protocol AmortizationHomeProductCellDelegate <NSObject>
@optional

- (void)amortizationHomeProductCellmoreButtonDidClicked:(AmortizationHomeProductCell*)cell type:(AmortizationHomeProductCellType)type;
- (void)amortizationHomeProductCell:(AmortizationHomeProductCell *)cell productButtonDidClickedAtIndex:(NSInteger)index model:(GoodsResume *)model;

@end


@interface AmortizationHomeProductCell : UITableViewCell

@property (nonatomic,assign) id<AmortizationHomeProductCellDelegate> delegate;

@property (nonatomic,strong) NSArray *resumes;
@property (nonatomic,assign) AmortizationHomeProductCellType type;

@end

@interface AmortizationHomeProductButton : UIButton
@property (nonatomic,strong) GoodsResume *goodsResume;
@end