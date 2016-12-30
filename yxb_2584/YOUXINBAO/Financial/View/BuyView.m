//
//  BuyView.m
//  YOUXINBAO
//
//  Created by pro on 16/7/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BuyView.h"
#import "SubscribeViewController.h"
#import "YXBTool.h"
@interface BuyView ()

@property (nonatomic, strong) UIButton * buyBtn;
@property (nonatomic, strong) CalculatorViewNew * jisuanview;

@end

@implementation BuyView



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)setModel:(AssetDetails *)model
{
    _model = model;
    if ([model.percentage integerValue]>=100) {
//        [_buyBtn setBackgroundImage: [UIImage imageNamed:@"BuyEnd.png"] forState:UIControlStateNormal];
        [_buyBtn setTitle:@"已结束" forState:UIControlStateNormal];
        _buyBtn.backgroundColor = rgb(183, 178, 178, 1);
    }else{
        [_buyBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
        _buyBtn.backgroundColor = rgb(230, 46, 37, 1);
    }
}
-(void)createView
{
    self.buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyBtn.frame = CGRectMake(kDeviceWidth/750*30, kDeviceWidth/750*18, kDeviceWidth/750*570, kDeviceWidth/750*102);
    _buyBtn.layer.cornerRadius = 5;
    _buyBtn.layer.masksToBounds = YES;
    [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buyBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    _buyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:kDeviceWidth/750*40];
    _buyBtn.backgroundColor = rgb(230, 46, 37, 1);
    [_buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [_buyBtn setBackgroundImage: [UIImage imageNamed:@"JiLiQiangGou.png"] forState:UIControlStateNormal];
    
    [self addSubview:_buyBtn];
    
    
    UIButton * jisuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jisuanBtn.frame = CGRectMake(kDeviceWidth - kDeviceWidth/750*102 - kDeviceWidth/750*30, kDeviceWidth/750*18, kDeviceWidth/750*102, kDeviceWidth/750*102);
    [jisuanBtn addTarget:self action:@selector(jisuanAction) forControlEvents:UIControlEventTouchUpInside];
     [jisuanBtn setBackgroundImage:[UIImage imageNamed:@"JiSuanQi"] forState:UIControlStateNormal];
    [self addSubview:jisuanBtn];
    
}


//确认购买界面
-(void)buyBtnAction
{
    if ([_model.percentage integerValue]>=100) {
        return;
    }
    SubscribeViewController * subscribeVC = [[SubscribeViewController alloc] init];

    subscribeVC.assetID = _model.assetID;
    [[YXBTool getCurrentNav] pushViewController:subscribeVC animated:YES];
}


//计算器
-(void)jisuanAction
{
    _jisuanview = [[CalculatorViewNew alloc] initWithFrame:[[UIApplication sharedApplication].delegate window].bounds];
    _jisuanview.annualizedReturn = _model.annualizedReturn;
    _jisuanview.limit = _model.limit;
    _jisuanview.calculatorType = YES;
    [[[UIApplication sharedApplication].delegate window] addSubview:_jisuanview];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
