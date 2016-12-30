//
//  FundDetailHeaderViewDown.m
//  LotteryApp
//
//  Created by Feili on 15/12/15.
//  Copyright © 2015年 windo. All rights reserved.
//

#import "YXBTool.h"
#import "FundDetailHeaderViewDown.h"

@interface FundDetailHeaderViewDown ()
{
    UILabel * diseLabel;
}
@property (nonatomic,strong)UILabel *profitTodayLabel;//今日收益
@property (nonatomic,strong)UILabel *profitAllLabel;//已收益
//@property (nonatomic,strong)UIButton *profitAllBtn;//已收益
@property (nonatomic,strong)UILabel *leftLabel;//左侧 钱 日期
@property (nonatomic,strong)UILabel *rightLabel;//右侧 钱 日期
@property (nonatomic,strong)UILabel *jLabel;//动画进度

@end

@implementation FundDetailHeaderViewDown

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
#define LEftAlign 15
    CGFloat x = LEftAlign,y = 0,w = kDeviceWidth - 2*x,h = 42;
    UILabel *leijiLabel = [[UILabel alloc] initWithFrame:ccr(x, y, w, h)];
    leijiLabel.text = @"收益进度";
    leijiLabel.textAlignment = NSTextAlignmentLeft;
    leijiLabel.font = [UIFont systemFontOfSize:18];
    leijiLabel.textColor = [YXBTool colorWithHexString:@"#333333"];
    [self addSubview:leijiLabel];
    
    //累计收益金额
    y = leijiLabel.bottom + 5;
    h = 18;
    w = (w-10)/2.0;
    self.profitTodayLabel = [[UILabel alloc] initWithFrame:ccr(x, y, w, h)];
    _profitTodayLabel.text = @"正在计算.";
    _profitTodayLabel.font = [UIFont systemFontOfSize:18];
    _profitTodayLabel.textAlignment = NSTextAlignmentRight;
    _profitTodayLabel.adjustsFontSizeToFitWidth = YES;
    _profitTodayLabel.minimumScaleFactor = 10.0/_profitTodayLabel.font.pointSize;
    _profitTodayLabel.textColor = [YXBTool colorWithHexString:@"#333333"];

    [self addSubview:_profitTodayLabel];
    
    
    //已收益
    x = _profitTodayLabel.right + 10;
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:ccr(x, y, w, h)];
    bgView.image = [UIImage imageNamed:@"shoyi.png"];
    [self addSubview:bgView];
    
    self.profitAllLabel = [[UILabel alloc] initWithFrame:ccr(0, 0, w, h)];
    _profitAllLabel.text = @"正在计算..";
//    _profitAllLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shoyi.png"]];
    _profitAllLabel.layer.contents = (id)[UIImage imageNamed:@"shoyi.png"].CGImage;
    _profitAllLabel.contentMode = UIViewContentModeCenter;
