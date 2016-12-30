//
//  MoneyButton.m
//  LotteryApp
//
//  Created by 程立彬 on 14-4-30.
//  Copyright (c) 2014年 windo. All rights reserved.
//

#import "MoneyButton.h"

@implementation MoneyButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        float x = 0, y = 10, w = self.width,h = 20;
        _nameLabel = [[UILabel alloc] initWithFrame:ccr(x, y, w, h)];
        _nameLabel.backgroundColor = [UIColor clearColor];
//        _nameLabel.textColor = kRGB(82, 82, 82);
        _nameLabel.font = [UIFont systemFontOfSize:12.0];
        _nameLabel.text = @"总额";
        
        [_nameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_nameLabel];

        
        x = 0, y = y+h, w = self.width,h = 20;
        _moneyLabel = [[UILabel alloc] initWithFrame:ccr(x, y, w, h)];
        [_moneyLabel setUserInteractionEnabled:NO];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        _moneyLabel.text = @"元";
//        _moneyLabel.textColor = kRGB(0, 83, 250);
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.adjustsFontSizeToFitWidth = YES;
        _moneyLabel.minimumScaleFactor = 8.0/_moneyLabel.font.pointSize;
        //        [_moneyLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_moneyLabel];

        
        
        x = 90,y =25, w = 13,h= 12;
        _nextButton = [[UIButton alloc] initWithFrame:ccr(x, y, w, h)];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"next_highlight.png"] forState:UIControlStateHighlighted];
//        [self addSubview:_nextButton];
        

        [self setBackgroundImage:[[self class] imageWithColor:kRGB(217, 217, 217)] forState:UIControlStateHighlighted];


    }
    return self;
}

-(void)setMoney:(NSString *)money
{
    _money  = money;
    if (_money == nil) {
        _money = @"--";
    }
    
    if(_type == MoneyButtonTypeNewZongE)
    {
        _moneyLabel.textColor = kRGB(213, 37, 37);

    }
    else
    {
        _moneyLabel.textColor = [UIColor whiteColor];

    }
//    [NSString stringWithFormat:@"<font size=16 color='#BB0000'>%@</font><font size=16 color='#555555'>元</font>", [_model.schemeModel getPrizeText]]
//    _moneyLabel.text = [NSString stringWithFormat:@"￥ %.2f ",_money];
//    NSLog(@"money,  %.2f@",_money);
    NSString *text = [NSString stringWithFormat:@"%@",_money];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange([text length] - 1, 1)];
//    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange([text length] - 1, 1)];
    _moneyLabel.attributedText = str;
    
}

-(void)setName:(NSString *)name
{
    if (_name != name) {
        _name = name;
        _nameLabel.text = [NSString stringWithFormat:@"%@",_name];
    }
}


-(void)setMoneyButtonWithMoney:(NSString *)money name:(NSString *)name
{
    self.money = money;
    self.name = name;
}
-(void)setMoneyButtonColorWithMoneyColor:(UIColor*)moneyColor nameColor:(UIColor*)nameColor{
    _moneyLabel.textColor = moneyColor;
    _nameLabel.textColor = nameColor;
}
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


//-(void)layoutSubviews
//{
//    _moneyLabel.text = @"hhh";
//    _nameLabel.text = @"aaaaa";
//    [super layoutSubviews];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
