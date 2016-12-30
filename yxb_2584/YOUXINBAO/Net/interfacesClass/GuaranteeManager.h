//
//  GuaranteeManager.h
//  YOUXINBAO
//
//  Created by zjp on 15/9/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HelpPayment.h"
#import "GuaranteeData.h"
#import "NSSkyArray.h"
#import "RepaymentNoteData.h"
#import "CrowdfundingData.h"
@interface GuaranteeManager : NSObject


/**
 * 获取担保用户显示列表数据
 *
 * @param userToken
 *            用户登录token
 * @param pageNum
 *            页面索引，从1开始
 * @return TList列表中返回GuaranteeRequestListData类数组
 *
 * @author SKY
 * @date 2015年5月23日
 */
- (NSSkyArray *)getGuaranteeList:(NSString *)userToken pageNum:(NSInteger)pageNum;

/**
 * 获取到保单详情数据
 * @param userToken   用户登录token
 * @param guaranteeID  数据id
 * @return
 *
 * @author SKY
 * @date   2015年9月16日
 */
- (GuaranteeData*)getGuaranteeDetails:(NSString *)userToken guaranteeID:(NSInteger)guaranteeID;

/**
 * 拒绝担保
 *
 * @param userToken
 *            用户登录token
 * @param guaranteeID
 *            担保单id
 * @return
 *
 * @author SKY
 * @date 2015年9月15日
 */
- (GuaranteeData*)refuseGuarantee:(NSString *)userToken guaranteeID:(NSInteger)guaranteeID;

/**
 * 获取代付数据
 *
 * @param userToken
 *            用户登录token
 * @param helpPayID
 *            数据id
 * @return
 *
 * @author SKY
 * @date 2015年9月15日
 */
- (HelpPayment*) getHelpPayment:(NSString *)userToken helpPayID:(NSInteger)helpPayID;

/**
 * 拒绝代付
 *
 * @param userToken
 *            用户登录token
 * @param helpPayID
 *            数据id
 * @return
 *
 * @author SKY
 * @date 2015年9月15日
 */
- (HelpPayment*)refuseHelpPayment:(NSString *)userToken helpPayID:(NSInteger)helpPayID;

/**
 * 获取众筹保单数据
 *
 * @param userToken
 * @param crowdfundingID
 * @return
 *
 * @author SKY
 * @date 2015年11月13日
 */
-(CrowdfundingData *)getCrowdfundingDetails:(NSString *)userToken crowdfundingID:(NSInteger)crowdfundingID;


@end
