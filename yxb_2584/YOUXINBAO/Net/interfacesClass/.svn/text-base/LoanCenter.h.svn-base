#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface LoanCenter : BaseData

@property (nonatomic, assign) NSInteger id;
/**
 * field 错误编号
 */
@property (nonatomic, assign) NSInteger errCode;
/**
 * field 错误提示
 */
@property (nonatomic, strong) NSString* errString;
/**
 * field 借条序列号
 */
@property (nonatomic, strong) NSString* serialNo;
/**
 * field 借款人token
 */
@property (nonatomic, strong) NSString* borrowerToken;
/**
 * 借款人实名
 */
@property (nonatomic, strong) NSString* borrowerRealname;
/**
 * 借款人头像地址
 */
@property (nonatomic, strong) NSString* borrowerIconAddr;
/**
 * 借款人身份证
 */
@property (nonatomic, strong) NSString* borrowerIdCardNo;
/**
 * 借款人手机号
 */
//@property (nonatomic, strong) NSString* borrowerUsername;
@property (nonatomic,strong) NSString * borrowerPhoneNum;
/**
 * field 放款人token
 */
@property (nonatomic, strong) NSString* lenderToken;
/**
 * 放款人实名
 */


@property (nonatomic, strong) NSString* lenderRealname;
/**
 * 放款人头像地址
 */
@property (nonatomic, strong) NSString* lenderIconAddr;
/**
 * 放款人身份证
 */
@property (nonatomic, strong) NSString* lenderIdCardNo;
/**
 * 放款人手机号
 */
//@property (nonatomic, strong) NSString* lenderUsername;
@property (nonatomic,strong) NSString * lenderPhoneNumer;
/**
 * field 借条中心状态 0->失效; 1->有效;
 */
@property (nonatomic, assign) NSInteger status;
/************
 * 借款详情 *
 ************/

/**
 * field 借款单id
 */
@property (nonatomic, assign) NSInteger loanId;
/**
 * field 借贷金额
 */
@property (nonatomic, strong) NSString* money;
/**
 * field 扣息方式描述 无息/先息/后息
 */
@property (nonatomic, strong) NSString* interestTypeDesc;
/**
 * field 借款时长描述
 */
@property (nonatomic, strong) NSString* loanPeriodDesc;
/**
 * field 借贷利息
 */
@property (nonatomic, strong) NSString* interest;
/**
 * field 期待借款时间
 */
@property (nonatomic, strong) NSString* expectBorrowDate;
/**
 * field 实际借款时间(放款人打款时间)
 */
@property (nonatomic, strong) NSString* realBorrowDate;
/**
 * field 还款方式描述
 */
@property (nonatomic, strong) NSString* repayTypeDesc;
/**
 * field 借款人未读 flag
 */
@property (nonatomic, assign) NSInteger borrowerUnreadFlag;
/**
 * field 放款人未读 flag
 */
@property (nonatomic, assign) NSInteger lenderUnreadFlag;
/**
 * 分期详情列表
 */
@property (nonatomic, strong) NSMutableArray * installmentList;

/**
 * 累计补偿金
 */
@property (nonatomic, strong) NSString *sumCompensation;


/**
 * 显示催款按键 0->隐藏; 1->显示
 */
@property (nonatomic,assign) NSInteger showReminderBtn;

@end
