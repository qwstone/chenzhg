//
//  StatusHttp.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/31.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TActivityMemberManager.h"
//#import "TActivityManager.h"
#import "AAManager.h"
#import "HttpOperator.h"
#import "User.h"
#import "LoanManagerV2.h"
#import "AAActivity.h"

#define LoanDetailsViewControllerPostPoneAlertViewTag 2015

@protocol StatusHttpDelegate <NSObject>

- (void)httpCompleteWithResultSet:(TResultSet *)set withHttpTag:(NSInteger)tag;

@end

typedef void (^StatusHttpCompletedBlock)(AAActivity *activity);
typedef void (^StatusHttpResultSetBlock)(TResultSet *resultSet);

@interface StatusHttp : NSObject

@property (nonatomic,retain)HttpOperator *iHttpOperator;
@property (nonatomic,assign) id<StatusHttpDelegate>delegate;
@property (nonatomic,assign)NSInteger netNumber;
//邀请好友
- (void)addTActivityInviteeWithMaodel:(AAActivity *)model withArrray:(NSArray *)array;

//报名
- (void)addTActivityParticipantwithModel:(AAActivity *)model;

//退出
- (void)quitTActivityParticipant:(AAActivity *)model;

//拒绝活动报名
- (void)rejectTActivityParticipantWith:(AAActivity *)model with:(NSInteger)friendID;

//我要签到
- (void)checkInTActivityParticipant:(AAActivity *)model Longitude:(NSString *)Longitude Latitude:(NSString *)Latitude;

//替他签到
- (void)checkInTActivityParticipantByCreator:(AAActivity *)model friendId:(NSInteger)friendid Longitude:(NSString *)Longitude Latitude:(NSString *)Latitude;

//结束活动
- (void)finishTActivity:(AAActivity *)model;

//取消活动
- (void)cancelTActivity:(AAActivity *)model;
//////////////////////友借友还
//发起借款和修改借款
- (void)__yxb_service__createAndModifyTLoan:(Loan *)model;
//取消
- (void)cancelTLoan:(NSInteger)borrowerId loanId:(NSInteger)loanId;
//同意
- (void)comfirmTLoan:(NSInteger)lenderId loanId:(NSInteger)loanId;
//拒绝
- (void)declineTLoan:(NSInteger)lenderId loanId:(NSInteger)loanId;

- (void)__yxb_service__operateTLoan:(LoanOperation)LoanOperation withTloan:(Loan *)loan;
//     * 通用打款还款操作
- (void)__yxb__chargeTLoanwithTloan:(CgLoan *)loan;

 /**
* 用户参与活动拒绝活动取消活动等操作
*
* @param ao
* @return
*
* @author SKY
* @date 2015年5月8日
*/
- (void)__yxb_service__userActivityOperate:(ActivityOperate *)ao complete:(StatusHttpCompletedBlock)block;

/**
 * 邀请好友参加活动
 *
 * @param userToken
 *            用户token
 * @param activityId
 *            活动id
 * @param userIdStr
 *            用户id数组 以,分割
 * @return
 */

-(void)addTActivityInviteeListActivityId:(NSInteger)activityId userIdStr:(NSString *)userIdStr complete:(StatusHttpResultSetBlock)block;


@end
