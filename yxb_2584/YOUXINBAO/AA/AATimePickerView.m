//
//  AATimePickerView.m
//  YOUXINBAO
//
//  Created by CH10 on 14-3-28.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AATimePickerView.h"
#import "NSDate+Helpers.h"
#import "QCUtils.h"
#import "QCConst.h"

@implementation AATimePickerView {
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

- (id)initWithFrame:(CGRect)frame withHour:(BOOL)yesOrNo
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        

        
        UIImageView * sendBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44)];
//        sendBackImage.backgroundColor = [UIColor whiteColor];
//        sendBackImage.layer.borderWidth = 1.0;
//        sendBackImage.layer.borderColor = [rgb(255, 156, 146, 1) CGColor];
        sendBackImage.userInteractionEnabled = YES;
//        [self addSubview:sendBackImage];
        
//        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(10, 5, kDeviceWidth-20, 40);
//        button.backgroundColor = [UIColor clearColor];
//        [button setImage:[UIImage imageNamed:@"register_sure.png"] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
//        [sendBackImage addSubview:button];
        
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44)];
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(showPickerView)];

        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(sureAction:)];
        toolBar.items = [NSArray arrayWithObject:right];
        
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *fixSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        [toolBar setItems:[NSArray arrayWithObjects:flexibleSpace,left,flexibleSpace,flexibleSpace,flexibleSpace,flexibleSpace,flexibleSpace,flexibleSpace,flexibleSpace,flexibleSpace,right,flexibleSpace, nil]];
        [sendBackImage addSubview:toolBar];
        [self addSubview:toolBar];
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.width, self.height-50)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];
        
        
        //初始化
        _isShow = NO;
        _hasHour = yesOrNo;
        self.date = [self afterHour];
        //        NSString *formate = @"yyyyMMddHH";
        //        NSString *todayString = [QCUtils stringFromDate:self.date formate:formate];
        //        _selectedYear = _currentYear = [[todayString substringWithRange:NSMakeRange(0, 4)] integerValue];
        //        _selectedMonth = _currentMonth = [[todayString substringWithRange:NSMakeRange(4, 2)] integerValue];
        //        _selectedDay = _currentDay = [[todayString substringWithRange:NSMakeRange(6, 2)] integerValue];
        //        _selectedHour = _currentHour = [[todayString substringWithRange:NSMakeRange(8, 2)] integerValue];
        
        //        self.layer.borderColor = [[UIColor grayColor] CGColor];
        //        self.layer.borderWidth = 1;
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
            formate = @"yyyyMMdd";
        }
        NSString *dateString = [QCUtils stringFromDate:date formate:formate];
        
        
        NSString *year = [dateString substringWithRange:NSMakeRange(0, 4)];
        NSString *month = [dateString substringWithRange:NSMakeRange(4, 2)];
        NSString *day = [dateString substringWithRange:NSMakeRange(6, 2)];
        if (_hasHour) {
            NSString *hour = [dateString substringWithRange:NSMakeRange(8, 2)];
            _selectedHour = [hour integerValue];
            [_pickerView selectRow:_selectedHour inComponent:3 animated:NO];
            
        }
        
        _selectedDay = [day integerValue];
        _selectedMonth = [month integerValue];
        _selectedYear = [year integerValue];
        
        [_pickerView selectRow:_selectedDay-1 inComponent:2 animated:NO];
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
    
//    if (_isShow) {
//        [self removeFromSuperview];
//    }
    _isShow = !_isShow;
}


//获取选中月的天数
- (NSInteger) getnumberOfDaysInMonth
{
    NSDate *selectedDate = [self getDateFromYearRow:_selectedYear monthRow:_selectedMonth dayRow:1 hoursRow:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:selectedDate];
    
    NSUInteger days = range.length;
    return days;
}


