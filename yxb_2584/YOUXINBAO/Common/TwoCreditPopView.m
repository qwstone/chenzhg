//
//  TwoCreditPopView.m
//  YOUXINBAO
//
//  Created by zjp on 16/1/6.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TwoCreditPopView.h"
#import "YXBTool.h"
#import "CreditPopViewModel.h"

@implementation TwoCreditPopView {

    UIView *_bgView;
    
    
}
- (void)tapAction {
    [self.window endEditing:YES];
}
//
- (id)initWithcreditData:(NSDictionary *)creditData {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    self = [super initWithFrame:window.bounds];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
        self.backgroundColor = rgb(0, 0, 0, 0.7);
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        _bgView.top -=_bgView.height;
        [self addSubview:_bgView];
        NSInteger type = 0;
        if (creditData[@"type"] != nil) {
            type = [creditData[@"type"] integerValue];
        }
//        type = 1;
        if (type == 1) {
            [self createUiOfUpLV:creditData];
        }else if (type == 2){
            [self createUiOfDownLV:creditData];
        }
    }
    return self;
}


//加分·
- (void)createUiOfUpLV:(NSDictionary *)dic {
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/623*556)];
    bgImgView.userInteractionEnabled = YES;
    bgImgView.image = [UIImage imageNamed:@"zu1img"];
    [_bgView addSubview:bgImgView];
    
    UILabel *fen = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/320*90, kDeviceWidth/320*111,kDeviceWidth/320*160, 45)];
    fen.numberOfLines = 1;
    fen.textAlignment = NSTextAlignmentCenter;
    fen.font = [UIFont fontWithName:@"Helvetica-Bold" size:45];
    fen.text = [NSString stringWithFormat:@"+%@",dic[@"newScore"]];
//    fen.textColor = [YXBTool colorWithHexString:@"#B52323"];
    [bgImgView addSubview:fen];
    NSMutableParagraphStyle *paragraph1 = [[NSMutableParagraphStyle alloc] init];
    paragraph1.alignment = NSTextAlignmentCenter;
    NSDictionary *dict1=@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:45],
                          NSParagraphStyleAttributeName:paragraph1,
                          NSForegroundColorAttributeName:[YXBTool colorWithHexString:@"#B52323"],
                          NSStrokeWidthAttributeName:@-3,
                          NSStrokeColorAttributeName:[UIColor whiteColor]
                          };
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:fen.text attributes:dict1];
    fen.attributedText = str1;
//    [fen setAdjustsFontSizeToFitWidth:YES];
    
    NSString *strs = [NSString stringWithFormat:@"%@\n%@",dic[@"str1"],dic[@"str2"]];
    UILabel *tishi = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/320*100, fen.bottom+5,kDeviceWidth/320*128, 30)];
    tishi.numberOfLines = 0;
    tishi.textAlignment = NSTextAlignmentCenter;
    tishi.font = [UIFont boldSystemFontOfSize:13];
    tishi.text = strs;
    [tishi setAdjustsFontSizeToFitWidth:YES];
    tishi.textColor = [YXBTool colorWithHexString:@"#F15D35"];
    [bgImgView addSubview:tishi];
    
    
    UIView *jview = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/320*78, kDeviceWidth/320*201, kDeviceWidth/320*170, kDeviceWidth/320*13)];
    jview.backgroundColor = [UIColor clearColor];
    jview.layer.borderColor = [YXBTool colorWithHexString:@"#ffae41"].CGColor;
    jview.layer.borderWidth = 1;
    jview.layer.cornerRadius = jview.height/2.0;
    [bgImgView addSubview:jview];
    
    _jLabel = [[UILabel alloc] initWithFrame:ccr(0, 0, 0, jview.height)];
    _jLabel.textAlignment = NSTextAlignmentRight;
    _jLabel.font = [UIFont boldSystemFontOfSize:10];
    _jLabel.backgroundColor = [YXBTool colorWithHexString:@"#ffae41"];
    _jLabel.clipsToBounds = YES;
     [_jLabel setAdjustsFontSizeToFitWidth:YES];
