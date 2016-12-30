#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface LoanMoreInfo : BaseData


/**
 * 借据id
 */

@property (nonatomic, assign) NSInteger loanID;

/**
 * 是否延期 1已經延期。 0没有延期
 */

@property (nonatomic, assign) NSInteger hasDelay;

/**
 * 延期金额
 */

@property (nonatomic, strong) NSString* deleyMoney;

/**
 * 交易号
 */

@property (nonatomic, strong) NSString* tradeID;

/**
 * 姓名
 */

@property (nonatomic, strong) NSString* name;

/**
 * 金额
 */

@property (nonatomic, strong) NSString* money;

/**
 * 利息
 */

@property (nonatomic, strong) NSString* interest;

/**
 * 申请时间
 */

@property (nonatomic, strong) NSString* askTime;

/**
 * 还款时间
 */

@property (nonatomic, strong) NSString* payTime;

/**
 * 还款方式
 */

@property (nonatomic, strong) NSString* payMode;

/**
 * 借款用途
 */

@property (nonatomic, strong) NSString* payPurpose;

/**
 * 列表
 * LoanManagerV10后失效
 */

@property (nonatomic, strong) NSMutableArray* participants;

/**
 * 借条资金详情列表
 */
                                            
@property (nonatomic, strong) NSMutableArray* loanFundDetails;



/**
 上一个借条ID
 */
@property (nonatomic, assign) NSInteger lastLoanId;


@end
