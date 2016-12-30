#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface GuaranteeStages : BaseData


/**
* 应还时间
*/

@property (nonatomic, strong) NSString* shouldPayTime;

/**
* 实际支付时间
*/

@property (nonatomic, strong) NSString* actualPayTime;

/**
* 支付金额
*/

@property (nonatomic, strong) NSString* payMoney;

/**
* 是否逾期   1是， 0否。
*/

@property (nonatomic, strong) NSString* hasOverdue;

/**
 * 是否代付  1是， 0否。
 */

@property (nonatomic, strong) NSString* hasHelpPay;


/**
* 是否已经还款完成     1是， 0否。
*/

@property (nonatomic, strong) NSString* hasPayCompleted;

@end
