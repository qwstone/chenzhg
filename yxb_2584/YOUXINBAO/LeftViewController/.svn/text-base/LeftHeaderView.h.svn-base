//
//  LeftHeaderView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/6/5.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#define kLeftHeaderHeight getScreenFitSize(236.5)
#define kLeftHeaderWidth kDeviceWidth/320*270

#import <UIKit/UIKit.h>
@class LeftHeaderView;

@protocol LeftHeaderViewDelegate <NSObject>
@optional
- (void)LeftHeaderView:(UIView *)leftView ButtonClickedAtIndex:(NSInteger)index;

- (void)LeftHeaderView:(UIView *)leftView portraitTapAction:(UITapGestureRecognizer *)tap;
- (void)LeftHeaderView:(UIView *)leftView qrCodeAction:(UIButton *)button;

@end


@interface LeftHeaderView : UIView

@property (nonatomic,assign) id<LeftHeaderViewDelegate> delegate;

- (void)refreshData;

- (void)updatePortraitWithImage:(UIImage *)image;

@end
