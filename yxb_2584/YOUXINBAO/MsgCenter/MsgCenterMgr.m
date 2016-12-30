//
//  MsgCenterMgr.m
//  LotteryApp
//
//  Created by SKY on 13-10-29.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import "MsgCenterMgr.h"
#import "MsgDBMgr.h"
//#import "CPB_Const.h"
#import "YXBTool.h"
#import "HttpRequest.h"
#import "SBJSON.h"
//#import "CPBaoTool.h"
#import "QCConfigTool.h"
#import "MsgCenterMgr+Public.h"
//#import "LotteryAcountInfo.h"
//#import "AppDelegate+Public.h"


@implementation MsgCenterMgr

#define JSPURL_ADDRESS @"mobile/mobileNotice.jsp"
//#define JSPURL_ADDRESS @"testNotice.jsp"
#define MsgCenterMgrTimeInterval 30.0f
//#define MsgCenterMgrTimeInterval 60.0f
//#define MsgCenterMgrTimeInterval 600.0f

static MsgCenterMgr *sharedMsgCenterMgr = nil;

@synthesize iMsgDBMgr;
@synthesize iCenterTimer;
@synthesize iMsgHttpEngine;

- (id)init
{
    self = [super init];
    if (self) {
        iTimeTicker = 0;
//        aaa = 1;
        self.iMsgDBMgr = [[MsgDBMgr alloc] init];
        self.iCenterTimer = [NSTimer scheduledTimerWithTimeInterval:MsgCenterMgrTimeInterval target:self selector:@selector(timeCallBack:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)timeCallBack:(NSTimer *)time {
//    NSLog(@"timeCallBack ");
    
//    if (YES) {
//        return;
//    }
    iTimeTicker++;
    
    if (iTimeTicker > 9999999) {
        iTimeTicker = 0;
    }
    
    [self doGetMsgFlag];
    
}



-(void) doGetMsgFlag {
    
    NSString* userName = [YXBTool getUserToken];
    if (userName == nil || [userName length] <= 0) {
        return;
    }
    
//    NSString* jsp = @"mobileNotice1.jsp";
//    jsp = @"testNotice.jsp";
    
//    NSString* url = [NSString stringWithFormat:@"%@%@?token=%@&v=%@&pt=%@", [QCConfigTool getHostUrl],  JSPURL_ADDRESS, userName, YXB_VERSION_CODE, CHANDLE_AK_ID];
    NSString *url = [YXBTool getURL:JSPURL_ADDRESS params:nil];
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"轮询url---%@",url);
    NSURL *requestURL = [NSURL URLWithString:url];

    HttpRequest *request = [HttpRequest requestWithURL:requestURL];
    __weak HttpRequest *requestWEAK = request;
    [QCConfigTool setHttpSystemHeaderWithRequest:request];
    [request setCompletionBlock:^{
        if ([requestWEAK.responseString length]) {
            
            NSLog(@"request.responseString = %@", requestWEAK.responseString);
            
            SBJSON *json = [[SBJSON alloc] init];
            id object = [json objectWithString:requestWEAK.responseString];
            NSString* userName = [YXBTool getUserToken];
            NSString* dbUser = [self.iMsgDBMgr.iSysMsgDic objectForKey:YXB_LOGIN_USER_TOKEN];
            if (userName != nil && [userName isEqualToString:dbUser] == NO) {
                //不是同一个用户的数据存储
                [self.iMsgDBMgr cleanAllMsg];
            }
            
            if (object != nil && [object isKindOfClass:[NSDictionary class]]) {
                [self.iMsgDBMgr parserMsgJsonDic:object];
            }
            
            
        }
    }];
    [request setFailedBlock:^{
//        YD_LOG(@"requestFailed %@", request.responseString);
        NSLog(@"requestFailed %@", requestWEAK.responseString);
    }];
    [request startAsynchronous];
//    NSLog(@"%@",request.requestHeaders);
}

- (void)dealloc
{
    [self.iCenterTimer invalidate];
    self.iCenterTimer = nil;
    self.iMsgDBMgr = nil;
//    [super dealloc];
}

+(MsgCenterMgr*) sharedInstance {
    @synchronized (self)
    {
        if (sharedMsgCenterMgr == nil)
        {
            sharedMsgCenterMgr = [[self alloc] init];
        }
    }
    return sharedMsgCenterMgr;
}

@end