//    _jLabel.text = @"5%";
    _jLabel.layer.cornerRadius = _jLabel.height/2.0;
    _jLabel.textColor = [YXBTool colorWithHexString:@"#F15D35"];
    [jview addSubview:_jLabel];
    
   UILabel* _jLabel1 = [[UILabel alloc] initWithFrame:ccr(0, 0, jview.width, jview.height)];
    _jLabel1.textAlignment = NSTextAlignmentCenter;
    _jLabel1.font = [UIFont boldSystemFontOfSize:10];
    _jLabel1.backgroundColor = [UIColor clearColor];
    _jLabel1.clipsToBounds = YES;
    _jLabel1.layer.cornerRadius = _jLabel1.height/2.0;
    _jLabel1.textColor = [YXBTool colorWithHexString:@"#F15D35"];
    [jview addSubview:_jLabel1];
    CGFloat width = jview.width/100*[dic[@"progress"] integerValue];

    [UIView animateKeyframesWithDuration:0.4 delay:0.3 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
//        if (width < 60) {
//            width = jview.width;
//            _jLabel.backgroundColor = [UIColor clearColor];
//            _jLabel.textAlignment = NSTextAlignmentCenter;
//        }
        _jLabel.width = width;
        
    } completion:^(BOOL finished) {
        NSString *string = [NSString stringWithFormat:@"%@%%  )",dic[@"progress"]];
        CGFloat letgh = [YXBTool getFontSizeWithString:string font:_jLabel.font constrainSize:CGSizeMake(jview.width, jview.height)].width;
        if (width < letgh) {
            _jLabel1.text = [NSString stringWithFormat:@"%@%%",dic[@"progress"]];
        }else {
            NSMutableAttributedString *strLabel = [[NSMutableAttributedString alloc] initWithString:string];
            [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:[string rangeOfString:@")"]];
            _jLabel.attributedText = strLabel;
        }

    }];

    
    UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/320*260, kDeviceWidth/320*35, 25, 25)];
    [close setImage:[UIImage imageNamed:@"closeim"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:close];
    
    UILabel *AAA = [[UILabel alloc] initWithFrame:CGRectMake(0, bgImgView.bottom,kDeviceWidth, 90)];
    AAA.numberOfLines = 0;
    AAA.textAlignment = NSTextAlignmentCenter;
    AAA.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    AAA.text = [NSString stringWithFormat:@"恭喜您!\n您的信用积分提升了%@",dic[@"newScore"]];
    [AAA setAdjustsFontSizeToFitWidth:YES];
    AAA.textColor = [UIColor redColor];
    [_bgView addSubview:AAA];
//    NSString *sss = @"恭喜您!\n您的信用积分提升了5%!";
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *dict=@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:20],
                         NSParagraphStyleAttributeName:paragraph,
                         NSForegroundColorAttributeName:[YXBTool colorWithHexString:@"#F15D35"],
                         NSStrokeWidthAttributeName:@-3,
                         NSStrokeColorAttributeName:[UIColor whiteColor]
                         };
    NSMutableAttributedString *strLabel1 = [[NSMutableAttributedString alloc] initWithString:AAA.text];
    [strLabel1 addAttributes:dict range:NSMakeRange(0, AAA.text.length)];
    [strLabel1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:22] range:[AAA.text rangeOfString:@"恭喜您!"]];
    AAA.attributedText = strLabel1;
    
    
    UIButton *surebut = [[UIButton alloc] initWithFrame:CGRectMake((kDeviceWidth-160)/2, AAA.bottom, 160, 52)];
    [surebut setImage:[UIImage imageNamed:@"gaodiaoxuanyao"] forState:UIControlStateNormal];
    [surebut addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:surebut];

    self.shareUrl = dic[@"share"];
    self.shareStr = dic[@"rank"];
}
//降分
- (void)createUiOfDownLV:(NSDictionary *)dic {
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/623*556)];
    bgImgView.userInteractionEnabled = YES;
    bgImgView.image = [UIImage imageNamed:@"zu6img"];
    [_bgView addSubview:bgImgView];
    
    UILabel *fen = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/320*90, kDeviceWidth/320*111,kDeviceWidth/320*160, 45)];
    fen.numberOfLines = 1;
