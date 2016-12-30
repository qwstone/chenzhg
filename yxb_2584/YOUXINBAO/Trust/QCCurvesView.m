//
//  QCCurvesView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCCurvesView.h"

@implementation QCCurvesView {
    CGRect _ellipseRect;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _ellipseRect = CGRectMake(-self.height/3, 0, frame.size.width-60, frame.size.height-60);
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBStrokeColor(context, 0.7, 0.7, 0.7, 1.0);
    CGContextAddEllipseInRect(context, CGRectMake(30, 30, rect.size.width-60, rect.size.height-60));
    CGContextStrokePath(context);
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIView *view = [self.subviews objectAtIndex:i];

        CGMutablePathRef path = (CGMutablePathRef)CGPathCreateWithEllipseInRect(_ellipseRect, NULL);
        view.center = CGPointMake(self.width/2, 30);
        CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
        orbit.keyPath = @"position";
        orbit.path = path;
        orbit.duration = 8-i;
        orbit.additive = YES;
        orbit.repeatCount = HUGE_VALF;
        orbit.calculationMode = kCAAnimationPaced;
        //        orbit.rotationMode = /*kCAAnimationRotateAuto*/ nil;
        
        [view.layer addAnimation:orbit forKey:@"ani-track"];

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
