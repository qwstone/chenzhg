//
//  QCLinkManCell.h
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-6.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#define kLinkManCellHeight 55
#define CellLabelFont 16
@class QCLinkManCell;
@protocol QCLinkManCellDelegate <NSObject>

@optional
- (void)deleteButtonClickedLinkManCell:(QCLinkManCell *)cell userName:(NSString *)name;  //删除按钮被点击
- (void)QCLinkManCellDidEditing:(QCLinkManCell *)cell;  //展开的单元格
- (void)QCLinkManCellDidClose:(QCLinkManCell *)cell;   //关闭单元格

////接受按钮被点击
//- (void)acceptButtonClickedLinkManCell:(QCLinkManCell *)cell;

@end

@interface QCLinkManCell : UITableViewCell
{
    UIButton *_deleteButton;
    //    UIButton *_acceptButton;
        BOOL			m_checked;
    
    UISwipeGestureRecognizer *_leftSwipe;
    UISwipeGestureRecognizer *_rightSwipe;
}

@property(nonatomic,strong)User *userModel;
@property (nonatomic,strong)NSMutableDictionary *dic;
@property (nonatomic,assign)id<QCLinkManCellDelegate> delegate;
@property (nonatomic,assign)BOOL isEditing;
//@property (nonatomic,assign)BOOL isNewFriend;
@property (nonatomic,retain)UIImageView * imageview;    //头像
@property (nonatomic,retain)UILabel * nameLabel;        //名字
//@property (nonatomic,retain)UIImageView *badgeView;     //新朋友个数视图

@property (nonatomic,assign)BOOL canDelete;     //能否删除
@property (nonatomic,strong)UIButton *deleteButton;
//@property (nonatomic,retain)UILabel * detailLabel;
@property(nonatomic,strong)UIImageView *arrow;

- (void)closeDeleteButton;
- (void)openSwipeAction;
- (void)closeSwipeAction;
-(void)loadViewsWidth;

@property (nonatomic,strong)UIImageView*	m_checkImageView;
- (void)setChecked:(BOOL)checked;
-(void)showNewIcon:(BOOL)isShow;

@end
