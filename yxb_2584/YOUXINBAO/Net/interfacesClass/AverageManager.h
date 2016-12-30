//
//  AverageManager.h
//  YOUXINBAO
//
//  Created by Walice on 15/6/19.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSkyArray.h"
#import "TResultSet.h"
#import "GatheringRecordDetail.h"

@interface AverageManager : NSObject
/**
 * 获取收款记录
 *
 * @param userToken
 * @param pageNum
 * @return
 *
 * @author SKY
 * @date 2015年6月19日
 */
-(NSSkyArray *)getGatheringRecordList:(NSString *)userToken pageNum:(NSInteger)pageNum;

/**
 * 获取AA收款详情页面
 *
 * @param userToken
 * @param recordID
 *            收款id
 * @return
 *
 * @author SKY
 * @date 2015年6月19日
 */
-(GatheringRecordDetail *)getGatheringRecordDetail:(NSString *)userToken
                                          recordID:(NSInteger)recordID;
/**
 * 发起AA收款/退款
 *
 * @param userToken
 *            发起人
 * @param title
 *            主题
 * @param sumPeople
 *            总人数
 * @param sumMoney
 *            总金额
 * @param descript
 *            描述
 * @param mode
 *            1代表收款 2代表退款 *
 * @param tokenArr
 *            参与人 token1|token2 中间以|分隔
 * @return
 *
 * @author SKY
 * @date 2015年6月19日
 */

- (TResultSet*)createAAAverage:(NSString *)userToken title:(NSString *)title sumPeople:( NSInteger)sumPeople sumMoney:(NSInteger)sumMoney descript:(NSString *)descript mode:(NSInteger)mode tokenArr:(NSString *)tokenArr couponId:(NSInteger)couponId;
/**
 * 付款
 * @param userToken
 * @param recordID
 * @return
 */
- (TResultSet *)payAAAverage:(NSString *)userToken recordID:(NSInteger)recordID;

/**
 * 关闭AA收款
 * @param userToken
 * @param recordID
 * @return
 */
- (TResultSet *) closeAAAverage:(NSString *)userToken recordID:(NSInteger) recordID;
@end
