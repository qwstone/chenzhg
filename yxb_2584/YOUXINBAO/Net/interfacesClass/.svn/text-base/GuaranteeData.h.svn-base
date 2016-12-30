#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface GuaranteeData : BaseData


/**
* 担保单id
*/

@property (nonatomic, assign) NSInteger guaranteeID;

/**
* 订单编号
*/

@property (nonatomic, assign) NSInteger orderID;

/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 申请人
*/

@property (nonatomic, strong) NSString* proposerName;

/**
* 申请人电话
*/

@property (nonatomic, strong) NSString* proposerPhoneNumber;

/**
* 申请人头像地址
*/

@property (nonatomic, strong) NSString* proposerImgUrl;

/**
* 担保金额
*/

@property (nonatomic, strong) NSString* guaranteeMoney;

/**
* 担保收益
*/

@property (nonatomic, strong) NSString* guaranteeEarnings;

/**
 * 担保状态 100 待担保; 200 待收款; 300  已完成; 400  已关闭（拒绝担保）; 500  已关闭（取消担保）; 600  已关闭（被担保）
 * 待担保显示按钮【支付担保金】【拒绝担保】 待收款显示按钮【电话沟通】 其余状态不显示按钮
 */

@property (nonatomic, assign) NSInteger guaranteeState;

/**
* 当前担保单状态对应文字
*/

@property (nonatomic, strong) NSString* guaranteeStatusStr;

/**
	 * 备注说明
 */

@property (nonatomic, strong) NSString* remark;
/**
* 已收款
*/

@property (nonatomic, strong) NSString* alreadyReceive;

/**
* 将收款
*/

@property (nonatomic, strong) NSString* willReceive;

/**
* 生成时间
*/

@property (nonatomic, strong) NSString* generateTime;

/**
* 担保时间
*/

@property (nonatomic, strong) NSString* guaranteeTime;

/**
* 开始于哪一年
*/

@property (nonatomic, strong) NSString* startYear;

/**
* 人气商品
*/

@property (nonatomic, strong) NSMutableArray* guaranteeStages;

@end
