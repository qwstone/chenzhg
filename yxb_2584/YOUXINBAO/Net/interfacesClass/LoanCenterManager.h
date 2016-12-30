//
//  TLoanCenterManager.h
//  YOUXINBAO
//
//  Created by CH10 on 15/4/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSkyArray.h"
#import "LoanCenter.h"
#import "TResultSet.h"
@interface LoanCenterManager : NSObject

/**
 * 以状态获取借条中心列表
 *
 * @param userId     借贷人信息：用户id
 * @param roleType   借贷类型：0->全部; 1->借入; 2->放出
 * @param query_type 借条中心状态：0-> 全部 ;1->失效;  2->生效;
 * @param page       页数
 * @return
 */
- (NSSkyArray *)getTLoanCenterListByUserInfoAndQueryType:(NSString *)userToken role:(NSInteger)roleType query:(NSInteger)query_type page:(NSInteger)page;

/**
 * 获取借条详情
 *
 * @param userToken
 *            操作人登录token
 * @param LoanCenterID
 *            借条id
 * @return
 *
 * @author SKY
 * @date 2015年5月9日
 */
- (LoanCenter *) getLoanCenterDetail:(NSString *)userToken loanCenterID:(NSInteger)LoanCenterID;
/**
 * 以状态获取借条中心列表
 *
 * @param userToken    借贷人信息：用户token
 * @param roleType     借贷类型：0->全部; 1->借入; 2->放出
 * @param queryType    借条中心状态：0-> 全部 ;1->失效; 2->生效;
 * @param categoryType 分类
 * @param page         页数
 * @return
 */
- (NSSkyArray *)getTLoanCenterListByUserInfoAndQueryTypeNew:(NSString *)userToken roleType:(NSInteger)roleType queryType:(NSInteger)queryType categoryType:(NSInteger)categoryType page:(NSInteger)page;
/**
 * 放款人催款
 *
 * @param loanCenterId
 * @return TResultSet
 */
//(String userToken, Integer loanCenterId)
-(TResultSet *)loanRemindRepay:(NSString *)userToken loanCenterId:(NSInteger)loanCenterId;
@end
