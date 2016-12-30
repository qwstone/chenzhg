#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface OrderDownPayment : BaseData


/**
* 订单号
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
* 收货人
*/

@property (nonatomic, strong) NSString* name;

/**
* 电话
*/

@property (nonatomic, strong) NSString* mobile;

/**
* 地址
*/

@property (nonatomic, strong) NSString* adress;

/**
* 图片url地址
*/

@property (nonatomic, strong) NSString* imageUrl;

/**
* 描述
*/

@property (nonatomic, strong) NSString* descripe;

/**
* 副标题描述
*/

@property (nonatomic, strong) NSString* subDescripe;

/**
* 分多少期次
*/

@property (nonatomic, assign) NSInteger stagesNum;

/**
* 每月应还金额
*/

@property (nonatomic, strong) NSString* stagesMoney;

/**
* 首付金额
*/

@property (nonatomic, strong) NSString* downPaymentMoney;

/**
* 运费
*/

@property (nonatomic, strong) NSString* freight;

/**
* 优惠信息
*/

@property (nonatomic, strong) NSString* coupon;

/**
* 实付款
*/

@property (nonatomic, strong) NSString* disbursements;

@end