#pragma mark - UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (_hasHour) {
        return 5;
        
    }else {
        return 3;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    NSDate *today = [NSDate date];
//    NSString *formate = @"yyyyMMddHH";
//    NSString *todayString = [QCUtils stringFromDate:today formate:formate];
//    NSString *hour = [todayString substringWithRange:NSMakeRange(8, 2)];
    
    if (component == 0) {
        return 10;
    }else if (component == 1) {
//        if ([self isEqualTodayinComponent:1]) {
//            return (12-[today getMonth]+1);
//        }else {
            return 12;
//        }
        
    }else if (component == 2){
//        if ([self isEqualTodayinComponent:2]) {
//            NSInteger totalDay = [[today endOfMonth] getDay];
//            NSInteger day = [today getDay];
//            return (totalDay-day+1);
//        }else {
            return [[self.date endOfMonth] getDay];
//        }
        
    }else if (component == 3){
//        if ([self isEqualTodayinComponent:3]) {
//            return (24-[hour integerValue]+1);
//        }else {
            return 24;
            
//        }
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
        //如果当前选择器中的day  大于 选中年份当月的天数  则day更改为选中年份当月的最大天数
        NSInteger daysofSelectMonth = [self getnumberOfDaysInMonth];
        if (daysofSelectMonth < _selectedDay) {
            _selectedDay = daysofSelectMonth;
        }

    }
    
    if (component == 1) {
//        if ([self isEqualTodayinComponent:1]) {
//            _selectedMonth = _currentMonth+row;
//        }else {
            _selectedMonth = row+1;
        //如果当前选择器中的day  大于 选中月的天数  则day更改为选中月的最大天数
        NSInteger daysofSelectMonth = [self getnumberOfDaysInMonth];
        if (daysofSelectMonth < _selectedDay) {
            _selectedDay = daysofSelectMonth;
        }

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
    
    NSDate *selectedDate = [self getDateFromYearRow:_selectedYear monthRow:_selectedMonth dayRow:_selectedDay hoursRow:_selectedHour];
    
    NSString *mes;
    if (_hasHour) {
        mes = @"请选择1小时后的日期";
    }else {
        mes = @"请选择大于当前日的日期";
    }
    
    if ([[NSDate date] compare:selectedDate] == NSOrderedDescending) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:mes delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
    }else {
        self.date = selectedDate;
        //        [self reloadComponent:2];
        [_pickerView reloadAllComponents];
        
        if (self.selectedBlock != nil) {
            self.selectedBlock(_selectedYear,_selectedMonth,_selectedDay,_selectedHour,_selectedMinIndex,self);
        }
        
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
        dateString = [NSString stringWithFormat:@"%ld%02ld%02ld",(long)y,(long)m,(long)d];
        formate = @"yyyyMMdd";
    }
    
    return [QCUtils dateFromString:dateString formate:formate];
}

//- (BOOL)isEqualTodayinComponent:(NSInteger)component {
//    NSDate *today = [NSDate date];
//    NSString *formate = @"yyyyMMddHH";
//    NSString *todayString = [QCUtils stringFromDate:today formate:formate];
//    NSString *year = [todayString substringWithRange:NSMakeRange(0, 4)];
//    NSString *month = [todayString substringWithRange:NSMakeRange(4, 2)];
//    NSString *day = [todayString substringWithRange:NSMakeRange(6, 2)];
////    NSString *hour = [todayString substringWithRange:NSMakeRange(8, 2)];
//    
//    NSString *selectedString = [QCUtils stringFromDate:self.date formate:formate];
//    NSString *selectedYear = [selectedString substringWithRange:NSMakeRange(0, 4)];
//    NSString *selectedMonth = [selectedString substringWithRange:NSMakeRange(4, 2)];
//    NSString *selectedDay = [selectedString substringWithRange:NSMakeRange(6, 2)];
//    //    NSString *selectedHour = [selectedString substringWithRange:NSMakeRange(8, 2)];
//    
//    if (component == 1) {
//        return [year isEqualToString:selectedYear];
//        
//    }else if (component == 2){
//        return [year isEqualToString:selectedYear] && [month isEqualToString:selectedMonth];
//        
//    }else if (component == 3){
//        return [year isEqualToString:selectedYear] && [month isEqualToString:selectedMonth] && [day isEqualToString:selectedDay];
//    }else {
//        return YES;
//    }
//}

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
//    int hour = [dateComponent hour];
//    int minute = [dateComponent minute];
//    int second = [dateComponent second];
    return [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)year,(long)month,(long)day];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
