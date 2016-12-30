//
//  PayForanotherViewController.h
//  YOUXINBAO
//
//  Created by zjp on 15/9/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "QCBaseTableView.h"
#import "PayForanotherTableViewCell.h"
#import "HttpOperator.h"
@interface PayForanotherViewController : QCBaseViewController<QCBaseTableViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)QCBaseTableView *tableView;
@property(nonatomic,strong)HttpOperator             *iHttpOperator;
@property(nonatomic,strong)UIView           *bottomView;//放底部按钮的View


@property(nonatomic,assign)NSInteger    helpID;//代付ID
@end
