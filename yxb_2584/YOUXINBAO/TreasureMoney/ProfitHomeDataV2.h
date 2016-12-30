#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface ProfitHomeDataV2 : BaseData


/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 宝赚钱为多少用户提供理财
*/

@property (nonatomic, strong) NSString* peopleNum;

/**
* 宝赚钱总共提供的理财金额
*/

@property (nonatomic, strong) NSString* peopleMoney;

/**
* 昨日收益
*/

@property (nonatomic, strong) NSString* yestodayMoney;

/**
* 历史收益
*/

@property (nonatomic, strong) NSString* historyMoney;

/**
* 当前余额
*/

@property (nonatomic, strong) NSString* moneyOfAccount;

/**
* 万元收益
*/

@property (nonatomic, strong) NSString* profitOf10thousand;

/**
 * 利率
 */
@property (nonatomic, strong) NSString* interestRate;

/**
* 轮播内容
*/


@property (nonatomic, strong) NSMutableArray* iProfitBannerData;

@end
