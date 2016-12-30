//
//  PayForanotherTableViewCell.h
//  YOUXINBAO
//
//  Created by zjp on 15/9/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpPayment.h"

@protocol PayForanotherTableViewCellDelegate <NSObject>

-(void)toMyFriend;

@end

@interface PayForanotherTableViewCell : UITableViewCell


@property(nonatomic,strong)HelpPayment *model;
@property (nonatomic,strong)id <PayForanotherTableViewCellDelegate>delegate;
@end