//    fen.textAlignment = NSTextAlignmentCenter;
    fen.font = [UIFont fontWithName:@"Helvetica-Bold" size:45];
    fen.text = [NSString stringWithFormat:@"-%@",dic[@"newScore"]];
//    [fen setAdjustsFontSizeToFitWidth:YES];
//    fen.textColor = [YXBTool colorWithHexString:@"#10ADD3"];
    [bgImgView addSubview:fen];
    NSMutableParagraphStyle *paragraph1 = [[NSMutableParagraphStyle alloc] init];
    paragraph1.alignment = NSTextAlignmentCenter;
    NSDictionary *dict1=@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:45],
                          NSParagraphStyleAttributeName:paragraph1,
                          NSForegroundColorAttributeName:[YXBTool colorWithHexString:@"#10ADD3"],
                          NSStrokeWidthAttributeName:@-3,
                          NSStrokeColorAttributeName:[UIColor whiteColor]
                          };
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:fen.text attributes:dict1];
    fen.attributedText = str1;
    
    NSString *strs = [NSString stringWithFormat:@"%@\n%@",dic[@"str1"],dic[@"str2"]];
    UILabel *tishi = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/320*100, fen.bottom+5,kDeviceWidth/320*128, 30)];
    tishi.numberOfLines = 0;
    tishi.textAlignment = NSTextAlignmentCenter;
    tishi.font = [UIFont boldSystemFontOfSize:13];
    tishi.text = strs;
    [tishi setAdjustsFontSizeToFitWidth:YES];
    tishi.textColor = [YXBTool colorWithHexString:@"#535353"];
    [bgImgView addSubview:tishi];
    
    UIView *jview = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/320*78, kDeviceWidth/320*201, kDeviceWidth/320*170, kDeviceWidth/320*13)];
    jview.backgroundColor = [UIColor whiteColor];
    jview.layer.borderColor = [YXBTool colorWithHexString:@"#10ADD3"].CGColor;
    jview.layer.borderWidth = 1;
    jview.layer.cornerRadius = jview.height/2.0;
    [bgImgView addSubview:jview];
    
    _jLabel = [[UILabel alloc] initWithFrame:ccr(0, 0, 0, jview.height)];
    _jLabel.textAlignment = NSTextAlignmentRight;
    _jLabel.font = [UIFont boldSystemFontOfSize:10];
    _jLabel.backgroundColor = [YXBTool colorWithHexString:@"#10ADD3"];
    _jLabel.clipsToBounds = YES;
    [_jLabel setAdjustsFontSizeToFitWidth:YES];
