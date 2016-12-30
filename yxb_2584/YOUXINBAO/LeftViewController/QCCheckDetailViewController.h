//
//  QCCheckDetailViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"
#define NavigationBarTitleBtnTag 2008

@interface QCCheckDetailViewController : QCBaseViewController

@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (assign, nonatomic) NSInteger fundId;

@end
