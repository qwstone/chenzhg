#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface CommerceHomePageData : BaseData


/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 是否有秒杀显示 1 有， 0没有
*/

@property (nonatomic, strong) NSString* hasSeckill;

/**
* 秒杀图片地址
*/

@property (nonatomic, strong) NSString* seckillImageUrl;

/**
* 秒杀倒计时 以秒为单位
*/

@property (nonatomic, strong) NSString* seckillClockTime;

/**
* 人气商品
*/

@property (nonatomic, strong) NSMutableArray* goodsResumeList;

/**
* 4个分类商品对应的url
*/

@property (nonatomic, strong) NSMutableArray* categoryImageUrl;

/**
* 顶部banner图广告轮播
*/

@property (nonatomic, strong) NSMutableArray* commerceBannerList;

/**
 *这个字段是信分期首页显示的距离下一场开始的
 */
@property (nonatomic,strong) NSString *seckillClockMsg;

@end
