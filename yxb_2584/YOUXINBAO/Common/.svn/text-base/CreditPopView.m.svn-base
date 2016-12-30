//
//  CreditPopView.m
//  YOUXINBAO
//
//  Created by zjp on 15/10/28.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CreditPopView.h"
#import "YXBTool.h"
#import "CreditPopViewModel.h"
#import "TwoCreditPopView.h"


@implementation CreditPopView {
    UIImageView *_bgImgView;
}

- (void)tapAction {
    [self.window endEditing:YES];
}

//        type  变化类别  1升级；2降级；3降至最低级别（需要跳转到失信地图的那种）
- (id)initWithcreditData:(NSDictionary *)creditData {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    self = [super initWithFrame:window.bounds];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
        self.backgroundColor = rgb(0, 0, 0, 0.7);
//        self.backgroundColor = [UIColor clearColor];
        NSInteger type = 0;
        if (creditData[@"type"] != nil) {
            type = [creditData[@"type"] integerValue];
        }
//        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
//        effectview.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
//        effectview.alpha = 0.9;
//        effectview.userInteractionEnabled = YES;
//        [self addSubview:effectview];
        if (type == 1) {
            [self createUiOfUpLV:creditData];
        }else if (type == 2){
            [self createUiOfDownLV:creditData];
        }else if (type == 3){
            [self createUiOfDownLowestLV:creditData];
        }
    }
    return self;
}


//升级
- (void)createUiOfUpLV:(NSDictionary *)dic {
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, kDeviceWidth-20, (kDeviceWidth-20)/556*633)];
    _bgImgView.userInteractionEnabled = YES;
    _bgImgView.center = self.center;
    _bgImgView.image = [UIImage imageNamed:@"xydj-bg1"];
    [self addSubview:_bgImgView];
    
    UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(_bgImgView.width/5*4, 0, _bgImgView.width/5, _bgImgView.width/5)];
//    close.backgroundColor = [UIColor redColor];
    [close addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [_bgImgView addSubview:close];
    
    CGFloat higt;
    if (kDeviceWidth == 320) {
        higt = _bgImgView.height/633*325;
    }else {
        higt = _bgImgView.height/633*335;
    }
    UILabel *AAA = [[UILabel alloc] initWithFrame:CGRectMake((_bgImgView.width-_bgImgView.width/556*160)/2, higt, _bgImgView.width/556*160, 45)];
    AAA.textAlignment = NSTextAlignmentCenter;
    AAA.font = [UIFont boldSystemFontOfSize:40];
    AAA.text = dic[@"newRate"];
//    AAA.backgroundColor = [UIColor brownColor];
    [AAA setAdjustsFontSizeToFitWidth:YES];
    AAA.textColor = [UIColor redColor];
    [_bgImgView addSubview:AAA];
    
    UILabel *midtext = [[UILabel alloc] initWithFrame:CGRectMake((_bgImgView.width-_bgImgView.width/556*330)/2, AAA.bottom-5, _bgImgView.width/556*330, 80)];
    midtext.lineBreakMode = NSLineBreakByWordWrapping;
//    midtext.backgroundColor = [UIColor redColor];
    midtext.numberOfLines = 3;
    midtext.textColor = [UIColor lightGrayColor];
    midtext.textAlignment = NSTextAlignmentCenter;
    if (kDeviceWidth == 320) {
        midtext.font = [UIFont systemFontOfSize:12];
    }else {
        midtext.font = [UIFont systemFontOfSize:14];
    }
    [midtext setAdjustsFontSizeToFitWidth:YES];
    [_bgImgView addSubview:midtext];
    NSString *str1 = @"";
    NSString *str2 = @"";
    NSString *str3 = @"";
    if (dic[@"str1"] != nil) {
        str1 = dic[@"str1"];
    }
    if (dic[@"str2"] != nil) {
        str2 = dic[@"str2"];
    }
    if (dic[@"str3"] != nil) {
        str3 = dic[@"str3"];
    }
    NSString *string = [NSString stringWithFormat:@"%@%@%@",str1,str2,str3];
    NSMutableAttributedString *strLabel = [[NSMutableAttributedString alloc] initWithString:string];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[string rangeOfString:str2]];
    [strLabel addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:17] range:[string rangeOfString:str2]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [paragraphStyle setLineSpacing:6];
    [strLabel addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    midtext.attributedText = strLabel;
    
    UIImageView *img =[[UIImageView alloc] initWithFrame:CGRectMake(-10, _bgImgView.height-(kDeviceWidth-20)/556*154, (kDeviceWidth-20)/556*505, (kDeviceWidth-20)/556*170)];
    img.image = [UIImage imageNamed:@"xydj-but1"];
    img.userInteractionEnabled = YES;
//     img.backgroundColor = [UIColor redColor];
    [_bgImgView addSubview:img];
    
    
    self.shareStr = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];;
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    self.shareUrl = [NSString stringWithFormat:@"%@wap/creditmaps/share.jsp?type=asc&name=%@&rate=%@&percent=%@&userID=%ld",YXB_IP_address_share,userModel.user.nickname,dic[@"newRate"],dic[@"str2"],(long)userModel.user.t_id];
    UIButton *sure = [[UIButton alloc] initWithFrame:CGRectMake(0, img.height/10*3, img.width/10*8, img.height/10*6)];
    sure.right = img.right+10;
