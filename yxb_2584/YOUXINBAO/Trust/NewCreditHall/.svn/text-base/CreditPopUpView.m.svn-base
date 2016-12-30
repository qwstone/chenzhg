//
//  CreditPopUpView.m
//  YOUXINBAO
//
//  Created by Feili on 15/6/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CreditPopUpView.h"
#import "UIImageView+WebCache.h"

#define CreditPopUpViewAvatarImageViewWidth 80 //头像宽高
#define CreditPopUpViewContentHeight 185 //内容高度
#define CreditPopUpViewAnimationTime 0.5

@interface CreditPopUpView ()<UIGestureRecognizerDelegate>
{
    UIView *bgView;
    UIImageView *_avatarImageView; //头像
    UILabel *_userNameLabel;//用户名
    UIView  *_line; //横线
    UILabel *_levelTextLabel;//等级 “宇宙土豪”
    UILabel *_signatureLabel;//签名
    UILabel *_sumMoney;//累计借出金额 近30天累计借出 2100元
    UIButton *_addFriendBtn;//添加好友 已是好友 按钮
    UIImageView *_levelImage;//土豪显示砖石图片
    
    BOOL _isShown;//正在显示
//    CGFloat userNameWidth;//用户名宽度
//    CGFloat userNameY; //用户名纵坐标
//    CGFloat signatureY; //签名纵坐标
//    CGFloat sumMoneyY;//钱数纵坐标
//    CGFloat friendY;//加好友按钮纵坐标
    
}
@end

@implementation CreditPopUpView


-(void)initViews
{
    self.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
    self.backgroundColor = rgb(94, 93, 93, 0.9);

    bgView = [[UIView alloc] initWithFrame:CGRectMake(10, CreditPopUpViewAvatarImageViewWidth/2, self.width-2*10, CreditPopUpViewContentHeight)];
    bgView.layer.cornerRadius = 5.0;
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
//    UIControl *control = [[UIControl alloc] initWithFrame:self.bounds];
//    [control addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:control];
    
    //添加元头像
    CGFloat x = 0, y = -CreditPopUpViewAvatarImageViewWidth/2.0, w = CreditPopUpViewAvatarImageViewWidth, h = CreditPopUpViewAvatarImageViewWidth;
    UIImageView *imageView = [self borderImageViewWithImage:[UIImage imageNamed:@"useimg"] frame:CGRectMake(x, y, w, h)];
    imageView.center = CGPointMake(bgView.width/2.0, imageView.center.y);
    [bgView addSubview:imageView];
    
    //添加用户名
    x = 0,y = imageView.bottom - 5;
    w = (bgView.width - CreditPopUpViewAvatarImageViewWidth)/2.0;
    h = 18;
    _userNameLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:h textColor:[YXBTool colorWithHexString:@"#363636"]];
    _userNameLabel.text = @"";
    _userNameLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:_userNameLabel];
    
    //添加横线
    x = _userNameLabel.right + 10,y = _userNameLabel.center.y,w = CreditPopUpViewAvatarImageViewWidth - 20,h = 1;
    _line = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _line.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:_line];
    
    
    _levelImage = [[UIImageView alloc] initWithFrame:CGRectMake(_line.right + 5, _userNameLabel.top, 15, _userNameLabel.height)];
    _levelImage.contentMode = UIViewContentModeCenter;
    [bgView addSubview:_levelImage];

    //添加等级标识
    x = _levelImage.right,y = _userNameLabel.top,w = _userNameLabel.width,h = _userNameLabel.height;
    _levelTextLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:h-4 textColor:[YXBTool colorWithHexString:@"#f46956"]];
    _levelTextLabel.text = @"";
    _levelTextLabel.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:_levelTextLabel];
    
    //添加签名
    x = 0, y = _userNameLabel.bottom + 10, w = bgView.width, h = 12;
    _signatureLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:h textColor:[YXBTool colorWithHexString:@"#7f7f7f"]];
    _signatureLabel.text = @"";
    _signatureLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:_signatureLabel];
    
    //添加累计钱数或积分
    x = 0, y = _signatureLabel.bottom + 10,w = self.width,h = 20;
    _sumMoney = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:h-6 textColor:[YXBTool colorWithHexString:@"#363636"]];
    _sumMoney.text = @"";
    _sumMoney.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:_sumMoney];
    
    //添加好友label
    x = 0, y = _sumMoney.bottom + 20, w = 130, h = 35;
    _addFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addFriendBtn.frame = CGRectMake(x, y, w, h);
    _addFriendBtn.layer.cornerRadius = 5.0;
    [_addFriendBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    _addFriendBtn.center = CGPointMake(bgView.center.x, _addFriendBtn.center.y);
    [bgView addSubview:_addFriendBtn];
    
    
}

