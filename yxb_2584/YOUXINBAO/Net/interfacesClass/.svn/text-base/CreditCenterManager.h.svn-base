//
//  CreditCenterManager.h
//  YOUXINBAO
//
//  Created by zjp on 15/10/30.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSkyArray.h"
@interface CreditCenterManager : NSObject


/**
 * 获取信用大厅排行榜(不包含 失信榜)
 *
 * @param userToken 用户token
 * @param categoryIndex 分类id 0->土豪榜; 1->人缘榜; 2->号召力榜; 3->义气榜; 4->活跃度;
 * @return
 */
- (NSSkyArray *)getTCreditCenterRankListByCategory:(NSString *)userToken categoryIndex:(NSInteger)categoryIndex;

/**
 * 获取失信榜记录列表
 *
 * @return
 */
- (NSSkyArray *)getAllTDishonestBoardRecord:(NSString *)userToken page:(NSInteger)page;


/**
 * 通过 身份证/手机号 查询信息榜记录
 * @param userToken 友信宝token
 * @param queryInfo 查询条件 （身份证/手机号）
 * @return
 */
- (NSSkyArray *)searchTDishonestBoardRecord:(NSString *)userToken queryInfo:(NSString *)queryInfo;

@end
