//
//  AmortizationDetailView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/5/26.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AmortizationDetailView.h"
#import "UIImageView+WebCache.h"
#import "StagesInterest.h"

@implementation AmortizationDetailView {
    QCCycleScrollView *_topScrollView;
    UILabel *_descript;
    UILabel *_sum;
    UILabel *_firstMoney;   //首付金额
    UILabel *_monthPrice;   //月供
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.payment = [[CommercePayment alloc] init];
        
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    _topScrollView = [[QCCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 210)];
    //    scrollView.backgroundColor = [UIColor orangeColor];
    _topScrollView.delegate = self;
    _topScrollView.datasource = self;
    [self addSubview:_topScrollView];
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, _topScrollView.bottom, kDeviceWidth, 160)];
    [self addSubview:centerView];
    
    _descript = [[UILabel alloc] initWithFrame:CGRectMake(5, 15, kDeviceWidth-10, 20)];
    _descript.font = [UIFont systemFontOfSize:14];
    _descript.backgroundColor = [UIColor clearColor];
    [centerView addSubview:_descript];
    
    NSArray *namesArr = @[@"总价：",@"",@"首付：",@"首付金额：",@"分期：",@"月供："];
    for (int i = 0; i<6; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5+kDeviceWidth/2*(i%2), 55+22*(i/2), 150, 20)];
        label.text = [namesArr objectAtIndex:i];
        label.font = [UIFont systemFontOfSize:13];
        if (i == 0) {
            label.textColor = [UIColor redColor];
        }else {
            label.textColor = [UIColor blackColor];
        }
        label.backgroundColor = [UIColor clearColor];
        [centerView addSubview:label];
    }
    
    _sum = [[UILabel alloc] initWithFrame:CGRectMake(45, 55, 150, 20)];
    _sum.font = [UIFont systemFontOfSize:13];
    _sum.textColor = [UIColor redColor];
    _sum.backgroundColor = [UIColor clearColor];
    [centerView addSubview:_sum];
    
    _firstRate = [[UIButton alloc] initWithFrame:CGRectMake(45, 77, 100, 20)];
    [_firstRate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _firstRate.titleLabel.font = [UIFont systemFontOfSize:13];
    [_firstRate addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:_firstRate];
    
    _firstMoney = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+65, 77, 120, 20)];
    _firstMoney.font = [UIFont systemFontOfSize:13];
    _firstMoney.textColor = [UIColor redColor];
    _firstMoney.backgroundColor = [UIColor clearColor];
    [centerView addSubview:_firstMoney];
    
    _stage = [[UIButton alloc] initWithFrame:CGRectMake(45, 99, 100, 20)];
    [_stage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _stage.titleLabel.font = [UIFont systemFontOfSize:13];
    [_stage addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:_stage];
    
    _monthPrice = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2+45, 99, 120, 20)];
    _monthPrice.font = [UIFont systemFontOfSize:13];
    _monthPrice.textColor = [UIColor redColor];
    _monthPrice.backgroundColor = [UIColor clearColor];
    [centerView addSubview:_monthPrice];
    
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(5, 120, 120, 20)];
    tip.font = [UIFont systemFontOfSize:13];
    tip.text = @"温馨提示：XXXXXXXXXXX";
    tip.textColor = [UIColor redColor];
    tip.backgroundColor = [UIColor clearColor];
    [centerView addSubview:tip];
}

- (void)setData:(CommerceDetail *)data {
    _data = data;
    
    if (data != nil) {
        [_topScrollView reloadData];
        _sum.text = data.sumMoney;
        
        [self resetViewsWithFirstRateIndex:0 stageIndex:0];
    }
}

- (void)resetViewsWithFirstRateIndex:(NSInteger)rateIndex stageIndex:(NSInteger)stageIndex {
    //首付比例
    if (self.data.downPayment.count == 0 || self.data.stagesInterestList.count == 0) {
        return;
    }
    NSString *rateStr = [self.data.downPayment objectAtIndex:rateIndex];
    [self.firstRate setTitle:rateStr forState:UIControlStateNormal];
    
    //首付金额
    double rate = rateStr.doubleValue/100;
    double sum = _sum.text.doubleValue;
    double firstMoney = sum*rate;
    _firstMoney.text = [NSString stringWithFormat:@"%.1f",firstMoney];
    double residueMoney = sum-firstMoney;
    
    //分期
    
    StagesInterest *stageInterest = [self.data.stagesInterestList objectAtIndex:stageIndex];
    NSInteger stagesNum = stageInterest.stagesNum;
    [self.stage setTitle:[NSString stringWithFormat:@"%ld",(long)stagesNum] forState:UIControlStateNormal];
    
    //月供
    double interest = stageInterest.interest.doubleValue;
    double require = residueMoney*(1+interest); //
    double monthRequire = require/stagesNum;    //月供
    _monthPrice.text = [NSString stringWithFormat:@"%.1f",monthRequire];
    
    self.payment.downPayment = rateStr;
    self.payment.stagesNum = stagesNum;
    self.payment.interest = stageInterest.interest;
    self.payment.downPaymentMoney = _firstMoney.text;
    self.payment.stagesMoney = _monthPrice.text;
    
    if ([self.delegate respondsToSelector:@selector(amortizationDetailView:resetViewsFinished:)]) {
        [self.delegate amortizationDetailView:self resetViewsFinished:self.payment];
    }
}


#pragma mark - QCCycleScrollView delegate
- (NSInteger)numberOfPages
{
    return self.data.imageUrlArray.count;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    UIImageView *image = [[UIImageView alloc] initWithFrame:_topScrollView.bounds];
    [image sd_setImageWithURL:[NSURL URLWithString:[self.data.imageUrlArray objectAtIndex:index]] placeholderImage:nil];
    
    return image;
}

- (void)didClickPage:(QCCycleScrollView *)csView atIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(amortizationDetailView:scrollViewDidClickAtPage:)]) {
        [self.delegate amortizationDetailView:self scrollViewDidClickAtPage:index];
    }
}

- (void)buttonAction:(UIButton *)button {
    NSInteger index = 0;
    if ([button isEqual:_firstRate]) {
        index = 0;
    }else if ([button isEqual:_stage]) {
        index = 1;
    }
    
    if ([self.delegate respondsToSelector:@selector(amortizationDetailView:detailButtonDidClickAtIndex:)]) {
        [self.delegate amortizationDetailView:self detailButtonDidClickAtIndex:index];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
