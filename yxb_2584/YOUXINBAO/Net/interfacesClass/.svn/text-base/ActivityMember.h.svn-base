#import <Foundation/Foundation.h>
#import "BaseData.h"


@interface ActivityMember : BaseData

@property (nonatomic, assign) NSInteger id;

/** 活动id */
@property (nonatomic, assign) NSInteger activityId;

/** 参与用户id */
@property (nonatomic, assign) NSInteger userId;

/** 发起用户id */
@property (nonatomic, assign) NSInteger sponsorId;

/**
 * field 错误编号
 */
@property (nonatomic, assign) NSInteger errCode;

/**
 * field 错误提示
 */
@property (nonatomic, strong) NSString* errString;

/**
 * field 活动分类
 */
@property (nonatomic, assign) NSInteger category;

/**
 * field 主题
 */
@property (nonatomic, strong) NSString* topic;

/**
 * field 活动时间
 */
@property (nonatomic, strong) NSString* activityDate;

/**
 * field 星期 1->星期一，2->星期二，3->星期三，4->星期四，5->星期五，6->星期六，7->星期天，
 */
@property (nonatomic, assign) NSInteger weekday;

/**
 * field 活动状态 520->审核中; 490->审核失败; 500->活动未开始; 600->活动进行中; 400->活动取消;
 * 300->活动结束
 */
@property (nonatomic, assign) NSInteger status;

/**
 * 我在该活动中的状态 1我参与的 2受邀请 3被拒绝 4 我发起
 */
@property (nonatomic, assign) NSInteger myMemberStatus;
@property (nonatomic, strong) NSString* mobile;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, strong) NSString* ryId;

/**
 * field 融云token
 */
@property (nonatomic, strong) NSString* ryToken;

/**
 * field yxbToken
 */
@property (nonatomic, strong) NSString* yxbToken;

/**
 * field yxbId;
 */
@property (nonatomic, strong) NSString* yxbId;

/**
 * 头像地址
 */
@property (nonatomic, strong) NSString* iconAddr;
@property (nonatomic, strong) NSString* nickname;

/** 签到状态 1->已发起，2->受邀请，3->已报名，4->已签到，5->已退出，6->被拒绝 7->已投诉*/
@property (nonatomic, assign) NSInteger type;

/**
 * 已支付人数
 */
@property (nonatomic, assign) NSInteger payedCount;

/**
 * 总借条人数
 */
@property (nonatomic,assign) NSInteger loanCount;

/**
 * field  人均费用
 */
@property (nonatomic,assign) NSString * avgCost;

/**
 * 借条还款状态 1 已还, 2 未还
 */
@property (nonatomic, assign)NSInteger loanStatus;

/**
 * field 支付方式  1 免费; 2 预付费; 3 后付费
 */
@property (nonatomic,assign) NSInteger payType;

/**
 * 活动发起图片
 */
@property (nonatomic,strong) NSString * iconPic;

@end
