//
//  DashLine.m
//  DashLine
//
//  Created by Juwencheng on 15/5/17.
//  Copyright (c) 2015年 jackdono. All rights reserved.
//

#import "DashLine.h"

@interface DashLine ()

@property (nonatomic, strong) UIBezierPath *path;

@end


@implementation DashLine

+ (Class)layerClass
{
    return [CAShapeLayer class];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [self configurePath];
    [self configureLayer];
    [self drawDash];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

#pragma mark 
- (void)configurePath
{
    if (!self.path) {
        self.path = [[UIBezierPath alloc]init];
    }
}

- (void)configureLayer
{
    CAShapeLayer *layer = (CAShapeLayer *)[self layer];
    layer.strokeColor = self.dashColor.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = self.frame.size.height;
    

    layer.geometryFlipped = YES;
}

- (void)drawDash
{
    //设置默认的dash间距
    self.dashInset = self.dashInset == 0 ? self.frame.size.height : self.dashInset;
    CGFloat dashWidth = CGRectGetHeight(self.frame);
    dashWidth = 5.0;
    NSInteger dashCount = CGRectGetWidth(self.frame) / (CGRectGetHeight(self.frame) + self.dashInset);
    dashCount = self.width/(dashWidth + 1);
    //两种方法可以实现虚线，一种是使用CAShapeLayer提供的方法，配置dash的一些参数
    //另一种是自己使用UIBezierPath绘制，为了学习UIBezierPath，使用了第二种方法
    /* 第一种方法
    ((CAShapeLayer*)self.layer).lineDashPattern = [NSArray arrayWithObjects:@(dashWidth),@(self.dashInset),nil];
    [self.path moveToPoint:CGPointMake(0, 0.5 * dashWidth)];
    [self.path addLineToPoint:CGPointMake(self.frame.size.width, 0.5 * dashWidth)];
     */
    for (NSInteger i = 0; i <= dashCount; i++) {
        [self.path moveToPoint:CGPointMake(i * (self.dashInset + dashWidth), 0.5 * dashWidth)];
        [self.path addLineToPoint:CGPointMake(i * (self.dashInset + dashWidth) + dashWidth, 0.5 * dashWidth)];
    }
    
    ((CAShapeLayer*)self.layer).path = self.path.CGPath;
    
}

@end
