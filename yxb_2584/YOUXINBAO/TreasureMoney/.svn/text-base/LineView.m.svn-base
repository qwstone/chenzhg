//
//  LineView.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LineView.h"
#import "YXBTool.h"
@implementation LineView

#pragma mark -- 绘图
- (void)drawRect:(CGRect)rect {
    //虚线
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, [YXBTool colorWithHexString:@"#e7e7e7"].CGColor);
    CGFloat lengths[] = {3,3};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, kDeviceWidth,0.0);
    CGContextStrokePath(context);
    CGContextClosePath(context);
    
}
@end
