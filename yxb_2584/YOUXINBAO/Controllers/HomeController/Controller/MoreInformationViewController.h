//
//  MoreInformationViewController.h
//  YOUXINBAO
//
//  Created by zjp on 16/1/30.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
@class LoanMoreInfo;
#define MessageCenterPageNOStart 1

@interface MoreInformationViewController : QCBaseViewController<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate>

@property (nonatomic,strong)QCBaseTableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property(nonatomic,strong)LoanMoreInfo *detail;
@property(nonatomic,assign)NSInteger loanId;

@end
