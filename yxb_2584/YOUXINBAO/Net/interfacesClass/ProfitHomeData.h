#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface ProfitHomeData : BaseData


/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 利率
*/

@property (nonatomic, strong) NSString* interestRate;

/**
* 是否显示更多理财按钮 “1” 显示 “0” 不显示
*/

@property (nonatomic, strong) NSString* hasMoreProfit;

/**
* 账户总额
*/

@property (nonatomic, strong) NSString* moneyOfAccount;

/**
* 红包显示
*/

@property (nonatomic, strong) NSMutableArray* iProfitDetailOfMonth;

@end
