//
//  QCBorrowManageViewController.h
//  YOUXINBAO
//
//  Created by Walice on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"
#import "AALoanDetail.h"

@interface QCBorrowManageViewController : QCBaseViewController<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate>
{

     NSInteger page;
}

@property (nonatomic,strong)QCBaseTableView *tableView;
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong) AALoanDetail *detail;
@property(nonatomic,strong)UILabel *textLabel;
@property(nonatomic,strong)UILabel *perLabel;
@property(nonatomic,strong)UILabel *allLabel;
@property(nonatomic,strong)UILabel *payLabel;
@property(nonatomic,assign)NSInteger AALoanId;

@end
