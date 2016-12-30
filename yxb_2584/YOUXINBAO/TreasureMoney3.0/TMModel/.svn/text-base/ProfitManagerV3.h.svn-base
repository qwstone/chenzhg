//
//  ProfitManagerV3.h
//  YOUXINBAO
//
//  Created by zjp on 15/12/14.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfitHomeDataV3.h"
#import "ProfitUserBuyDetail.h"
#import "ProfitRegularDetail.h"
#import "TResultSet.h"
#import "NSSkyArray.h"
#import "ProfitUserSummarize.h"
@interface ProfitManagerV3 : NSObject


/**
 * 宝赚钱3.0首页数据
 *
 * @param userToken
 * @return
 *
 * @author SKY
 * @date 2015年12月14日
 */
- (ProfitHomeDataV3*)getProfitHomeData:(NSString *)userToken;

/**
 * 获取用户购买的理财明细,立即用户购买的某个理财产品的具体情况页面
 *
 * @param userToken
 * @param userRegularID
 *            用户购买id
 * @return
 *
 * @author SKY
 * @date 2015年12月14日
 */
-(ProfitUserBuyDetail *)getProfitUserBuyDetail:(NSString *)userToken userRegularID:(NSInteger)userRegularID;

/**
 * 获取定期赚钱明细,即用户购买理财页面数据
 *
 * @param regularID
 *            宝赚钱ID
 * @return
 *
 * @author SKY
 * @date 2015年12月14日
 */
-(ProfitRegularDetail *)getProfitRegularDetail:(NSInteger)regularID;

/**
 * 购买宝赚钱理财
 *
 * @param userToken
 * @param regularID
 *            宝赚钱X号 id
 * @param buyMoney
 *            用户购买金额(必须为100的整数倍)
 * @return
 *
 * @author SKY
 * @date 2015年12月14日
 */
-(TResultSet *)buyProfit:(NSString *)userToken regularID:(NSInteger)regularID buyMoney:(NSString *)buyMoney;

/**
 * 获取红包记录(同V2接口没有变化)
 *
 * @param userToken
 *            用户token
 * @param pageNum
 *            页面索引
 * @param year
 *            请求年
 * @param month
 *            请求月
 * @return ProfitListItemV2类的TList数据
 *
 * @author SKY
 * @date 2015年12月14日
 */

- (NSSkyArray *)getNewProfitList:(NSString *)userToken pageNum:(NSInteger)pageNum year:(NSString *)year month:(NSString *)year;
/**
 * 获取理财赚钱记录
 *
 * @param userToken
 *            用户token
 * @param pageNum
 *            页面索引
 *
 * @return ProfitDepositListItem类的TList数据
 *
 * @author SKY
 * @date 2015年12月14日
 */
- (NSSkyArray *)getProfitDepositList:(NSString *)userToken pageNum:(NSInteger)pageNum;

/**
 * 获取用户我的账本页面的 明日预期数据等收益
 *
 * @param userToken
 * @return
 *
 * @author SKY
 * @date 2015年12月14日
 */
- (ProfitUserSummarize *)getProfitUserSummarize:(NSString *)userToken;

@end
