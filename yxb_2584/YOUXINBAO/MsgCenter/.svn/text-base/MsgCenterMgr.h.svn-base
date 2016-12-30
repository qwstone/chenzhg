//
//  MsgCenterMgr.h
//  LotteryApp
//
//  Created by SKY on 13-10-29.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MsgDBMgr;
@class MsgHttpEngine;




//typedef enum {
//    // 1  是否有中奖方案
//    EMsgRequest_Prize_Mode = 1,
//    // 2  帖子是否有回复  - 是否有系统消息
//    EMsgRequest_Rply_Mode = 2,
//    // 4  是否有人回复评论
//    EMsgRequest_AtMe_Mode = 4,
//    // 8  是否关注的人有合买方案
//    EMsgRequest_AttTogeterBuy = 8,
//}TMsgRequestMode;

@interface MsgCenterMgr : NSObject {
    
    NSTimer* iCenterTimer;
    
    NSInteger iTimeTicker;
    
    
}

@property (retain, nonatomic) MsgHttpEngine* iMsgHttpEngine;

@property (retain, nonatomic) MsgDBMgr* iMsgDBMgr;
@property (retain, nonatomic) NSTimer* iCenterTimer;


+(MsgCenterMgr*) sharedInstance;

-(void) doGetMsgFlag;

@end
