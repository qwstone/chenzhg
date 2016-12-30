//
//  QCThreeViewController.h
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCBaseViewController.h"

@class HttpOperator;
@interface QCThreeViewController : QCBaseViewController


@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (assign, nonatomic) NSInteger iHttpTaskID;



@end
