//
//  LeftHeaderView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/6/5.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LeftHeaderView.h"
#import "YXBTool.h"
#import "UIImageView+WebCache.h"
#import "YXBLevelView.h"
#import "QCRegisterOneViewController.h"

@implementation LeftHeaderView {
    UIImageView *_portrait;
    UILabel*_nickName;
    UIImageView *_level;
    UILabel *_sign;
    UILabel *_sum;
    UILabel *_remain;
    UILabel *_redBag;
    YXBLevelView *_levelView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [YXBTool colorWithHexString:@"#32323A"];
        
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLeftHeaderWidth, getScreenFitSize(179)/2)];
    topView.backgroundColor = [YXBTool colorWithHexString:@"28282E"];
    [self addSubview:topView];
    
    _portrait = [[UIImageView alloc] initWithFrame:CGRectMake(getScreenFitSize(25), getScreenFitSize(20), getScreenFitSize(60.5), getScreenFitSize(60.5))];
    _portrait.layer.cornerRadius = getScreenFitSize(60.5)/2;
    _portrait.layer.masksToBounds = YES;
    _portrait.userInteractionEnabled = YES;
    [topView addSubview:_portrait];
    
    UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_portrait addGestureRecognizer:portraitTap];
    
    _nickName = [[UILabel alloc] initWithFrame:CGRectMake(_portrait.right+getScreenFitSize(12.5), _portrait.top, getScreenFitSize(90), getScreenFitSize(20))];
    _nickName.backgroundColor = [UIColor clearColor];
    _nickName.font = [UIFont systemFontOfSize:getScreenFitSize(16)];
    _nickName.textColor = [UIColor whiteColor];
    [topView addSubview:_nickName];
    
    //二维码 25*25
    //扩大区域
    
    EnlargeButton *qrCode = [[EnlargeButton alloc] initWithFrame:CGRectMake(kLeftHeaderWidth-getScreenFitSize(40), _nickName.center.y, getScreenFitSize(25), getScreenFitSize(25))];
    qrCode.enlargeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [qrCode setBackgroundImage:[UIImage imageNamed:@"usertc-ewm"] forState:UIControlStateNormal];
    [qrCode addTarget:self action:@selector(qrCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:qrCode];
    
    //添加等级
    _levelView = [[YXBLevelView alloc] initWithFrame:CGRectMake(_nickName.left, _nickName.bottom+getScreenFitSize(5), getScreenFitSize(200), getScreenFitSize(30))];
//    _levelView.stateString = @"00000";
    [topView addSubview:_levelView];
    
    _level = [[UIImageView alloc] initWithFrame:CGRectMake(0, _nickName.top, getScreenFitSize(20.5), getScreenFitSize(12.5))];
    [topView addSubview:_level];
    
    _sign = [[UILabel alloc] initWithFrame:CGRectMake(_portrait.right+getScreenFitSize(12.5), _portrait.bottom-getScreenFitSize(15), getScreenFitSize(200), getScreenFitSize(15))];
    _sign.backgroundColor = [UIColor clearColor];
    _sign.font = [UIFont systemFontOfSize:getScreenFitSize(12)];
    _sign.textColor = [YXBTool colorWithHexString:@"#777777"];
    [topView addSubview:_sign];
    
    UIImageView *money = [[UIImageView alloc] initWithFrame:CGRectMake(getScreenFitSize(24), topView.bottom+getScreenFitSize(11), getScreenFitSize(15), getScreenFitSize(15))];
    money.image = [UIImage imageNamed:@"total-icon"];
    [self addSubview:money];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(getScreenFitSize(44), topView.bottom, getScreenFitSize(70), getScreenFitSize(37))];
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont systemFontOfSize:getScreenFitSize(14)];
    label1.text = @"账户总额：";
    label1.textColor = [YXBTool colorWithHexString:@"#C0C0C0"];
    [self addSubview:label1];

    _sum = [[UILabel alloc] initWithFrame:CGRectMake(label1.left+getScreenFitSize(70), topView.bottom, getScreenFitSize(150), getScreenFitSize(37))];
    _sum.backgroundColor = [UIColor clearColor];
    _sum.font = [UIFont systemFontOfSize:getScreenFitSize(14)];
    _sum.textColor = [YXBTool colorWithHexString:@"#C0C0C0"];
    [topView addSubview:_sum];
    
    [self addLineWithPoint:CGPointMake(getScreenFitSize(24), getScreenFitSize(37)+topView.bottom)];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(getScreenFitSize(44), getScreenFitSize(37)+topView.bottom, getScreenFitSize(70), getScreenFitSize(30))];
    label2.backgroundColor = [UIColor clearColor];
    label2.font = [UIFont systemFontOfSize:getScreenFitSize(14)];
    label2.text = @"现金余额：";
    label2.textColor = [YXBTool colorWithHexString:@"#777777"];
    [self addSubview:label2];
    
    _redBag = [[UILabel alloc] initWithFrame:CGRectMake(label1.left+getScreenFitSize(70), getScreenFitSize(37)+topView.bottom, getScreenFitSize(150), getScreenFitSize(30))];
    _redBag.backgroundColor = [UIColor clearColor];
    _redBag.font = [UIFont systemFontOfSize:getScreenFitSize(14)];
    _redBag.textColor = [YXBTool colorWithHexString:@"#777777"];
    [topView addSubview:_redBag];
    
    [self addLineWithPoint:CGPointMake(getScreenFitSize(44), getScreenFitSize(67)+topView.bottom)];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(getScreenFitSize(44), getScreenFitSize(67)+topView.bottom, getScreenFitSize(70), getScreenFitSize(30))];
    label3.backgroundColor = [UIColor clearColor];
    label3.font = [UIFont systemFontOfSize:getScreenFitSize(14)];
    label3.text = @"补贴金额：";
    label3.textColor = [YXBTool colorWithHexString:@"#777777"];
    [self addSubview:label3];
    
    _remain = [[UILabel alloc] initWithFrame:CGRectMake(label1.left+getScreenFitSize(70), getScreenFitSize(67)+topView.bottom, getScreenFitSize(150), getScreenFitSize(30))];
    _remain.backgroundColor = [UIColor clearColor];
    _remain.font = [UIFont systemFontOfSize:getScreenFitSize(14)];
    _remain.textColor = [YXBTool colorWithHexString:@"#777777"];
    [topView addSubview:_remain];
    
    [self addLineWithPoint:CGPointMake(getScreenFitSize(44), getScreenFitSize(97)+topView.bottom)];
    
    UIButton *chongZhi = [[UIButton alloc] initWithFrame:CGRectMake(getScreenFitSize(24), getScreenFitSize(107)+topView.bottom, getScreenFitSize(100), getScreenFitSize(31))];
    [chongZhi setImage:[UIImage imageNamed:@"rechargebut"] forState:UIControlStateNormal];
    chongZhi.tag = 30001;
    [chongZhi addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:chongZhi];
    
    UIButton *tiXian = [[UIButton alloc] initWithFrame:CGRectMake(kLeftHeaderWidth-getScreenFitSize(124), getScreenFitSize(107)+topView.bottom, getScreenFitSize(100), getScreenFitSize(31))];
    [tiXian setImage:[UIImage imageNamed:@"tcbut"] forState:UIControlStateNormal];
    tiXian.tag = 30002;
    [tiXian addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tiXian];
    
    [self addLineWithPoint:CGPointMake(getScreenFitSize(24), kLeftHeaderHeight-getScreenFitSize(0.5))];
}

