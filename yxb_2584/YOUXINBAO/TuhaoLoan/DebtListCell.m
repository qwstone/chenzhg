//
//  DebtListCell.m
//  YOUXINBAO
//
//  Created by clb on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DebtListCell.h"
#import "UIImageView+WebCache.h"
#import "YXBTool.h"
#import "AttributeStringModel.h"
#import "DebtMoneyView.h"
#define DebtListCellLabelTagStart 2000
#define DebtLabelFontSize 14
#define DebtListCellLeftAlign 10
#define SpaceXBetweenImageAndLabel 10
#define SpaceYBetweenTopAndLabel 15

@interface DebtListCell ()

@property(nonatomic,strong)UIImageView *avatarImageView;//头像
@property(nonatomic,strong)UILabel     *userNameLabel;//用户名
@property(nonatomic,strong)NSMutableArray *elementArray;//model中的元素拼成的数组，用于循环为cell中的label赋值
@property(nonatomic,strong)UILabel      *moneyLabel;//money
@property(nonatomic,strong)DebtMoneyView *moneyView;//前面显示钱的view


//zjp
@property(nonatomic,strong)UIImageView *stateImg;//状态
@end
@implementation DebtListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = DebtListCellLeftAlign;
    frame.size.width = frame.size.width - 2 * DebtListCellLeftAlign;
    [super setFrame:frame];
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


-(void)reSetViewsFrame
{
    
}
-(void)initViews
{
    CGFloat x = 0,y = 0,w = 72,h = DebtCellHeight;
    self.moneyView = [[DebtMoneyView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _moneyView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_moneyView];
    

    x = x + w + SpaceXBetweenImageAndLabel;
    y = SpaceYBetweenTopAndLabel;
    w = (kDeviceWidth - 2*DebtListCellLeftAlign - SpaceXBetweenImageAndLabel - _moneyView.width)/2.0;
    h = 15;
    CGFloat x1 = x;
    CGFloat y1 = y;
    CGFloat w1 = w;
    CGFloat h1 = h;

    CGFloat labelYSpace = 15;
    for (int i = 0; i < 6; i ++) {
        if(i % 2 == 0)
        {
            x1 = x;
        }
        else
        {
            x1 = x + w;
        }
        y1 = y + (h+labelYSpace)*(i/2);
        
        UILabel *label = [self labelWithFrame:CGRectMake(x1, y1, w1, h1)];
//        label.backgroundColor = [YXBTool generateRandomColor];
        label.tag = DebtListCellLabelTagStart + i;
        [self.contentView addSubview:label];
        
        if (i == 3) {
            labelYSpace = 12;
        }
    }
    

    
}
- (void)setClassName:(NSString *)className {
    if (_className != className) {
        _className= className;
        if ([self.className isEqualToString:@"我的"]) {
            self.stateImg = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-110)/2, 20, 110, 50)];
            [self.contentView addSubview:self.stateImg];
        }
    }
}

-(void)setModel:(BlankNoteData *)model
{
    if (_model != model) {
        _model = model;
        
        _moneyView.model = _model;
//        _moneyLabel.text = [NSString stringWithFormat:@"%@",_model.money];
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.imgurl] placeholderImage:[UIImage imageNamed:@"register_photo.png"]];
        if ([self.className isEqualToString:@"我的"]) {
            NSString *yearRatestr = [_model.time substringWithRange:NSMakeRange(0,10)];
            _moneyView.userNameLabel.text = yearRatestr;
            if (_model.state == 150) {
                self.stateImg.image = [UIImage imageNamed:@"borrowallgz"];
            }
            if (_model.state == 200) {
                self.stateImg.image = [UIImage imageNamed:@"canclegaiz"];
            }
        }
        
        self.elementArray = [NSMutableArray arrayWithObjects:
                             [NSString stringWithFormat:@"白条总数:%ld个",(long)_model.borrowNumber],
                             [NSString stringWithFormat:@"已经借出:%ld个",(long)_model.loanNumber],
                             [NSString stringWithFormat:@"还款方式: %@",[_model repaymentStringWithType]],
                             [NSString stringWithFormat:@"周期: %ld个月",(long)_model.repaymentMonth],
                             [NSString stringWithFormat:@"年利率: %@",_model.yearRate],
                             [NSString stringWithFormat:@"利息: %@元",[YXBTool setMoney:self.model.money yearRate:self.model.yearRate repaymentMonth:self.model.repaymentMonth]], nil];
        NSMutableArray *aArray = [self attributeArrayWithSourceStrArray:_elementArray];

        for (int i = 0; i < [_elementArray count]; i ++) {
            NSInteger tag = DebtListCellLabelTagStart + i;
            UILabel *label = (UILabel *)[self viewWithTag:tag];
//            label.text = _elementArray[i];
//            label.width = (self.width - (_moneyView.origin.x+_moneyView.width+SpaceXBetweenImageAndLabel))/2.0;
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_elementArray[i]];
            for (AttributeStringModel *model in aArray[i]) {
                [str addAttribute:model.attributeName value:model.attributeValue range:model.attributeRange];
            }
            label.attributedText = str;
        }

        
    }
}

-(NSMutableArray *)attributeArrayWithSourceStrArray:(NSArray *)sourceStrArray
{
    NSMutableArray *attributeArray = [NSMutableArray array];

    //第一个
    for (int i = 0; i < [sourceStrArray count]; i ++) {
        NSMutableArray *aArray = [NSMutableArray array];
        for (int j = 0; j < 3; j ++) {
            if (i < 2) {
                //[0][0] [0][1]位置的属性 三部分

                if (j == 0) {
                    AttributeStringModel *model1 = [[AttributeStringModel alloc] init];
                    model1.attributeName = NSFontAttributeName;
                    model1.attributeValue = [UIFont boldSystemFontOfSize:16.0];
                    model1.attributeRange = NSMakeRange(0, [sourceStrArray[i] length]);
                    [aArray addObject:model1];
                }
                else if(j == 1)
                {
                    AttributeStringModel *model2 = [[AttributeStringModel alloc] init];
                    model2.attributeName = NSForegroundColorAttributeName;
                    model2.attributeValue = rgb(12, 12, 12, 1.0);
                    model2.attributeRange = NSMakeRange(0, [sourceStrArray[i] length]);
                    [aArray addObject:model2];

                }
                else if(j == 2)
                {
                    AttributeStringModel *model3 = [[AttributeStringModel alloc] init];
                    model3.attributeName = NSForegroundColorAttributeName;
                    model3.attributeValue = rgb(231, 99, 40, 1.0);
                    model3.attributeRange = NSMakeRange(5, [sourceStrArray[i] length] - 5 - 1);
                    [aArray addObject:model3];

                }
                    

                }
            else if (i >= 2)
            {
                AttributeStringModel *model1 = [[AttributeStringModel alloc] init];
                model1.attributeName = NSFontAttributeName;
                model1.attributeValue = [UIFont systemFontOfSize:14.0];
                model1.attributeRange = NSMakeRange(0, [sourceStrArray[i] length]);
                [aArray addObject:model1];

            }
            
            }
        [attributeArray addObject:aArray];

        }
    
    return attributeArray;
}
    
    


-(UILabel *)labelWithFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.minimumScaleFactor = 10.0/label.font.pointSize;
    label.adjustsFontSizeToFitWidth = YES;
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
