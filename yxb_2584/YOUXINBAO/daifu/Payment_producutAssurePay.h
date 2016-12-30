#import <Foundation/Foundation.h> 
#import "BaseData.h"


	/**
	 * 信分期--担保支付
	 * 调用jspURL：/webView/user/producutAssurePay.jsp
	 * 参数data={"cookie": ,"token": ,"v": ,"pt": ,"tmp": ,"encToken": ,"other": {"money": ,"assureId": }}
	 * money 支付金额; assureId 担保ID
	 */
@interface Payment_producutAssurePay : BaseData


/**
* 支付金额
*/

@property (nonatomic, strong) NSString* money;

/**
* 担保ID
*/

@property (nonatomic, strong) NSString* assureId;

@end
