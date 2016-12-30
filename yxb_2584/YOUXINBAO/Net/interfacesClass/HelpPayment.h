#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface HelpPayment : BaseData


/**
* 代付单ID
*/

@property (nonatomic, assign) NSInteger helpPaymentId;

/**
 * 代付单状态  代付状态 100 代付款; 200  已付款; 300 已关闭(已付款); 400  已关闭（拒绝代付）
 */
@property (nonatomic, assign) NSInteger helpPaymentStatus;

/**
* 代付金额
*/

@property (nonatomic, strong) NSString* helpPayMoney;

/**
 * field 错误提示
 */

@property (nonatomic, strong) NSString* errString;
/**
* 申请人
*/

@property (nonatomic, strong) NSString* helpPayUser;

/**
* 代付说明
*/

@property (nonatomic, strong) NSString* helpPayDeclare;

/**
* 发起时间
*/

@property (nonatomic, strong) NSString* createTime;

/**
* 支付时间
*/

@property (nonatomic, strong) NSString* payTime;
/**
 * 好友id
 */

@property (nonatomic, assign) NSInteger helpPayUserId;


@end
