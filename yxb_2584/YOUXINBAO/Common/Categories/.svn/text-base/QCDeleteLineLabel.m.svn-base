//
//  QCDeleteLineLabel.m
//  YOUXINBAO
//
//  Created by zjp on 15/7/10.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCDeleteLineLabel.h"
#import "YXBTool.h"
@implementation QCDeleteLineLabel



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    
    return self;
}

- (void)setText:(NSString *)text {
    if (text.length > 0) {
        self.textAlignment = NSTextAlignmentCenter;
        NSString *oldPrice = text;
        NSUInteger length = [oldPrice length];
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleThick) range:NSMakeRange(0, length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, length)];
        [self setAttributedText:attri];
    }

}
//#pragma mark -- 绘图
//- (void)drawRect:(CGRect)rect {
//    //虚线
//    CGContextRef context =UIGraphicsGetCurrentContext();
//    CGContextBeginPath(context);
//    CGContextSetLineWidth(context, 1.0f);
//    CGContextSetStrokeColorWithColor(context, [YXBTool colorWithHexString:@"#e7e7e7"].CGColor);
//    CGFloat lengths[] = {3,0};
//    CGContextSetLineDash(context, 0, lengths,2);
//    CGContextMoveToPoint(context, 0.0, 0.0);
//    CGContextAddLineToPoint(context, self.bounds.size.width,self.bounds.size.height);
//    CGContextStrokePath(context);
//    CGContextClosePath(context);
//    
//}
@end
