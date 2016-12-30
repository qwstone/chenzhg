//
//  JieKuanInstance.m
//  YOUXINBAO
//
//  Created by Feili on 16/1/28.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "JieKuanInstance.h"

__strong static JieKuanInstance *instance = nil;

@implementation JieKuanInstance


+(id)shareInstance {
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init]; // or some other init method
    });
    return instance;
}



@end
