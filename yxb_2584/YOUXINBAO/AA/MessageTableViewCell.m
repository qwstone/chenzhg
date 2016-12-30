//
//  MessageTableViewCell.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier mySelf:(BOOL)me
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _userimage = [[UIImageView alloc]init];
        _userimage.layer.cornerRadius = 25;
        _userimage.layer.masksToBounds = YES;
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:13];
        if (me) {
            _userimage.frame= CGRectMake(kDeviceWidth-60, 10, 50, 50);
            _nameLabel.frame = CGRectMake(kDeviceWidth-60, 63, 50, 10);
        }else{
            _userimage.frame= CGRectMake(10, 10, 50, 50);
            _nameLabel.frame = CGRectMake(10, 63, 50, 10);
        }
        _userimage.backgroundColor = [UIColor redColor];
        [self addSubview:_userimage];
        [self addSubview:_nameLabel];
//        [self addSubview:[self BubbleView:@"safasfasfasfasfasfasfasfas" myself:me]];
    }
    return self;
}

- (UIView *)BubbleView:(NSString *)messge myself:(BOOL)me
{
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(3, 6, 110, 40)];
//    self = [self initWithFrame:CGRectMake(3, 6, 110, 40)];
//    bgview = [self initWithFrame:CGRectMake(3, 6, 110, 40)];
    if (bgview) {
        bgview.backgroundColor = [UIColor clearColor];
        
        UIImage * ima = [UIImage imageNamed:me?@"chat_right_bg.png":@"chat_left_bg.png"];
        
        UIImageView *imgview = [[UIImageView alloc]initWithImage:[ima stretchableImageWithLeftCapWidth:20 topCapHeight:24]];
        imgview.backgroundColor = [UIColor clearColor];
        
        UIFont *font = [UIFont systemFontOfSize:17];

//        _messageSize = [messge sizeWithFont:font constrainedToSize:CGSizeMake(kDeviceWidth-120, 300) lineBreakMode:NSLineBreakByWordWrapping];
        _messageSize = [messge boundingRectWithSize:CGSizeMake(kDeviceWidth-120, 300) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
        
//        UILabel * label;
        if (me) {
            _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, _messageSize.width, _messageSize.height)];
        }else{
            _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, _messageSize.width, _messageSize.height)];
        }
        
        _messageLabel.text = messge;
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        //label.backgroundColor = [UIColor redColor];
        _messageLabel.font =font;
        _messageLabel.numberOfLines = 0;
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        imgview.frame = CGRectMake(5, 0, _messageSize.width+40 , _messageSize.height+20);
        if (me) {
            bgview.frame = CGRectMake(kDeviceWidth-_messageSize.width-110, 10, _messageSize.width+40, _messageSize.height+20);
            
        }else{
            bgview.frame = CGRectMake(60, 10, _messageSize.width+40, _messageSize.height+20);
        }
        [bgview addSubview:imgview];
        [bgview addSubview:_messageLabel];
        
    }
    return bgview;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
