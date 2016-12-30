//
//  HeaderView.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderViewDelegate <NSObject>

@optional
- (void)headerBtnAction:(UIButton *)sender;
-(void)headerViewSelectedIndex:(NSInteger)index;
@end

@interface HeaderView : UIView

@property (nonatomic,assign)id<HeaderViewDelegate>delegate;
@property (nonatomic,assign)NSInteger selectedIndex;

- (id)initWithFrame:(CGRect)frame WithArray:(NSArray *)array;

-(void)setHeaderViewColorsWithUnSelectedBgColor:(UIColor *)unSelectedBgColor selectedBgColor:(UIColor *)selectedBgColor unSelectedTextColor:(UIColor *)unSelectedTextColor selectedTextColor:(UIColor *)selectedTextColor;


@end
