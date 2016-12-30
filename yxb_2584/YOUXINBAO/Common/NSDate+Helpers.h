//
//  NSDate+Helpers.h
//  SRMonthPickerExample
//
//  Created by CH10 on 14-3-28.
//  Copyright (c) 2014年 Simon Rice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helpers)

- (NSDate *)endOfMonth;

- (NSUInteger)getMonth;

- (NSUInteger)getDay;

- (NSDate *)beginningOfMonth;

- (NSUInteger)weekday;

@end
