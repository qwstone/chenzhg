//
//  MsgCenterMgr+Public.m
//  LotteryApp
//
//  Created by SKY on 13-10-29.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import "MsgCenterMgr+Public.h"
#import "YXBTool.h"
#import "AppDelegate+Push.h"
#import "AppDelegate.h"

@implementation MsgCenterMgr (public_DB)


-(void) setNewMessageNumber:(NSInteger) num {
    if (num < 0) {
        return;
    }
    
    if ([YXBTool getUserToken] == nil) {
        return;
    }
    
    [self.iMsgDBMgr.iSysMsgDic setObject:[NSString stringWithFormat:@"%ld", (long)num] forKey:HAS_SYSTEM_MSG_DB_FLAG];
    
    [self.iMsgDBMgr saveDicWithMode:E_Msg_Message];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate showBadgeNumber];
    
}

//返回与多少条新消息
-(NSString*) newMessageNumber {
    NSString* res = @"0";
    if ([YXBTool getUserToken] == nil) {
        return res;
    }
    
    NSString* tmp = [self.iMsgDBMgr.iSysMsgDic objectForKey:HAS_SYSTEM_MSG_DB_FLAG];
    NSString* saveToken = [self.iMsgDBMgr.iSysMsgDic objectForKey:YXB_LOGIN_USER_TOKEN];
    
    if (tmp != nil && [tmp isEqualToString:@"0"] == NO && saveToken != nil && [saveToken isEqualToString:[YXBTool getUserToken]] == YES) {
        res = tmp;
    }

//    res = [NSString stringWithFormat:@"%d",arc4random() % 100];//随机数 假数据
//    res = @"10";
    return res;
}


-(BOOL) hasNewMessage {
    BOOL res = NO;
    
    if ([YXBTool getUserToken] == nil) {
        return NO;
    }
    
    NSString* tmp = [self.iMsgDBMgr.iSysMsgDic objectForKey:HAS_SYSTEM_MSG_DB_FLAG];
    NSString* saveToken = [self.iMsgDBMgr.iSysMsgDic objectForKey:YXB_LOGIN_USER_TOKEN];
    
    if (tmp != nil && [tmp isEqualToString:@"0"] == NO && saveToken != nil && [saveToken isEqualToString:[YXBTool getUserToken]] == YES) {
        res = YES;
    }
    
    return res;
}

-(BOOL) hasNewFriend {
    BOOL res = NO;
    
    if ([YXBTool getUserToken] == nil) {
        return NO;
    }
    
    NSString* tmp = [self.iMsgDBMgr.iSysMsgDic objectForKey:HAS_NEW_ATME_MSG];
    NSString* saveToken = [self.iMsgDBMgr.iSysMsgDic objectForKey:YXB_LOGIN_USER_TOKEN];
    
    if (tmp != nil && [tmp isEqualToString:@"0"] == NO && saveToken != nil && [saveToken isEqualToString:[YXBTool getUserToken]] == YES) {
        res = YES;
    }
    
    return res;
}


-(void) removeMessgae {
    
    if ([YXBTool getUserToken] == nil) {
        return;
    }
    
    
    NSString* tmp = [self.iMsgDBMgr.iSysMsgDic objectForKey:HAS_SYSTEM_MSG_DB_FLAG];
    NSInteger tttt = 0;
    if (tmp != nil) {
        tttt = [tmp integerValue] - 1;
    }
    if (tttt <= 0) {
        tttt = 0;
    }
    
    [self.iMsgDBMgr.iSysMsgDic setObject:[NSString stringWithFormat:@"%ld", (long)tttt] forKey:HAS_SYSTEM_MSG_DB_FLAG];
    [self.iMsgDBMgr saveDicWithMode:E_Msg_Message];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate showBadgeNumber];
    
}

-(void) removeFriend {
    [self.iMsgDBMgr.iSysMsgDic removeObjectForKey:HAS_NEW_ATME_MSG];
    [self.iMsgDBMgr saveDicWithMode:E_Msg_Friend];
}



@end
