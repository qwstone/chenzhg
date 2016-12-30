//
//  FundDetailHeaderView.m
//  YOUXINBAO
//
//  Created by Feili on 15/12/15.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "FundDetailHeaderView.h"
#import "FundDetailHeaderViewUp.h"
#import "FundDetailHeaderViewDown.h"

@interface FundDetailHeaderView ()

@property (nonatomic,strong)FundDetailHeaderViewUp *viewUp;
@property (nonatomic,strong)FundDetailHeaderViewDown *viewDown;

@end

@implementation FundDetailHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    CGFloat x = 0, y = 0,w = kDeviceWidth, h = 160;
    self.viewUp = [[FundDetailHeaderViewUp alloc] initWithFrame:ccr(x, y, w, h)];
    _viewUp.backgroundColor = kRGB(213, 37, 37);


    [self addSubview:_viewUp];
    
    y = _viewUp.bottom, h = 140;
    self.viewDown = [[FundDetailHeaderViewDown alloc] initWithFrame:ccr(x, y, w, h)];
    [self addSubview:_viewDown];
}

-(void)setModel:(ProfitUserBuyDetail *)model
{
    if (_model != model) {
        _model = model;
        _viewUp.model = _model;
        _viewDown.model = _model;
    }
}

@end
