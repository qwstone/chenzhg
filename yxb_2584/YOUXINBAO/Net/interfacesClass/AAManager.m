//
//  AAManager.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAManager.h"
#import "AALoanDetail.h"

@implementation AAManager

/**
 * 用户参与活动拒绝活动取消活动等操作
 *
 * @param ao
 * @return
 *
 * @author SKY
 * @date 2015年5月8日
 */
-(AAActivity*)__yxb_service__userActivityOperate:(ActivityOperate *)ao
{
    return [[AAActivity alloc] init];
}

/**
 * 获取活动结束图片列表
 *
 * @param activityId
 * @return
 */
-(NSSkyArray*)getPostWallPics:(NSInteger)activityId
{
    return [[NSSkyArray alloc] init];
}

/**
 * 编辑活动
 * @param activity
 * @return
 */
-(TResultSet*) __yxb_service__updateTActivity:(AAActivity*) activity {
    return [[TResultSet alloc] init];
}

/**
 * 创建新活动
 *
 * @param activity
 * @return
 */
-(TResultSet *)__yxb_service__createTActivity:(AAActivity *) activity
{
    return [[TResultSet alloc] init];
}

/**
 *
 *
 * @param userId
 *            用户id
 * @param tagType
 *            标签 0->附近活动; 1->好友活动; 2->我的活动;
 * @param localLongitude
 *            地理位置-经度
 * @param localLatitude
 *            地理位置-纬度
 * @param categoryType
 *            0->全部;1->其他;2->吃喝聚会;3->K歌娱乐;4->体育运动;5->交友派对;6->学习分享;7->户外旅游
 *            活动状态 520->审核中; 490->审核失败; 500->活动未开始; 600->活动进行中; 400->活动取消;
 *            300->活动结束
 * @param dateType
 *            日期类型 0->全部;1->今天;2->明天;3->周末
 * @param keyword
 *            关键字
 * @param page
 *            分页
 * @param payType
 *            0 全部 1我参与的 2受邀请 3被拒绝 4 我发起
 * @param costType
 *            0 免费 1 付费
 * @return
 */
-(NSSkyArray *)getTActivityListWGS84:(NSString *) userToken tagType:(NSInteger)tagType localLongitude:(NSString *)localLongitude  localLatitude:(NSString *)localLatitude categoryType:(NSInteger)categoryType  dateType:(NSInteger)dateType keyword:(NSString *)keyword page:(NSInteger)page payType:(NSInteger)payType costType:(NSInteger)costType gpsStatus:(NSInteger)gpsStatus
{
    return [[NSSkyArray alloc] init];
}

/**
 * 邀请好友参加活动
 *
 * @param userToken
 *            用户token
 * @param activityId
 *            活动id
 * @param userIdStr
 *            用户id数组 以,分割
 * @return
 */

-(TResultSet *)addTActivityInviteeList:(NSString *)userToken activityId:(NSInteger)activityId userIdStr:(NSString *)userIdStr
{
    return [[TResultSet alloc] init];
}

/**
 * 获取某个AAActivity详情
 *
 * @param userToken
 *            登录用户token
 * @param AAActivityID
 *            AAActivityID
 * @return
 *
 * @author SKY
 * @date 2015年5月9日
 */
-(AAActivity *)getAAActivityDetail:(NSString *)userToken  AAActivityID:(NSInteger)AAActivityID
{
    return [[AAActivity alloc] init];
}

/**
 * 存储结束图片URL
 * @param userToken   上传用户TOKEN
 * @param url         图片URL
 * @param activityId  活动ID
 * @return
 */
- (AAActivity*)createPostWallPics:(NSString *)userToken url:(NSString *)url activityId:(NSInteger)activityId {
    return [[AAActivity alloc] init];
}

/**
 * 获取AA活动借条列表
 *
 * @param userToken
 *            上传用户TOKEN
 * @param page
 *            分页
 * @return
 *
 * @author SKY
 * @date 2015年6月30日
 */
- (NSSkyArray *)getAALoanList:(NSString *)userToken page:(NSInteger)page{
   return [[NSSkyArray alloc] init];

}

/**
 * 获取AA活动图片墙
 * @param userToken
 * @param activityId
 * @return
 */
- (TResultSet *)getPictureWall:(NSString *)userToken activityId:(NSInteger)activityId {
    return [[TResultSet alloc] init];
}

/**
 * 获取AA活动某一条借条的详情
 *
 * @param userToken
 * @param AALoanID
 *            借条ID
 * @return
 *
 * @author SKY
 * @date 2015年6月30日
 */
-(AALoanDetail *) getAALoanDetail:(NSString *) userToken AALoanID:(NSInteger) AALoanID{
    return [[AALoanDetail alloc]init];

}

/**
 * 获取CA 借条展示数据
 *
 * @param userToken
 * @param loanID
 * @return
 *
 * @author SKY
 * @date 2015年6月30日
 */
- (TLoanOfAAActivity *)getTLoanOfAAActivity:(NSString *)userToken loanID:(NSInteger)loanID {
    return [[TLoanOfAAActivity alloc] init];
}


- (TLoanOfAAActivity *)closeTLoanOfAAActivity:(NSString *)userToken loanID:(NSInteger)loanID {
    return [[TLoanOfAAActivity alloc] init];
}
@end
