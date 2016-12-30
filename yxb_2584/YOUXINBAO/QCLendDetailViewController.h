//
//  QCLendDetailViewController.h
//  YOUXINBAO
//
//  Created by Walice on 15/7/2.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "LoanConfig.h"

@class HttpOperator;

@interface QCLendDetailViewController : QCBaseViewController<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)QCBaseTableView *tableView;
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property(nonatomic,assign)NSInteger loanId;
@property(nonatomic,strong)UILabel *label3;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong) UILabel *label1;
@property(nonatomic,strong)UIView *view1;
@property(nonatomic,assign)BorrowerORLenders bOrL;
@property(nonatomic,strong)Loan *loan;


@end
