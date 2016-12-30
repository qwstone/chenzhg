#import <Foundation/Foundation.h> 
#import "BaseData.h"


//@property (nonatomic, assign) NSInteger ORDERSTATE_CHECK_PENDING;
//@property (nonatomic, assign) NSInteger ORDERSTATE_WAIT_FOR_PAY;
//@property (nonatomic, assign) NSInteger ORDERSTATE_RECEIVE_GOODS;
//@property (nonatomic, assign) NSInteger ORDERSTATE_WAIT_FOR_REPAYMENT;
//@property (nonatomic, assign) NSInteger ORDERSTATE_SUBSCRIBE_FAILURE;
//@property (nonatomic, assign) NSInteger ORDERSTATE_DELIVER_GOODS;
//@property (nonatomic, assign) NSInteger ORDERSTATE_GUARANTEE;
//@property (nonatomic, assign) NSInteger ORDERSTATE_WAIT_FOR_REPAYMENT2;
//@property (nonatomic, assign) NSInteger ORDERSTATE_COMPLETE;
//@property (nonatomic, assign) NSInteger ORDERSTATE_CLOSED;

//订单状态
typedef NS_ENUM(NSInteger, ORDERSTATETT)
{   //待审核
    ORDERSTATE_CHECK_PENDINGGG = 1,
    // 订单状态 待支付
    ORDERSTATE_WAIT_FOR_PAY = 2,
    // 订单状态 待收货
     ORDERSTATE_RECEIVE_GOODS = 3,
    // 订单状态 待还款
    ORDERSTATE_WAIT_FOR_REPAYMENT = 4,
    // 订单状态 待付款
     ORDERSTATE_SUBSCRIBE_FAILUREEE = 5,
    // 订单状态 待发货
    ORDERSTATE_DELIVER_GOODS = 6,
    // 订单状态 待担保
     ORDERSTATE_GUARANTEE = 7,
    // 订单状态 待打款
    ORDERSTATE_WAIT_FOR_REPAYMENT2 = 8,
    // 订单状态 已完成
     ORDERSTATE_COMPLETE = 9,
    // 订单状态 已关闭
    ORDERSTATE_CLOSED = 10
    
};


@interface CommerceOrderV2 : BaseData

/**
* 订单ID
*/

@property (nonatomic, assign) NSInteger orderID;

/**
* 当前订单状态
*/

@property (nonatomic, assign) NSInteger orderState;

/**
* 买入时候价格
*/

@property (nonatomic, strong) NSString* priceWhenBuying;

/**
* 用于显示的订单编号
*/

@property (nonatomic, strong) NSString* displayOrderID;

/**
* 商品图片url地址
*/

@property (nonatomic, strong) NSString* imageUrl;

/**
* @author SKY 2015年9月14日
*/

@property (nonatomic, strong) NSString* descript;

@end
