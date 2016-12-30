//
//  AAReceivablesDetailCell.h
//  YOUXINBAO
//
//  Created by Feili on 15/6/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseCell.h"
#import "GatheringRecordFriend.h"
#import "LoanMessageTableViewCell.h"
#define AAReceivablesDetailCellHeight 50



@interface AAReceivablesDetailCell : QCBaseCell
@property (nonatomic,strong)GatheringRecordFriend *model;
@property (nonatomic,strong)id<LoanMessageTableViewCellDelegate>delegate;
@end
