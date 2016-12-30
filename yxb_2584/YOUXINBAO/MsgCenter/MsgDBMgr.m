//
//  MsgDBMgr.m
//  LotteryApp
//
//  Created by SKY on 13-10-29.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import "MsgDBMgr.h"
#import "AppDelegate.h"
#import "YXBTool.h"
#import "QCHomeDataManager.h"
//#import "CPBaoTool.h"

//存储系统变量的动态数组
#define MESSAGE_DATA_FILE_FOR_PRIZE      @"Message_Center_YXB.xml"


@implementation MsgDBMgr

@synthesize iSysMsgDic;

- (void)dealloc
{
//    self.iPrizeMsgDic = nil;
//    self.iBbsReplyMsgDic = nil;
    self.iSysMsgDic = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
//    self.iPrizeMsgDic = [self getDBDic:E_Msg_Message];
    self.iSysMsgDic = [self getDBDic:E_Msg_Friend];
    if (self) {
        
    }
    return self;
}
-(void)saveGameNewDisplay:(NSString *)game{

}

-(void) saveDicWithMode:(Tcpb_Msg_Mode)mode {
    NSString *file = nil;
    NSMutableDictionary* tmpSysConfig = nil;
    switch (mode) {
        case E_Msg_Friend:
        case E_Msg_Message: {
            file = [[YXBTool getDocumentPath] stringByAppendingPathComponent:MESSAGE_DATA_FILE_FOR_PRIZE];
            tmpSysConfig = self.iSysMsgDic;
            break;
        }
        default:
            break;
    }
    
    if (file == nil) {
        return;
    }
           
    @synchronized(self) {
        
        [tmpSysConfig retain];

        NSString *err = nil;
        NSMutableDictionary *saveConfig = [[NSMutableDictionary alloc] init];
        id key;
        NSEnumerator *enumerator = [tmpSysConfig keyEnumerator];
        while (key = [enumerator nextObject]) {
                [saveConfig setObject:[tmpSysConfig valueForKey:key] forKey:key];
        }
        NSData *pd = [NSPropertyListSerialization dataFromPropertyList:saveConfig format:NSPropertyListXMLFormat_v1_0 errorDescription:&err];
        if(nil == err)
            [pd writeToFile:file atomically:YES];
        [saveConfig release];
        [tmpSysConfig release];
    }
}



-(BOOL) needSaveWithDic:(NSDictionary*) dic key:(NSString*) key key2:key2 {
    BOOL res = NO;
    
    //key @"newMessage"
    
    NSString* value = [YXBTool jsonSaveGetStrWithDic:dic key:key];
    NSString* localValue = [self.iSysMsgDic objectForKey:key2];
    
    
    NSInteger tmp = 0;
    NSInteger tmp2 = 0;
    
    if (localValue != nil) {
        tmp = [localValue integerValue];
    }
    
    if (value != nil) {
        tmp2 = [value integerValue];
    }
    
    NSInteger tmp3 = tmp + tmp2;
    
//    if (([localValue isEqualToString:@"0"] || localValue == nil) && value != nil) {
//        [self.iSysMsgDic setObject:value  forKey:key2];
//        res = YES;
//    }

    [self.iSysMsgDic setObject:[NSString stringWithFormat:@"%ld", (long)tmp3]  forKey:key2];
    res = YES;
    
    return res;
}


