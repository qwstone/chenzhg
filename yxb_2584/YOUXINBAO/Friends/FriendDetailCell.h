//
//  FriendDetailCell.h
//  YOUXINBAO
//
//  Created by Feili on 15/5/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendDetailItemModel.h"
#define FriendDetailCellHeight 50

@protocol FriendDetailCellDelegate <NSObject>

@optional
-(void)detailInfoChanged:(NSIndexPath *)indexPath value:(NSString *)value;

@end

@interface FriendDetailCell : UITableViewCell

@property(nonatomic,strong)FriendDetailItemModel *user;
@property(nonatomic,strong)NSIndexPath *indexPath;

@end
