//
//  QRCodeView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/8/4.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#define customPoint CGPointMake(kDeviceWidth/2, kDeviceHeight/2)

#import "QRCodeView.h"

@implementation QRCodeView {
    UIImageView *_codeView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initWithOriginationPoint:customPoint];
    }
    
    return self;
}

- (id)initWithImage:(UIImage *)image withOriginationPoint:(CGPoint)point {
    if (self = [super init]) {
        [self initWithOriginationPoint:point];
        self.image = image;
    }
    
    return self;
}

- (void)setImage:(UIImage *)image {
    _codeView.image = image;
}

- (void)initWithOriginationPoint:(CGPoint)point {
    self.originationPoint = point;
    self.frame = CGRectMake(point.x, point.y, 0, 0);
    self.backgroundColor = [UIColor whiteColor];
    
    _codeView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _codeView.userInteractionEnabled = YES;
    [self addSubview:_codeView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tap];
}
- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    [UIView animateWithDuration:0.35 animations:^{
        self.frame = [UIScreen mainScreen].bounds;
        _codeView.frame = CGRectMake(0, 0, kDeviceWidth-100, kDeviceWidth-100);
        _codeView.center = self.center;
    }];
}
- (void)dismiss {
    if (self.superview) {
        [UIView animateWithDuration:0.35 animations:^{
            self.frame = CGRectMake(self.originationPoint.x, self.originationPoint.y, 0, 0);
            _codeView.frame = CGRectZero;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
