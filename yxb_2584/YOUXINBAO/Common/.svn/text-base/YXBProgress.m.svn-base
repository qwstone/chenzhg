//
//  YXBProgress.m
//  YOUXINBAO
//
//  Created by zjp on 15/10/10.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBProgress.h"
#import "YXBTool.h"
@implementation YXBProgress
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.hidden = YES;
        self.userInteractionEnabled = YES;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 50)];
        view.backgroundColor = rgb(0, 0, 0, 0.8);
        //        self.activity.layer.cornerRadius = 5;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = view.bounds;
        maskLayer.path = maskPath.CGPath;
        view.layer.mask = maskLayer;
        view.center = self.center;
        [self addSubview:view];
        
        self.activity = [[UIActivityIndicatorView alloc] initWithFrame:view.bounds];//指定进度轮的大小

//        [self.activity setCenter:CGPointMake(40, 30)];//指定进度轮中心点
//        self.activity.center = view.center;
        [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];//设置进度轮显示类型
        [view addSubview:self.activity];

        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(view.left, view.bottom, view.width, 30)];
        UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:button.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
        maskLayer1.frame = self.activity.bounds;
        maskLayer1.path = maskPath1.CGPath;
        button.layer.mask = maskLayer1;
        [button setTitle:@"返回" forState:UIControlStateNormal];
        button.backgroundColor = rgb(0, 0, 0, 0.5);
        
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}


- (void)buttonAction {
    [self hidden];
    [[YXBTool getCurrentNav] popViewControllerAnimated:YES];
}


- (void)show {
    [self.activity startAnimating];
    self.hidden = NO;
}

- (void)hidden {
    [self.activity stopAnimating];
    self.hidden = YES;
}

@end
