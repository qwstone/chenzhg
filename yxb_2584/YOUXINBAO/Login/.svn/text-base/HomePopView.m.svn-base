//
//  HomePopView.m
//  YOUXINBAO
//
//  Created by zjp on 15/7/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HomePopView.h"
#import "YXBTool.h"




//查看万能卷
#define LookNniversalRoll_ADDRESS   @"webView/user/couponList.jsp?t=1"

@implementation HomePopView {
    UIImageView     *_imagebg;
    UIButton        *_closeBut;
    UIButton        *_xianguangguang;
    UIButton        *_Ok;
    UILabel         *_label;
        NSMutableAttributedString *strLabel;
}



- (id)init {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self) {
        self.backgroundColor = rgb(0, 0, 0, 0.6);
        [self createView];
    }
    
    return self;
}


- (void)createView {

    _imagebg = [[UIImageView alloc] initWithFrame:CGRectMake(0, kDeviceHeight/6, kDeviceWidth, kDeviceWidth/320*264)];
    _imagebg.userInteractionEnabled = YES;
    [self addSubview:_imagebg];
    
    _label = [[UILabel alloc ]initWithFrame:CGRectMake(15, kDeviceHeight/1333*340, kDeviceWidth-30, 20)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [YXBTool colorWithHexString:@"#d3111b"];
    _label.font = [UIFont boldSystemFontOfSize:19];
    [_label setAdjustsFontSizeToFitWidth:YES];
    [_imagebg addSubview:_label];
    if (kDeviceHeight == 480) {
        _label.top = kDeviceHeight/1333*390;
    }
    
    
    _xianguangguang = [[UIButton alloc ]initWithFrame:CGRectMake(kDeviceWidth/750*60, _imagebg.bottom+10, kDeviceWidth/750*270, kDeviceWidth/750*84)];
    [_xianguangguang addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_xianguangguang];
    
    _Ok = [[UIButton alloc ]initWithFrame:CGRectMake(kDeviceWidth - (kDeviceWidth/750*330), _imagebg.bottom+10, kDeviceWidth/750*270, kDeviceWidth/750*84)];
    [_Ok addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_Ok];
    
    _closeBut = [[UIButton alloc ]initWithFrame:CGRectMake(kDeviceWidth - 90, 50, 90, 90)];
    _closeBut.tag = 100;
    [_closeBut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_imagebg addSubview:_closeBut];

}

- (void)showMostHonest {
    _imagebg.image = [UIImage imageNamed:@"ts1"];
    [_xianguangguang setBackgroundImage:[UIImage imageNamed:@"see-but"] forState:UIControlStateNormal];
    _xianguangguang.tag = 100;
    
    [_Ok setBackgroundImage:[UIImage imageNamed:@"join-but"] forState:UIControlStateNormal];
    _Ok.tag = 101;
    
   [self show];
}


- (void)showHonestUser:(NSString *)Ranking {
    NSString *string = [NSString stringWithFormat:@"恭喜你成为无忧借条第 %@ 位中国诚信用户",Ranking];
    strLabel = [[NSMutableAttributedString alloc] initWithString:string];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#750404"]
                     range:[string rangeOfString:Ranking]];
    [strLabel addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:21]
                     range:[string rangeOfString:Ranking]];
    _label.attributedText = strLabel;
    _imagebg.image = [UIImage imageNamed:@"ts2"];
    [_xianguangguang setBackgroundImage:[UIImage imageNamed:@"see-but"] forState:UIControlStateNormal];
    _xianguangguang.tag = 100;
    
    
    [_Ok setBackgroundImage:[UIImage imageNamed:@"quan-but"] forState:UIControlStateNormal];
    _Ok.tag = 102;
    
   [self show];
}

- (void)showCongratulations{
    _imagebg.image = [UIImage imageNamed:@"zctsnew2"];
    [_xianguangguang setBackgroundImage:[UIImage imageNamed:@"see-but"] forState:UIControlStateNormal];
    _xianguangguang.tag = 100;
    
    [_Ok setBackgroundImage:[UIImage imageNamed:@"quan2-but"] forState:UIControlStateNormal];
    _Ok.tag = 103;
    
    [self show];
}


- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    _imagebg.transform = CGAffineTransformMakeTranslation(0, -_imagebg.bottom);
    _xianguangguang.transform = CGAffineTransformMakeTranslation(0, _xianguangguang.top);
    _Ok.transform = CGAffineTransformMakeTranslation(0, _Ok.top);
    [UIView animateWithDuration:0.5 animations:^{
        _imagebg.transform = CGAffineTransformIdentity;
        _xianguangguang.transform = CGAffineTransformIdentity;
        _Ok.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)buttonAction:(UIButton *)sender {

   
    if (sender.tag == 100) {
    }

    if (sender.tag == 101) {
        if ([self.delegte respondsToSelector:@selector(ImmediatelyJoin)]) {//立即加入
            [self.delegte ImmediatelyJoin];
        }
    }
    
    if (sender.tag == 102) {
        if ([self.delegte respondsToSelector:@selector(IWantANniversalRoll:)]) {//我要万能卷
            [self.delegte IWantANniversalRoll:[YXBTool getCurrentNav]];
        }else {
        
            AuthenticationViewController *authentic = [[AuthenticationViewController alloc] init];
            [[YXBTool getCurrentNav] pushViewController:authentic animated:YES];
        }
    }
    
    if (sender.tag == 103) {
        //优惠券
        NSString *url = [YXBTool getURL:LookNniversalRoll_ADDRESS params:nil];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"我的优惠券"];
//        if ([self.delegte respondsToSelector:@selector(LookNniversalRoll:)]) {//查看万能卷
//
//            [self.delegte LookNniversalRoll:[YXBTool getURL:LookNniversalRoll_ADDRESS params:nil]];
//        }
    }
    
 
    [self removeFromSuperview];
}

@end
