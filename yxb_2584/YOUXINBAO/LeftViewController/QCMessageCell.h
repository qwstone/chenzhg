//
//  QCMessageCell.h
//  YOUXINBAO
//
//  Created by 冰冰 on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageCenterItem.h"

@interface QCMessageCell : UITableViewCell{
    UILabel *_titleLabel;
    UILabel *_subTitleLabel;
    UILabel *_timeLabel;
    UIImageView  *imgView;
    UIImageView  *iconImg;

}

@property(nonatomic,retain) MessageCenterItem *model;
@property(nonatomic,retain) UIImageView *img;

@end
