//
//  LoanDetaildSliderView.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loan.h"

@protocol SliderViewDelegate <NSObject>

//滑动时
- (void)changesValue:(LoanPeriod)loanPeriod;
//滑动完成
- (void)sliderFinsh:(LoanPeriod)loanPeriod;

@end

@interface LoanDetaildSliderView : UIView

@property (nonatomic,assign)id<SliderViewDelegate>delegate;

@property (nonatomic,retain) UISlider * slider;

//时长
@property (nonatomic,assign)LoanPeriod loanPeriod;

@end
