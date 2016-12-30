//
//  QCNewFriendCell.h
//  YOUXINBAO
//
//  Created by CH10 on 14-5-23.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "TFriendRelation.h"
#define kNewFriendCellHeight 64
@class QCNewFriendCell;

@protocol QCNewFriendCellDelegate <NSObject>

@optional
- (void)deleteButtonClickedNewFriendCell:(QCNewFriendCell *)cell userName:(NSString *)name;  //删除按钮被点击
- (void)QCNewFriendCellDidEditing:(QCNewFriendCell *)cell;  //展开的单元格
- (void)QCNewFriendCellDidClose:(QCNewFriendCell *)cell;   //关闭单元格

//接受按钮被点击
- (void)acceptButtonClickedNewFriendCell:(QCNewFriendCell *)cell;

@end

@interface QCNewFriendCell : UITableViewCell

@property (nonatomic,assign)id<QCNewFriendCellDelegate> delegate;
@property (nonatomic,assign)BOOL isEditing;
@property (nonatomic,retain)UIImageView * imageview;
@property (nonatomic,retain)UILabel * nameLabel;
@property (nonatomic,retain)UILabel * detailLabel;
@property (nonatomic,retain)UIButton *acceptButton;
@property (nonatomic,assign)BOOL isFromSearch;//是否来自搜索

@property (nonatomic,retain)TFriendRelation *user;
@property (nonatomic,strong)User *tUser;

- (void)changeAcceptType;

- (void)closeDeleteButton;
- (void)closeSwipeAction;
- (void)openSwipeAction;
@end

