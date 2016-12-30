#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface CommercePayment : BaseData


/**
* 购买人token
*/

@property (nonatomic, strong) NSString* userToken;

/**
* 购买的商品ID
*/

@property (nonatomic, assign) NSInteger commerceID;

/**
* 首付百分比 例如 "10" "90" 没有%
*/

@property (nonatomic, strong) NSString* downPayment;

/**
* 分多少期次
*/

@property (nonatomic, assign) NSInteger stagesNum;

/**
* 对应分期应付的利息百分比 例如 "0.18"
*/

@property (nonatomic, strong) NSString* interest;

/**
* 每月应还金额，由客户端计算，服务器做校验
*/

@property (nonatomic, strong) NSString* stagesMoney;

/**
* 首付金额，由客户端计算，服务器做校验
*/

@property (nonatomic, strong) NSString* downPaymentMoney;

@end
