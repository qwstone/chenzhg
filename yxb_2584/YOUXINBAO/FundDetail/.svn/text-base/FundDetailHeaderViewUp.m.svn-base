//
//  FundDetailHeaderViewUp.m
//  LotteryApp
//
//  Created by Feili on 15/12/15.
//  Copyright © 2015年 windo. All rights reserved.
//

#import "FundDetailHeaderViewUp.h"

@interface FundDetailHeaderViewUp ()

@property(nonatomic,strong)UILabel *LeijishouyiLabel;//累计收益
@property(nonatomic,strong)UILabel *todayLabel;//今日收益
@end

@implementation FundDetailHeaderViewUp

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    
    return self;
}


-(void)initViews
{
    //累计收益title
    CGFloat x = 0,y = 0,w = kDeviceWidth,h = 40;
    UILabel *leijiLabel = [[UILabel alloc] initWithFrame:ccr(x, y, w, h)];
    leijiLabel.text = @"累计收益(元)";
    leijiLabel.textAlignment = NSTextAlignmentCenter;
    leijiLabel.font = [UIFont systemFontOfSize:14.0];
    leijiLabel.textColor = [UIColor whiteColor];
    [self addSubview:leijiLabel];
    
    //累计收益金额
    y = leijiLabel.bottom + 10;
    h = 60;
    self.LeijishouyiLabel = [[UILabel alloc] initWithFrame:ccr(x, y, w, h)];
    _LeijishouyiLabel.text = @"正在计算.";
    _LeijishouyiLabel.font = [UIFont boldSystemFontOfSize:60.0];
    _LeijishouyiLabel.textAlignment = NSTextAlignmentCenter;
    _LeijishouyiLabel.adjustsFontSizeToFitWidth = YES;
    _LeijishouyiLabel.minimumScaleFactor = 10.0/_LeijishouyiLabel.font.pointSize;
    _LeijishouyiLabel.textColor = [UIColor whiteColor];

    [self addSubview:_LeijishouyiLabel];
    
    //今日收益
    y = _LeijishouyiLabel.bottom + 10;
    h = 40;
    self.todayLabel = [[UILabel alloc] initWithFrame:ccr(x, y, w, h)];
    _todayLabel.text = @"正在计算..";
    _todayLabel.font = [UIFont boldSystemFontOfSize:15.0];
    _todayLabel.textAlignment = NSTextAlignmentCenter;
    _todayLabel.adjustsFontSizeToFitWidth = YES;
    _todayLabel.minimumScaleFactor = 10.0/_todayLabel.font.pointSize;
    _todayLabel.textColor = [UIColor whiteColor];
    [self addSubview:_todayLabel];
    
    
}

-(void)setModel:(ProfitUserBuyDetail *)model
{
    if (_model != model) {
        _model = model;
        _LeijishouyiLabel.text = _model.accumulatedMoney;
        _todayLabel.text = [NSString stringWithFormat:@"今日收益%@元",_model.moneyPerDay];
    }
}


@end
