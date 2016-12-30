//
//  payScrollView.h
//  YOUXINBAO
//
//  Created by Feili on 15/9/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaydetailView.h"

#define payScrollViewHeight 136

@protocol PayScrollViewDelegate <NSObject>

-(void)payScrollViewDidSelectIndex:(NSInteger)index model:(GuaranteeStages *)model;

@end

@interface PayScrollView : UIView

@property (nonatomic,strong)NSArray *modelArray;
@property (nonatomic,strong)NSString *startYear;
@property (nonatomic,assign)id <PayScrollViewDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame array:(NSMutableArray *)modelArray;

//@property (nonatomic,assign)NSInteger numberOfItems;
@end
