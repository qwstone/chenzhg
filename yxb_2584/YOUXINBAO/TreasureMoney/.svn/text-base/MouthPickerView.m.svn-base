//
//  MouthPickerView.m
//  YOUXINBAO
//
//  Created by zjp on 15/9/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MouthPickerView.h"
#import "NSDate+Helpers.h"
#import "QCUtils.h"
#import "QCConst.h"
@implementation MouthPickerView


{
    UIPickerView *_pickerView;
    
    //    NSInteger _currentYear;
    //    NSInteger _currentMonth;
    //    NSInteger _currentDay;
    //    NSInteger _currentHour;
    
    NSInteger _selectedYear;
    NSInteger _selectedMonth;
    NSInteger _selectedDay;
    NSInteger _selectedHour;
    NSInteger _selectedMinIndex;    //选中分钟索引
    
    BOOL _hasHour;
}

- (id)initWithFrame:(CGRect)frame withHour:(BOOL)dayOrNo
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView * sendBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(-1, 0, kDeviceWidth+2, 50)];
        sendBackImage.backgroundColor = rgb(230, 230, 230, 1);
        sendBackImage.userInteractionEnabled = YES;
        [self addSubview:sendBackImage];
        
        UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(10, 10, 60, 30);
        button1.backgroundColor = [UIColor clearColor];
        [button1 setImage:[UIImage imageNamed:@"newbzq-cancle"] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
        [sendBackImage addSubview:button1];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kDeviceWidth-70, 10, 60, 30);
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:@"newbzq-ok"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        [sendBackImage addSubview:button];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, self.width, self.height-50)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];
        
        
        //初始化
        _isShow = NO;
        _hasHour = dayOrNo;
        self.date = [self afterHour];
    }
    return self;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    if (_date) {
        NSString *formate;
        if (_hasHour) {
            formate = @"yyyyMMddHH";
            
        }else {
            formate = @"yyyyMM";
        }
        NSString *dateString = [QCUtils stringFromDate:date formate:formate];
        
        
        NSString *year = [dateString substringWithRange:NSMakeRange(0, 4)];
        NSString *month = [dateString substringWithRange:NSMakeRange(4, 2)];

        if (_hasHour) {
            NSString *hour = [dateString substringWithRange:NSMakeRange(8, 2)];
            _selectedHour = [hour integerValue];
            [_pickerView selectRow:_selectedHour inComponent:3 animated:NO];
            
        }
        

        _selectedMonth = [month integerValue];
        _selectedYear = [year integerValue];
        

        [_pickerView selectRow:_selectedMonth-1 inComponent:1 animated:NO];
        [_pickerView selectRow:_selectedYear-2010 inComponent:0 animated:NO];
        
    }
    
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
    if (_hasHour) {
        return 5;
        
    }else {
        return 2;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    
    if (component == 0) {
        return 10;
    }else if (component == 1) {
        return 12;
        //        }
        
    }else if (component == 2){
        return [[self.date endOfMonth] getDay];
        
    }else if (component == 3){
        return 24;

    }else {
        return 2;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return getScreenFitSize(60);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,0.0f,100.0f,20.0f)];
    showLabel.backgroundColor = [UIColor clearColor];
    showLabel.textAlignment = NSTextAlignmentCenter;
    
    if (component == 0) {
        showLabel.text = [NSString stringWithFormat:@"%ld年",(long)(row+2010)];
        
    }else if (component == 1) {
        //        if ([self isEqualTodayinComponent:1]) {
        //            showLabel.text = [NSString stringWithFormat:@"%ld月",(long)(row+_currentMonth)];
        //        }else {
        showLabel.text = [NSString stringWithFormat:@"%ld月",(long)(row+1)];
        
        //        }
        
    }else if (component == 2) {
        //        if ([self isEqualTodayinComponent:2]) {
        //            showLabel.text = [NSString stringWithFormat:@"%ld日",(long)(row+_currentDay)];
        //        }else {
        showLabel.text = [NSString stringWithFormat:@"%ld日",(long)(row+1)];
        
        //        }
        
    }else if (component == 3){
        //        if ([self isEqualTodayinComponent:3]) {
        //            showLabel.text = [NSString stringWithFormat:@"%02ld",(long)(row +_currentHour)];
        
        //        }else {
        showLabel.text = [NSString stringWithFormat:@"%02ld",(long)row];
        
        //        }
    }else {
        if (row == 0) {
            showLabel.text = @"00";
        }else {
            showLabel.text = @"30";
        }
    }
    
    return showLabel;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        
        _selectedYear = 2010+row;
    }
    
    if (component == 1) {
        //        if ([self isEqualTodayinComponent:1]) {
        //            _selectedMonth = _currentMonth+row;
        //        }else {
        _selectedMonth = row+1;
        //        }
    }
    
    if (component == 2) {
        //        if ([self isEqualTodayinComponent:2]) {
        //            _selectedDay = _currentDay+row;
        //        }else {
        _selectedDay = row+1;
        //        }
    }
    
    if (component == 3) {
        //        if ([self isEqualTodayinComponent:3]) {
        //            _selectedHour = _currentHour+row;
        //        }else {
        _selectedHour = row;
        //        }
        
    }
    
    if (component == 4) {
        _selectedMinIndex = row;
    }
    
    
    [_pickerView reloadAllComponents];
    NSDate *selectedDate = [self getDateFromYearRow:_selectedYear monthRow:_selectedMonth dayRow:_selectedDay hoursRow:_selectedHour];
    
    self.date = selectedDate;
