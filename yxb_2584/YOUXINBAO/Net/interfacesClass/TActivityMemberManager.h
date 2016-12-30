//
//  TActivityMemberManager.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/31.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TResultSet.h"

@interface TActivityMemberManager : NSObject

//邀请好友
- (TResultSet *)addTActivityInviteeList:(NSInteger)userId activityId:(NSInteger)activityId List:(NSArray *)List;
//我要报名
- (TResultSet *)addTActivityParticipant:(NSInteger)userId activityId:(NSInteger)activityId;

//我要退出活动
- (TResultSet *)quitTActivityParticipant:(NSInteger)userId activityId:(NSInteger)activityId;
//拒绝活动报名
- (TResultSet *)rejectTActivityParticipant:(NSInteger)userId activityId:(NSInteger)activityId relatedId:(NSInteger)relatedId;

//我要签到
- (TResultSet*)checkInTActivityParticipant:(NSInteger)userId activityId:(NSInteger)activityId reqLongitude:(NSString*)reqLongitude reqLatitude:(NSString *)reqLatitude;

//替他签到
- (TResultSet *)checkInTActivityParticipantByCreator:(NSInteger)userId activityId:(NSInteger)activityId relatedId:(NSInteger)relatedId reqLongitude:(NSString*)reqLongitude reqLatitude:(NSString *)reqLatitude;
@end
