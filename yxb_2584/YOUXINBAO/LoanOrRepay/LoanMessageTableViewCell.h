//
//  LoanMessageTableViewCell.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLoanWithLog.h"


@protocol LoanMessageTableViewCellDelegate <NSObject>

-(void)userImageClickedWithUserId:(NSInteger)uId;

@end

@interface LoanMessageTableViewCell : UITableViewCell

@property (nonatomic,retain)UIImageView * userimage;

@property (nonatomic,retain)UIImageView * detailsImage;

@property (nonatomic,retain)UILabel * timeLabel;

@property (nonatomic, assign)id<LoanMessageTableViewCellDelegate>delegate;

@property (nonatomic,retain)TLoanLog * loanLog;
@property (nonatomic,retain)TLoanWithLog * loanWithLog;

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
