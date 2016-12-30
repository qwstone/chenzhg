//
//  ActivityStatusView.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/27.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityStatusViewDelegate <NSObject>

- (void)activituStatusViewBtn:(UIButton *)sender;

@end

@interface ActivityStatusView : UIView
@property (nonatomic ,strong)UIView *bgView;
@property (nonatomic ,retain)UIButton * zhuangBtn;
@property (nonatomic,assign) id<ActivityStatusViewDelegate>delegate;

- (void)startAnimationWithPoint:(CGPoint)pt;

- (void)setFrameWithPoint:(CGPoint)pt;


@end
