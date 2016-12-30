//
//  JieKuanSquareView.m
//  YOUXINBAO
//
//  Created by Feili on 16/1/27.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "JieKuanSquareView.h"
#import "YXBTool.h"
#define JieKuanSquareViewBaseTag 3000

@interface JieKuanSquareView ()
@property (nonatomic,strong)NSMutableArray *monthArray;
@end

@implementation JieKuanSquareView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor brownColor];
        self.monthArray = [NSMutableArray arrayWithObjects:@"7",@"14",@"1",@"3",@"6",@"12", nil];
        [self initViews];
    }
    return self;
}

-(void)initViews
{
    NSArray *titleArray = [NSArray arrayWithObjects:@"1周",@"2周",@"1个月",@"3个月",@"6个月",@"1年", nil];
    
    CGFloat imageWidth = (kDeviceWidth - 120)/3;
    NSString *stringNameSelected = @"timesquareS";
    UIImage *sizeImage =[UIImage imageNamed:stringNameSelected];
    NSInteger space = 10;
    NSInteger vSpace = 5;
    imageWidth = ((kDeviceWidth - 60) - (2 * space))/3.0;
    imageWidth = 80;
    space = (self.width - (3 * imageWidth))/2.0;
    for (int i =0 ; i < 6; i ++) {
        
        CGFloat x = (i%3) * imageWidth + (i%3) * space;
        CGFloat h = [YXBTool heightWithSize:sizeImage.size width:imageWidth];
//        CGFloat h = 32;
        CGFloat y = h * (i/3) + 10 + (vSpace*(i/3)), w = imageWidth;
//        if (i < 3) {
//            y = y + 10;
//        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = ccr(x, y, w, h);
        btn.tag = i + JieKuanSquareViewBaseTag;
        NSString *stringNameSelected = @"timesquareS";
        NSString *stringNameUnSelected = @"timesquare";
        [btn setBackgroundImage:[UIImage imageNamed:stringNameSelected] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:stringNameUnSelected] forState:UIControlStateNormal];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:kRGB(86, 86, 86) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }
}

-(void)btnAction:(UIButton *)sender
{
    [self setAllUnSelected];
    sender.selected = YES;
//    NSString *date = [self getDateWithDays:sender.tag - JieKuanSquareViewBaseTag];
    NSInteger index = sender.tag - JieKuanSquareViewBaseTag;
    NSString *date = [YXBTool dateWithCurrentDateWithPeriodMonths:[self.monthArray[index] integerValue]];
    if (_delegate && [_delegate respondsToSelector:@selector(squareViewSelectedDate:)]) {
        [_delegate squareViewSelectedDate:date];
    }
    
}

-(NSString *)getDateWithDays:(JieKuanDays)day
{
    NSInteger days = 1;
    switch (day) {
        case JieKuanDaysOneWeek:
            days = 7;
            break;
        case JieKuanDaysTwoWeek:
            days = 14;
            break;
        case JieKuanDaysOneMonth:
            days = 30;
            break;
        case JieKuanDaysThreeMonth:
            days = 90;
            break;

        case JieKuanDaysSixMonth:
            days = 210;
            break;

        case JieKuanDaysOneYear:
            days = 360;
            break;

            
            
        default:
            break;
    }
    
    NSDate *now = [NSDate date];
    NSDate *newDate = [now dateByAddingTimeInterval:60*60*24*days];
    NSString *date = [self stringFromDate:newDate];
    return date;
}

-(void)setAllUnSelected
{
    for (int i = 0; i < 6; i ++) {
        UIButton *btn = [self viewWithTag:JieKuanSquareViewBaseTag + i];
        btn.selected = NO;
    }
}

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];

    return destDateString;
    
}

@end
