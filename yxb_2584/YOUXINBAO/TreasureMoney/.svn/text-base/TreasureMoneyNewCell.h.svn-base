//
//  TreasureMoneyNewCell.h
//  YOUXINBAO
//
//  Created by zjp on 15/9/22.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfitHomeDataV2.h"
#import "QCCarouselItem.h"
#import "iCarousel.h"
#import "SelectView.h"
#import "CalculatorView.h"
#import "PayHomeViewController.h"
#define bottomHight         (kDeviceWidth/600*90+10)
@protocol TreasureMoneyNewCellDelegate <NSObject>
@optional

-(void)TreasureMoneyNewCell:(NSInteger)index;

-(void)chongzhi;
@end
@interface TreasureMoneyNewCell : UITableViewCell <iCarouselDelegate,iCarouselDataSource,SelectViewDelegate,CalculatorViewDelegate>{
    iCarousel *_carousel;
        CalculatorView  *_jisuanview;
}
@property(nonatomic,strong)ProfitHomeDataV2       *model;
@property (nonatomic,assign)id<TreasureMoneyNewCellDelegate>delegate;
@end
