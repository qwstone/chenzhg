//
//  AmortizationHeaderView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/5/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AmortizationHeaderView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "CommerceBanner.h"
#import "YXBTool.h"

#define kButtonTag 20000

@implementation AmortizationHeaderView {
    UIView *_secondView;    //秒杀视图
    UIImageView *_secondImage;  //秒杀图片
    UILabel *_next;     //下一场
    UIView *_buttonContainer;
    TimeCountView *_timeView;   //倒计时
    QCCycleScrollView *_topScrollView;  //轮播图
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    _topScrollView = [[QCCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/320*150)];
//    scrollView.backgroundColor = [UIColor orangeColor];
    _topScrollView.delegate = self;
    _topScrollView.datasource = self;
    [self addSubview:_topScrollView];
    
    [self addLineWithOriginY:_topScrollView.bottom];
    
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(0, _topScrollView.bottom+12.5, kDeviceWidth, 125)];
    _secondView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_secondView];
    
    [self addLineWithOriginY:(_secondView.top-0.5)];
    [self addLineWithOriginY:_secondView.bottom];

    //添加秒杀点击事件
    UIControl *secondAction = [[UIControl alloc] initWithFrame:_secondView.bounds];
    [secondAction addTarget:self action:@selector(secondsAction) forControlEvents:UIControlEventTouchUpInside];
    [_secondView addSubview:secondAction];
    
    UIImageView *clock = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 14, 15.5)];
    clock.image = [UIImage imageNamed:@"ms-icon"];
    [_secondView addSubview:clock];
    
    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 8, 100, 15)];
    secondLabel.text = @"秒杀专场";
    secondLabel.textColor = [YXBTool colorWithHexString:@"#D91D37"];
    secondLabel.font = [UIFont systemFontOfSize:14];
    secondLabel.backgroundColor = [UIColor clearColor];
    [_secondView addSubview:secondLabel];
    
    
    _secondImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 157, 87)];
//    _secondImage.backgroundColor = [UIColor orangeColor];
    [_secondView addSubview:_secondImage];
    
    UIView *time = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/2+12.5, 30, 140, 85)];
    time.backgroundColor = rgb(239, 239, 239, 1);
    [_secondView addSubview:time];
    
    _next = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 120, 20)];
    _next.font = [UIFont systemFontOfSize:14];
    _next.backgroundColor = [UIColor clearColor];
    [time addSubview:_next];
    
    UILabel *start = [[UILabel alloc] initWithFrame:CGRectMake(10, _next.bottom+2, 120, 20)];
    start.text = @"距离开抢还有：";
    start.textColor = rgb(130, 130, 130, 1);
    start.font = [UIFont systemFontOfSize:14];
    start.backgroundColor = [UIColor clearColor];
    [time addSubview:start];
    
    _timeView = [[TimeCountView alloc] initWithFrame:CGRectMake(10, start.bottom+3, 120, 32.5)];
    [time addSubview:_timeView];
    
    _buttonContainer = [[UIView alloc] initWithFrame:CGRectMake(0, _secondView.bottom+10, kDeviceWidth, kDeviceWidth/320*230)];
    _buttonContainer.backgroundColor = [UIColor whiteColor];
    [self addSubview:_buttonContainer];
    
    [self addLineWithOriginY:(_buttonContainer.top-0.5)];
    
    //99*130  300*76
    CGFloat buttonWidth1 = kDeviceWidth/320*99;
    CGFloat buttonWidth2 = kDeviceWidth/320*300;
    CGFloat leftGap = (kDeviceWidth-(buttonWidth1*3+1.5*2))/2;
    CGFloat topGap = (kDeviceWidth/320*230-(buttonWidth1/99*130+1.5+buttonWidth2/300*76))/2;
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(leftGap, topGap, buttonWidth1, buttonWidth1/99*130)];
//    [button1 setTitle:@"时尚电子" forState:UIControlStateNormal];
//    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.tag = kButtonTag+1;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonContainer addSubview:button1];
    
//    [self addLineWithFrame:CGRectMake(button1.right, button1.top, 1, button1.height) inView:_buttonContainer];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(button1.right+1.5, topGap, buttonWidth1, buttonWidth1/99*130)];
//    [button2 setTitle:@"学习加油站" forState:UIControlStateNormal];
//    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button2.tag = kButtonTag+2;
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonContainer addSubview:button2];

//    [self addLineWithFrame:CGRectMake(button1.right+1, button2.bottom, button2.width, 1) inView:_buttonContainer];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(button2.right+1.5, topGap, buttonWidth1, buttonWidth1/99*130)];
//    [button3 setTitle:@"美妆护肤" forState:UIControlStateNormal];
//    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button3.tag = kButtonTag+3;
    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonContainer addSubview:button3];
    
//    [self addLineWithFrame:CGRectMake(button3.right, button3.top, 1, button3.height) inView:_buttonContainer];
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(leftGap, button1.bottom+1.5, buttonWidth2, buttonWidth2/300*76)];
//    [button4 setTitle:@"时尚潮品" forState:UIControlStateNormal];
//    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button4.tag = kButtonTag+4;
    [button4 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonContainer addSubview:button4];
}

- (void)addLineWithOriginY:(CGFloat)OriginY {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, OriginY, kDeviceWidth, 0.5)];
    line.backgroundColor = rgb(209, 207, 209, 1);
    [self addSubview:line];
}

