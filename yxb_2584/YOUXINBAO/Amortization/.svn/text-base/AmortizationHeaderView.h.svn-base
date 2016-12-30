//
//  AmortizationHeaderView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/5/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//
#define kAmortizationHeaderHeight kDeviceWidth/320*150+147.5+kDeviceWidth/320*230

#import <UIKit/UIKit.h>
#import "CommerceHomePageData.h"
#import "CPBTimerManager.h"
#import "QCCycleScrollView.h"
@class AmortizationHeaderView;

@protocol AmortizationHeaderViewDelegate <NSObject>
@optional
//
- (void)amortizationHeaderView:(AmortizationHeaderView *)view categoryButtonDidClickAtIndex:(NSInteger)index;

//轮播图点击事件
- (void)amortizationHeaderView:(AmortizationHeaderView *)view scrollViewDidClickAtPage:(NSInteger)page;

//秒杀点击事件
- (void)amortizationHeaderViewSecondsClicked;


@end

@interface AmortizationHeaderView : UIView<QCCycleScrollViewDatasource,QCCycleScrollViewDelegate>

@property (nonatomic,strong) CommerceHomePageData *data;
@property (nonatomic,assign) id<AmortizationHeaderViewDelegate> delegate;

@end

@interface TimeCountView : UIView<CPBTimerDelegate>

//计算倒计时
- (void)setTimeWithSecond:(NSInteger)second;

@end
