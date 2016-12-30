//
//  InstallmentButton.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/5/4.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "InstallmentButton.h"

@implementation InstallmentButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _nperLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 14, 10)];
        _nperLabel.textColor = [UIColor whiteColor];
        _nperLabel.textAlignment = NSTextAlignmentCenter;
        _nperLabel.font = [UIFont systemFontOfSize:12];
//        _nperLabel.text = [NSString stringWithFormat:@"%ld",i+1];
        [self addSubview:_nperLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 4, 60, 10)];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.text = @"15-04-15";
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        _timeLabel.minimumScaleFactor = 8.0/_timeLabel.font.pointSize;
        [self addSubview:_timeLabel];
        
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 22, 70, 20)];
        _moneyLabel.textColor = [UIColor redColor];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.font = [UIFont systemFontOfSize:15];
        _moneyLabel.text =@"1222";
        [self addSubview:_moneyLabel];
        
        
        UIImage *image = [UIImage imageNamed:@"yuqi-icon.png"];
        _yuqiView = [[UIImageView alloc] initWithImage:image];
        
        CGFloat x = self.width - image.size.width;
        _yuqiView.frame = CGRectMake(x, 0, image.size.width, image.size.height);
        _yuqiView.hidden = YES;
        [self addSubview:_yuqiView];
        

    }
    
    return self;
}

-(void)showYuqiImage:(BOOL)isShow
{
    _yuqiView.hidden = !isShow;

    if(isShow)
    {
        _timeLabel.font = [UIFont systemFontOfSize:8];

    }
    else
    {
        _timeLabel.font = [UIFont systemFontOfSize:10];

    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger money = [_moneyLabel.text integerValue];
    NSString *moneyStr = [NSString stringWithFormat:@"%ld",(long)money];
    _moneyLabel.text = moneyStr;
}


@end