- (void)buttonAction:(UIButton *)button {

    if ([self.delegate respondsToSelector:@selector(amortizationHeaderView:categoryButtonDidClickAtIndex:)]) {
        [self.delegate amortizationHeaderView:self categoryButtonDidClickAtIndex:(button.tag-kButtonTag)];
    }
}

//添加秒杀事件
-(void)secondsAction
{
    if ([self.delegate respondsToSelector:@selector(amortizationHeaderViewSecondsClicked)]) {
        [self.delegate amortizationHeaderViewSecondsClicked];
    }

}

//- (void)addLineWithFrame:(CGRect)frame inView:(UIView *)superView {
//    UIView *line = [[UIView alloc] initWithFrame:frame];
//    line.backgroundColor = rgb(221, 221, 221, 1);
//    [superView addSubview:line];
//}

- (void)resetFrame {
    if (self.data.hasSeckill.boolValue) {
        _secondView.hidden = NO;
        self.height = kAmortizationHeaderHeight;
        _buttonContainer.top = _secondView.bottom+10;
    }else {
        _secondView.hidden = YES;
        self.height = kAmortizationHeaderHeight-125;
        _buttonContainer.top = _secondView.top;
    }
}

- (void)setData:(CommerceHomePageData *)data {
    _data = data;
    
    if (data != nil) {
        [_topScrollView reloadData];
        
        if (data.hasSeckill.boolValue) {
            [_secondImage sd_setImageWithURL:[NSURL URLWithString:data.seckillImageUrl] placeholderImage:[UIImage imageNamed:@"msimg1"]];
            [_timeView setTimeWithSecond:[data.seckillClockTime integerValue]];
            _next.text = [NSString stringWithFormat:@"%@",data.seckillClockMsg];
        }else {
            
        }
        
        [self resetFrame];
        
        for (int i = kButtonTag+1; i<kButtonTag+5; i++) {
            UIButton *button = (UIButton *)[_buttonContainer viewWithTag:i];
            [button sd_setImageWithURL:[NSURL URLWithString:[data.categoryImageUrl objectAtIndex:i-kButtonTag-1]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"prod%ld",(long)(i-kButtonTag)]]];
        }
    }
}

#pragma mark - QCCycleScrollView delegate
- (NSInteger)numberOfPages
{
    return self.data.commerceBannerList.count;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    UIImageView *image = [[UIImageView alloc] initWithFrame:_topScrollView.bounds];
    CommerceBanner *banner = [self.data.commerceBannerList objectAtIndex:index];
    [image sd_setImageWithURL:[NSURL URLWithString:banner.imageUrl] placeholderImage:[UIImage imageNamed:@"bann1"]];
    
    return image;
}

- (void)didClickPage:(QCCycleScrollView *)csView atIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(amortizationHeaderView:scrollViewDidClickAtPage:)]) {
        [self.delegate amortizationHeaderView:self scrollViewDidClickAtPage:index];
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

#define kTimeCountTag 40000

@implementation TimeCountView {
    NSInteger _second;  //剩余秒数
    
    CPBTimerManager *  _timerManager;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i<3; i++) {
            CGFloat width1 = 30;
            CGFloat width2 = (self.frame.size.width-width1*3)/2;
            UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake((width1+width2)*i, 0, width1, frame.size.height)];
            time.tag = kTimeCountTag+i;
            time.textAlignment = NSTextAlignmentCenter;
            time.backgroundColor = rgb(36, 36, 36, 1);
            time.font = [UIFont boldSystemFontOfSize:17];
            time.layer.contents = (id)[UIImage imageNamed:@"clockbg"].CGImage;
            time.layer.cornerRadius = 5;
            time.layer.masksToBounds = YES;
            time.textColor = [UIColor whiteColor];
            [self addSubview:time];
            
            if (i != 2) {
                UILabel *symbol = [[UILabel alloc] initWithFrame:CGRectMake((width1+width2)*i+width1, 0, width2, frame.size.height)];
                symbol.text = @":";
                symbol.textAlignment = NSTextAlignmentCenter;
                symbol.backgroundColor = [UIColor clearColor];
                [self addSubview:symbol];
            }
            
            
        }
        
        _timerManager = [[CPBTimerManager alloc]initWithTimeInterval:1 userInfo:Nil repeats:YES];
        _timerManager.delegate = self;

    }
    return self;
}

- (void)setTimeWithSecond:(NSInteger)second {
    _second = second;
    for (int i = 0; i<3; i++) {
        UILabel *time = (UILabel *)[self viewWithTag:kTimeCountTag+i];
        if (i == 0) {
            //小时
            time.text = [NSString stringWithFormat:@"%02ld",(long)second/3600];
        }else if (i == 1) {
            //分
            time.text = [NSString stringWithFormat:@"%02ld",(long)(second/60)%60];
        }else if (i == 2) {
            //秒
            time.text = [NSString stringWithFormat:@"%02ld",(long)second%60];
        }
    }
}

- (void)CPBTimerManagerAction:(CPBTimerManager *)timer {
    if (_second == 0) {
        return;
    }
    _second--;
    [self setTimeWithSecond:_second];
}

- (void)dealloc {
    [_timerManager stop];
    
}

@end
