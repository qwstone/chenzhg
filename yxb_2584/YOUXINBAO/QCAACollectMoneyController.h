//
//  QCAACollectMoneyController.h
//  YOUXINBAO
//
//  Created by Walice on 15/6/19.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "AACollectCell.h"
#import "HttpOperator.h"
#import "GatheringRecordDetail.h"
#import "AAActivity.h"
#import "QCFriendsViewController.h"
@interface QCAACollectMoneyController : QCBaseViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIAlertViewDelegate,QCFriendsViewControllerBackDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property(nonatomic,retain)GatheringRecordDetail *detail;
@property (nonatomic,strong)AAActivity *activity;

@property(nonatomic,strong)NSMutableArray *useridArray;
@property(nonatomic,strong)NSString *abctitle;
@property(nonatomic,strong)NSString *state;
@property(nonatomic,assign)BOOL isCreate;
@property(nonatomic,assign)NSInteger activityId;
@property(nonatomic,assign)NSInteger record;
@property(nonatomic,strong)NSMutableArray *dataArray;




@end
