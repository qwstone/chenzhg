#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface ProfitRoundData : BaseData


/**
* e.g. 昨日赚钱红包(元)
*/

@property (nonatomic, strong) NSString* str1;

/**
* e.g. 2000.00
*/

@property (nonatomic, strong) NSString* str2;

/**
* e.g. 历史收益(元)
*/

@property (nonatomic, strong) NSString* str3;

/**
* 10.00
*/

@property (nonatomic, strong) NSString* str4;

@end
