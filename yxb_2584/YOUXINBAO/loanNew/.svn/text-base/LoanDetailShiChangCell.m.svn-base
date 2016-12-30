//
//  LoanDetailShiChangCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/8/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanDetailShiChangCell.h"
#import "LoanDetaildSliderView.h"


@interface LoanDetailShiChangCell ()<SliderViewDelegate>


@property(nonatomic, strong)UILabel *shichangLabel;  //时长
@property(nonatomic, strong)UILabel  *titleLabel;    //标题
@property(nonatomic, strong)LoanDetaildSliderView *slideView;//时间选择滚动器

@end

@implementation LoanDetailShiChangCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    
    return self;
}


-(void)initViews
{
    //添加背景
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    CGFloat x = 0,y = 0;
    CGFloat w = kDeviceWidth,h = 100;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    bgView.backgroundColor = rgb(255, 255, 255, 0.8);
    [self.contentView addSubview:bgView];
    
    //添加标题
    x = 20 , w = 80, h = 50;
    self.titleLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:14 minimumScaleFactor:16 adjustsFontSizeToFitWidth:NO textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor]];
    [bgView addSubview:_titleLabel];
    
    //添加文本
#define LoginCellTextfieldleftAlign 20
    x = x + w + LoginCellTextfieldleftAlign;
    w = 100;
    self.shichangLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth - 20 - w, y, w, h)];
    _shichangLabel.textAlignment = NSTextAlignmentRight;
    _shichangLabel.font = [UIFont systemFontOfSize:15.0];
    
    [bgView addSubview:_shichangLabel];
    
    //时长滑轮
    self.slideView = [[LoanDetaildSliderView alloc]initWithFrame:CGRectMake(0, 50, kDeviceWidth, 50)];
    _slideView.delegate  = self;
    _slideView.slider.value = 7.0;
    [bgView addSubview:_slideView];
    
    
}

-(void)setModel:(LoginModel *)model
{
    _model = model;
    _titleLabel.text = _model.titleName;
    _shichangLabel.text = _model.text;
}

//滑动时
- (void)changesValue:(LoanPeriod)loanPeriod
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(changesValue:)]) {
        [_delegate changesValue:loanPeriod];
        _shichangLabel.text = [Loan getLoanPeriodWith:loanPeriod];
    }
}
//滑动完成
- (void)sliderFinsh:(LoanPeriod)loanPeriod
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(sliderFinsh:)]) {
        [_delegate sliderFinsh:loanPeriod];
        _shichangLabel.text = [Loan getLoanPeriodWith:loanPeriod];

    }

}



@end
