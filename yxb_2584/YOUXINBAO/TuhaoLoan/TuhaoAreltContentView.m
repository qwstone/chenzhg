//
//  TuhaoAreltContentView.m
//  YOUXINBAO
//
//  Created by zjp on 15/5/5.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TuhaoAreltContentView.h"

@implementation TuhaoAreltContentView {
    NSMutableAttributedString *strLabel;
    NSMutableAttributedString *strLabel1;
    UILabel *_label1;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    
    return self;
}

- (void)setF:(CGFloat)f {
    if (_f != f) {
        _f = f;
    }
    [self createData];
}

- (void)createView {
    NSString *str = @"是否确认做土豪？";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, kDeviceWidth, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    strLabel = [[NSMutableAttributedString alloc] initWithString:str];
    [strLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0,strLabel.length)];
    [strLabel addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:25] range:NSMakeRange(5,2)];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5,2)];
    label.attributedText = strLabel;
    [self addSubview:label];
    

    _label1= [[UILabel alloc] initWithFrame:CGRectMake(35, 60, kDeviceWidth-70, 140)];
    _label1.numberOfLines = 0;
    [self addSubview:_label1];
}


- (void)createData {
    NSString *str1 = [NSString stringWithFormat:@"成为土豪后无忧借条将锁定您的账户资金%.2f元做为白条资金保障，您也可以随时修改取消白条。",self.f];
    strLabel1 = [[NSMutableAttributedString alloc] initWithString:str1];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:20];//调整行间距
    if (kDeviceHeight <= 568) {
        [paragraphStyle setLineSpacing:13];
    }
    [strLabel1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [strLabel1 length])];
    [strLabel1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0,strLabel1.length)];
    [strLabel1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,strLabel1.length)];
    [strLabel1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str1 rangeOfString:@"成为土豪后无忧借条将锁定您的账户资金"]];
    [strLabel1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[str1 rangeOfString:@"元做为白条资金保障，您也可以随时修改取消白条。"]];
    _label1.attributedText = strLabel1;

}
@end
