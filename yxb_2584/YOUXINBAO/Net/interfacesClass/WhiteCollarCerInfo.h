#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface WhiteCollarCerInfo : BaseData


/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 省份名称
*/

@property (nonatomic, strong) NSString* provinceName;

/**
* 城市名称
*/

@property (nonatomic, strong) NSString* cityName;

/**
* 区名称
*/

@property (nonatomic, strong) NSString* districtName;

/**
* 商圈名称
*/

@property (nonatomic, strong) NSString* businessAreaName;

/**
* 写字楼名称
*/

@property (nonatomic, strong) NSString* officeBuildingName;

/**
* 公司名称
*/

@property (nonatomic, strong) NSString* companyName;

/**
* 公司名称
*/

@property (nonatomic, strong) NSString* companyPhone;

/**
* 用户id
*/

@property (nonatomic, assign) NSInteger userId;

@end