//    _jLabel.text = @"5%";
    _jLabel.layer.cornerRadius = _jLabel.height/2.0;
    _jLabel.textColor = [UIColor whiteColor];
    [jview addSubview:_jLabel];
    UILabel* _jLabel1 = [[UILabel alloc] initWithFrame:ccr(0, 0, jview.width, jview.height)];
    _jLabel1.textAlignment = NSTextAlignmentCenter;
    _jLabel1.font = [UIFont boldSystemFontOfSize:10];
    _jLabel1.backgroundColor = [UIColor clearColor];
    _jLabel1.clipsToBounds = YES;
    _jLabel1.layer.cornerRadius = _jLabel1.height/2.0;
    _jLabel1.textColor = [YXBTool colorWithHexString:@"#10ADD3"];
    [jview addSubview:_jLabel1];
    CGFloat width = jview.width/100*[dic[@"progress"] integerValue];
    
    [UIView animateKeyframesWithDuration:0.4 delay:0.3 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        //        if (width < 60) {
        //            width = jview.width;
        //            _jLabel.backgroundColor = [UIColor clearColor];
        //            _jLabel.textAlignment = NSTextAlignmentCenter;
        //        }
        _jLabel.width = width;
        
    } completion:^(BOOL finished) {
        NSString *string = [NSString stringWithFormat:@"%@%%  )",dic[@"progress"]];
        CGFloat letgh = [YXBTool getFontSizeWithString:string font:_jLabel.font constrainSize:CGSizeMake(jview.width, jview.height)].width;
        if (width < letgh) {
            _jLabel1.text = [NSString stringWithFormat:@"%@%%",dic[@"progress"]];
        }else {
            NSMutableAttributedString *strLabel = [[NSMutableAttributedString alloc] initWithString:string];
            [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:[string rangeOfString:@")"]];
            _jLabel.attributedText = strLabel;
        }
        
    }];
    
    UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/320*260, kDeviceWidth/320*35, 25, 25)];
    [close setImage:[UIImage imageNamed:@"closebutimg"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:close];
    
    UILabel *AAA = [[UILabel alloc] initWithFrame:CGRectMake(0, bgImgView.bottom,kDeviceWidth, 90)];
    AAA.numberOfLines = 0;
    AAA.textAlignment = NSTextAlignmentCenter;
    AAA.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    AAA.text = [NSString stringWithFormat:@"很遗憾!\n您的信用积分降低了%@",dic[@"newScore"]];
    [AAA setAdjustsFontSizeToFitWidth:YES];
    AAA.textColor = [UIColor redColor];
    [_bgView addSubview:AAA];
    //    NSString *sss = @"恭喜您!\n您的信用积分提升了5%!";
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *dict=@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:20],
                         NSParagraphStyleAttributeName:paragraph,
                         NSForegroundColorAttributeName:[YXBTool colorWithHexString:@"#10ADD3"],
                         NSStrokeWidthAttributeName:@-3,
                         NSStrokeColorAttributeName:[UIColor whiteColor]
                         };
    NSMutableAttributedString *strLabel1 = [[NSMutableAttributedString alloc] initWithString:AAA.text];
    [strLabel1 addAttributes:dict range:NSMakeRange(0, AAA.text.length)];
    [strLabel1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:22] range:[AAA.text rangeOfString:@"很遗憾!"]];
    AAA.attributedText = strLabel1;
    
    
    UIButton *surebut = [[UIButton alloc] initWithFrame:CGRectMake((kDeviceWidth-160)/2, AAA.bottom, 160, 52)];
    [surebut setImage:[UIImage imageNamed:@"zu5img"] forState:UIControlStateNormal];
    [surebut addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:surebut];
}





- (void)sureAction {
    [self shareView];
}

- (void)shareView {
    AAShareView *share = [[AAShareView alloc] initWithType:AAShareViewTypeFriend];
    share.delegate = self;
    [share setLodgeButtonHidden:YES];
    [share show];
}


#pragma mark -- AAShareViewdelegate
//微信好友
- (void)AAShareViewWeixinSessionButtonDidClicked:(AAShareView *)view {
    [YXBTool shareToWeixinSessionContent:[NSString stringWithFormat:@"我的信用等级已达到%@啦！你敢来挑战吗？",self.shareStr] imgName:nil url:self.shareUrl title:[NSString stringWithFormat:@"人生新高度！我的信用已达到%@级啦！",self.shareStr] callBackBlock:^{
        
    }];
}
//微信朋友圈
- (void)AAShareViewWeixinTimelineContentButtonDidClicked:(AAShareView *)view {
    [YXBTool shareToWeixinTimelineContent:[NSString stringWithFormat:@"我的信用等级已达到%@啦！你敢来挑战吗？",self.shareStr] imgName:nil url:self.shareUrl title:[NSString stringWithFormat:@"人生新高度！我的信用已达到%@级啦！",self.shareStr] callBackBlock:^{
        
    }];
}

- (void)show {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.4 animations:^{
        _bgView.center = self.center;
    } completion:^(BOOL finished) {
        
    }];

}

- (void)remove {
    [UIView animateWithDuration:0.4 animations:^{
        _bgView.top -=_bgView.height;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    [CreditPopViewModel shareInstance].rateChange2 = nil;
}

@end
