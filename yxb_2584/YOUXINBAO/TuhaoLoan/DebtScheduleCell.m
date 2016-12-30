//
//  DebtScheduleCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/4/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DebtScheduleCell.h"
#import "YXBTool.h"
#define DebtScheduleCellLabelTagStart 2000
#define DebtLabelFontSize 12.0

@interface DebtScheduleCell ()
@property(nonatomic,strong)NSMutableArray *elementArray;//model中的元素拼成的数组，用于循环为cell中的label赋值
@property(nonatomic,strong)UIImageView *delayImage;//逾期图标

@end
@implementation DebtScheduleCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.elementArray = [NSMutableArray array];
        [self initViews];
        
    }
    
    return self;
}

-(void)initViews
{
    NSInteger leftAlign = 10;
    CGFloat x = leftAlign, y = 0,w = (kDeviceWidth-2*x)/4.0,h = self.height;
    for (int i = 0; i < 4; i ++) {

        UILabel *label = [self labelWithFrame:CGRectMake(x, y, w, h)];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.lineBreakMode = 0;
        label.textColor = [UIColor lightGrayColor];
        label.tag = DebtScheduleCellLabelTagStart + i;
        [self.contentView addSubview:label];
        x = x + w;

    }

    self.delayImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yu-icon2.png"]];
    _delayImage.frame = CGRectMake(55, 3, 14, 15);
    _delayImage.contentMode = UIViewContentModeCenter;
//    _delayImage.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_delayImage];
    _delayImage.hidden = YES;

}


-(void)setModel:(InstallmentDetail *)model
{
    _model = model;
    self.elementArray = [NSMutableArray arrayWithObjects:
                         [NSString stringWithFormat:@"%ld",(long)_model.installmentDetailID],
                         [NSString stringWithFormat:@"%@",_model.dateTime],
                         [self moneyStringWithOverDue],
                         [NSString stringWithFormat:@"%@",[self stateTitleWithState:_model.installmentState]],
                         nil];
    
    for (int i = 0; i < [_elementArray count]; i ++) {
        NSInteger tag = DebtScheduleCellLabelTagStart + i;
        UILabel *label = (UILabel *)[self viewWithTag:tag];
        label.textAlignment = NSTextAlignmentCenter;
        if (_model.installmentState == 0 && i == [_elementArray count] - 1) {
            label.textColor = [YXBTool colorWithHexString:@"#32bef9"];
        }
        else
        {
            label.textColor = [UIColor lightGrayColor];

        }
        
        if (i !=2) {
            label.text = _elementArray[i];
            
        }
        else
        {
            label.attributedText = _elementArray[i];
        }

    }
    
    if (_model.hasAlreadyRepayment == 2) {
        _delayImage.hidden = NO;
    }
    else
    {
        _delayImage.hidden = YES;
    }

}

-(NSMutableAttributedString *)moneyStringWithOverDue
{
    NSString *str = _model.money;
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:str];

    if (_model.moneyOverdue > 0) {
        str = [NSString stringWithFormat:@"%@+%ld",_model.moneyDispaly,(long)_model.moneyOverdue];
        aStr = [[NSMutableAttributedString alloc] initWithString:str];
        [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[str rangeOfString:[NSString stringWithFormat:@"+%ld",(long)_model.moneyOverdue]]];

    }
    
    return aStr;
    
    
    
}

-(NSString *)stateTitleWithState:(NSInteger)installmentState
{
    //还款状态 0去还款， 1审核中， 2还款完成
    NSString *title = @"";
    NSArray *array = [NSArray arrayWithObjects:@"还款中",@"---",@"还款完成", nil];
    if (_isTuhao == 0) {
        array = [NSArray arrayWithObjects:@"去还款",@"---",@"还款完成", nil];
    }
    if (installmentState >= 0 && installmentState <= 2) {
        title = [array objectAtIndex:installmentState];
    }
    
    return title;
}

-(UILabel *)labelWithFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [self generateRandomColor];
    label.font = [UIFont systemFontOfSize:DebtLabelFontSize];
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
