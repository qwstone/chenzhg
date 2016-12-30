//
//  QCLocation.m
//  YOUXINBAO
//
//  Created by CH10 on 15/3/12.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCLocalLocation.h"

__strong static QCLocalLocation *instance = nil;

@implementation QCLocalLocation

+ (id)shareInstance {
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init]; // or some other init method
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
 {
     @synchronized(self) {
         if (!instance) {
             instance = [super allocWithZone:zone];
         }
     }
     return instance;
}


//实现copyWithZone:方法

+ (id)copyWithZone:(struct _NSZone *)zone
{
     return instance;
}

@end
