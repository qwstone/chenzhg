//
//  ProfitManager.m
//  DiTui
//
//  Created by Walice on 15/6/1.
//  Copyright (c) 2015年 YXBao. All rights reserved.
//

#import "ProfitManager.h"

@implementation ProfitManager
-(NSSkyArray *)getNewProfitList:(NSString *)userToken pageNum:(NSInteger)pageNum type:(NSInteger)type{

      return [[NSSkyArray alloc]init];
}
- (ProfitHomeData *)getProfitHomeData:(NSString*)userToken {
    return [[ProfitHomeData alloc] init];
}
- (ProfitNewHomeData*)getProfitNewHomeData:(NSString *)userString {
    return [[ProfitNewHomeData alloc] init];
}
@end
