#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface GatheringRecordDetail : BaseData


/**
* 收款记录ID
*/

@property (nonatomic, assign) NSInteger recordId;

/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 当前状态 0，不做处理 | 100，出现付款按钮 | 200， 已关闭 | 300， 已退款| 400， 已收齐
*/

@property (nonatomic, assign) NSInteger state;

/**
* 标题
*/

@property (nonatomic, strong) NSString* title;

/**
* 发起人头像地址
*/

@property (nonatomic, strong) NSString* imageUrl;

/**
* 发起人昵称
*/

@property (nonatomic, strong) NSString* nickName;

/**
* 描述
*/

@property (nonatomic, strong) NSString* describe;

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
* 没人应收多少钱
*/

@property (nonatomic, strong) NSString* moneyPerPeople;
@property (nonatomic, strong) NSMutableArray* iGatheringRecordFriend;

@property (nonatomic, strong) NSString *creatorToken;

@property (nonatomic, assign) NSInteger userId;
@end
