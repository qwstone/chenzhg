//
//  CommerceManagerV2.h
//  YOUXINBAO
//
//  Created by Walice on 15/9/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSkyArray.h"
#import "CommerceDetailV2.h"

@interface CommerceManagerV2 : NSObject
    
    /**
     * 获取用户订单列表
     *
     * @param userToken
     *            用户登录token
     * @param pageNum
     *            页面索引，从1开始
     * @return TList列表中返回CommerceOrderV2类数组
     *
     * @author SKY
     * @date 2015年5月23日
     */
  //  public TList getUserOrder(String userToken, int pageNum);
    
- (NSSkyArray *)getUserOrder:(NSString *)userToken pageNum:(NSInteger)pageNum;

/**
 * 获取订单详情
 *
 * @param userToken
 * @param commerceID
 * @return
 *
 * @author SKY
 * @date 2015年9月16日
 */
-(CommerceDetailV2*)getCommerceDetailV2:(NSString *)userToken commerceID:(NSInteger) commerceID;
/**
 * 取消订单
 * @param userToken
 * @param commerceID
 * @return
 */
- (CommerceDetailV2*)cancelCommerceDetailV2:(NSString *)userToken commerceID:(NSInteger)commerceID;


/**
 * 确认收货
 * @param userToken
 * @param commerceID
 * @return
 */
-(CommerceDetailV2*)confirmCommerceDetailV2:(NSString *)userToken commerceID:(NSInteger) commerceID;

/**
 * 选择人担保订单
 * @param userToken
 * @param commerceID
 * @param guaranteeId 可以选择多个以,号分割
 * @return
 */
-(CommerceDetailV2*)guaranteeCommerceDetailV2:(NSString *)userToken commerceID: (NSInteger)commerceID guaranteeId:(NSString *)guaranteeId;

/**
 * 找人代付还款金额
 * @param userToken
 * @param commerceID
 * @param periodId 担保期次号 0 全额 -1 当前期次
 * @return
 */
-(CommerceDetailV2*)otherPayCommerceDetailV2:(NSString *)userToken commerceID:(NSInteger)commerceID periodId:(NSString *)periodId guaranteeId:(NSString *)guaranteeId;

@end
