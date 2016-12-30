//
//  MyOrderScheduleTopView.h
//  YOUXINBAO
//
//  Created by Feili on 15/5/26.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseView.h"
#import "CommerceOrderDetail.h"
#import "CommerceOrder.h"
#import "MyOrderConfig.h"




@protocol MyOrderScheduleTopViewDelegate <NSObject>

-(void)contactInfo;

@end

@interface MyOrderScheduleTopView : QCBaseView

@property(nonatomic,strong) BaseData *model;
@property(nonatomic,assign) id<MyOrderScheduleTopViewDelegate>delegate;

-(void)showSchedulePabel;

/**
 *  @author chenglibin
 *
 *  是否显示横线下面的两行
 */

-(void)isShowItemsBelowLine:(BOOL)isShow;
@end
