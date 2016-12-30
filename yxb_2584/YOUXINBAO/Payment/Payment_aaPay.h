#import <Foundation/Foundation.h> 
#import "BaseData.h"

	/**
	 * AA报名--付款 调用jspURL：webView/user/aaPay.jsp
	 * 参数data={"cookie": ,"token": ,"v": ,"pt": ,"tmp": ,"encToken": ,"other":
	 * {"money": ,"tActivityId": }} money 支付金额; tActivityId AA活动ID
	 */
@interface Payment_aaPay : BaseData


/**
* 支付金额
*/

@property (nonatomic, strong) NSString* money;

/**
* 付款活动ID
*/

@property (nonatomic, strong) NSString* tActivityId;

@end
