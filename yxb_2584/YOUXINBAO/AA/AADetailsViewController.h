//
//  AADetailsViewController.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AABaseViewController.h"
#import "TActivity.h"
#import "HttpOperator.h"
//#import "TActivityBrief.h"
#import "AAActivitiesListViewController.h"
#import "AAActivity.h"
#import "PayJsonTools.h"

@interface AADetailsViewController : AABaseViewController<UITableViewDataSource,UITableViewDelegate>

//@property (nonatomic,retain)TActivity * activity;

@property (strong, nonatomic) PayJsonTools* iPayJsonTools;
@property (retain, nonatomic) HttpOperator* iHttpOperator;
//@property (nonatomic,strong) TActivityBrief *brief;
@property (nonatomic,assign) NSInteger activityId;
@property (nonatomic,assign) ListStyle tagType;
@property (nonatomic,strong) AAActivity *activity;

@end
