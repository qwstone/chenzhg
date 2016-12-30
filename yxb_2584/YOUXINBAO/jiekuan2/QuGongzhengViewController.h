//
//  QuGongzhengViewController.h
//  YOUXINBAO
//
//  Created by Walice on 16/3/23.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"
#import "QuGongzhengCell.h"
@interface QuGongzhengViewController : QCBaseViewController<QCBaseTableViewDelegate,UITableViewDataSource,UITableViewDelegate>
{

     NSInteger page;
}


@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)QCBaseTableView *tableView;
@property(nonatomic,assign)NSInteger loanId;
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@end
