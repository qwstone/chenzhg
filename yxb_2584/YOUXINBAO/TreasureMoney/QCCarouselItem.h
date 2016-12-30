//
//  QCCarouselItem.h
//  YOUXINBAO
//
//  Created by CH10 on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfitRoundData.h"
//#import "CTreasureMoneyOneView.h"

@interface QCCarouselItem : UIView

@property (nonatomic,strong)ProfitRoundData *roundData;

- (id)initWithFrame:(CGRect)frame type:(NSInteger)type;
- (id)initWithFrame:(CGRect)frame type:(NSInteger)type dic:(NSDictionary *)dic;

+ (CGFloat)getCarouselHeightAndWidth;
//
//@property(nonatomic,strong)CTreasureMoneyOneView *TMview;
@property(nonatomic,assign)NSInteger    index;
@property(nonatomic,strong)UIImageView *line;
@end
