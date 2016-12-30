//
//  DebtScheduleBottomView.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/5.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DebtScheduleBottomView.h"
#import "YXBTool.h"
#define DebtScheduleBottomViewLabelFontSize 12.0

@implementation DebtScheduleBottomView

-(instancetype)initWithFrame:(CGRect)frame cancelBlock:(void(^)())cancelBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        if (cancelBlock) {
            self.cancelBlock = cancelBlock;
        }
    }
    return self;
}

-(void)initView
{
    NSString *yuText = @"《逾期违约说明》";
    CGFloat x = 10,y = 10,w = kDeviceWidth - 2*x, h = 44;
    UILabel *label =  [self labelWithFrame:CGRectMake(x, y, w, h)];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 2;
    label.lineBreakMode = 0;
    [label setAdjustsFontSizeToFitWidth:YES];

    NSString *text = @"逾期未还,每超一天将收取当前期应还金额的3%作为违约金(不足1元将补至1元) 《逾期违约说明》";
    NSMutableAttributedString *aText = [[NSMutableAttributedString alloc] initWithString:text];
    [aText addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"de4642"] range:[text rangeOfString:@"3%"]];
    [aText addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"de4642"] range:NSMakeRange([text length] - 3, 1)];
    [aText addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"de4642"] range:NSMakeRange([text length] - 8, 1)];
    [aText addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:[text rangeOfString:yuText]];
    label.attributedText = aText;

    [self addSubview:label];
    
    UIControl *control = [[UIControl alloc] initWithFrame:label.bounds];
    [control addTarget:self action:@selector(jumpProtocol) forControlEvents:UIControlEventTouchUpInside];
    label.userInteractionEnabled = YES;
    [label addSubview:control];
    
    
    x = 60;
    y = y + h+10;
    w = kDeviceWidth - 2 * x;
    h = 35;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.layer.borderColor = [UIColor orangeColor].CGColor;
    btn.layer.borderWidth = 1.0;
    [btn addTarget:self action:@selector(cancelAll:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(changeBtnColor:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(changeBtnColor:) forControlEvents:UIControlEventTouchDragOutside];

    btn.frame = CGRectMake(x, y, w, h);
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [btn setTitle:@"全部分期还款" forState:UIControlStateNormal];
    [self addSubview:btn];
    
}

-(void)jumpProtocol
{
//    [YXBTool jumpInnerSafaryWithUrl:@"http://60.195.254.33:8083/webView/explain/outTimeExplain.jsp?t=1" hasTopBar:YES titleName:@"逾期违约说明"];
    [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:@"webView/explain/outTimeExplain.jsp?t=1" params:nil] hasTopBar:YES titleName:@"逾期违约说明"];

}

-(void)cancelAll:(UIButton *)btn
{
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;

    if (_cancelBlock) {
        self.cancelBlock();
    }
}

-(void)changeBtnColor:(UIButton *)btn
{
    if(btn.state == UIControlEventTouchDown)
    {
        btn.layer.borderColor = [UIColor orangeColor].CGColor;
    }
    else
    {
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;

    }
}

-(UILabel *)labelWithFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [self generateRandomColor];
    label.font = [UIFont systemFontOfSize:DebtScheduleBottomViewLabelFontSize];
    return label;
}

-(UIColor *)generateRandomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    color = [UIColor clearColor];
    
    return color;
    
}

@end
