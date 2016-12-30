//
//  BillDetailViewController.h
//  YOUXINBAO
//
//  Created by Walice on 16/2/1.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "LoanCertificate.h"
#import "IOUDetailsHeaderView.h"
#define MessageCenterPageNOStart 1
@interface BillDetailViewController : QCBaseViewController<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,IOUDetailHeaderViewDelegate>
@property (nonatomic,strong)QCBaseTableView *tableView;
@property (nonatomic,assign)NSInteger loanID;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property(nonatomic,strong)LoanCertificate *detail;
@property(nonatomic,strong)UIImageView *gongzhang;


@property (nonatomic,strong) NSString * encryptionID;//首页跳转需要隐藏个人信息
@property (nonatomic,assign) BOOL isHideInfo;//是否隐藏个人信息
@end
