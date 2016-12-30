#import <Foundation/Foundation.h> 
#import "BaseData.h"
#import "LoanCenterConfig.h"

@interface AALoan : BaseData


/**
* aa 借条id
*/

@property (nonatomic, assign) NSInteger AALoanID;

/**
* 借条发起状态 1 我发起的 2我参与的
*/

@property (nonatomic, assign) LoanCenterState stateOfInitiator;

/**
* 账单状态 1已经还款 2未还款 3已收齐 4未收齐
*/

@property (nonatomic, assign) LoanCenterPay stateOfAmount;

/**
* 总人数
*/

@property (nonatomic, assign) NSInteger sumPeople;

/**
* 已还款人数
*/

@property (nonatomic, assign) NSInteger alreadyPayPeople;

/**
* 标题
*/

@property (nonatomic, strong) NSString* title;

/**
* 金额
*/

@property (nonatomic, strong) NSString* money;

/**
* 时间
*/

@property (nonatomic, strong) NSString* time;

/**
* 图片http url地址
*/

@property (nonatomic, strong) NSString* imageUrl;

@end
