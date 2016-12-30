#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface Payment_loanPayPartLoan :BaseData

/**
 * 支付催收手续费 调用jspURL：/webView/user/loanPayPartLoan.jsp 参数data={"cookie": ,"token": ,"v":
 * ,"pt": ,"tmp": ,"encToken": ,"other": {"loanId":"借款单id", "repayMoney":"还款金额","bcj":"补偿金","repayDate":"还款时间",
 * }}
 /**
* 催收单id
*/

@property (nonatomic, strong) NSString* loanId;

/**
* 还款金额
*/

@property (nonatomic, strong) NSString* repayMoney;

/**
* 补偿金
* 无补偿金 返回"0"
*/

@property (nonatomic, strong) NSString* bcj;

/**
* 还款时间
* yyyy-MM-dd
*/

@property (nonatomic, strong) NSString* repayDate;

@end
