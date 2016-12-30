//
//  LoanDetaildSliderView.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanDetaildSliderView.h"

#define SliderDivide (kDeviceWidth-20)/20
@implementation LoanDetaildSliderView
{
    NSInteger timeLong;
    NSArray * timeArray;
}
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
//        self.backgroundColor = [UIColor redColor];
        timeArray = @[@"1天",@"2天",@"3天",@"4天",@"5天",@"6天",@"一周",@"两周",@"三周",@"1个月",@"2个月",@"3个月",@"4个月",@"5个月",@"6个月",@"7个月",@"8个月",@"9个月",@"10个月",@"11个月",@"1年"];
        UILabel * label1Day = [[UILabel alloc]initWithFrame:CGRectMake(23, 0, 30, 20)];
        label1Day.text = @"1天";
        label1Day.font = [UIFont systemFontOfSize:14];
        [self addSubview:label1Day];
        
        UILabel * label1Weak = [[UILabel alloc]initWithFrame:CGRectMake(20+SliderDivide*6, 0, 30,20)];
        label1Weak.text = @"1周";
        label1Weak.font = [UIFont systemFontOfSize:14];
        [self addSubview:label1Weak];
        
        UILabel * label1month = [[UILabel alloc]initWithFrame:CGRectMake(20+SliderDivide*8, 0, 30,20)];
        label1month.text = @"1个月";
        label1month.font = [UIFont systemFontOfSize:14];
        label1month.minimumScaleFactor = 10/label1month.font.pointSize;
        label1month.adjustsFontSizeToFitWidth = YES;

        [self addSubview:label1month];
        
        UILabel * label3month = [[UILabel alloc]initWithFrame:CGRectMake(20+SliderDivide*10, 0, 30,20)];
        label3month.text = @"3个月";
        label3month.font = [UIFont systemFontOfSize:14];
        label3month.minimumScaleFactor = 10/label3month.font.pointSize;
        label3month.adjustsFontSizeToFitWidth = YES;

        [self addSubview:label3month];

        UILabel * label6month = [[UILabel alloc]initWithFrame:CGRectMake(20+SliderDivide*13, 0, 30,20)];
        label6month.text = @"6个月";
        label6month.font = [UIFont systemFontOfSize:14];
        label6month.minimumScaleFactor = 10/label6month.font.pointSize;
        label6month.adjustsFontSizeToFitWidth = YES;

        [self addSubview:label6month];
        
        UILabel * label1Year = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width-45, 0, 30, 20)];
        label1Year.text = @"1年";
        label1Year.font = [UIFont systemFontOfSize:14];
        label1Year.minimumScaleFactor = 10/label1Year.font.pointSize;
        label1Year.adjustsFontSizeToFitWidth = YES;

        [self addSubview:label1Year];
        
        
        
        
        _slider = [[UISlider alloc]initWithFrame:CGRectMake(20, 25, frame.size.width-40, 20)];
//        slider.continuous = YES;

        _slider.maximumValue = timeArray.count-1;
        _slider.minimumValue = 0;
        _slider.value = 0;
        [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [_slider addTarget:self action:@selector(sliderFinsh:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_slider];
    }
    return self;
}

- (void)sliderAction:(UISlider *)sender
{
//    if ([self.delegate performSelector:@selector(changesValue:)]) {
        NSInteger number = (NSInteger)sender.value;
    [self.delegate changesValue:(LoanPeriod)number];
  //    }
}

- (void)sliderFinsh:(UISlider *)sender
{
    NSInteger number = (NSInteger)sender.value;
    _loanPeriod = (LoanPeriod)number;
    [self.delegate sliderFinsh:_loanPeriod];
}


@end
