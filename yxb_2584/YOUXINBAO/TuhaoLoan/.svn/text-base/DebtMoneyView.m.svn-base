//
//  DebtMoneyView.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DebtMoneyView.h"

@interface DebtMoneyView ()
@property(nonatomic,strong)UILabel *moneyLabel;//钱数label
@property(nonatomic,strong)UILabel *lineLabel;//一条横线
@end

@implementation DebtMoneyView

-(void)initViews
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    bgImageView.image = [UIImage imageNamed:@"ycbtbg.png"];
    [self addSubview:bgImageView];
    CGFloat x = 0, y = 0, w = self.width,h = 30;
    self.moneyLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:25 textColor:[UIColor whiteColor]];
    _moneyLabel.font = [UIFont boldSystemFontOfSize:25];
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    [bgImageView addSubview:_moneyLabel];
    
    y = y + h;h = 20;
    self.userNameLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:20 textColor:[UIColor whiteColor]];
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    [bgImageView addSubview:_userNameLabel];
    
    
//    self.lineLabel = [self labelWithFrame:CGRectMake(10, 0, self.width-20, 0.5) fontSize:1 textColor:[UIColor whiteColor]];
    _lineLabel.backgroundColor = [UIColor whiteColor];
//    [bgImageView addSubview:_lineLabel];
    [self reSetCenter];
    
}

-(void)reSetCenter
{
    _moneyLabel.center = CGPointMake(_moneyLabel.center.x, 30);
    _userNameLabel.center = CGPointMake(_userNameLabel.center.x, 70);
//    _lineLabel.center = CGPointMake(_lineLabel.center.x, (_moneyLabel.center.y + _userNameLabel.center.y)/2);
}

-(void)setModel:(BlankNoteData *)model
{
    if (_model != model) {
        _model = model;
        NSString *text = [NSString stringWithFormat:@"￥%@",_model.money];
        NSMutableAttributedString *aText = [[NSMutableAttributedString alloc] initWithString:text];
        [aText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}
                              range:NSMakeRange(0, 1)];
        _moneyLabel.attributedText = aText;
        _userNameLabel.text = _model.nickName;
    }
}



@end
