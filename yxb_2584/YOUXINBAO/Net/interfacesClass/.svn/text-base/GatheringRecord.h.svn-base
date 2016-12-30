#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface GatheringRecord : BaseData


/**
* 收款记录ID
*/

@property (nonatomic, assign) NSInteger recordId;

/**
* 标题
*/

@property (nonatomic, strong) NSString* title;

/**
* 时间
*/

@property (nonatomic, strong) NSString* time;

/**
* 金钱
*/

@property (nonatomic, strong) NSString* money;

/**
* 总人数
*/

@property (nonatomic, assign) NSInteger peopleSum;

/**
* 完成人数
*/

@property (nonatomic, assign) NSInteger peopleComplete;
/**
 * 交易类型 1->收入;2->支出
 */
@property(nonatomic,assign)NSInteger mode;

/**
 * 记录状态  100，付款中 | 200， 已关闭 | 300， 已退款| 400， 已收齐| 800，已付款 | 900， 未付款
 */
@property(nonatomic,assign) NSInteger collectType;

@end
