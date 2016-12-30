//
//  TActivity.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BaseData.h"
#import "TActivityMember.h"
#import "AAActivity.h"



@interface TActivity : BaseData


/**
 * identifier field
 */

@property NSInteger t_id;


/**  field  auto_increment */


/**
 * field  错误编号
 */

@property (nonatomic,assign) NSInteger errCode;

/**
 * field  错误提示
 */

@property (nonatomic,retain) NSString * errString;

/**
 * field 发起人
 */

@property (nonatomic,copy) NSString * creator;

/**
 * field 活动分类
 */

@property (nonatomic,assign) NSInteger category;
//    private FilterOtherCategory category;

/**
 * field  主题
 */

@property (nonatomic,retain) NSString  * topic;

/**
 * field  活动时间
 */

@property (nonatomic,retain) NSString * activityDate;

/**
 * field  星期
 */

@property (nonatomic,assign) NSInteger weekday;
//    private Weekday weekday;

/**
 * field  创建时间
 */

@property (nonatomic,retain) NSString * createDate;

/**
 * field  最后修改时间
 */

@property (nonatomic,retain) NSString * lastModifyDate;

/**
 * field  位置名称
 */

@property (nonatomic,retain) NSString * destName;

/**
 * field  位置经度
 */

@property (nonatomic,copy) NSString * destLongitude;

/**
 * field  位置纬度
 */

@property (nonatomic,copy) NSString *  destLatitude;

/**
 * field  参与人User列表
 */

@property (nonatomic,strong) NSArray * participants;

/**
 * field  参与人数
 */

@property (nonatomic,assign) NSInteger participantsCount;

/**
 * field  人数上限
 */

@property (nonatomic,assign) NSInteger capacity;


/**
 * field  可见类型
 */

@property (nonatomic,assign) NSInteger showType;
//    private ShowType showType;

///**
// * field  付费方式
// */
//
@property (nonatomic,assign) NSInteger payType;
//    private PayType payType;

/**
 * field  人均费用
 */

@property (nonatomic,copy) NSString * avgCost;

/**
 * field  活动预览图片列表
 */

@property (nonatomic,strong) NSArray * previewPics;

/**
 * field  活动结束图片列表
 */

@property (nonatomic,strong) NSArray * postWallPics;

/**
 * field  活动详情
 */

@property (nonatomic,retain) NSString * detail;

/**
 * field  活动状态
 */

@property (nonatomic,assign) activityState status;
//    private FilterMyCategory status;

/**
 * 我在该活动中的状态  1我参与的 2受邀请 3被拒绝 4 我发起
 */
@property (nonatomic,assign) StatusStyle myMemberStatus;
/**
 * field  距离
 */

@property (nonatomic,retain) NSString * distance;

/**
 * field  是否删除
 */

@property (nonatomic,assign) NSInteger showFlag;

/**
 * 聊天组id
 */
@property (nonatomic,copy) NSString * chatId;

/**
 * 聊天组name
 */
@property (nonatomic,copy) NSString * chatName;

@end
