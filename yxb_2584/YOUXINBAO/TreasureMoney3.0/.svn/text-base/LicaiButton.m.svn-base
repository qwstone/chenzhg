//
//  LicaiButton.m
//  YOUXINBAO
//
//  Created by Walice on 15/12/14.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//
#import "LicaiButton.h"

@implementation LicaiButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _moneyLabel = [[UILabel alloc] initWithFrame:ccr(0, 20, (kDeviceWidth-36)/3, 24)];
        [_moneyLabel setUserInteractionEnabled:NO];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        _moneyLabel.textAlignment=NSTextAlignmentCenter;
        _moneyLabel.textColor = [UIColor redColor];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.adjustsFontSizeToFitWidth = YES;
        _moneyLabel.minimumScaleFactor = 8.0/_moneyLabel.font.pointSize;
        [self addSubview:_moneyLabel];
        self.backgroundColor = [UIColor clearColor];
       
        _nameLabel = [[UILabel alloc] initWithFrame:ccr(0 , _moneyLabel.bottom+10 , (kDeviceWidth-36)/3, 10)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:12.0];
        _nameLabel.text = @"金额";
        
        [_nameLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_nameLabel];

        
        
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
    
    NSString *text = [NSString stringWithFormat:@"%@",_money];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];

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



@end

