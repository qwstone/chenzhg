#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface ProfitRegularDetail : BaseData


/**
* field 错误编号
*/

//@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 理财编号
*/

@property (nonatomic, assign) NSInteger regularID;

/**
* 名称
*/

@property (nonatomic, strong) NSString* name;

/**
* 项目公司
*/

@property (nonatomic, strong) NSString* projectName;

/**
* 项目说明
*/

@property (nonatomic, strong) NSString* projectDes;

/**
* 万份收益
*/

@property (nonatomic, strong) NSString* earningsOf10thousand;

/**
* 产品周期
*/

@property (nonatomic, strong) NSString* period;

/**
* 年化收益
*/

@property (nonatomic, strong) NSString* percent;

/**
* 结算方式
*/

@property (nonatomic, strong) NSString* settlement;

/**
* 预计到期日
*/

@property (nonatomic, strong) NSString* expectedTime;

@end
