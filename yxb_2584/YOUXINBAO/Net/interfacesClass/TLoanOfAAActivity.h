#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface TLoanOfAAActivity : BaseData


/**
* identifier field
*/

@property (nonatomic, assign) NSInteger loanOfAAActivityID;

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
* field 借款人id
*/

@property (nonatomic, assign) NSInteger borrowerId;

/**
* 借款人实名
*/

@property (nonatomic, strong) NSString* borrowerRealname;

/**
* 借款人身份证
*/

@property (nonatomic, strong) NSString* borrowerIdCardNo;

/**
* 借款人手机号
*/

@property (nonatomic, strong) NSString* borrowerUserPhone;

/**
* field 放款人id
*/

@property (nonatomic, assign) NSInteger lenderId;

/**
* 放款人实名
*/

@property (nonatomic, strong) NSString* lenderRealname;

/**
* 放款人身份证
*/

@property (nonatomic, strong) NSString* lenderIdCardNo;

/**
* 放款人手机号
*/

@property (nonatomic, strong) NSString* lenderUserPhone;

/**
* field 借条中心状态 0->失效; 1->有效;
*/

@property (nonatomic, assign) NSInteger status;

/**
 * 成员类型 1->发起人;2->参与者
 */
@property (nonatomic, assign) NSInteger memberType;

/**
* field 借贷金额
*/

@property (nonatomic, strong) NSString* money;

/**
* 还款日期
*/

@property (nonatomic, strong) NSString* time;

/**
* 备注
*/

@property (nonatomic, strong) NSString* remark;

@end
