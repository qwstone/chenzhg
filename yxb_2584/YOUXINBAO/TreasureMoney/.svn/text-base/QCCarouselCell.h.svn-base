//
//  QCCarouselCell.h
//  YOUXINBAO
//
//  Created by CH10 on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "QCCarouselItem.h"
#import "ProfitNewHomeData.h"
@class QCCarouselCell;

#define kCarouselCellHeight ([QCCarouselItem getCarouselHeightAndWidth]+55)

@protocol QCCarouselCellDelegate <NSObject>
@optional
- (void)QCCarouselCell:(QCCarouselCell *)cell carouselClickedAtIndex:(NSInteger)index;

@end

@interface QCCarouselCell : UITableViewCell<iCarouselDelegate,iCarouselDataSource>

@property (nonatomic,strong) ProfitNewHomeData *data;
@property (nonatomic,assign) id<QCCarouselCellDelegate> delegate;

@end
