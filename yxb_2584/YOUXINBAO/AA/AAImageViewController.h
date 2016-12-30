//
//  AAImageViewController.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AABaseViewController.h"
//#import "TActivity.h"
#import "HttpOperator.h"
#import "AAActivity.h"

@interface AAImageViewController : AABaseViewController

@property (nonatomic,retain)AAActivity * activity;

@property (retain, nonatomic) HttpOperator* iHttpOperator;


@end
