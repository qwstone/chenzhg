#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface UserBriefInfo : BaseData


/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 被查询人与查询人是否为友信宝好友 1是好友， 0不是好友。
*/

@property (nonatomic, assign) NSInteger isFriend;

/**
* 被查询人友信宝id
*/

@property (nonatomic, strong) NSString* yxbUserID;

/**
* 被查询人友信宝注册手机号码
*/

@property (nonatomic, strong) NSString* loginNum;

/**
* 被查询人友信宝昵称
*/

@property (nonatomic, strong) NSString* nickName;

/**
* 被查询人友信宝头像地址
*/

@property (nonatomic, strong) NSString* imageUrl;

/**
* 被查询人友信宝个性签名
*/

@property (nonatomic, strong) NSString* signingMessages;

/**
 * 被查询人 id
 */
@property (nonatomic,assign) NSInteger userID;
/**
 * 被查询人友信宝信用等级
 */

@property(nonatomic,strong)NSString *rankLevel;
/**
 * 被查询人真是姓名
 */
@property(nonatomic,strong)NSString *realName;

@end