//    sure.backgroundColor = [UIColor greenColor];
    [sure addTarget:self action:@selector(shareView) forControlEvents:UIControlEventTouchUpInside];
    [img addSubview:sure];
}
//普通降级
- (void)createUiOfDownLV:(NSDictionary *)dic {
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, kDeviceWidth-20, (kDeviceWidth-20)/556*633)];
    _bgImgView.userInteractionEnabled = YES;
    _bgImgView.center = self.center;
    _bgImgView.image = [UIImage imageNamed:@"xyddj13"];
    [self addSubview:_bgImgView];
    
    UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(_bgImgView.width/5*4, 0, _bgImgView.width/5, _bgImgView.width/5)];
    //    close.backgroundColor = [UIColor redColor];
    [close addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [_bgImgView addSubview:close];
    
    CGFloat higt;
    if (kDeviceWidth == 320) {
        higt = _bgImgView.height/633*325;
    }else {
        higt = _bgImgView.height/633*335;
    }
    UILabel *AAA = [[UILabel alloc] initWithFrame:CGRectMake((_bgImgView.width-_bgImgView.width/556*160)/2, higt, _bgImgView.width/556*160, 45)];
    AAA.textAlignment = NSTextAlignmentCenter;
    AAA.font = [UIFont boldSystemFontOfSize:40];
    AAA.text = dic[@"newRate"];
    [AAA setAdjustsFontSizeToFitWidth:YES];
    AAA.textColor = [UIColor grayColor];
    [_bgImgView addSubview:AAA];
    
    NSString *str1 = @"";
    NSString *str2 = @"";
    NSString *str3 = @"";
    if (dic[@"str1"] != nil) {
        str1 = dic[@"str1"];
    }
    if (dic[@"str2"] != nil) {
        str2 = dic[@"str2"];
    }
    if (dic[@"str3"] != nil) {
        str3 = dic[@"str3"];
    }
    NSString *string = [NSString stringWithFormat:@"%@%@%@",str1,str2,str3];
    UILabel *midtext = [[UILabel alloc] initWithFrame:CGRectMake((_bgImgView.width-_bgImgView.width/556*300)/2, AAA.bottom, _bgImgView.width/556*300, 80)];
    midtext.lineBreakMode = NSLineBreakByWordWrapping;
    midtext.numberOfLines = 2;
    midtext.textColor = [UIColor redColor];
    midtext.textAlignment = NSTextAlignmentCenter;
    if (kDeviceWidth == 320) {
        midtext.font = [UIFont systemFontOfSize:14];
    }else {
        midtext.font = [UIFont systemFontOfSize:16];
    }
    [midtext setAdjustsFontSizeToFitWidth:YES];
    [_bgImgView addSubview:midtext];

    NSMutableAttributedString *strLabel = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [paragraphStyle setLineSpacing:8];
    [strLabel addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    midtext.attributedText = strLabel;
    
    
    UIImageView *img =[[UIImageView alloc] initWithFrame:CGRectMake(-10, _bgImgView.height-(kDeviceWidth-20)/556*154, (kDeviceWidth-20)/556*505, (kDeviceWidth-20)/556*170)];
    img.image = [UIImage imageNamed:@"xydj-but4"];
    img.userInteractionEnabled = YES;
//    img.backgroundColor = [UIColor redColor];
    [_bgImgView addSubview:img];
    
    UIButton *sure = [[UIButton alloc] initWithFrame:CGRectMake(0, img.height/10*3, img.width/10*8, img.height/10*6)];
    sure.right = img.right+10;
//    sure.backgroundColor = [UIColor greenColor];
    [sure addTarget:self action:@selector(creditHome) forControlEvents:UIControlEventTouchUpInside];
    [img addSubview:sure];
}
//降至最低级别
- (void)createUiOfDownLowestLV:(NSDictionary *)dic {
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, kDeviceWidth-20, (kDeviceWidth-20)/500*551)];
    _bgImgView.userInteractionEnabled = YES;
    _bgImgView.center = self.center;
    _bgImgView.image = [UIImage imageNamed:@"xydj-bg3"];
    [self addSubview:_bgImgView];
    
    UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(_bgImgView.width/5*4, 0, _bgImgView.width/5, _bgImgView.width/5)];
    //    close.backgroundColor = [UIColor redColor];
    [close addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [_bgImgView addSubview:close];
    
    UILabel *AAA = [[UILabel alloc] initWithFrame:CGRectMake((_bgImgView.width-_bgImgView.width/556*160)/2, (_bgImgView.height/633*292), _bgImgView.width/556*160, 45)];
    AAA.textAlignment = NSTextAlignmentCenter;
    AAA.font = [UIFont boldSystemFontOfSize:40];
    AAA.text = dic[@"newRate"];
    [AAA setAdjustsFontSizeToFitWidth:YES];
    AAA.textColor = [UIColor blackColor];
    [_bgImgView addSubview:AAA];
    
    NSString *str1 = @"";
    NSString *str2 = @"";
    NSString *str3 = @"";
    if (dic[@"str1"] != nil) {
        str1 = dic[@"str1"];
    }
    if (dic[@"str2"] != nil) {
        str2 = dic[@"str2"];
    }
    if (dic[@"str3"] != nil) {
        str3 = dic[@"str3"];
    }
    NSString *string = [NSString stringWithFormat:@"%@%@%@",str1,str2,str3];
    UILabel *midtext = [[UILabel alloc] initWithFrame:CGRectMake((_bgImgView.width-280)/2, AAA.bottom, 280, 80)];
//    midtext.backgroundColor = [UIColor grayColor];
    midtext.lineBreakMode = NSLineBreakByWordWrapping;
    midtext.numberOfLines = 2;
    midtext.textColor = [UIColor redColor];
    midtext.textAlignment = NSTextAlignmentCenter;
    midtext.font = [UIFont systemFontOfSize:16];
    [midtext setAdjustsFontSizeToFitWidth:YES];
    [_bgImgView addSubview:midtext];
    
    NSMutableAttributedString *strLabel = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [paragraphStyle setLineSpacing:8];
    [strLabel addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    midtext.attributedText = strLabel;
    
    
    UIButton *sure = [[UIButton alloc] initWithFrame:CGRectMake(_bgImgView.width/750*30, _bgImgView.height-_bgImgView.width/750*140, _bgImgView.width/750*660, _bgImgView.width/750*107)];
    [sure setBackgroundImage:[UIImage imageNamed:@"xydj-but3"] forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(creditHome) forControlEvents:UIControlEventTouchUpInside];
    [_bgImgView addSubview:sure];
}

//低等级 跳转到信用大厅
- (void)creditHome {
    NSString *creditUrl = @"webView/explain/centerLevelExplain.jsp";
    [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:creditUrl params:nil] hasTopBar:YES titleName:@"升级攻略"];
    [self remove];
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
    [YXBTool shareToWeixinSessionContent:self.shareStr imgName:nil url:self.shareUrl title:@"人生新高度!我的信用升级啦!" callBackBlock:^{
        
    }];
    [self remove];
}
//微信朋友圈
- (void)AAShareViewWeixinTimelineContentButtonDidClicked:(AAShareView *)view {
    [YXBTool shareToWeixinTimelineContent:self.shareStr imgName:nil url:self.shareUrl title:@"人生新高度!我的信用升级啦!" callBackBlock:^{
        
    }];
    [self remove];
}

//分享
- (void)shareAction {

}


- (void)show {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    _bgImgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.5 animations:^{
        _bgImgView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)remove {
    [self removeFromSuperview];
    [CreditPopViewModel shareInstance].rateChange = nil;
    if ([CreditPopViewModel shareInstance].rateChange2 != nil) {
        TwoCreditPopView *crrs = [[TwoCreditPopView alloc] initWithcreditData:[CreditPopViewModel shareInstance].rateChange2];
        [crrs show];
    }
}
@end
