//
//  HomeCtrBotView.m
//  YOUXINBAO
//
//  Created by zjp on 16/2/17.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HomeCtrBotView.h"
#import "YXBTool.h"
#import "BaoHongLiViewController.h"
#import "QCLoginOneViewController.h"
#import "QCHomeDataManager.h"
@implementation HomeCtrBotView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)createView {
    CGFloat linw = kDeviceWidth/640*4;
    UIView * linnn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, linw+kDeviceWidth/750*2  , kDeviceWidth/750*72)];
    linnn.backgroundColor = [YXBTool colorWithHexString:@"#e84a44"];
    linnn.layer.cornerRadius = kDeviceWidth/640*2;
//    [self addSubview:linnn];
    
    //上半部分
    UIView * upView = [[UIView alloc] initWithFrame:CGRectMake(linw, 0, kDeviceWidth-linw, kDeviceWidth/750*72)];
    upView.backgroundColor = [UIColor whiteColor];
    [self addSubview:upView];
    
    UIImageView *img = [[UIImageView alloc ]initWithFrame:CGRectMake(kDeviceWidth/750*25, kDeviceWidth/750*20, kDeviceWidth/750*165, kDeviceWidth/750*42)];
    img.image = [UIImage imageNamed:@"baohonglizi"];
    [upView addSubview:img];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/750*35 + kDeviceWidth/750*149 + kDeviceWidth/750*15 , kDeviceWidth/750*36, kDeviceWidth/750*507, 1)];
    line.backgroundColor = [YXBTool colorWithHexString:@"#FDE9F0"];
    [upView addSubview:line];
    
    UIButton *one = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/750*46,kDeviceWidth/750*80, kDeviceWidth/750*192, kDeviceWidth/750*119)];
    [one setBackgroundImage:[UIImage imageNamed:@"nianhuahonglihb"] forState:UIControlStateNormal];
    [self addSubview:one];
    _nhhongli = [[UILabel alloc] initWithFrame:CGRectMake(one.width/298*1, one.height/258*90, one.width/298*238, one.width/298*61)];
    _nhhongli.textColor = [UIColor whiteColor];
    _nhhongli.textAlignment = NSTextAlignmentCenter;
    [_nhhongli setAdjustsFontSizeToFitWidth:YES];
    _nhhongli.font = [UIFont boldSystemFontOfSize:one.width/298*60];
    //    _nhhongli.text = @"%10";
    [one addSubview:_nhhongli];
    UILabel*oneLab=[[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*46, one.bottom+3,kDeviceWidth/750*192, kDeviceWidth/750*25)];
    oneLab.textColor = rgb(229, 28, 56, 1);
    oneLab.text = @"率";
    oneLab.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*25];
    oneLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:oneLab];

    
    UIButton *two = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/750*45+one.right,kDeviceWidth/750*80, kDeviceWidth/750*192, kDeviceWidth/750*119)];
    [two setBackgroundImage:[UIImage imageNamed:@"wanfenhonglihb"] forState:UIControlStateNormal];
    [self addSubview:two];
    _wfhongli = [[UILabel alloc] initWithFrame:CGRectMake(one.width/298*1, one.height/258*90, one.width/298*238, one.width/298*61)];
    _wfhongli.textColor = [UIColor whiteColor];
    _wfhongli.textAlignment = NSTextAlignmentCenter;
    [_wfhongli setAdjustsFontSizeToFitWidth:YES];
    _wfhongli.font = [UIFont boldSystemFontOfSize:one.width/298*60];
    //    _wfhongli.text = @"%10";
    [two addSubview:_wfhongli];
    
    UILabel*twoLab=[[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/750*42+one.right,one.bottom+3, kDeviceWidth/750*192, kDeviceWidth/750*25)];
    twoLab.textColor = rgb(229, 28, 56, 1);
    twoLab.text = @"红包/日";
    twoLab.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*25];
    twoLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:twoLab];
    
    UIButton *three = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/750*45+two.right,kDeviceWidth/750*60, kDeviceWidth/750*157, kDeviceWidth/750*164)];
    [three setBackgroundImage:[UIImage imageNamed:@"zuorihonglihb111"] forState:UIControlStateNormal];
    three.tag = 3;
    [three addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:three];
    
    _zrhongli = [[UILabel alloc] initWithFrame:CGRectMake(three.width/298*28, three.height/258*131, three.width/298*238, three.width/298*61)];
    _zrhongli.textColor = [UIColor whiteColor];
    _zrhongli.textAlignment = NSTextAlignmentCenter;
    [_zrhongli setAdjustsFontSizeToFitWidth:YES];
    _zrhongli.font = [UIFont boldSystemFontOfSize:three.width/298*61];
    //    _zrhongli.backgroundColor = [UIColor blackColor];
    _zrhongli.text = [QCHomeDataManager sharedInstance].zuorishouyi;
    [three addSubview:_zrhongli];
    
//    UIView * downlinw = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceWidth/750*264, kDeviceWidth  , kDeviceWidth/750*7)];
//    downlinw.backgroundColor = [UIColor redColor];
//    [self addSubview:downlinw];

    
    UIButton *big = [[UIButton alloc] initWithFrame:self.bounds];
    big.tag = 1000;
    [big addTarget:self action:@selector(butAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:big];
}


- (void)setStr:(NSString *)str {
    
    if (str == nil || [str isEqualToString:@""]) {
        _zrhongli.text = @"—   —";
    }else {
        _zrhongli.text = str;
    }
}

- (void)setStr1:(NSString *)str1 {
    _nhhongli.text = str1;
}

- (void)setStr2:(NSString *)str2 {
    _wfhongli.text = str2;
}
- (void)butAction:(UIButton *)button {
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.isLogin == YES) {
    }else {
        [self toLogin];
        return;
    }
    if (button.tag == 1000) {
        
        BaoHongLiViewController * loanViewControllers = [[BaoHongLiViewController alloc]init];
        loanViewControllers.hidesBottomBarWhenPushed = YES;
        [[YXBTool getCurrentNav] pushViewController:loanViewControllers animated:YES];
    }
}

//跳出登陆页面
- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    //    loginNav.navigationBar.barTintColor = rgb(231, 27, 27, 1);
    //    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    loginView.modalPresentationStyle = UIModalPresentationPopover;
    [[YXBTool getCurrentNav] presentViewController:loginNav animated:YES completion:nil ];
}
@end
