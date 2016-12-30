//
//  OverdueModel.m
//  YOUXINBAO
//
//  Created by CH10 on 15/10/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "OverdueModel.h"



@implementation OverdueModel

+(instancetype)shareOverdueModel{
    static OverdueModel *instance = nil;
    
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        
        instance = [[[self class] alloc] init];
        instance.showNewLoan = @"-1";
        instance.HighLightID = @"";
    });
    
    return instance;

}


@end
