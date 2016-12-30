#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface CommerceDetail : BaseData


/**
* 商品id
*/

@property (nonatomic, assign) NSInteger commerceID;

/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 商品总价
*/

@property (nonatomic, strong) NSString* sumMoney;

/**
* 文字描述
*/

@property (nonatomic, strong) NSString* descript;

/**
* 配置参数url
*/

@property (nonatomic, strong) NSString* parameterUrl;

/**
* 商品详情url
*/

@property (nonatomic, strong) NSString* detailUrl;

/**
* 图片展示url地址
*/

@property (nonatomic, strong) NSMutableArray* imageUrlArray;

/**
* 可选择首付百分比, 内容 "10" 代表10% "90" 代表90%
*/

@property (nonatomic, strong) NSMutableArray* downPayment;

/**
* 用户可选择的分期方式，以及不同分期对应的利息百分比
*/

@property (nonatomic, strong) NSMutableArray* stagesInterestList;

@end
