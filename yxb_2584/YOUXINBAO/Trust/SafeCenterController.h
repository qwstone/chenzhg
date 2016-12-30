//
//  SafeCenterController.h
//  YOUXINBAO
//
//  Created by Walice on 15/9/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"

@interface SafeCenterController : QCBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end
