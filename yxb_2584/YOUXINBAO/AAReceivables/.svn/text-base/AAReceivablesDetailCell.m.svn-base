//
//  AAReceivablesDetailCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/6/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAReceivablesDetailCell.h"
#import "UIImageView+WebCache.h"
#import "AAReceivablesConfig.h"

@interface AAReceivablesDetailCell ()

@property(nonatomic,strong)UIImageView *avartarImageView;//头像
@property(nonatomic,strong)UILabel     *userNameLabel;//用户名
@property(nonatomic,strong)UILabel      *dateLabel;//日期
@property(nonatomic,strong)UIImageView  *stateImage;//是否已付款

@end
@implementation AAReceivablesDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    
    return self;
}

-(void)initViews
{
    //添加头像用户名
    CGFloat x = 20, y = 8,w = 35,h = 35;
    UIImageView *imageView = [self borderImageViewWithImage:[UIImage imageNamed:@"useimg"] frame:CGRectMake(x,y, w, h)];
    [self.contentView addSubview:imageView];
    
    x = x + w + 10,
    w = [self nickNameWidth];
    self.userNameLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:14 textColor:rgb(71, 71, 71, 1.0)];
    _userNameLabel.backgroundColor = [UIColor clearColor];
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    _userNameLabel.adjustsFontSizeToFitWidth = NO;
    [self.contentView addSubview:_userNameLabel];
    
    //添加时间
    x = x + w;
    self.dateLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:14 textColor:rgb(71, 71, 71, 1.0)];
    _dateLabel.backgroundColor = [UIColor clearColor];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_dateLabel];

    //添加状态
    x = x + w;
    self.stateImage = [[UIImageView alloc] initWithFrame:CGRectMake(x+10, 0, w-20, AAReceivablesDetailCellHeight)];
    _stateImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_stateImage];
    
    UIControl *imageAction = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 200, AAReceivablesDetailCellHeight)];
    [imageAction addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:imageAction];

}

-(void)setModel:(GatheringRecordFriend *)model
{
    if (_model != model) {
        _model = model;
        [_avartarImageView sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:@"useimg.png"]];
        _userNameLabel.text = _model.nickName;
        _dateLabel.text = _model.time;
        _stateImage.image = [UIImage imageNamed:[self imageNameWithStatusCode:_model.state]];
        
    }
}


//根据状态码获取图片名称
-(NSString *)imageNameWithStatusCode:(NSInteger)code
{
    
    NSString *name = @"";
    switch (code) {
        case AAMoneyTotalStateNone:
        {
            name = @"  ";
        }
            break;
        case AAMoneyTotalStatePaying:
        {
            name = @"AA-dsk-stamp.png";
        }
            break;
        case AAMoneyTotalStateClosed:
        {
            name = @"AA-ygb-stamp.png";
        }
            break;
        case AAMoneyTotalStateAARefund:
        {
            name = @"AA-ytk-stamp.png";
        }
            break;
        case AAMoneyTotalStateOK:
        {
            name = @"AA-ysq-stamp.png";
        }
            break;
        case AAMoneyTotalStateClosedNotPayed:
        {
            name = @"AA-wfk-stamp.png";
        }
            break;
        case AAMoneyTotalStatePayed:
        {
            name = @"AA-payded-stamp.png";
        }
            break;
        case AAMoneyTotalStateNotPayed:
        {
            name = @"AA-wfk-stamp.png";
        }
            break;
        case AAMoneyTotalStateMemberRefund:
        {
            name = @"AA-ytk-stamp.png";
        }
            break;
            
            
            
        default:
            break;
    }
    
    return name;
}



-(UILabel *)labelWithFrame:(CGRect)frame fontSize:(NSInteger)fontSize textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    //    label.backgroundColor = [YXBTool generateRandomColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.minimumScaleFactor = 10.0/label.font.pointSize;
    label.adjustsFontSizeToFitWidth = YES;
    label.textColor = textColor;
    
    return label;
}

-(UIImageView*)borderImageViewWithImage:(UIImage *)image frame:(CGRect)frame
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expertUserImg.png"]];
    bgImageView.clipsToBounds = YES;
    bgImageView.frame = frame;
    
    CGFloat space = 1;
    
    CGFloat x = space;
    CGFloat y = space;
    CGFloat w = frame.size.width - 2 * space;
    CGFloat h = frame.size.height - 2 * space;
    
    self.avartarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _avartarImageView.layer.cornerRadius = _avartarImageView.width/2;
    _avartarImageView.clipsToBounds = YES;
    _avartarImageView.image = image;
    [bgImageView addSubview:_avartarImageView];
    
    return bgImageView;
}

-(CGFloat)nickNameWidth
{
//    CGFloat w = (kDeviceWidth - 145)/2.0;
    CGFloat w = (kDeviceWidth - _avartarImageView.right - 30)/3.0;
    return w;
}

-(void)buttonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(userImageClickedWithUserId:)]) {
        [_delegate userImageClickedWithUserId:_model.userId];
    }
}

@end
