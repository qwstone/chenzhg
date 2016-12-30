//
//  MsgCenterMgr+Public.h
//  LotteryApp
//
//  Created by SKY on 13-10-29.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MsgCenterMgr.h"
#import "MsgDBMgr.h"


@interface MsgCenterMgr (public_DB)

-(BOOL) hasNewMessage;
-(BOOL) hasNewFriend;


-(void) setNewMessageNumber:(NSInteger) num;



//返回与多少条新消息
-(NSString*) newMessageNumber;


-(void) removeMessgae;
-(void) removeFriend;

@end

