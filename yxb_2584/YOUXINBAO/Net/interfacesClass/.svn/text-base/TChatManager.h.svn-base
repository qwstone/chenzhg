//
//  TChatManager.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/26.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSkyArray.h"
#import "TChat.h"

@interface TChatManager : NSObject


//获取历史消息

- (NSSkyArray *)getHistoryTChatByCategory:(NSInteger)categoryIndex categoryId:(NSInteger)categoryId timeStamp:(NSString *)timeStamp;

//获取最新消息
- (NSSkyArray *)getCurrentTChatByCategory:(NSInteger)categoryIndex categoryId:(NSInteger)categoryId timestamp:(NSString *)timestamp;


- (TChat *)addTChat:(NSInteger)userId category:(NSInteger)category categoryId:(NSInteger)categoryId message:(NSString *)message;

@end
