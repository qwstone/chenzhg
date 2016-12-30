//
//  MyYXBHeaderView.m
//  YOUXINBAO
//
//  Created by Feili on 15/9/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyYXBHeaderView.h"
#import "MoneyButton.h"
#import "UIButton+WebCache.h"
#import "YXBLevelView.h"
#import "QRCodeGenerator.h"
#import "MyCodeViewController.h"
#define ChongZhiTag 1000
#define TiXianTag 2000
#define ErWeiMaTag 3000
#define MyYXBHeaderViewBackTag 4000
#define MyYXBHeaderViewToSetting 5000

@interface MyYXBHeaderView ()
{
    UILabel *_nameLabel;
//    UIImageView *_levelImageView;
    MoneyButton *_zongeButton;
    MoneyButton *_LiCaiButton;
    MoneyButton *_xianjinButton;
    MoneyButton *_hongbaoButton;
    MoneyButton *_nZongeButton;
    UIButton *_backButton;
    YXBLevelView *_levelView;
    UILabel *_pingjiLabel;

}
@end


@implementation MyYXBHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        //可点击的背景
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = ccr(0, 0, kDeviceWidth, 170);
        backButton.tag = MyYXBHeaderViewToSetting;
        [backButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        //        [backButton setBackgroundImage:[UIImage imageNamed:@"left_headerBG.png"] forState:UIControlStateNormal];
        backButton.backgroundColor = kRGB(213, 37, 37);
        _backButton = backButton;
        [self addSubview:backButton];
        
        
        //添加返回按钮
        UIButton *navBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [navBackBtn setImage:[UIImage imageNamed:@"navigation_abck_"] forState:UIControlStateNormal];
        navBackBtn.frame = ccr(0, 18, 62, 50);
//        navBackBtn.backgroundColor = [UIColor greenColor];
        [navBackBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        navBackBtn.tag = MyYXBHeaderViewBackTag;
        
        [_backButton addSubview:navBackBtn];
        
        UILabel *title = [[UILabel alloc] initWithFrame:ccr(0, 20, self.width, 44)];
//        title.text = @"个人中心";
        title.font = [UIFont boldSystemFontOfSize:21.0];
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor whiteColor];
        [_backButton addSubview:title];
        
        
        //添加头像
        
        //头像背景框
        float x = 13.0, y = navBackBtn.bottom+10,w = 72, h = 72;
        
        UIImageView *portraitBg = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        portraitBg.userInteractionEnabled = NO;
        portraitBg.image = [YXBTool imageWithColor:[UIColor whiteColor]];
        //        portraitBg.layer.contents = (id)[UIImage imageNamed:@"left_portrait"].CGImage;
        //        portraitBg.layer.cornerRadius = portraitBg.height/2;
        portraitBg.layer.cornerRadius = w/2.0;
        portraitBg.clipsToBounds = YES;
        [backButton addSubview:portraitBg];
        
        /*
        self.avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        self.avatarButton.backgroundColor = [UIColor greenColor];
        //        self.avatarButton.frame = CGRectInsets(5,5, 5, 5);
        NSInteger space = 3;
        self.avatarButton.frame = ccr(space, space, portraitBg.width-2*space, portraitBg.width-2*space);
        
        self.avatarButton.layer.cornerRadius = _avatarButton.height/2;
        self.avatarButton.clipsToBounds = YES;
        //        self.avatarButton.center = portraitBg.center;
        [portraitBg addSubview:_avatarButton];
        
        */
        NSInteger space = 3;

        self.avatarImage = [[UIImageView alloc] initWithFrame:ccr(space, space, portraitBg.width-2*space, portraitBg.width-2*space)];
        _avatarImage.layer.cornerRadius = _avatarImage.width/2.0;
        _avatarImage.clipsToBounds = YES;
        [portraitBg addSubview:_avatarImage];
        
        float xSpace = 9.0,ySpace = 10.0;
        x = x + w + xSpace;
        y = y + ySpace;
        w = 14;
        h = 14;
        UIImageView *xiaoren = [[UIImageView alloc] initWithFrame:ccr(x, y+5, w, h)];
        xiaoren.image = [UIImage imageNamed:@"xiaoren.png"];
        [backButton addSubview:xiaoren];
//        y = 45;
//        w = 320-x;
//        h = 20;
        
        
//        _levelImageView = [[UIImageView alloc] initWithFrame:ccr(x + 110, y-5, 22, 24)];
//        
//        [backButton addSubview:_levelImageView];
        
        x = x + xiaoren.frame.size.width + 5;
        y = xiaoren.frame.origin.y-5;
        w = (self.width - x)/2+5;
        h = 20;
        _nameLabel = [[UILabel alloc] initWithFrame:ccr(x, y, w, h)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.text = @"---";
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _nameLabel.minimumScaleFactor = 10.0;
        //        [_nameLabel sizeToFit];
        [_nameLabel setAdjustsFontSizeToFitWidth:YES];
        [backButton addSubview:_nameLabel];
        NSLog(@"x-----%f",x);
        
        //添加等级
        _levelView = [[YXBLevelView alloc] initWithFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom+getScreenFitSize(2), getScreenFitSize(200), 0)];
        //    _levelView.stateString = @"00000";
        _levelView.userInteractionEnabled = NO;
        [backButton addSubview:_levelView];

        
        _pingjiLabel = [[UILabel alloc] initWithFrame:ccr(_levelView.left, _levelView.bottom+10, kDeviceWidth - _avatarImage.width, 20)];
        _pingjiLabel.text = @"信用评级: ";
        _pingjiLabel.textColor = [UIColor whiteColor];
        _pingjiLabel.font = [UIFont boldSystemFontOfSize:13];
        [backButton addSubview:_pingjiLabel];
        
        //二维码
        CGFloat ewmWidth = 120;
        UIButton *qrCode = [[UIButton alloc] initWithFrame:ccr(kDeviceWidth - ewmWidth, 0, ewmWidth, ewmWidth)];
        qrCode.tag = ErWeiMaTag;
        qrCode.userInteractionEnabled = NO;
        qrCode.center = CGPointMake(qrCode.center.x, _levelView.center.y);
        [qrCode setImage:[UIImage imageNamed:@"usertc-ewm"] forState:UIControlStateNormal];
//        [qrCode addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [backButton addSubview:qrCode];
        
        UIImageView *nextImage = [[UIImageView alloc] initWithFrame:ccr(kDeviceWidth - 40, qrCode.top, 20, qrCode.height)];
        nextImage.image = [UIImage imageNamed:@"next"];
        nextImage.userInteractionEnabled = NO;
        nextImage.contentMode = UIViewContentModeCenter;
        [backButton addSubview:nextImage];

        
        x = 0, y = backButton.frame.origin.y+backButton.frame.size.height;
        w = kDeviceWidth, h = 120;
        
        UIView *moneyView = [[UIView alloc] initWithFrame:ccr(x, y, w, h)];
        [self addSubview:moneyView];
        //        moneyView.backgroundColor = [UIColor greenColor];
        y = 0;
        w = (kDeviceWidth)/3.0;
//        _zongeButton = [MoneyButton buttonWithType:UIButtonTypeCustom];
        _zongeButton = [[MoneyButton alloc] initWithFrame:ccr(x, y, w, h-62)];
//        _zongeButton.frame = ccr(x, y, 106, h-15);
        _zongeButton.type = MoneyButtonTypeZonge;
        _zongeButton.userInteractionEnabled = NO;
        [_zongeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_zongeButton setMoneyButtonWithMoney:@"" name:@"总额"];
        
        _zongeButton.backgroundColor = rgb(213, 37, 37,0.7);;
        
//       [moneyView addSubview:_zongeButton];
        _xianjinButton = [[MoneyButton alloc] initWithFrame:ccr(x, y, w, h-62)];
        
        _xianjinButton.type = MoneyButtonTypeZongCash;
        [_xianjinButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _xianjinButton.userInteractionEnabled = NO;
        _xianjinButton.backgroundColor = rgb(213, 37, 37,0.7);;
        
        [_xianjinButton setMoneyButtonWithMoney:@"" name:@"现金"];
        [moneyView addSubview:_xianjinButton];

        
        UIImageView *ylineView1 = [[UIImageView alloc] initWithFrame:ccr(x+w, 12, 1, 36)];
        //        ylineView1.backgroundColor = kRGB(215, 215, 215);
        ylineView1.image = [UIImage imageNamed:@"verticalLine.png"];
//        [moneyView addSubview:ylineView1];
        
        
        
       x = x + w + 1;
        _LiCaiButton = [[MoneyButton alloc] initWithFrame:ccr(x, y, w, h-62)];
        _LiCaiButton.type = MoneyButtonTypeLiCai;
        [_LiCaiButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _LiCaiButton.userInteractionEnabled = NO;
        _LiCaiButton.backgroundColor = rgb(213, 37, 37,0.7);;
        
        [_LiCaiButton setMoneyButtonWithMoney:@"" name:@"现金"];
        [moneyView addSubview:_LiCaiButton];
        
        UIImageView *ylineView2 = [[UIImageView alloc] initWithFrame:ccr(x+w, 12, 1, 36)];
        //        ylineView2.backgroundColor = kRGB(215, 215, 215);
        ylineView2.image = [UIImage imageNamed:@"verticalLine.png"];
//        [moneyView addSubview:ylineView2];
        
        x = x + w + 1;
        _hongbaoButton = [[MoneyButton alloc] initWithFrame:ccr(x, y, w, h-62)];

        _hongbaoButton.type = MoneyButtonTypeRedBag;
        [_hongbaoButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _hongbaoButton.userInteractionEnabled = NO;
        _hongbaoButton.backgroundColor = rgb(213, 37, 37,0.7);;

        [_hongbaoButton setMoneyButtonWithMoney:@"" name:@"红包"];
        [moneyView addSubview:_hongbaoButton];
        
        UIImageView *xlineView = [[UIImageView alloc] initWithFrame:ccr(0, 58, kDeviceWidth, 1)];
        //        xlineView.backgroundColor = kRGB(215, 215, 215);
        xlineView.image = [UIImage imageNamed:@"HistorySepLine.png"];
        [moneyView addSubview:xlineView];
        
        //10月28日改版，新添加总额
        
        _nZongeButton = [[MoneyButton alloc] initWithFrame:ccr(x, y, 150, h-45)];
        
        _nZongeButton.type = MoneyButtonTypeNewZongE;
        [_nZongeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _nZongeButton.userInteractionEnabled = NO;
        
        [_nZongeButton setMoneyButtonWithMoney:@"" name:@"账户总额(元)"];
        [moneyView addSubview:_nZongeButton];

        
        //充值  提现
        x = kDeviceWidth - (kDeviceWidth - _nZongeButton.width)/2, y = 59,w = (kDeviceWidth - _nZongeButton.width)/2.0,h = 60;
        _nZongeButton.left = 0;
        _nZongeButton.top = y;
        UIButton *chongzhiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        chongzhiButton.frame = ccr(x, y, w, h);
        chongzhiButton.backgroundColor = [UIColor whiteColor];
        chongzhiButton.tag = ChongZhiTag;
        [chongzhiButton setImage:[UIImage imageNamed:@"charge-but.png"] forState:UIControlStateNormal];
        [chongzhiButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [chongzhiButton setAdjustsImageWhenHighlighted:NO];
        [moneyView addSubview:chongzhiButton];
        
        UIImageView *ylineView3 = [[UIImageView alloc] initWithFrame:ccr(148, 58, 1, 60)];
        ylineView3.image = [UIImage imageNamed:@"verticalLine.png"];
        
        [moneyView addSubview:ylineView3];
        
        UIButton *tixianButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tixianButton.frame = ccr(150, y, w, h);
//        tixianButton.right = chongzhiButton.left - 20;
        tixianButton.tag = TiXianTag;
        [tixianButton setImage:[UIImage imageNamed:@"tixian-but.png"] forState:UIControlStateNormal];
        [tixianButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        tixianButton.backgroundColor = [UIColor clearColor];
        
        [tixianButton setAdjustsImageWhenHighlighted:NO];

        [moneyView addSubview:tixianButton];
        
        UIImageView *xlineView2 = [[UIImageView alloc] initWithFrame:ccr(0, 103+15, kDeviceWidth, 1)];
        //        xlineView2.backgroundColor = kRGB(215, 215, 215);
        xlineView2.image = [UIImage imageNamed:@"HistorySepLine.png"];
        [moneyView addSubview:xlineView2];
        
        
    }
    return self;
}

-(void)setUserInfo:(User *)userInfo
{
    if (_userInfo != userInfo) {
        _userInfo = userInfo;
    }
    
    //    NSLog(@"float money--- %@",_userInfo.defaultAccountRemainMoney);
    
    if (_userInfo != nil) {
        _nameLabel.text = _userInfo.nickname;
        if(_userInfo.creditLevelDesc == nil || [_userInfo.creditLevelDesc isKindOfClass:[NSNull class]])
        {
            _userInfo.creditLevelDesc = @"暂无数据";
        }
        _pingjiLabel.text = [NSString stringWithFormat:@"信用评级: %@",_userInfo.creditLevelDesc];
//        _levelView.stateString = [_userInfo levelFormatWithDesc];

//        [_avatarButton setImageWithURL:[NSURL URLWithString:_userInfo.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
        [_avatarImage sd_setImageWithURL:[NSURL URLWithString:_userInfo.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
        [_zongeButton setMoneyButtonWithMoney:_userInfo.remainMoney name:@"现金余额(元)"];

        //现金
        [_xianjinButton setMoneyButtonWithMoney:_userInfo.freezenMoney name:@"视频冻结资金(元)"];
        [_xianjinButton setMoneyButtonColorWithMoneyColor:[UIColor whiteColor] nameColor:[UIColor whiteColor]];
        [_LiCaiButton setMoneyButtonWithMoney:_userInfo.financefreezenMoney name:@"理财金额(元)"];
        [_LiCaiButton setMoneyButtonColorWithMoneyColor:[UIColor whiteColor] nameColor:[UIColor whiteColor]];
        [_hongbaoButton setMoneyButtonWithMoney:_userInfo.redbag name:@"补贴金额(元)"];
        [_hongbaoButton setMoneyButtonColorWithMoneyColor:[UIColor whiteColor] nameColor:[UIColor whiteColor]];
        [_nZongeButton setMoneyButtonWithMoney:_userInfo.remainMoney name:@"现金金额(元)"];
//        _levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"jibie_%@.png",]];
    }
    
    else
    {
        _nameLabel.text = @"";
    
        [_zongeButton setMoneyButtonWithMoney:@"" name:@"账户总额"];
        [_xianjinButton setMoneyButtonWithMoney:@"" name:@"现金"];
        [_hongbaoButton setMoneyButtonWithMoney:@"" name:@"红包"];
    }
    
    
}

-(void)addMoneyButtonWithButton:(MoneyButton *)button Frame:(CGRect)frame
{
    button = [MoneyButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setMoneyButtonWithMoney:@"" name:@"总额"];
    [self addSubview:button];
    
}

-(void)buttonAction:(MoneyButton *)sender
{
    //充值  提现
    if (sender.tag == ChongZhiTag) {
        if (_delegate && [_delegate respondsToSelector:@selector(chongzhi)])
        {
            [_delegate chongzhi];
        }
        
    }else if (sender.tag == TiXianTag)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(chongzhi)])
        {
            [_delegate tixian];
        }
        
        
    }else if (sender.tag == ErWeiMaTag)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(chongzhi)])
        {
            [_delegate qrCodeAction];
        }
        
        
    }else if (sender.tag == MyYXBHeaderViewToSetting)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(headerToSettings)])
        {
            [_delegate headerToSettings];
        }
        
        
    }else if (sender.tag == MyYXBHeaderViewBackTag)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(headerToSettings)])
        {
            [_delegate leftClicked];
        }
        
        
    }else
    {
        if (sender.type == MoneyButtonTypeZonge ||
            sender.type == MoneyButtonTypeZongCash ||
            sender.type == MoneyButtonTypeRedBag)
        {
            if (_delegate && [_delegate respondsToSelector:@selector(moneySelected)])
            {
                [_delegate moneySelected];
            }
        }

    }

    
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
