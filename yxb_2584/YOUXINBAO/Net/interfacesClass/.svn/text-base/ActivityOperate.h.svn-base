#import <Foundation/Foundation.h>
#import "BaseData.h"

/**
 * 操作状态 结束活动 0 取消活动 1; 报名 2; 退出活动 3 拒绝活动 4; 活动签到 5; 分享活动 6 
 投诉活动 7;
 */
typedef enum{
    OPERATE_FINISH_ACTIVITY = 99,
    OPERATE_CANCEL_ACTIVITY = 1,
    OPERATE_PARTICIPANT_ACTIVITY = 2,
    OPERATE_QUIT_ACTIVITY = 3,
    OPERATE_REJECT_ACTIVITY = 4,
    OPERATE_CHECKIN_ACTIVITY =5,
    OPERATE_SHARE_ACTIVITY = 6,
    OPERATE_CT_ACTIVITY = 7
}E_OPERATE_ACTIVITY;

@interface ActivityOperate : BaseData

@property (nonatomic, assign) E_OPERATE_ACTIVITY OperateState;
/**
 * field 错误编号
 */
@property (nonatomic, assign) NSInteger errCode;
/**
 * field 错误提示
 */
@property (nonatomic, strong) NSString* errString;
/**
 * 活动id
 */
@property (nonatomic, assign) NSInteger activityID;
/**
 * 发起动作人的token
 */
@property (nonatomic, strong) NSString* operaterToken;
/**
 * 被拒绝用户的token
 */
@property (nonatomic, strong) NSString* rejectUserToken;
/**
 * 当前精度
 */
@property (nonatomic, strong) NSString* reqLongitude;
/**
 * 当前纬度
 */
@property (nonatomic, strong) NSString* reqLatitude;

@end
