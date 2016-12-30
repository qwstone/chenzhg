//
//  ISendViewBg.m
//  YOUXINBAO
//
//  Created by zjp on 15/4/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ISendViewBg.h"

@implementation ISendViewBg

#pragma mark -- 绘图
- (void)drawRect:(CGRect)rect {
    //虚线
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 0.6f);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGFloat lengths[] = {3,2};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 10.0, 70.0);
    CGContextAddLineToPoint(context, kDeviceWidth-10,70.0);
    CGContextStrokePath(context);
    CGContextClosePath(context);
    
}
@end
