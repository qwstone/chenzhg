//
//  FriendDetailHeaderView.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "FriendDetailHeaderView.h"

@interface FriendDetailHeaderView ()

@property(nonatomic,strong)UIImageView  *imageView;//头像
@property(nonatomic,strong)UILabel      *userNameLabel;//用户名
@property(nonatomic,strong)UILabel      *yxbCode;//友信宝代码
@property(nonatomic,strong)UILabel      *yxbWords;//友信宝签名


@end

@implementation FriendDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews
{
    CGFloat leftAlign = 15;
    CGFloat topAlign = 17;
    CGFloat x = leftAlign,y = topAlign,w = 70,h = 70;
//    self.avatarImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView= [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    _imageView.userInteractionEnabled = YES;
    _imageView.layer.cornerRadius=w/4;
    _imageView.clipsToBounds = YES;

    [self addSubview:_imageView];
    
    
    UIControl *control = [[UIControl alloc] initWithFrame:_imageView.bounds];
    [control addTarget:self action:@selector(imageAction) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:control];
    
    //创建用户名
    CGFloat space = 5;
    x = x+ w + 8;
    y = y + space;
    w = kDeviceWidth-_imageView.right-10;
    h = 20;
    NSInteger fontSize = 16;
    self.userNameLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:fontSize textColor:[UIColor blackColor]];
    [self addSubview:_userNameLabel];
    
    
    //友信宝账号
    
    y = _userNameLabel.origin.y + _userNameLabel.height + space;
    fontSize -= 3;
    self.yxbCode = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:fontSize textColor:[UIColor lightGrayColor]];
    _yxbCode.backgroundColor = [UIColor clearColor];

    [self addSubview:_yxbCode];
    //信用等级
    y = _yxbCode.origin.y + _yxbCode.height;
    self.yxbWords = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:fontSize textColor:[UIColor lightGrayColor]];
    _yxbWords.backgroundColor = [UIColor clearColor];

    [self addSubview:_yxbWords];
}

-(void)setUser:(User *)user
{
    if (_user != user) {
        _user = user;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_user.iconAddr] placeholderImage:[UIImage imageNamed:@"userPlace"]];
        self.yxbCode.text = [NSString stringWithFormat:@"无忧借条账号: %@",_user.yxbId];
        self.yxbWords.text = [NSString stringWithFormat:@"信用等级: %@",self.xinyongGrade];
        NSMutableAttributedString *Str = [[NSMutableAttributedString alloc] initWithString:self.yxbWords.text];
        if (_xinyongGrade!=nil) {
            [Str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[self.yxbWords.text rangeOfString:[NSString stringWithFormat:@"%@",_xinyongGrade]]];
            [Str addAttribute:NSForegroundColorAttributeName value:rgb(65, 117, 213, 1) range:[self.yxbWords.text rangeOfString:_xinyongGrade]];
            self.yxbWords.attributedText = Str;
        }
        
        
        if (_isFriend) {
            self.userNameLabel.text =[NSString stringWithFormat:@"%@%@",_user.nickname,_realName];
            NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:self.userNameLabel.text];
            if (_realName!=nil) {
                [aStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[self.userNameLabel.text rangeOfString:[NSString stringWithFormat:@"%@",_realName]]];
                [aStr addAttribute:NSForegroundColorAttributeName value:rgb(65, 117, 213, 1) range:[self.userNameLabel.text rangeOfString:_realName]];
                self.userNameLabel.attributedText = aStr;
            }

            
            
        }
        else{
            self.userNameLabel.text =[NSString stringWithFormat:@"%@",_user.nickname];
        
        }
    }
}

//-(UIImageView*)borderImageViewWithImage:(UIImage *)image frame:(CGRect)frame
//{
//    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hy-usermr-icon.png"]];
//    bgImageView.clipsToBounds = YES;
//    bgImageView.frame = frame;
//    
//    CGFloat space = 4;
//    
//    CGFloat x = space;
//    CGFloat y = space-2;
//    CGFloat w = frame.size.width - 2 * space;
//    CGFloat h = frame.size.height - 2 * space;
//    
//    self.avatarImg = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
//    self.avatarImg.layer.cornerRadius = self.avatarImg.width/4;
//    self.avatarImg.clipsToBounds = YES;
//    self.avatarImg.image = image;
//    _avatarImg.userInteractionEnabled = YES;
//    [bgImageView addSubview:self.avatarImg];
//    
//    return bgImageView;
//}

-(void)imageAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(imageActionWithImageView:)]) {
        [_delegate imageActionWithImageView:_imageView];
    }
    
    
}

@end
