#import <Foundation/Foundation.h> 
#import "BaseData.h"

//订单状态
typedef NS_ENUM(NSInteger, ORDERSTATE)
{
    /**
     *  @author chenglibin
     *
     *  待审核
     */
    ORDERSTATE_CHECK_PENDING = 1,
    /**
     *  @author chenglibin
     *
     *  审核通过
     */
    ORDERSTATE_CHECK_PASS = 2,
    /**
     *  @author chenglibin
     *
     *  审核未通过
     */
    ORDERSTATE_CHECK_FAILURE = 3,
    /**
     *  @author chenglibin
     *
     *  预约签约通过
     */
    ORDERSTATE_SUBSCRIBE_PASS = 4, //显示去付款
    /**
     *  @author chenglibin
     *
     *  预约签约未通过
     */
    ORDERSTATE_SUBSCRIBE_FAILURE = 5,
    /**
     *  @author chenglibin
     *
     *  支付
     */
    ORDERSTATE_PAY = 6,
    /**
     *  @author chenglibin
     *
     *  未支付
     */
    ORDERSTATE_NON_PAYMENT = 7,
    /**
     *  @author chenglibin
     *
     *  收到
     */
    ORDERSTATE_RECEIVE = 8,
    /**
     *  @author chenglibin
     *
     *  未收到
     */
    ORDERSTATE_UNRECEIVED = 9,
    /**
     *  @author chenglibin
     *
     *  还款当天
     */
    ORDERSTATE_ONTHEDAYOFPAYMENT = 10,
    /**
     *  @author chenglibin
     *
     *  延期还款
     */
    ORDERSTATE_POSTPONE = 11,
    /**
     *  @author chenglibin
     *
     *  逾期还款
     */
    ORDERSTATE_OVERDUE_PAYMENT = 12,
    /**
     *  @author chenglibin
     *
     *  已取消
     */
    ORDERSTATE_CANCEL = 13,

    /**
     *  @author chenglibin
     *
     *  已完成
     */
    ORDERSTATE_FINISH = 14,
    /**
     *  @author chenglibin
     *
     *  物流
     */
    
    ORDERSTATE_EXPRESS_INFO=15,
    
    // 新的去还款状态，
    
    ORDERSTATE_TO_REPAYMENT = 16

};

@interface CommerceOrder : BaseData


/**
* 订单ID
*/

@property (nonatomic, assign) NSInteger orderID;

/**
* 订单当前状态
*/

@property (nonatomic, assign) NSInteger orderState;

/**
* 商品图片url地址
*/

@property (nonatomic, strong) NSString* imageUrl;

/**
* 商品文字描述
*/

@property (nonatomic, strong) NSString* descript;
/**
 * 副标题描述
 */
@property(nonatomic,strong)NSString *subDescripe;

/**
* 首付金额
*/

@property (nonatomic, strong) NSString* firstPayment;

/**
* 分期，分期应付金额
*/

@property (nonatomic, strong) NSString* stagePayment;

/**
* 分了多少期
*/

@property (nonatomic, assign) NSInteger stageNum;

/**
* 备注说明， e.g. 审核失败的失败信息说明。 备用字段
*/

/**
 *  @author chenglibin
 *
 *  副标题
 */
//@property (nonatomic,strong)NSString *subTitle;

@property (nonatomic, strong) NSString* remark;
/**
 * 显示状态文字， 例如审核中等
 */

@property(nonatomic,strong)NSString *orderStateStr;
/**
 * 优惠信息
 */
@property(nonatomic,strong)NSString *couponStr;

/**
 * 优惠信息补充
 */

@property (nonatomic, strong) NSString* couponStr2;

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
@end
