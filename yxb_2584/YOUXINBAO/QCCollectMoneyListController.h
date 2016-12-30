//
//  QCCollectMoneyListController.h
//  YOUXINBAO
//
//  Created by Walice on 15/6/18.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"
typedef NS_ENUM(NSInteger, QCMoneyListStyle){
  
    QCAACreate,     //+
    QCAAParticipate    //-
};

@interface QCCollectMoneyListController : QCBaseViewController
<UITableViewDelegate,UITableViewDataSource,QCBaseTableViewDelegate>
@property (nonatomic,strong)QCBaseTableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (retain, nonatomic) HttpOperator* iHttpOperator;

@end
