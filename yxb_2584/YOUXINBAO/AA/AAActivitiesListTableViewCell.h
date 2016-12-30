//
//  AAActivitiesListTableViewCell.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAActivity.h"

#define AAActivitiesListTableViewCellHeight 140
#define AAActivitiesListLeftLeft 10

@interface AAActivitiesListTableViewCell : UITableViewCell

@property(nonatomic,assign)NSInteger index;
@property (nonatomic,retain)UIImageView * image;
@property(nonatomic,assign)BOOL isMine;//YES是我发起的活动,NO不是

@property (nonatomic,retain)UILabel * titleLabel;

@property (nonatomic,retain)UILabel * destNameLabel;

@property (nonatomic,retain)UILabel * timeLabel;

@property (nonatomic,retain)UILabel * numberOfPeopleLabel;

@property (nonatomic,assign)NSInteger unReadCount;//消息未读数

//@property ()

@property (nonatomic,retain)AAActivity * tactivity;
-(void)resetViewsWidth;


@end
