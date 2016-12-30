//
//  MsgDBMgr.h
//  LotteryApp
//
//  Created by SKY on 13-10-29.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import <Foundation/Foundation.h>



//新消息
#define HAS_SYSTEM_MSG_DB_FLAG @"Has_SYsTemMsG"

//新好友
#define HAS_NEW_ATME_MSG @"Has_nEw_At_Me_mSg"


//登录token
#define YXB_LOGIN_USER_TOKEN @"YXB_LOgin_USER_TOKEN"

//新cookie
#define YXB_LOGIN_USER_COOKIE @"YXB_LOgin_USER_COOKIE"


typedef enum {
    //新的消息中心消息
    E_Msg_Message = 100,
    //新的好友消息
    E_Msg_Friend,
}Tcpb_Msg_Mode;

//typedef enum {
//    E_Msg_Icon_Mycpb = 200,
//    E_Msg_Icon_MyShuoSHuo,
//}Tcpb_Msg_Icon_Dispaley_Mode;

@interface MsgDBMgr : NSObject {
    
}

//@property (retain, nonatomic) NSMutableDictionary* iPrizeMsgDic;
@property (retain, nonatomic) NSMutableDictionary* iSysMsgDic;
//@property (retain, nonatomic) NSMutableDictionary* iBbsReplyMsgDic;


-(void) saveDicWithMode:(Tcpb_Msg_Mode)mode;


-(void) cleanAllMsg;

-(void) parserMsgJsonDic:(NSDictionary*) dic;


-(void) saveGameNewDisplay:(NSString*) game;

@end
