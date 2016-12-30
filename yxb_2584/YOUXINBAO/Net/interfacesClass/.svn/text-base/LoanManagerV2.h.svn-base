//
//  LoanManager.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/8.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Loan.h"
#import "NSSkyArray.h"
#import "TLoanWithLog.h"
#import "TResultSet.h"
#import "CLoan.h"
#import "OpLoan.h"
#import "CgLoan.h"
#import "TLoanIndexInfo.h"
@interface LoanManagerV2 : NSObject


- (TLoanIndexInfo *)getLoanIndexInfo:(NSString *)userToken;
- (NSSkyArray *)getTLoanListByBorrowerInfoAndQueryType:(NSInteger)borrower_info query_type:(NSInteger)query_type page:(NSInteger)page;


- (NSSkyArray *)getTLoanListByLenderInfoAndQueryType:(NSInteger)lender_info query_type:(NSInteger)query_type page:(NSInteger)page;



/**
 * 添加录制视频
 * @param userToken 用户tokn
 * @param verifyVideoUrl 视频地址
 * @param loanId 借款单id
 * @return
 */

-(TResultSet *)uploadVerifyVideo:(NSString *)userToken verifyVideoUrl:(NSString *)verifyVideoUrl loanId:(NSInteger)loanId;



/**
 * 获取借款单详情
 *
 * @param userId 用户id
 * @param loanId 借款单id
 * @return
 */
- (Loan *)getTLoanDetail:(NSInteger)userId loanId:(NSInteger)loanId;
- (Loan *)getTLoanDetailNew:(NSInteger)userId loanId:(NSInteger)loanId loanFriendType:(NSInteger)loanFriendType;

//- (TLoanWithLog *)getTLoanWithLog:(NSInteger)userId loanId:(NSInteger)loanId; //已废弃

//- (TLoanWithLog *)getTLoanWithLogNew:(NSInteger)userId loanId:(NSInteger)loanId loanFriendType:(NSInteger)loanFriendType;
- (TLoanWithLog *)getTLoanWithLogV2:(NSInteger)userId loanId:(NSInteger)loanId loanFriendType:(NSInteger)loanFriendType;

//发起借款和修改
- (TResultSet *)__yxb_service__createAndModifyTLoan:(Loan *)cloan;
//取消借款
- (TResultSet *)cancelTLoan:(NSInteger)borrowerId loanId:(NSInteger)loanId;
//同意
- (TResultSet *)comfirmTLoan:(NSInteger)lenderId loanId:(NSInteger)loanId;
//拒绝
- (TResultSet *)declineTLoan:(NSInteger)lenderId loanId:(NSInteger)loanId;

//借款单操作

- (TResultSet *)__yxb_service__operateTLoan:(OpLoan *)opLoan;


- (TResultSet *)__yxb_service__chargeTLoan:(CgLoan *)cgloan;

/**
 * 闪电借出
 *
 * @param userToken 用户登录token
 * @param money     借出金额
 * @param friendID  收款人在yxb用户id
 * @return
 * @author SKY
 * @date 2015年6月30日
 */
- (TResultSet *) createLightningLoanOut:(NSString *) userToken money:(NSString *)money friendID:(NSInteger)friendID;
@end
