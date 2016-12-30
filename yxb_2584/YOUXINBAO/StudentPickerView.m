//
//  StudentPickerView.m
//  YOUXINBAO
//
//  Created by Feili on 15/8/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "StudentPickerView.h"
#import "NSDate+Helpers.h"
#import "QCUtils.h"
#import "QCConst.h"

@implementation StudentPickerView
{
    UIPickerView *_pickerView;
    NSInteger _selectedYear;
    NSInteger _selectedMonth;
//    BOOL _hasHour;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView * sendBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(-1, 0, kDeviceWidth+2, 50)];
        sendBackImage.backgroundColor = [UIColor whiteColor];
        sendBackImage.layer.borderWidth = 1.0;
        sendBackImage.layer.borderColor = [rgb(255, 156, 146, 1) CGColor];
        sendBackImage.userInteractionEnabled = YES;
        [self addSubview:sendBackImage];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 5, kDeviceWidth-20, 40);
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:@"register_sure.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        [sendBackImage addSubview:button];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, self.width, self.height-50)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];
        
//        self.yearArray = [NSMutableArray arrayWithObjects:@"2015",@"2016",@"2017", nil];
//        _selectedYear = [_yearArray[0] integerValue];
//        _selectedMonth = [_monthArray[0] integerValue];
    }
    return self;
}


- (void)showPickerView {
    [UIView animateWithDuration:.5 animations:^{
        if (!_isShow) {
            self.top -= self.height;
        }else {
            self.top += self.height;
        }
    }];
    
    _isShow = !_isShow;
}

#pragma mark - UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger number = 0;
    if (component == 0) {
        
        number = [_yearArray count];
    }else if (component == 1) {
        
        number = [_monthArray count];
    }
    
    return number;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return getScreenFitSize(60);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,0.0f,100.0f,20.0f)];
    showLabel.backgroundColor = [UIColor clearColor];
    showLabel.textAlignment = NSTextAlignmentCenter;
    
    if (component == 0)
    {
        showLabel.text = [NSString stringWithFormat:@"%@年",_yearArray[row]];
        
    }else if (component == 1)
    {
        showLabel.text = [NSString stringWithFormat:@"%@月",_monthArray[row]];
        
    }
    
    return showLabel;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        
        _selectedYear = [_yearArray[row] integerValue];
    }
    
    if (component == 1) {
        _selectedMonth = [_monthArray[row] integerValue];
    }
    
}

- (void)sureAction:(UIButton *)button {
    [self showPickerView];
    
    if (self.selectedBlock != nil) {
        self.selectedBlock(_selectedYear,_selectedMonth,0,0,0,self);
    }
}


#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
//        self.date = [self afterHour];
    }
}


+ (NSString *)getCurrentTime
{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    //    int hour = [dateComponent hour];
    //    int minute = [dateComponent minute];
    //    int second = [dateComponent second];
    return [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)year,(long)month,(long)day];
}

-(void)setYearArray:(NSMutableArray *)yearArray
{
    _yearArray = yearArray;
    _selectedYear = [_yearArray[0] integerValue];
    _monthArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
    _selectedMonth = [_monthArray[0] integerValue];
}

@end
