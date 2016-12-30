//
//  MessageTableViewCell.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell


@property (nonatomic,retain) UIImageView * userimage;
@property (nonatomic,retain) UILabel * nameLabel;
@property (nonatomic,copy) UILabel * messageLabel;
@property (nonatomic,assign)CGSize messageSize;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier mySelf:(BOOL)me;

- (UIView *)BubbleView:(NSString *)messge myself:(BOOL)me;


@end
