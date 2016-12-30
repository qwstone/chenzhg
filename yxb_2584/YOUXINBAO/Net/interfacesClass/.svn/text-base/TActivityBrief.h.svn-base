//
//  TActivityBrief.h
//  YOUXINBAO
//
//  Created by CH10 on 15/3/18.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BaseData.h"
#import "TActivityMember.h"

@interface TActivityBrief : BaseData

/**
 * identifier field
 */

@property (nonatomic,assign) NSInteger t_id;


/**  field  auto_increment */


/**
 * field  错误编号
 */

@property (nonatomic,assign) NSInteger errCode;

/**
 * field  错误提示
 */

@property (nonatomic,copy) NSString * errString;

/**
 * field 活动分类
 */

@property (nonatomic,assign) NSInteger category;
//    private FilterOtherCategory category;

/**
 * field  主题
 */

@property (nonatomic,copy) NSString * topic;

/**
 * field  活动时间
 */

@property (nonatomic,copy) NSString * activityDate;

/**
 * field  星期
 */

@property (nonatomic,assign) NSInteger weekday;


/**
 * field  位置名称
 */

@property (nonatomic,copy) NSString * destName;


/**
 * field  参与人数
 */

@property (nonatomic,assign) NSInteger participantsCount;

/**
 * field  人数上限
 */

@property (nonatomic,assign) NSInteger capacity;


/**
 * field  活动预览图片
 */

@property (nonatomic,copy) NSString * previewPic;


/**
 * field 筛选分类显示
 * 我的活动
 *      0->全部;1->审核中;2->未通过;3->我发起(已通过);4->已取消;5->已结束;6->受邀请;7->已报名;8->已退出
 */

@property (nonatomic,assign) NSInteger filterCategory;
//    private FilterMyCategory filterCategory;

/**
 * field  距离
 */

@property (nonatomic,copy) NSString * distance;

@property (nonatomic,assign)NSInteger status;

@end
