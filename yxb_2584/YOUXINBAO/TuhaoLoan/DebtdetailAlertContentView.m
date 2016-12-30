//
//  DebtdetailAlertContentView.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/5.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DebtdetailAlertContentView.h"
#define DebtDetailAlertLabelFontSize 12.0

@interface DebtdetailAlertContentView ()

@property(nonatomic,strong)UILabel *nameLabel; //用户名
@property(nonatomic,strong)UILabel *repaymentWayLabel; //还款方式
@property(nonatomic,strong)UILabel *repaymentMonthLabel;//月还款额
@property(nonatomic,strong)UILabel *tintLabel;//提示语
@property(nonatomic,strong)UILabel *setTintLabel;//提示语2
@property(nonatomic,strong)NSMutableArray *labelArray;//

@end
@implementation DebtdetailAlertContentView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    
    return self;
}

-(void)initView
{
    const NSInteger arrayCount = 5;
    self.labelArray = [NSMutableArray arrayWithCapacity:arrayCount];
    CGFloat x = 10,y = 20,w = self.width,h = 15;
    
    const NSInteger spaceBetweenLabel = 20;
    for (int i = 0; i < arrayCount; i ++) {
        _labelArray[i] = [self labelWithFrame:CGRectMake(x, y, w, h)];
        if (i == 0) {
            ((UILabel *)_labelArray[i]).font = [UIFont systemFontOfSize:DebtDetailAlertLabelFontSize + 4];
        }
        if (i == arrayCount - 1) {
            ((UILabel *)_labelArray[i]).textColor = rgb(180, 180, 180, 1.0);
        }
        
        [self addSubview:_labelArray[i]];
        y = y + h + spaceBetweenLabel;
    }
    
}

-(void)setModel:(BlankNoteData *)model
{
    _model = model;
    
    NSMutableArray *elementArray = [NSMutableArray arrayWithObjects:
                         [NSString stringWithFormat:@"您正在向\"%@\"借入%@",_model.nickName,_model.money],
                         [NSString stringWithFormat:@"还款方式: %@%ld个月",[_model repaymentStringWithType],(long)_model.repaymentMonth],
                         [NSString stringWithFormat:@"月还款额: %@",_model.moneyPerMonth],
                         [NSString stringWithFormat:@"预计48小时内到账"],
                         [NSString stringWithFormat:@"您已开启自动还款功能，如需关闭请到个人中心设置"],
                          nil];
    for (int i = 0; i < [_labelArray count]; i ++) {
        ((UILabel *)_labelArray[i]).text = elementArray[i];
    }
}


-(UILabel *)labelWithFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [self generateRandomColor];
    label.font = [UIFont systemFontOfSize:DebtDetailAlertLabelFontSize];
    label.minimumScaleFactor = 8.0/label.font.pointSize;
    label.adjustsFontSizeToFitWidth = YES;

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
