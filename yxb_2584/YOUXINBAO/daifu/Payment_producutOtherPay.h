#import <Foundation/Foundation.h> 
#import "BaseData.h"

	/**
	 * 信分期--代付支付
	 * 调用jspURL：/webView/user/producutOtherPay.jsp
	 * 参数data={"cookie": ,"token": ,"v": ,"pt": ,"tmp": ,"encToken": ,"other": {"money": ,"otherId": }}
	 * money 支付金额; otherId 代付ID
	 */
@interface Payment_producutOtherPay : BaseData


/**
* 支付金额
*/

@property (nonatomic, strong) NSString* money;

/**
* 代付ID
*/

@property (nonatomic, strong) NSString* otherId;

@end
