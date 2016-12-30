//
//  ActivityStatusView.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/27.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ActivityStatusView.h"
#import "AAImageViewController.h"

@implementation ActivityStatusView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200*3, 80*3)];
//        self.bgView.layer.borderColor = [UIColor redColor].CGColor;
//        self.bgView.layer.borderWidth = 0.2f;
        [self addSubview:self.bgView];
        self.zhuangBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200*3, 80*3)];
        self.zhuangBtn.backgroundColor = [UIColor clearColor];
        [self.zhuangBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.alpha = 0;
//        self.zhuangBtn.layer.borderColor = [UIColor redColor].CGColor;
//        self.zhuangBtn.layer.borderWidth = 1;
//        self.transform = CGAffineTransformMakeRotation(-M_PI_2/10);
        [self.zhuangBtn addTarget:self action:@selector(zhuangBtnActon:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.zhuangBtn];
    }
    return self;
}

- (void)setFrameWithPoint:(CGPoint)pt {
    self.bgView.frame = CGRectMake(0, 0, 200, 80);
    self.center = pt;
    self.zhuangBtn.frame = CGRectMake(0, 0, 200, 80);
    self.zhuangBtn.transform = CGAffineTransformMakeScale(0.95f, 0.9);
    self.alpha = 1;
}

- (void)startAnimationWithPoint:(CGPoint)pt
{
//    self.alpha = 1;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.bgView.frame = CGRectMake(0, 0, 200, 80);
//        self.center = pt;
//        self.zhuangBtn.frame = CGRectMake(0, 0, 200, 80);
//        self.zhuangBtn.transform = CGAffineTransformMakeScale(0.85f, 0.85);
//        self.alpha = 0.5;
//    } completion:^(BOOL finished) {
//        self.zhuangBtn.backgroundColor = [UIColor lightGrayColor];
//        [UIView animateWithDuration:0.1 animations:^{
//            self.zhuangBtn.transform = CGAffineTransformMakeScale(1, 1);
//            self.alpha = 1;
//            self.zhuangBtn.backgroundColor = [UIColor clearColor];
//        } completion:^(BOOL finished) {
//
//        }];
//    }];
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.frame = CGRectMake(0, 0, 200, 80);
        self.center = pt;
        self.zhuangBtn.frame = CGRectMake(0, 0, 200, 80);
        self.zhuangBtn.transform = CGAffineTransformMakeScale(0.95f, 0.9);
        self.alpha = 1;

    }];
}

- (void)zhuangBtnActon:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(activituStatusViewBtn:)]) {
        [self.delegate activituStatusViewBtn:sender];
    }
}
@end
