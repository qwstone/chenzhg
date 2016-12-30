//
//  TActivityBriefManager.h
//  YOUXINBAO
//
//  Created by CH10 on 15/3/18.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TActivityBriefManager : NSObject

/**
 *
 * @param tagType           标签 0->附近活动; 1->好友活动; 2->我的活动;
 * @param localLongitude    地理位置-经度
 * @param localLatitude     地理位置-纬度
 * @param categoryType           活动类型
 *                              附近活动/好友活动
 *                                  0->全部;1->其他;2->吃喝聚会;3->K歌娱乐;4->体育运动;5->交友派对;6->学习分享;7->户外旅游
 *                              我的活动
 *                                  0->全部;1->审核中;2->未通过;3->我发起(已通过);4->已取消;5->已结束;6->受邀请;7->已报名;8->已退出
 * @param dateType          日期类型
 *                              0->全部;1->今天;2->明天;3->周末
 * @param keyword           关键字
 * @param page              页数 > 0
 * @return
 */
- (NSArray *)getTActivityListWGS84:(NSInteger)userId tagType:(NSInteger)index longitude:(NSString *)localLongitude latitude:(NSString *)localLatitude categoryType:(NSInteger)categoryType dateType:(NSInteger)dateType   keyword:(NSString *)keyword page:(NSInteger)page;

@end
