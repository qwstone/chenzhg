#import <Foundation/Foundation.h> 
#import "BaseData.h"

	/**
	 * AA付款--退款 调用/webView/user/AverageBack.jsp
	 * 参数data={"cookie": ,"token": ,"v": ,"pt": ,"tmp": ,"encToken": ,"other":
	 * {"money": ,"activityId": ,"title": ,"sumPeople": ,"descript": ,"mode":
	 * ,"userArr": }} money 支付金额; activityId AA活动ID; title 主题; sumPeople 总人数;
	 * descript 描述; mode 1代表收款 2代表退款; userArr 参与人userId|userId 中间以|分隔
	 * 
	 */
@interface Payment_AverageBack : BaseData


/**
* 支付金额
*/

@property (nonatomic, strong) NSString* money;

/**
* 付款活动ID
*/

@property (nonatomic, strong) NSString* activityId;

/**
* 主题
*/

@property (nonatomic, strong) NSString* title;

/**
* 总人数
*/

@property (nonatomic, strong) NSString* sumPeople;

/**
* 描述
*/

@property (nonatomic, strong) NSString* descript;

/**
* 1代表收款 2代表退款
*/

@property (nonatomic, strong) NSString* mode;

/**
* 参与人userId|userId 中间以|分隔
*/

@property (nonatomic, strong) NSString* userArr;

@end