-(void) parserMsgJsonDic:(NSDictionary*) dic {

    
    BOOL needSaveSysDic = NO;
    
    needSaveSysDic = [self needSaveWithDic:dic key:@"newMessage" key2:HAS_SYSTEM_MSG_DB_FLAG];
    needSaveSysDic = [self needSaveWithDic:dic key:@"newFriend" key2:HAS_NEW_ATME_MSG];
    
//    if ([YXBTool jsonSaveGetStrWithDic:dic key:@"newMessage"] != nil) {
//        
//    
//        NSString* value = [YXBTool jsonSaveGetStrWithDic:dic key:@"newMessage"];
//        NSString* localValue = [self.iSysMsgDic objectForKey:@"newMessage"];
//    
//        [self.iSysMsgDic setObject:[YXBTool jsonSaveGetStrWithDic:dic key:@"newMessage"]  forKey:HAS_SYSTEM_MSG_DB_FLAG];
//        needSaveSysDic = YES;
//    }
    
//    if ([YXBTool jsonSaveGetStrWithDic:dic key:@"newFriend"] != nil) {
//        [self.iSysMsgDic setObject:[YXBTool jsonSaveGetStrWithDic:dic key:@"newFriend"]  forKey:HAS_NEW_ATME_MSG];
//        needSaveSysDic = YES;
//    }
    
    if ([YXBTool jsonSaveGetStrWithDic:dic key:@"cookie"] != nil) {
        [self.iSysMsgDic setObject:[YXBTool jsonSaveGetStrWithDic:dic key:@"cookie"]  forKey:YXB_LOGIN_USER_COOKIE];
        needSaveSysDic = YES;
        [YXBTool replaceUserYXBCookieWithCookie:[self.iSysMsgDic objectForKey:YXB_LOGIN_USER_COOKIE]];
        
    }

    
    NSString* token = [YXBTool getUserToken];
    
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    if ([dic objectForKey:@"loan"] != nil) {
        NSObject* obj = [dic objectForKey:@"loan"];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary* objDic = (NSDictionary*) obj;
            [appDelegate showAlertViewWithdic:objDic type:@"loan"];
        }
    }
    if ([dic objectForKey:@"guarantee"] != nil) {
        NSObject* obj = [dic objectForKey:@"guarantee"];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary* objDic = (NSDictionary*) obj;
            [appDelegate showAlertViewWithdic:objDic type:@"guarantee"];
        }
    }
    if ([dic objectForKey:@"rateChange"] != nil) {
        NSObject* obj = [dic objectForKey:@"rateChange"];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary* objDic = (NSDictionary*) obj;
            [appDelegate showAlertViewWithdic:objDic type:@"rateChange"];
        }
    }
    
    if ([dic objectForKey:@"scoreChange"] != nil) {
        NSObject* obj = [dic objectForKey:@"scoreChange"];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary* objDic = (NSDictionary*) obj;
            [appDelegate showAlertViewWithdic:objDic type:@"scoreChange"];
        }
    }
    
    if ([dic objectForKey:@"loanDetail"] != nil) {
        NSObject* obj = [dic objectForKey:@"loanDetail"];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary* objDic = (NSDictionary*) obj;
            [appDelegate showAlertViewWithdic:objDic type:@"loanDetail"];
        }
    }
    
    if ([dic objectForKey:@"income"] != nil) {
        NSObject* obj = [dic objectForKey:@"income"];
        if ([obj isKindOfClass:[NSString class]]) {
            NSString* objDic = (NSString*) obj;
            [QCHomeDataManager sharedInstance].zuorishouyi = objDic;
        }
    }

//    NSDictionary* dic5 = @{@"newRate":@"BB", @"str1":@"已进入是新地图\n惜您的信用呵呵", @"str2":@"", @"str3":@"", @"type":@"2"};
//    [appDelegate showAlertViewWithdic:dic5 type:@"rateChange"];
    
//    NSDictionary* dic6 = @{@"newScore":@"5.1%", @"str1":@"您当前等级为AAA", @"str2":@"距离下次升级还差40%",  @"type":@"2",@"progress":@"2"};
//    [appDelegate showAlertViewWithdic:dic6 type:@"scoreChange"];
    
//    NSDictionary* ddd = @{@"mes":@"xxxx代付代付", @"mode":@"1", @"dataId":@"25"};
//    [appDelegate showAlertViewWithdic:ddd type:@"guarantee"];
//        NSDictionary* ddd = @{@"mes":@"xxxx代付代付", @"mode":@"2", @"dataId":@"12"};
//    [appDelegate showAlertViewWithdic:ddd type:@"guarantee"];
    
//    "mes":"xxx借了一笔钱","mode":"1","loanID":"652",loanQuickType:"1", isLoaner:"1"
//    NSDictionary* ddd = @{@"mes":@"xxx借了一笔钱", @"mode":@"2", @"loanID":@"1217",@"loanQuickType":@"1", @"isLoaner":@"1",@"loanFriendType":@"1"};
//    [appDelegate showAlertViewWithdic:ddd];
    
    
    if (token == nil || [token length] <= 0) {
        return;
    }
    
    [self.iSysMsgDic setObject:token  forKey:YXB_LOGIN_USER_TOKEN];
    
    if (needSaveSysDic == YES) {
        [self saveDicWithMode:E_Msg_Friend];
    }

}


-(void) cleanAllMsg {
//    [self.iPrizeMsgDic removeAllObjects];
    [self.iSysMsgDic removeAllObjects];
//    [self.iBbsReplyMsgDic removeAllObjects];
    [self saveDicWithMode:E_Msg_Message];
}

-(NSMutableDictionary*) getDBDic:(Tcpb_Msg_Mode) mode {
    NSString *file = nil;
    switch (mode) {
        case E_Msg_Friend:
        case E_Msg_Message: {
            file = [[YXBTool getDocumentPath] stringByAppendingPathComponent:MESSAGE_DATA_FILE_FOR_PRIZE];
            break;
        }
        default:
            break;
    }
    if (file == nil) {
        return nil;
    }
    
    NSMutableDictionary* tmpSysConfig = nil;
    if([[NSFileManager defaultManager] fileExistsAtPath:file]){
		
		NSData *d;
		NSPropertyListFormat format;
		d = [NSData dataWithContentsOfFile:file];
		tmpSysConfig =	[NSPropertyListSerialization propertyListFromData:d
													 mutabilityOption:NSPropertyListMutableContainers
															   format:&format
													 errorDescription:nil];
        
		if(tmpSysConfig == nil)
		{
			tmpSysConfig = [[[NSMutableDictionary alloc] init] autorelease];
		}
	}
	else
		tmpSysConfig = [[[NSMutableDictionary alloc] init] autorelease];

    return tmpSysConfig;
}

@end
