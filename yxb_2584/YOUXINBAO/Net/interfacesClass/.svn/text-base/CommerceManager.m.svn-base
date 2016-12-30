//
//  CommerceManager.m
//  YOUXINBAO
//
//  Created by 冰冰 on 15/5/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CommerceManager.h"

@implementation CommerceManager
- (CommerceHomePageData*)getHomePageData:(NSString *)userToken {
    return [[CommerceHomePageData alloc] init];
}

- (NSSkyArray *)getUserOrder:(NSString *)userToken pageNum:(NSInteger)pageNum{

    return [[NSSkyArray alloc]init];

}

- (CommerceList *)getCommerceList:(NSString *)userToken pageNum:(NSInteger)pageNum commerceCategory:(NSInteger)commerceCategory secondaryCategory:(NSString *)secondaryCategory {
    return [[CommerceList alloc] init];
}

/**
 * 获取分期订单状态详细页面
 *
 * @param commerceOrderID
 *            订单id
 * @param userToken
 *            用户token
 * @return
 *
 * @author SKY
 * @date 2015年5月26日
 */
- (CommerceOrderDetail *)getCommerceOrderDetail:(NSInteger)commerceOrderID userToken:(NSString *)userToken
{
    return [[CommerceOrderDetail alloc] init];
}


- (CommerceDetail*)getCommerceDetail:(NSInteger)commerceID {
    return [[CommerceDetail alloc] init];
}

- (TResultSet*)__yxb_service__payForCommerce:(CommercePayment *)pay {
    return [[TResultSet alloc] init];
}

/**
 * 获取首付款确认页面信息
 *
 * @param commerceOrderID
 * @param userToken
 * @return
 *
 * @author SKY
 * @date 2015年6月2日
 */
-(OrderDownPayment*) getOrderDownPayment:(NSInteger)commerceOrderID userToken:(NSString *)userToken{
    return [[OrderDownPayment alloc] init];
}


/**
 * 用户付首付
 * @return
 */
-(TResultSet *)downPaymentOrder:(NSString *)userToken orderId:(NSInteger)orderId money:(NSString *)money
{
    return [[TResultSet alloc] init];

}
/**
 * 用户还款
 * @return
 */
-(TResultSet *)paymentOrder:(NSString *) userToken orderId:(NSInteger)orderId money:(NSString *)money qici:(NSString *)qici
{
    return [[TResultSet alloc] init];

}

/**
 * 延期付款
 *
 * @return
 */
-(TResultSet *)paymentDelay:(NSString *)userToken orderId:(NSInteger)orderId
{
    return [[TResultSet alloc] init];

}

/**
 * 获取新版信分期首页数据
 *
 * @param userToken
 * @return
 *
 * @author SKY
 * @date 2015年7月11日
 */
-(CommerceIndexPageData *)getCommerceIndexPageData:(NSString *)userToken {
    return [[CommerceIndexPageData alloc] init];
}


@end
