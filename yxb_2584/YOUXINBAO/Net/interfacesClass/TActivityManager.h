//
//  TActivityManager.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TActivity.h"
#import "TResultSet.h"

@interface TActivityManager : NSObject

//- (TActivity *)getTActivityList:(NSInteger)index page:(NSInteger)page;
//- (TActivity *)getTActivityListNearBy:(double)localLongitude localLatitude:(double)localLatitude page:(NSInteger)page;
//    public TActivity[] getAllTActivity(int from, int size);


/**
 * 获取活动详情
 * @param userId        用户id
 * @param activityId    活动id
 * @param tagType       标签 0->附近活动; 1->好友活动; 2->我的活动;
 * @return
 */
- (TActivity *)getTActivityById:(NSInteger)userId activityId:(NSInteger)activityId tagType:(NSInteger)tagType;

//结束活动
- (TResultSet *)finishTActivity:(NSInteger)userId activityId:(NSInteger)activityId;

//取消活动
- (TResultSet *)cancelTActivity:(NSInteger)userId activityId:(NSInteger)activityId;
/**
 * 创建活动
 *
 * @param userId        用户id
 * @param category      活动分类    1->其他;2->吃喝聚会;3->K歌娱乐;4->体育运动;5->交友派对;6->学习分享;7->户外旅游
 * @param activityDate  活动时间
 * @param topic         主题
 * @param destName      位置名称
 * @param destLongitude 位置经度
 * @param destLatitude  位置纬度
 * @param capacity      人数上限
 * @param showType      可见类型    全部可见->0; 好友可见->1; 秘密邀请->2;
 * @param femaleFee     女生费用    收费->0; 免费->1;
 * @param payType       付费方式    预付费->0; 后付费->1; 全部免费->2; 女生免费;
 * @param avgCost       人均费用
 * @param picCount      上传图片张数
 */

- (TResultSet *)createTActivity:(NSInteger)userId category:(NSInteger)category activityDate:(NSString *)activityDate topic:(NSString *)topic destName:(NSString *)destName destLongitude:(NSString *)destLongitude destLatitude:(NSString *)destLatitude capacity:(NSInteger)capacity showType:(NSInteger)showType payType:(NSInteger)payType femaleFee:(NSInteger)femaleFee avgCost:(NSString *)avgCost detail:(NSString *)detail picCount:(NSInteger)picCount;


- (TResultSet *)createTActivityNew:(NSString *)str arrr:(NSArray *)array;
@end