//    _profitAllLabel.layer.cornerRadius = 5.0;
    _profitAllLabel.clipsToBounds = YES;
    _profitAllLabel.font = [UIFont boldSystemFontOfSize:12.0];
    _profitAllLabel.textAlignment = NSTextAlignmentLeft;
    _profitAllLabel.adjustsFontSizeToFitWidth = YES;
    _profitAllLabel.minimumScaleFactor = 10.0/_profitAllLabel.font.pointSize;
    _profitAllLabel.textColor = [UIColor whiteColor];
    [bgView addSubview:_profitAllLabel];
    
    //进度底色
    x = LEftAlign,y = bgView.bottom + 12,h = 23,w= kDeviceWidth- 2 * x;
    diseLabel = [[UILabel alloc] initWithFrame:ccr(x, y, w, h)];
    diseLabel.textAlignment = NSTextAlignmentLeft;
    diseLabel.font = [UIFont systemFontOfSize:20];
    diseLabel.backgroundColor = [YXBTool colorWithHexString:@"#ededed"];
    diseLabel.clipsToBounds = YES;
    diseLabel.layer.cornerRadius = diseLabel.height/2.0;
    diseLabel.textColor = [YXBTool colorWithHexString:@"#333333"];
    [self addSubview:diseLabel];
    
    UILabel *jLabel = [[UILabel alloc] initWithFrame:ccr(x, y, h, h)];
    jLabel.textAlignment = NSTextAlignmentCenter;
    jLabel.font = [UIFont boldSystemFontOfSize:14];
    jLabel.backgroundColor = kRGB(32, 119, 246);
    jLabel.clipsToBounds = YES;
    jLabel.layer.cornerRadius = jLabel.height/2.0;
    jLabel.textColor = [UIColor whiteColor];
    [self addSubview:jLabel];
    self.jLabel = jLabel;

    
    //左侧钱日期
    y = diseLabel.bottom + 7,w = w/2.0;
    h = 15;
    self.leftLabel = [[UILabel alloc] initWithFrame:ccr(x, y, w, h)];
    _leftLabel.textAlignment = NSTextAlignmentLeft;
    _leftLabel.font = [UIFont systemFontOfSize:13];
    _leftLabel.text = @"正在计算";
    _leftLabel.adjustsFontSizeToFitWidth = YES;
    _leftLabel.minimumScaleFactor = 8.0/_leftLabel.font.pointSize;
    _leftLabel.textColor = [YXBTool colorWithHexString:@"#333333"];
    [self addSubview:_leftLabel];
    
    //右侧钱 日期
    x = _leftLabel.right;
    self.rightLabel = [[UILabel alloc] initWithFrame:ccr(x, y, w, h)];
    _rightLabel.textAlignment = NSTextAlignmentRight;
    _rightLabel.font = [UIFont systemFontOfSize:13];
    _rightLabel.text = @"正在计算";
    _rightLabel.adjustsFontSizeToFitWidth = YES;
    _rightLabel.minimumScaleFactor = 8.0/_rightLabel.font.pointSize;
    _rightLabel.textColor = [YXBTool colorWithHexString:@"#333333"];
    [self addSubview:_rightLabel];




}

-(void)setModel:(ProfitUserBuyDetail *)model
{
    if (_model != model) {
        _model = model;
        NSString *money = [NSString stringWithFormat:@"+%@",_model.moneyPerDay];
        NSString *fMoney = [NSString stringWithFormat:@"今日 %@",money];
        NSMutableAttributedString  *aMoney = [[NSMutableAttributedString alloc] initWithString:fMoney];
        [aMoney addAttribute:NSForegroundColorAttributeName value:kRGB(221, 39, 39) range:[fMoney rangeOfString:money]];
        _profitTodayLabel.attributedText = aMoney;
//        _profitTodayLabel.text = [NSString stringWithFormat:@"今日 +%@",_model.moneyPerDay];
        _profitAllLabel.text = [NSString stringWithFormat:@"  已收益 %@元",_model.totleMoney];
        CGSize size = [YXBTool getFontSizeWithString:_profitAllLabel.text font:[UIFont systemFontOfSize:18] constrainSize:CGSizeMake(_profitAllLabel.width, NSIntegerMax)];
        _profitAllLabel.width = size.width;
        _profitAllLabel.superview.width = size.width;
        _leftLabel.text = [NSString stringWithFormat:@"%@元(%@)",_model.moneyPerDay,_model.startTime];
        _rightLabel.text = [NSString stringWithFormat:@"%@元(%@)",_model.totleMoney,_model.endTime];
        if ([_model.finishPercent floatValue] >= 0 && [_model.finishPercent floatValue] <= 100) {
            _jLabel.width = 23;
            _jLabel.text = @"";
            CGFloat animationTime = 0.5;
            if ([_model.finishPercent floatValue] == 0.00) {
                animationTime = 0;
            }
            [UIView animateKeyframesWithDuration:animationTime delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{

                CGFloat width = [_model.finishPercent floatValue] * 0.01 * diseLabel.width;
                if (width < 60) {
                    width = 60;
                }
                _jLabel.width = width;

                
            } completion:^(BOOL finished) {
                
                _jLabel.text = [NSString stringWithFormat:@"%.2f%%",[_model.finishPercent floatValue]];

            }];
        }

    }
}





@end
