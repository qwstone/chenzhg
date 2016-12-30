#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface RealnameAuthentication : BaseData


/**
* identifier field
*/

@property (nonatomic, assign) NSInteger id;

/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 用户id
*/

@property (nonatomic, assign) NSInteger userId;

/**
* 用户 token
*/

@property (nonatomic, strong) NSString* userToken;

/**
* 姓名
*/

@property (nonatomic, strong) NSString* realname;

/**
* 身份证号
*/

@property (nonatomic, strong) NSString* idCardNo;

/**
* 身份证相片地址（正面）
*/

@property (nonatomic, strong) NSString* idCardFaceAddr;

/**
* 身份证相片地址（反面）
*/

@property (nonatomic, strong) NSString* idCardBackAddr;

/**
* 身份证相片地址（手持免冠）
*/

@property (nonatomic, strong) NSString* idCardBareheadedAddr;

/**
* 邮箱地址
*/

@property (nonatomic, strong) NSString* email;

@end
