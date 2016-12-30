//
//  GeRenZhongXinNavView.m
//  YOUXINBAO
//
//  Created by Feili on 15/10/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "GeRenZhongXinNavView.h"

@implementation GeRenZhongXinNavView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews
{
    //添加返回按钮
//    UIButton *navBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [navBackBtn setImage:[UIImage imageNamed:@"navigation_abck_"] forState:UIControlStateNormal];
//    navBackBtn.frame = ccr(0, 18, 62, 50);
//    //        navBackBtn.backgroundColor = [UIColor greenColor];
//    [navBackBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self addSubview:navBackBtn];
    
    UILabel *title = [[UILabel alloc] initWithFrame:ccr(0, 20, self.width, 44)];
    title.text = @"个人中心";
    title.font = [UIFont boldSystemFontOfSize:21.0];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [self addSubview:title];

}

-(void)buttonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(leftClicked)]) {
        [_delegate leftClicked];
    }
}

@end