- (void)buttonAction:(UIButton *)button {
    if (button.tag == 30001) {
        //充值
        if ([self.delegate respondsToSelector:@selector(LeftHeaderView:ButtonClickedAtIndex:)]) {
            [self.delegate LeftHeaderView:self ButtonClickedAtIndex:0];
        }
    }else if (button.tag == 30002) {
        //提现
        if ([self.delegate respondsToSelector:@selector(LeftHeaderView:ButtonClickedAtIndex:)]) {
            [self.delegate LeftHeaderView:self ButtonClickedAtIndex:1];
        }
    }
}

- (void)qrCodeAction:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(LeftHeaderView:qrCodeAction:)]) {
        [self.delegate LeftHeaderView:self qrCodeAction:button];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(LeftHeaderView:portraitTapAction:)]) {
        [self.delegate LeftHeaderView:self portraitTapAction:tap];
    }
}

- (void)addLineWithPoint:(CGPoint)point  {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, kLeftHeaderWidth-point.x-20, getScreenFitSize(0.5))];
    line.backgroundColor = [YXBTool colorWithHexString:@"#777777"];
    [self addSubview:line];
}

- (void)refreshData {
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [_portrait sd_setImageWithURL:[NSURL URLWithString:userModel.user.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
    _nickName.text = userModel.user.nickname;
//        _design.text = @"信用达人";
    _sign.text = [NSString stringWithFormat:@"%@",userModel.user.signature];
    //账户总额
    _sum.text = [NSString stringWithFormat:@"%@元",userModel.user.totalMoney];
    //现金余额
    _redBag.text = [NSString stringWithFormat:@"%@元",userModel.user.remainMoney];
    //补贴金额
    _remain.text = [NSString stringWithFormat:@"%@元",userModel.user.redbag];
    
    _levelView.stateString = [userModel.user levelFormatWithDesc];
    [_nickName sizeToFit];
    _level.left = _nickName.right;
    _level.image = [UIImage imageNamed:[NSString stringWithFormat:@"class-icon%ld",(long)userModel.user.comprehensiveLevel]];
}

- (void)updatePortraitWithImage:(UIImage *)image {
    _portrait.image = image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
