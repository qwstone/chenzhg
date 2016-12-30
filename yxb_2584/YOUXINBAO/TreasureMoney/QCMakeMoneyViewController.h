//
//  QCMakeMoneyViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "CPBTimerManager.h"
#import "BaoDynamicView.h"
#import "HttpOperator.h"
@interface QCMakeMoneyViewController : QCBaseViewController<CPBTimerDelegate>{

    CPBTimerManager              *_timerManager;
    NSInteger                       postion;
}

@property(nonatomic,strong)HttpOperator *iHttpOperator;
@property(nonatomic,strong)BaoDynamicView         *dynamicView;
@end