//
//    if (self.selectedBlock != nil) {
//        self.selectedBlock(_selectedYear,_selectedMonth,_selectedDay,_selectedHour,_selectedMinIndex,self);
//    }
//    NSString *mes;
//    if (_hasHour) {
//        mes = @"请选择1小时后的日期";
//    }else {
//        mes = @"请选择将来的日期";
//    }
//    
//    if ([[NSDate date] compare:selectedDate] == NSOrderedDescending) {
//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:mes delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alter show];
//        
//    }else {
//        
//    }
    
}

- (void)cancleAction {
[self showPickerView];
    if (self.caeclSelectBlock != nil) {
        self.caeclSelectBlock(_selectedYear,_selectedMonth,_selectedDay,_selectedHour,_selectedMinIndex,self);
    }
}

- (void)sureAction:(UIButton *)button {
    [self showPickerView];
    
    NSString *formate = @"yyyyMMddHH";
    NSString *todayString = [QCUtils stringFromDate:self.date formate:formate];
    _selectedYear  = [[todayString substringWithRange:NSMakeRange(0, 4)] integerValue];
    _selectedMonth = [[todayString substringWithRange:NSMakeRange(4, 2)] integerValue];
    _selectedDay = [[todayString substringWithRange:NSMakeRange(6, 2)] integerValue];
    _selectedHour = [[todayString substringWithRange:NSMakeRange(8, 2)] integerValue];
    
    if (self.selectedBlock != nil) {
        self.selectedBlock(_selectedYear,_selectedMonth,_selectedDay,_selectedHour,_selectedMinIndex,self);
    }
}

#pragma mark - Private Motheds
- (NSDate *)afterHour {
    NSDate *now = [NSDate date];
    NSString * formate = @"yyyyMMddHH";
    
    NSString *dateString = [QCUtils stringFromDate:now formate:formate];
    
    
    NSInteger year = [[dateString substringWithRange:NSMakeRange(0, 4)] integerValue];
    NSInteger month = [[dateString substringWithRange:NSMakeRange(4, 2)] integerValue];
    NSInteger day = [[dateString substringWithRange:NSMakeRange(6, 2)] integerValue];
    NSInteger hour = [[dateString substringWithRange:NSMakeRange(8, 2)] integerValue];
    if (hour == 23) {
        hour = 0;
        day++;
    }else {
        hour++;
    }
    NSString *afterString = [NSString stringWithFormat:@"%ld%02ld%02ld%02ld",(long)year,(long)month,(long)day,(long)hour];
    return [QCUtils dateFromString:afterString formate:formate];
    
}

- (NSDate *)getDateFromYearRow:(NSInteger)y monthRow:(NSInteger)m dayRow:(NSInteger)d hoursRow:(NSInteger)h{
    NSString *dateString;
    NSString *formate;
    if (_hasHour) {
        dateString = [NSString stringWithFormat:@"%ld%02ld%02ld%02ld",(long)y,(long)m,(long)d,(long)h];
        formate = @"yyyyMMddHH";
        
    }else {
        dateString = [NSString stringWithFormat:@"%ld%02ld",(long)y,(long)m];
        formate = @"yyyyMM";
    }
    
    return [QCUtils dateFromString:dateString formate:formate];
}



#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        self.date = [self afterHour];
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

    return [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)year,(long)month,(long)day];
}

@end
