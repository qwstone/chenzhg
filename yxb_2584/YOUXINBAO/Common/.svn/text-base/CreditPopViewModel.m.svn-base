//
//  CreditPopViewModel.m
//  YOUXINBAO
//
//  Created by zjp on 16/1/5.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CreditPopViewModel.h"

@implementation CreditPopViewModel

static CreditPopViewModel *Instance = nil;
+ (instancetype)shareInstance {
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        
        Instance = [[[self class] alloc] init];
        Instance.rateChange = nil;
        Instance.rateChange2 = nil;
    });
    return Instance;
}
@end
