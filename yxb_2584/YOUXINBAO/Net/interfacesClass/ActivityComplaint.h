#import <Foundation/Foundation.h>
#import "BaseData.h"


@interface ActivityComplaint : BaseData

@property (nonatomic, assign) NSInteger id;

/**
 * 活动id
 */

@property (nonatomic, assign) NSInteger activityId;

/**
 * 参与用户id
 */

@property (nonatomic, assign) NSInteger userId;

/**
 * field 投诉内容
 */

@property (nonatomic, strong) NSString* content;

/**
 * field 主题
 */

@property (nonatomic, strong) NSString* topic;

/**
 * field 投诉时间
 */

@property (nonatomic, strong) NSString * complaintDate;

/**
 * field 处理进度 1->处理中; 2->已处理; 3->处理失败; 4->处理成功;
 */

@property (nonatomic, assign) NSInteger status;

/**
 * field 受理结果
 */

@property (nonatomic, strong) NSString* result;

/**
 * field 预留
 */

@property (nonatomic, assign) NSInteger type;

/**
 * field 真实姓名
 */
@property (nonatomic, copy) NSString * realname;

/**
 * field 昵称
 */
@property (nonatomic,copy) NSString * nickname;

@end
