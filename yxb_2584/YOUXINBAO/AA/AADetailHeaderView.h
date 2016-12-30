//
//  AADetailHeaderView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/7/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAActivity.h"

#define getScreenFitSize(x) ((x)/320.0*kDeviceWidth)

typedef enum {
    AADetailHeaderViewButtonStyleLodge, //投诉列表
    AADetailHeaderViewButtonStyleCancle //取消活动
}AADetailHeaderViewButtonStyle;

@protocol AADetailHeaderViewDelegate <NSObject>
@optional
- (void)lodgeButtonActionWithStyle:(AADetailHeaderViewButtonStyle)style;
- (void)mapButtonAction;

@end


@interface AADetailHeaderView : UIView

@property (nonatomic,retain)AAActivity * activityModel;

@property (nonatomic,assign)id<AADetailHeaderViewDelegate> delegate;

@property (nonatomic,assign)AADetailHeaderViewButtonStyle buttonStyle;


//设置按钮标题
- (void)setLodgeButtonStyle:(AADetailHeaderViewButtonStyle)style;

+ (NSString *)getWeekdayWithNum:(NSInteger)num;

@end