#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface FlashSale : BaseData


/**
* 商品id
*/

@property (nonatomic, assign) NSInteger commerceID;

/**
* 商品图片url地址
*/

@property (nonatomic, strong) NSString* imageUrl;

/**
* 商品描述
*/

@property (nonatomic, strong) NSString* descript;

/**
* 商品新价格
*/

@property (nonatomic, strong) NSString* activityMoney;

/**
* 商品旧价格
*/

@property (nonatomic, strong) NSString* oldMoney;

@end
