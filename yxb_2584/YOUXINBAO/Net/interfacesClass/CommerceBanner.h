#import <Foundation/Foundation.h>
#import "BaseData.h"


@interface CommerceBanner : BaseData


/**
 * 图片url地址
 */

@property (nonatomic, strong) NSString* imageUrl;

/**
 * 商品ID
 */

@property (nonatomic, strong) NSString* valID;

/**
 * 广告类型
 */

@property (nonatomic, strong) NSString* type;

/**
 * 广告类型对应的val值
 */

@property (nonatomic, strong) NSString* val;

/**
 * 跳转类型， 留作备用
 */

@property (nonatomic, assign) NSInteger jumpMode;

@end

