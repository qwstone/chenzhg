//
//  MyOrderScheduleTopViewNew.h
//  YOUXINBAO
//
//  Created by Feili on 15/7/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseView.h"
#import "MyOrderConfig.h"
#import "CommerceOrderDetail.h"


@protocol MyOrderScheduleTopViewNewDelegate <NSObject>

-(void)contactInfo;

@end


@interface MyOrderScheduleTopViewNew : QCBaseView
@property(nonatomic,strong) CommerceOrderDetail *model;
@property(nonatomic,assign) id<MyOrderScheduleTopViewNewDelegate>delegate;


@end
