//
//  ProfitManagerV3.m
//  YOUXINBAO
//
//  Created by zjp on 15/12/14.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ProfitManagerV3.h"


@implementation ProfitManagerV3



/**
 * 宝赚钱3.0首页数据
 *
 * @param userToken
 * @return
 *
 * @author SKY
 * @date 2015年12月14日
 */
- (ProfitHomeDataV3*)getProfitHomeData:(NSString *)userToken {
    return [[ProfitHomeDataV3 alloc] init];
}
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
-(ProfitRegularDetail *)getProfitRegularDetail:(NSInteger)regularID{
    return [[ProfitRegularDetail alloc] init];
}
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
-(TResultSet *)buyProfit:(NSString *)userToken regularID:(NSInteger)regularID buyMoney:(NSString *)buyMoney{
    return [[TResultSet alloc] init];
}

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
-(ProfitUserBuyDetail *)getProfitUserBuyDetail:(NSString *)userToken userRegularID:(NSInteger)userRegularID
{
    return [[ProfitUserBuyDetail alloc] init];

}
- (NSSkyArray *)getNewProfitList:(NSString *)userToken pageNum:(NSInteger)pageNum year:(NSString *)year month:(NSString *)month{
    return [[NSSkyArray alloc]init];
}
- (NSSkyArray *)getProfitDepositList:(NSString *)userToken pageNum:(NSInteger)pageNum{
    return [[NSSkyArray alloc]init];
}
- (ProfitUserSummarize *)getProfitUserSummarize:(NSString *)userToken{


    return [[ProfitUserSummarize alloc]init];
}

@end
