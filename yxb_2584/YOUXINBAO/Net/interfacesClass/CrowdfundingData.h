#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface CrowdfundingData : BaseData


/**
* 众筹担保单id
*/

@property (nonatomic, assign) NSInteger crowdfundingID;

/**
* 订单id
*/

@property (nonatomic, assign) NSInteger orderID;

/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 结束时间
*/

@property (nonatomic, strong) NSString* endTime;

/**
* 总金额
*/

@property (nonatomic, strong) NSString* sumMoney;

/**
* 已筹集金额
*/

@property (nonatomic, strong) NSString* finishMoney;

/**
* 逾期收益
*/

@property (nonatomic, strong) NSString* earningsMoney;

/**
* 期限
*/

@property (nonatomic, strong) NSString* deadline;

/**
* 还款方式
*/

@property (nonatomic, strong) NSString* modeOfRepayment;

/**
* 还款时间
*/

@property (nonatomic, strong) NSString* timeOfRepayment;

/**
* 已经参与众筹人员名单列表
*/

@property (nonatomic, strong) NSMutableArray* crowdfundingPerson;

@end
