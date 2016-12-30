//
//  LoanOrRepayListTableViewCell.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/8.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loan.h"
#import "CustomBadge.h"
#import "GuaranteeRequestListData.h"

@interface LoanOrRepayListTableViewCell : UITableViewCell

@property (nonatomic,retain)UIImageView * image;

@property (nonatomic,retain)UIImageView * loanOrRepayImage;

@property (nonatomic,retain)UILabel * nameLabel;

@property (nonatomic,retain)UILabel * moneyLabel;

@property (nonatomic,retain)UILabel * timeLabel;

//@property (nonatomic,retain)UILabel * statusLabel;

@property (nonatomic,retain)UILabel * subStatusLabel;

@property (nonatomic,retain)Loan * loanModel;

@property (nonatomic,strong)CustomBadge *unReadView;

@property (nonatomic,strong)GuaranteeRequestListData *GuaranteeModel;//代付


@property(nonatomic,assign)BOOL isOtherFriend;

@end
