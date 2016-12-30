//
//  DateFormatInstance.m
//  YOUXINBAO
//
//  Created by Feili on 16/3/1.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//



#import "DateFormatInstance.h"

__strong static DateFormatInstance *instance = nil;

@implementation DateFormatInstance
+(DateFormatInstance *)shareInstance {
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        instance = [[DateFormatInstance alloc] init]; // or some other init method
        [instance initDateFormat];
    });
    return instance;
}

-(void)initDateFormat
{
    if (_dateFormat == nil) {
        self.dateFormat = [[NSDateFormatter alloc] init];
        [self.dateFormat setDateFormat:@"yyyy-MM-dd"];
        [self.dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

    }
}

@end