//-(void)loadDefaultValue
//{
//    userNameWidth = (self.width - CreditPopUpViewAvatarImageViewWidth)/2 - 10;
//    userNameY = CreditPopUpViewAvatarImageViewWidth;
//    signatureY =
//}

-(UIImageView*)borderImageViewWithImage:(UIImage *)image frame:(CGRect)frame
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expertUserImg.png"]];
    bgImageView.clipsToBounds = YES;
    bgImageView.frame = frame;
    
    CGFloat space = 4;
    
    CGFloat x = space;
    CGFloat y = space-2;
    CGFloat w = frame.size.width - 2 * space;
    CGFloat h = frame.size.height - 2 * space;
    
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _avatarImageView.layer.cornerRadius = _avatarImageView.width/2;
    _avatarImageView.clipsToBounds = YES;
    _avatarImageView.image = image;
    [bgImageView addSubview:_avatarImageView];
    
    return bgImageView;
}



-(void)setModel:(CreditCenter *)model
{
    if (_model != model) {
        _model = model;
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg.png"]];
        _signatureLabel.text = _model.signature;
        _userNameLabel.text = _model.realName;
        if (_type == QCBoardTypeTuHao) {
            _levelImage.image = [UIImage imageNamed:@"diamond-icon"];

            _levelTextLabel.text = [NSString stringWithFormat:@"%@",_model.level];
            NSString *moneyText = [NSString stringWithFormat:@"土豪榜累计积分: %@",_model.score];
            NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:moneyText];
            [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:[moneyText rangeOfString:_model.score]];
            [aString addAttribute:NSForegroundColorAttributeName value:rgb(176, 53, 42, 1.0) range:[moneyText rangeOfString:_model.score]];
            _sumMoney.attributedText = aString;
            QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
            if (userModel.isLogin == NO) {
                //未登录。默认都不是好友
                [self isFriend:NO];

            }
            else
            {
                if (_model.friendFlag == 1) {
                    [self isFriend:YES];
                    
                }
                else
                {
                    [self isFriend:NO];
                }

            }

        }
        
    }
}

-(void)isFriend:(BOOL)is
{
    if (!is) {
        [_addFriendBtn setTitle:@"加好友" forState:UIControlStateNormal];
        [_addFriendBtn setTitleColor:rgb(206, 36, 36, 1.0) forState:UIControlStateNormal];
        _addFriendBtn.layer.borderColor = rgb(206, 36, 36, 1.0).CGColor;
        _addFriendBtn.layer.borderWidth = 1.0;
    }
    else
    {
        [_addFriendBtn setTitle:@"已是好友" forState:UIControlStateNormal];
        [_addFriendBtn setTitleColor:rgb(113, 113, 113, 1.0) forState:UIControlStateNormal];
        _addFriendBtn.layer.borderColor = rgb(87, 87, 87, 1.0).CGColor;
        _addFriendBtn.layer.borderWidth = 1.0;

    }
}


//显示
-(void)show
{
    if (_isShown == NO) {
        UIWindow *mWindow = [[[UIApplication sharedApplication] delegate] window];
        if (!mWindow.isKeyWindow) {
            [mWindow makeKeyAndVisible];
            
        }
        bgView.center = mWindow.center;
        [self popupAnimation:bgView duration:CreditPopUpViewAnimationTime];
        [mWindow addSubview:self];
        _isShown = YES;

    }

}

//隐藏
-(void)hidden
{
    if (_isShown == YES)
    {
        _isShown = NO;
        
        [UIView animateWithDuration:0.2
                         animations:^{self.alpha = 0.0;}
                         completion:^(BOOL finished){
                             [self removeFromSuperview];
                         }];
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    CGPoint p = [touch locationInView:self];
    bool isIn = CGRectContainsPoint(bgView.frame, p);
    
    if (isIn) {
        return NO;
    }
    
    
    return YES; // handle the touch
}

-(void)buttonAction
{
    NSLog(@"加好友");
    if (_iOnAddFriend != nil && _model.friendFlag == 0) {
        self.iOnAddFriend([_model.username integerValue]);
    }
}

/** 弹出视图的动画 */

- (void)popupAnimation:(UIView *)outView duration:(CFTimeInterval)duration
{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    
    NSMutableArray * values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    [outView.layer addAnimation:animation forKey:nil];
}


@end
