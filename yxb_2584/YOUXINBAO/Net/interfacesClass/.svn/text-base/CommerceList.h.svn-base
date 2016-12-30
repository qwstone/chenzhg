#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface CommerceList : BaseData


/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 二级分类显示名称 如 全部，手机，笔记本等
*/

@property (nonatomic, strong) NSMutableArray* categoryArray;

/**
* 当前返回的二级分类名称，默认为[全部]
*/

@property (nonatomic, strong) NSString* currentCategoryName;

/**
* 当前总商品分类 1, 时尚产品 2，学习加油站 3， 美妆护肤 4，时尚潮品
*/

@property (nonatomic, assign) NSInteger currentCommerceCategory;

/**
* 是否有优惠券领取 1，有， 0没有
*/

@property (nonatomic, strong) NSString* hasCoupon;

/**
* 优惠券提示文字信息
*/

@property (nonatomic, strong) NSString* couponStr;

/**
* 优惠券跳转url 内嵌浏览器地址
*/

@property (nonatomic, strong) NSString* couponUrl;

/**
* 商品数据列表
*/

@property (nonatomic, strong) NSMutableArray* goodsResumeList;

@end
