#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface CommerceIndexPageData : BaseData


/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 是否有限时特惠显示 1 有， 0没有
*/

@property (nonatomic, strong) NSString* hasSeckill;

/**
 * 限时特惠时间段
 */

@property (nonatomic, strong) NSString* seckillTimeDosplay;

/**
* 是否有广告图显示 1 有， 0没有
*/

@property (nonatomic, strong) NSString* hasAD;
@property (nonatomic, strong) NSString* adImageUrl;

/**
* 顶部banner图广告轮播
*/

@property (nonatomic, strong) NSMutableArray* commerceBannerList;

/**
* 时尚电子
*/

@property (nonatomic, strong) NSMutableArray* electronicsList;

/**
* 学习培训
*/

@property (nonatomic, strong) NSMutableArray* trainingList;

/**
* 时尚潮品
*/

@property (nonatomic, strong) NSMutableArray* fashionList;

/**
* 美妆护肤
*/

@property (nonatomic, strong) NSMutableArray* beautyList;

/**
 * 限时特惠数据数组
 */

@property (nonatomic, strong) NSMutableArray* flashSaleList;

@end
