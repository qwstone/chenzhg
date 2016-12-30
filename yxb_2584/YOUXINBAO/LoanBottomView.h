//
//  LoanBottomView.h
//  YOUXINBAO
//
//  Created by zjp on 15/6/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoanBottomCell.h"
@interface LoanBottomView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView        *HomeLiseTableView;//滑动列表

@property (nonatomic, strong) NSMutableArray* iTLoanIndexPersonRank;
@property (nonatomic, strong) NSString* participantsNum;
@end
