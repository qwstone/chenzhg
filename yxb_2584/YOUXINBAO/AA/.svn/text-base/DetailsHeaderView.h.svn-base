//
//  DetailsHeaderView.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TActivity.h"
#import "AAActivity.h"

@protocol DetailsHeaderViewDelegate <NSObject>
@optional
- (void)informButtonActionWithSender:(UIButton *)sender;
- (void)imageButtonActionWithSender:(UIButton *)sender;

@end


@interface DetailsHeaderView : UIView

@property (nonatomic,retain)AAActivity * activityModel;

@property (nonatomic,assign)id<DetailsHeaderViewDelegate> delegate;

@property (nonatomic,strong)UIButton * inform;  //投诉


- (void)setImageButtonHidden:(BOOL)yesOrNo;

@end

