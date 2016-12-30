#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface CrowdfundingPerson : BaseData


/**
* 昵称
*/

@property (nonatomic, strong) NSString* nickName;

/**
* 头像地址
*/

@property (nonatomic, strong) NSString* imageUrl;

/**
* 友信宝id
*/

@property (nonatomic, strong) NSString* userID;

/**
* 担保金额
*/

@property (nonatomic, strong) NSString* money;

/**
* 付款时间
*/

@property (nonatomic, strong) NSString* time;

@end
