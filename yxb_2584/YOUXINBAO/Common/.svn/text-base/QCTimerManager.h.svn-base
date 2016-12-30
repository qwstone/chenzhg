//
//  QCTimerManager.h
//  YOUXINBAO
//
//  Created by 张淼 on 14-7-9.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPBTimerManager.h"
#import <UIKit/UIKit.h>
@class HttpOperator;


@protocol QCTimerManagerDelegate <NSObject>

- (void)GetUnreadNoticeFlagByUserInfoChange;

@end


@interface QCTimerManager : CPBTimerManager<UIAlertViewDelegate>
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (nonatomic,assign) id<QCTimerManagerDelegate>t_delegate;

+ (id)sharedInstanceTimer;

- (void)getUnreadLoanFlagByUserInfo;

@end
