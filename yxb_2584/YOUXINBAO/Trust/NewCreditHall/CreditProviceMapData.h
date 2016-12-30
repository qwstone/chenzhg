#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface CreditProviceMapData : BaseData


/**
* 省名称 e.g. 新疆
*/

@property (nonatomic, strong) NSString* proviceName;

/**
* 该省分数与平均值相比 1低于平均值; 2等于全国平均值; 3高于全国平均值;
*/

@property (nonatomic, strong) NSString* averageFlag;

/**
* 有效用户数 or 失信人数
*/

@property (nonatomic, strong) NSString* str1;

/**
* 平均信用积分 or 失信比例
*/

@property (nonatomic, strong) NSString* str2;

@end
