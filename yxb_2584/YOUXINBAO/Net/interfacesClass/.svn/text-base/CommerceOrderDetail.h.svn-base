#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface CommerceOrderDetail : BaseData


/**
* 订单id
*/

@property (nonatomic, assign) NSInteger orderID;

/**
* 当前订单状态 值为1-5
*/

@property (nonatomic, assign) NSInteger orderState;

/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 文字描述
*/

@property (nonatomic, strong) NSString* descript;

/**
* 图片url地址
*/

@property (nonatomic, strong) NSString* imageUrl;

/**
* 首付
*/

@property (nonatomic, strong) NSString* downPaymentMoney;

/**
* 分多少期次
*/

@property (nonatomic, assign) NSInteger stagesNum;

/**
* 每期需要交款
*/

@property (nonatomic, strong) NSString* stagesMoney;

/**
* 分期合同url地址
*/

@property (nonatomic, strong) NSString* stagesUrl;

/**
* 商品审核通过后各个分期的具体情况
*/

@property (nonatomic, strong) NSMutableArray* installmentDetailList;
/**
 * 买入时候价格
 */

@property (nonatomic, strong) NSString* priceWhenBuying;

/**
 * 服务费
 */

@property (nonatomic, strong) NSString* priceOfService;

/**
 * 用于显示的订单id
 */

@property (nonatomic, strong) NSString* displayOrderID;

/**
 * 优惠信息
 */

@property (nonatomic, strong) NSString* couponStr;

/**
 * 优惠信息补充
 */

@property (nonatomic, strong) NSString* couponStr2;
@end
