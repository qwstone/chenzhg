#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface ProfitUserBuyDetail : BaseData


/**
* 用户购买理财编号
*/

@property (nonatomic, assign) NSInteger userRegularID;

/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 购买日期
*/

@property (nonatomic, strong) NSString* startTime;

/**
* 结束日期
*/

@property (nonatomic, strong) NSString* endTime;

/**
* 累计收益
*/

@property (nonatomic, strong) NSString* accumulatedMoney;

/**
* 今日收益
*/

@property (nonatomic, strong) NSString* moneyPerDay;

/**
* 应该得到的总收益
*/

@property (nonatomic, strong) NSString* totleMoney;

/**
* 用户购买总金额
*/

@property (nonatomic, strong) NSString* buyMoney;

/**
* 名称
*/

@property (nonatomic, strong) NSString* name;

/**
* 产品周期
*/

@property (nonatomic, strong) NSString* time;

/**
* 已完成百分比
*/

@property (nonatomic, strong) NSString* finishPercent;

/**
* 当天购买时间列表,服务器一次性给全
*/

@property (nonatomic, strong) NSMutableArray* iProfitUserBuyDetailTips;

@end
