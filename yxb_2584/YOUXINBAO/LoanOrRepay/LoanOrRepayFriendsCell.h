//
//  LoanOrRepayFriendsCell.h
//  YOUXINBAO
//
//  Created by CH10 on 15/7/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCLinkManCell.h"
#import "User.h"
#import "LoanConfig.h"

@interface LoanOrRepayFriendsCell : QCLinkManCell

@property (nonatomic,strong) User *friendUser;
//@property (nonatomic,assign) BOOL isBorrow;

@property (nonatomic,assign) LoanFriendCellType cellType;

@end
