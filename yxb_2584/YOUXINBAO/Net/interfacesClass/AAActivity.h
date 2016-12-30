#import <Foundation/Foundation.h>
#import "BaseData.h"

typedef enum {
    /**
     * 审核中
     */
    A_CHECKING = 520, // 0
    
    /**
     * 未通过
     */
    A_REJECTED = 490, // 1
    
    /**
     * 已通过（我发起）
     */
    A_PASSED = 500, // 2
    
    /**
     * 已开始
     */
    A_STARTED = 600, // 3
    /**
     * 已取消
     */
    A_CANCELED = 400, // 4
    
    /**
     * 已结束
     */
    A_FINISHED = 300, // 5
    
}activityState;

typedef enum {
    /**
     * 游客
     */
    
    M_Vistor, // 0
    
    
    /**
     * 发起者
     */
    M_CREATED, // 1
    
    /**
     * 受邀请
     */
    M_BEINVITED, // 2
    
    /**
     * 已报名
     */
    M_REGISTERED, // 3
    //ACCEPTED("已报名"), // 2
    
    /**
     * 已签到
     */
    M_CHECKIN, // 4
    //PARTICIPATED("已签到"), // 3
    
    /**
     * 已退出
     */
    M_QUIT, // 5
    
    /**
     * 被拒绝
     */
    M_REJECTED, // 6
    
    /**
     * 已投诉
     */
    M_LODGE, // 6
    
}StatusStyle;


@interface AAActivity : BaseData

@property (nonatomic, assign) NSInteger t_id;

/**
 * field 错误编号
 */

@property (nonatomic, assign) NSInteger errCode;

/**
 * field 错误提示
 */

@property (nonatomic, strong) NSString* errString;

/**
 * field 发起人
 */

@property (nonatomic, strong) NSString* creator;

/**
 * field 发起人
 */

@property (nonatomic, strong) NSString* creatorToken;
@property (nonatomic, strong) NSString* mobile;

/**
 * field 活动分类 0->全部;1->其他;2->吃喝聚会;3->K歌娱乐;4->体育运动;5->交友派对;6->学习分享;7->户外旅游
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
 * field 星期
 */

@property (nonatomic, assign) NSInteger weekday;

/**
 * field 创建时间
 */

@property (nonatomic, strong) NSString* createDate;

/**
 * field 最后修改时间
 */

@property (nonatomic, strong) NSString* lastModifyDate;

/**
 * field 位置名称
 */

@property (nonatomic, strong) NSString* destName;

/**
 * field 位置经度
 */

@property (nonatomic, strong) NSString* destLongitude;

/**
 * field 位置纬度
 */

@property (nonatomic, strong) NSString* destLatitude;

/**
 * field 参与人User列表
 */

@property (nonatomic, strong) NSMutableArray* participants;

/**
 * field 投诉信息列表
 */

@property (nonatomic, strong) NSMutableArray* complaints;

/**
 * field 地图URL
 */

@property (nonatomic, strong) NSString* mapAddr;

/**
 * field 参与人数
 */

@property (nonatomic, assign) NSInteger participantsCount;

/**
 * field 人数上限
 */

@property (nonatomic, assign) NSInteger capacity;

/**
 * field 可见类型
 */

@property (nonatomic, assign) NSInteger showType;

/**
 * field 人均费用 0免费
 */

@property (nonatomic, strong) NSString * avgCost;

/**
 * field 活动预览图片列表
 */

@property (nonatomic, strong) NSString* previewPics;

/**
 * field 活动结束图片列表
 */

@property (nonatomic, strong) NSString* postWallPics;

/**
 * field 活动详情
 */

@property (nonatomic, strong) NSString* detail;

/**
 * field 活动状态 520->审核中; 490->审核失败; 500->活动未开始; 600->活动进行中; 400->活动取消;
 * 300->活动结束
 */

@property (nonatomic, assign) NSInteger status;

/**
 * 我在该活动中的状态 1我参与的 2受邀请 3被拒绝 4 我发起
 */

@property (nonatomic, assign) NSInteger myMemberStatus;

/**
 * field 距离
 */

@property (nonatomic, strong) NSString* distance;

/**
 * 聊天组id
 */

@property (nonatomic, strong) NSString* chatId;

/**
 * 聊天组name
 */

@property (nonatomic, strong) NSString* chatName;

/**
 * 图片数量
 *
 * @return
 */

@property (nonatomic, assign) NSInteger picCount;

/**
 * 人数下限
 *
 * @return
 */

@property (nonatomic, assign) NSInteger limit;

/**
 * field 浏览次数
 */

@property (nonatomic, assign) NSInteger readCount;

/**
 * field 分享次数
 */

@property (nonatomic, assign) NSInteger shareCount;

/** 签到状态 1->已发起，2->受邀请，3->已报名，4->已签到，5->已退出，6->被拒绝 */

@property (nonatomic, assign) NSInteger type;

/**
 * field 投诉标示 0->没有投诉;1->被投诉;
 */

@property (nonatomic, assign) NSInteger ctFlag;

/**
 * field 活动发起者头像地址
 */

@property (nonatomic, strong) NSString* iconAddr;

/**
 * 是否显示电话
 */

@property (nonatomic, assign) NSInteger showMobile;

/**
 * field 支付方式  1 免费; 2 预付费; 3 后付费
 */
@property (nonatomic, assign) NSInteger payType;

/**
 * 活动展示图片
 */
@property (nonatomic, strong) NSString * iconPic;

/**
 * field 参加人员付费方式 1 免费; 2 预付费; 3 后付费
 */
@property (nonatomic,assign) NSInteger memberPayType;

/**
 * 借条还款状态 1 已还, 2 未还
 */
@property (nonatomic,assign) NSInteger loanStatus;

/**
 * 跳转ID
 */
@property (nonatomic,assign) NSInteger jumpId;

/**
 * 性别  0->女 | 1->男
 */
@property (nonatomic,assign) NSInteger gender;

//获取星期
-(NSString *)getActivityWeekDay;

@end
