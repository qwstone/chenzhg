//
//  PersonalProfileHeadTableViewCell.h
//  YOUXINBAO
//
//  Created by CH10 on 15/9/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXBLevelView.h"
#import "QCUserModel.h"
@interface PersonalProfileHeadTableViewCell : UITableViewCell
@property (nonatomic,retain)UILabel * rownameLabel;

@property (nonatomic,retain)UIImageView * userimageView;

@property (nonatomic,retain)UILabel * detailsLabel;
@property (nonatomic,retain)UIImageView *detailImageView;
@property (nonatomic,strong)NSMutableArray *image2Array;
@property (nonatomic,strong)YXBLevelView *levelView;
@property (nonatomic,strong)QCUserModel *userModel;
@end
