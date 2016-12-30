//
//  QCSelectRefundViewController.h
//  YOUXINBAO
//
//  Created by zjp on 15/6/19.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"
#import "AverageManager.h"
#import "ActivityMember.h"
#import "AAActivity.h"
@interface QCSelectRefundViewController : QCBaseViewController


/**
 * field 参与人User列表
 */
@property (nonatomic, strong) NSMutableArray * participants;
@property (nonatomic, strong) AAActivity *activity;
@property(nonatomic,strong)UISegmentedControl       *segment;
@property (nonatomic,strong)UITableView         *tableView;
@property(nonatomic,copy)NSString                   *titltext;

@property(nonatomic,strong)HttpOperator             *iHttpOperator;
@property(nonatomic,strong)ActivityMember           *model;

@property(nonatomic,strong)NSMutableArray           *useridArr;
@property (nonatomic,assign) NSInteger          activityId;
@property(nonatomic,strong)NSString *state;
@end
