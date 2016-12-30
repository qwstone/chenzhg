//
//  CTreasureMoneyOneView.h
//  YOUXINBAO
//
//  Created by zjp on 15/12/15.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "QCCarouselItem.h"
#import "YXBTool.h"
#import "TreasureMoneyProductViewController.h"
#import "ProfitRegularBrief.h"


@protocol CTreasureMoneyOneViewDelegate <NSObject>
@optional

-(void)CTreasureMoneyOneView:(NSInteger)index;

@end
@interface CTreasureMoneyOneView : UIView<iCarouselDelegate,iCarouselDataSource>{
    iCarousel *_carousel;
}
@property (nonatomic,assign)id<CTreasureMoneyOneViewDelegate>delegate;
@property(nonatomic,strong)NSMutableArray *model;
@property(nonatomic,assign)NSInteger    index;
@property(nonatomic,strong)UIImageView  *img0;
@property(nonatomic,strong)UIImageView  *img1;
@property(nonatomic,strong)UIImageView  *img2;

-(void)CTreasureMoneyNewCell;

@end
