//
//  MergeViewController.h
//  YOUXINBAO
//
//  Created by pro on 2016/12/12.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "OverdueLoanData.h"
@interface MergeViewController : QCBaseViewController


@property (assign, nonatomic)NSInteger loanId;
@property (assign, nonatomic)NSInteger money;
@property (nonatomic ,strong) OverdueLoanData * model;

@end
