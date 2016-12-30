//
//  CommerceManagerV2.m
//  YOUXINBAO
//
//  Created by Walice on 15/9/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CommerceManagerV2.h"

@implementation CommerceManagerV2


- (NSSkyArray *)getUserOrder:(NSString *)userToken pageNum:(NSInteger)pageNum{

    return [[NSSkyArray alloc]init];

}

-(CommerceDetailV2*)getCommerceDetailV2:(NSString *)userToken commerceID:(NSInteger) commerceID{
    
    return [[CommerceDetailV2 alloc]init];
}
/**
 * 取消订单
 * @param userToken
 * @param commerceID
 * @return
 */
- (CommerceDetailV2*)cancelCommerceDetailV2:(NSString *)userToken commerceID:(NSInteger)commerceID{

    return [[CommerceDetailV2 alloc]init];

}

/**
 * 确认收货
 * @param userToken
 * @param commerceID
 * @return
 */
-(CommerceDetailV2*)confirmCommerceDetailV2:(NSString *)userToken commerceID:(NSInteger) commerceID{

    return [[CommerceDetailV2 alloc]init];

}

/**
 * 选择人担保订单
 * @param userToken
 * @param commerceID
 * @param guaranteeId 可以选择多个以,号分割
 * @return
 */
-(CommerceDetailV2*)guaranteeCommerceDetailV2:(NSString *)userToken commerceID: (NSInteger)commerceID guaranteeId:(NSString *)guaranteeId{
    
    return [[CommerceDetailV2 alloc]init];
}

/**
 * 找人代付还款金额
 * @param userToken
 * @param commerceID
 * @param periodId 担保期次号 0 全额 -1 当前期次
 * @return
 */
-(CommerceDetailV2*)otherPayCommerceDetailV2:(NSString *)userToken commerceID:(NSInteger)commerceID periodId:(NSString *)periodId guaranteeId:(NSString *)guaranteeId{
    return [[CommerceDetailV2 alloc]init];
}


@end
