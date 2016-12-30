#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface ProfitRegularBrief : BaseData


/**
* 理财编号
*/

@property (nonatomic, assign) NSInteger regularID;

/**
* 名称
*/

@property (nonatomic, strong) NSString* name;

/**
* 年化收益
*/

@property (nonatomic, strong) NSString* percent;

/**
* 产品周期
*/

@property (nonatomic, strong) NSString* time;

/**
* 万分收益
*/

@property (nonatomic, strong) NSString* earningsOf10thousand;

@end
