//
//  AmortizationDetailView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/5/26.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#define kAmortizationDetailViewHeight 375

#import <UIKit/UIKit.h>
#import "CommerceDetail.h"
#import "QCCycleScrollView.h"
#import "CommercePayment.h"
@class AmortizationDetailView;

@protocol AmortizationDetailViewDelegate <NSObject>

//
- (void)amortizationDetailView:(AmortizationDetailView *)view detailButtonDidClickAtIndex:(NSInteger)index;

//轮播图点击事件
- (void)amortizationDetailView:(AmortizationDetailView *)view scrollViewDidClickAtPage:(NSInteger)page;

//试图刷新完成返回commercePayment
- (void)amortizationDetailView:(AmortizationDetailView *)view resetViewsFinished:(CommercePayment *)payment;

@end

@interface AmortizationDetailView : UIView<QCCycleScrollViewDatasource,QCCycleScrollViewDelegate>

@property (nonatomic,assign) id<AmortizationDetailViewDelegate> delegate;
@property (nonatomic,strong) CommerceDetail *data;
@property (nonatomic,strong)UIButton *firstRate;    //首付比
@property (nonatomic,strong)UIButton *stage;    //分期

@property (nonatomic,strong)CommercePayment *payment;

- (void)resetViewsWithFirstRateIndex:(NSInteger)rateIndex stageIndex:(NSInteger)stageIndex;

@end
