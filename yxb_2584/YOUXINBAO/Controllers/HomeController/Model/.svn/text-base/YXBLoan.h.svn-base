#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface YXBLoan : BaseData


/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 借款单ID
*/

@property (nonatomic, assign) NSInteger loanId;

/**
* 借款单类型 0->普通借款; 1->快速放款-常规借款; 2->快速放款-闪电借出
*/

@property (nonatomic, assign) NSInteger loanType;

/**
* 借款类型 1->友信宝好友之间借款; 3->微信好友之间借款;
*/

@property (nonatomic, assign) NSInteger loanFriendType;

/**
* 借款金额
*/

@property (nonatomic, strong) NSString* money;

/**
* 还款时间
*/

@property (nonatomic, strong) NSString* backTime;

/**
* 借款时长
*/

@property (nonatomic, strong) NSString* duration;

/**
* 借款用途 1临时周转。 2交房租。3消费。4还信用卡。5报培训班。6考驾照。7其他。
*/

@property (nonatomic, strong) NSString* purpose;

/**
* 是否使用银行利率 0不使用， 1使用
*/

@property (nonatomic, assign) NSInteger useBankRate;

/**
* field 还款方式 0->全额; 1->分期
*/

@property (nonatomic, assign) NSInteger repayType;

/**
* field 扣息方式 0->无息。 1->有息。
*/

@property (nonatomic, assign) NSInteger interestType;

/**
* field 借贷利息
*/

@property (nonatomic, strong) NSString* interest;

/**
* field 借款人id
*/

@property (nonatomic, assign) NSInteger borrowerId;

/**
* field 贷款人id
*/

@property (nonatomic, assign) NSInteger lenderId;

/**
 * 用户token
 */
@property (nonatomic,strong)NSString *yxbToken;


///**
// * field  待还金额
// */
//@property (nonatomic,copy) NSString * needRepayMoney; //自己加的
///**
// * 累计补偿金
// */
//@property (nonatomic,retain) NSString * sumCompensation;

@end
