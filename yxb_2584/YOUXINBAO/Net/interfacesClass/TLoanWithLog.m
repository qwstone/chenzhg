//
//  TLoanWithLog.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TLoanWithLog.h"
#import <objc/runtime.h>


@implementation TLoanWithLog
@dynamic errCode;
- (id)init{
   self =  [super init];
    if (self) {
        self.loanLog = [[NSMutableArray alloc]init];
    }
    return self;
}


- (void)decodeWithSubArray:(NSArray *)arr withPropertyName:(NSString *)name
{
    
//    NSArray* tmp = [NSArray arrayWithArray:arr];
    for (int i = 0; i < [arr count]; i++) {
            NSDictionary* dicClass = [arr objectAtIndex:i];
            TLoanLog* obj = [[TLoanLog alloc] init];
            [obj decodeWithDic:dicClass];
            [self.loanLog addObject:obj];
    }
    
}


@end
