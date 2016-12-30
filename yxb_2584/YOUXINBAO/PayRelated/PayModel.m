//
//  PayModel.m
//  LotteryApp
//
//  Created by 程立彬 on 14-4-10.
//  Copyright (c) 2014年 windo. All rights reserved.
//

#import "PayModel.h"

@implementation PayModel
- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
     
        self.hdName = [dict objectForKey:@"hdName"];
        self.isCanyu = [dict objectForKey:@"isCanyu"];
        self.isHuoDong = [dict objectForKey:@"isHuoDong"];
        self.isWanShan = [dict objectForKey:@"isWanShan"];
        self.msg = [dict objectForKey:@"msg"];
        self.selectFailedReason = [dict objectForKey:@"selectFailedReason"];
        self.yhm = [dict objectForKey:@"yhm"];
        self.yue = [dict objectForKey:@"yue"];

    }
    return self;
}

@end
