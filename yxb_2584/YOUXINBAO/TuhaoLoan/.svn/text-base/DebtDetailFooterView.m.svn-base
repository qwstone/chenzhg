
//
//  DebtDetailFooterView.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DebtDetailFooterView.h"
#import "YXBTool.h"
#import "QCLoginOneViewController.h"
#import "YXBProtocolView.h"
#import "YXBProtocolView.h"
#define DebtDetailFooterViewLeftAlign 15


@interface DebtDetailFooterView ()<YXBProtocolViewtDelegate>
{
    YXBProtocolView *_protocolView;
    UIButton        *bottomBtn;
}
@end

@implementation DebtDetailFooterView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    
    return self;
}

-(void)initViews
{
    CGFloat x = DebtDetailFooterViewLeftAlign,y = DebtDetailFooterViewLeftAlign;
    CGFloat w = self.width - 2 *x, h = 20;
    //同意协议部分    
    _protocolView=[[YXBProtocolView alloc]initWithType:TYPE_TO_TUHAO_LOAN Frame:CGRectMake(x,y,w,h)location:VIEWAlignmentCenter];
    _protocolView.delegate=self;

    [self addSubview:_protocolView];
    //提示label
//    CGFloat x = DebtDetailFooterViewLeftAlign,y = DebtDetailFooterViewLeftAlign;
//    CGFloat w = self.width-2 *x, h = 44;
    y = y + h;
    h = 44;
    NSString *tintText = @"现在借款,48小时内即可提款";
    NSMutableAttributedString *aText = [[NSMutableAttributedString alloc] initWithString:tintText];
    UILabel *tintLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,y,w,h)];
    tintLabel.font = [UIFont systemFontOfSize:13.0];
    tintLabel.textColor = [UIColor lightGrayColor];
    
    [aText setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}
                          range:NSMakeRange(5, 2)];
    tintLabel.attributedText = aText;
    
    [self addSubview:tintLabel];
//    
//    YXBProtocolView *view1=[[YXBProtocolView alloc]initWithType:TYPE_TO_TUHAO_LOAN Frame:CGRectMake(0, tintLabel.top-20,kDeviceWidth, 20)location:VIEWAlignmentCenter];
//    view1.delegate=self;
//    [self addSubview:view1];
    
    y = y + h;
    
    bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.backgroundColor = rgb(52, 142, 250, 1);
    [bottomBtn setImage:[YXBTool imageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
    bottomBtn.frame = CGRectMake(x, y, w, h);
    [bottomBtn setTitle:@"找ta借款" forState:UIControlStateNormal];
    //    [bottomBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    bottomBtn.layer.cornerRadius = 5.0;
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    
    [self addSubview:bottomBtn];

}

-(void)buttonAction:(UIButton *)sender
{

    if (_delegate && [_delegate respondsToSelector:@selector(findToLoan)]) {
        [_delegate findToLoan];
    }
    else
    {
        NSLog(@"%@ 代理设置出错",[self class]);
    }
}

-(void)checkButton:(UIButton *)sender
{
    if (sender.selected) {
        bottomBtn.userInteractionEnabled = YES;
        bottomBtn.backgroundColor = rgb(52, 142, 250, 1);
    }
    else
    {
        bottomBtn.userInteractionEnabled = NO;
        bottomBtn.backgroundColor = [UIColor lightGrayColor];
    }
}


@end
