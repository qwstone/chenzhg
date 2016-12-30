//
//  AmortizationTopSelectView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/6/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AmortizationTopSelectView;

@protocol AmortizationTopSelectViewDelegate <NSObject>
@optional
- (void)AmortizationTopSelectView:(AmortizationTopSelectView *)selectView selectedAtIndex:(NSInteger)index;

@end

@interface AmortizationTopSelectView : UIView

- (id)initWithFrame:(CGRect)frame andArray:(NSArray *)array;

@property (nonatomic,strong) NSArray *array;

@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,assign) id<AmortizationTopSelectViewDelegate> delegate;

@end
