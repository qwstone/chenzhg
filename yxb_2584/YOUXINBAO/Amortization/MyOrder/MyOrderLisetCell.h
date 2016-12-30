//
//  MyOrderLisetCell.h
//  YOUXINBAO
//
//  Created by walcie on 15/5/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommerceOrder.h"
@class MyOrderScheduleTopView;

@class MyOrderNewScheduleTopView;
@protocol MyOrderLisetDelegate <NSObject>

- (void)MyOrderLisetPushAction:(CommerceOrder *)model butTag:(NSInteger)butTag;

@end
@interface MyOrderLisetCell : UITableViewCell

@property(nonatomic,retain)   UILabel *statusLabel;
@property(nonatomic,strong) UILabel *remarkLabel;
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,retain)  UIButton *button1;
@property(nonatomic,retain)  UIButton *button2;
@property(nonatomic,retain)  UIButton *button3;

@property(nonatomic,retain)MyOrderNewScheduleTopView *topView;
@property(nonatomic,retain) CommerceOrder *model;
@property (nonatomic, assign) id <MyOrderLisetDelegate>delegate;
@end
