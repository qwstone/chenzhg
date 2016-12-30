//
//  QCPopupView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/5/26.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QCPopupView;

@protocol QCPopupViewDelegate <NSObject>

//空白区域点击
- (void)QCPopupViewDismissTapAction:(QCPopupView*)popupView;
//按钮点击
- (void)QCPopupView:(QCPopupView*)popupView buttonDidClickAtIndex:(NSInteger)index;

@end

@interface QCPopupView : UIView

- (id)initWithArray:(NSArray *)array withColumnCount:(NSInteger)column;

@property (nonatomic,strong) NSArray *array;
@property (nonatomic,assign) NSInteger column;  //button列总数

@property (nonatomic,assign) id<QCPopupViewDelegate> delegate;

- (void)show;
- (void)dismiss;

@end
