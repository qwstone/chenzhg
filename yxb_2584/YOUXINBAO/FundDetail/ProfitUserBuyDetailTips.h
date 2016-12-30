#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface ProfitUserBuyDetailTips : BaseData


/**
* 当日购买时间
*/

@property (nonatomic, strong) NSString* time;

/**
* 档次购买金额
*/

@property (nonatomic, strong) NSString* money;

@end
