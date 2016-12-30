//
//  TChatManager.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/26.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TChatManager.h"

@implementation TChatManager

- (NSSkyArray *)getCurrentTChatByCategory:(NSInteger)categoryIndex categoryId:(NSInteger)categoryId timestamp:(NSString *)timestamp
{
    return [[NSSkyArray alloc]init];
}

- (NSSkyArray *)getHistoryTChatByCategory:(NSInteger)categoryIndex categoryId:(NSInteger)categoryId timeStamp:(NSString *)timeStamp
{
    return [[NSSkyArray alloc]init];
}

- (TChat *)addTChat:(NSInteger)userId category:(NSInteger)category categoryId:(NSInteger)categoryId message:(NSString *)message
{
    return [[TChat alloc]init];
}

@end
