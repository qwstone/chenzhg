//
//  CommerceManager.h
//  YOUXINBAO
//
//  Created by 冰冰 on 15/5/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSkyArray.h"
#import "CommerceHomePageData.h"
#import "CommerceList.h"
#import "CommerceOrderDetail.h"
#import "CommerceDetail.h"
#import "TResultSet.h"
#import "CommercePayment.h"
#import "OrderDownPayment.h"
#import "CommerceIndexPageData.h"
@interface CommerceManager : NSObject

/**
 * 获取信分期首页数据
 *
 * @param userToken
 *            用户登录token ， 如没有则传""空字符串
 * @return
 *
 * @author SKY
 * @date 2015年5月23日
 */
- (CommerceHomePageData*)getHomePageData:(NSString *)userToken;

/**
 * 获取用户订单列表
 *
 * @param userToken
 *            用户登录token
 * @param pageNum
 *            页面索引，从1开始
 * @return
 *
 * @author SKY
 * @date 2015年5月23日
 */
- (NSSkyArray *)getUserOrder:(NSString *)userToken pageNum:(NSInteger)pageNum;

/**
 * 获取商品分类列表数据
 *
 * @param userToken
 *            用户登录token， 没有登录则传"" 空字符串
 * @param pageNum
 *            页面索引，从1开始
 * @param commerceCategory
 *            获取商品一级分类 1, 时尚产品 .2学习加油站 。3， 美妆护肤。 4，时尚潮品。
 * @param secondaryCategory
 *            获取商品二级分类 默认值为 "全部"
 * @return
 *
 * @author SKY
 * @date 2015年5月25日
 */
- (CommerceList *)getCommerceList:(NSString *)userToken pageNum:(NSInteger)pageNum commerceCategory:(NSInteger)commerceCategory secondaryCategory:(NSString *)secondaryCategory;

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
- (CommerceOrderDetail *)getCommerceOrderDetail:(NSInteger)commerceOrderID userToken:(NSString *)userToken;


/**
 * 获取商品详情展示页
 *
 * @param commerceID
 *            商品id
 * @return
 *
 * @author SKY
 * @date 2015年5月23日
 */
- (CommerceDetail*)getCommerceDetail:(NSInteger)commerceID;

/**
 * 用户购买分期商品
 *
 * @param pay
 * @return
 *
 * @author SKY
 * @date 2015年5月26日
 */
- (TResultSet*)__yxb_service__payForCommerce:(CommercePayment *)pay;

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
-(OrderDownPayment*) getOrderDownPayment:(NSInteger)commerceOrderID userToken:(NSString *)userToken;


/**
 * 用户付首付
 * @return
 */
-(TResultSet *)downPaymentOrder:(NSString *)userToken orderId:(NSInteger)orderId money:(NSString *)money;
/**
 * 用户还款
 * @return
 */
-(TResultSet *)paymentOrder:(NSString *) userToken orderId:(NSInteger)orderId money:(NSString *)money qici:(NSString *)qici;
/**
 * 延期付款
 *
 * @return
 */
-(TResultSet *)paymentDelay:(NSString *)userToken orderId:(NSInteger)orderId;

/**
 * 获取新版信分期首页数据
 *
 * @param userToken
 * @return
 *
 * @author SKY
 * @date 2015年7月11日
 */
-(CommerceIndexPageData *)getCommerceIndexPageData:(NSString *)userToken;

@end
