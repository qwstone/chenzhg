//
//  TLoanWithLog.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BaseData.h"
#import "TLoanLog.h"


@interface TLoanWithLog : BaseData

/**
 * field  借款单id
 */

@property (nonatomic,assign) NSInteger loanId;

/**
 * 聊天组id
 */
@property (nonatomic,copy) NSString * chatId;

/**
 * 聊天组name
 */
@property (nonatomic,copy) NSString * chatName;
/**
 * field  错误编号
 */

@property (nonatomic,assign) NSInteger errCode;

/**
 * field  错误提示
 */

@property (nonatomic,copy) NSString * errString;

/**
 * field  借款单状态
 * 0->借款中-待同意; 1->借款中-待打款; 2->借款人-已取消; 3->已拒绝; 4->还款中-等待对方还款;
 * 5->还款中-等待对方确认; 6->还款成功; 7->还款超时-等待对方还款; 8->还款超时-等待对方确认;
 */

@property (nonatomic,assign) NSInteger status;

/**
 * field  借贷金额
 */

@property (nonatomic,copy) NSString * money;

/**
 * field  借贷利息
 */

@property (nonatomic,copy) NSString * interest;

/**
 * field  交易编号
 */
@property (nonatomic,copy) NSString * serialNo;

/**
 * field  借款时长
 */



@property (nonatomic,assign) NSInteger loanPeriod;

/**
 * field  期待借款时间
 */

@property (nonatomic,copy) NSString * expectBorrowDate;

/**
 * field  借款人未读 flag
 */

@property (nonatomic,assign) NSInteger borrowerUnreadFlag;

/**
 * field  贷款人未读 flag
 */

@property (nonatomic,assign) NSInteger lenderUnreadFlag;

/**
 * 好友id
 */
@property (nonatomic,assign) NSInteger friendId;

/**
 * 好友姓名
 */
@property (nonatomic,copy) NSString * friendNickname;

/**
 * 好友 头像地址
 */
@property (nonatomic,copy) NSString * friendIconAddr;

/**
 * 好友 融云id
 */
@property (nonatomic,copy) NSString * friendRyId;


/**
 * 借款单动态记录
 * operatorId 操作者id
 * operationType 操作类型
 * operationDate 操作时间
 */
@property (nonatomic,retain)NSMutableArray * loanLog;

@end
