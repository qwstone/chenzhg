//
//  PushManager.h
//  LotteryApp
//
//  Created by SKY on 13-10-25.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSPushData : NSObject <UIAlertViewDelegate> {
    
}

@property (nonatomic, retain) NSString* title;


//参数
@property (nonatomic, retain) NSString* param;

//广告跳转方式
@property (nonatomic, retain) NSString* mode;


//对应的消息中心消息id
@property (nonatomic, retain) NSString* messageID;


@end

@interface PushManager : NSObject {
    int i;
    NSArray* aaaa;
    NSDictionary* pushDicDic;
    NSPushData* iNSPushData;
}

@property (nonatomic, retain) NSPushData* iNSPushData;
@property (nonatomic, retain) NSDictionary* pushDicDic;
//@property (nonatomic, retain)  NSDictionary* iPushDic；

-(void) dealPushDic:(NSDictionary*) dic appState:(NSInteger) state;

@end
