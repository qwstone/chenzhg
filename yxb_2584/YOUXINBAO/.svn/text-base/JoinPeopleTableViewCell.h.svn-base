//
//  JoinPeopleTableViewCell.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TActivity.h"
//#import "TActivityMember.h"
#import "AAActivity.h"
@class JoinPeopleTableViewCell;

typedef enum {
    B_BUKECAOZHUO =11,
    B_JUJUE = 100,
    B_WEITAQIANDAO,
    B_QIANDAO,
}btnStyle;

@protocol JoinPeopleTableViewCellDelegate <NSObject>

- (void)JoinPeopleTableViewCellRejectButtonDidClicked:(JoinPeopleTableViewCell *)cell;
-(void)userImageClickedWithUserId:(NSInteger)uId;


@end

@interface JoinPeopleTableViewCell : UITableViewCell

@property (nonatomic,assign) id<JoinPeopleTableViewCellDelegate> delegate;

@property (nonatomic,retain) UIImageView * image;

@property (nonatomic,retain) UILabel * nameLabel;

@property (nonatomic,retain) UIImageView* sexLabel;

@property (nonatomic,retain) UILabel * sateLabel;

@property (nonatomic,retain) AAActivity * tacivity;

@property (nonatomic,assign) NSInteger row;

@property (nonatomic,retain) UIButton * jujueBtn;

@property (nonatomic,strong) UIButton *callButton;

@property (nonatomic,strong) UIImageView *borrowView;

@end
