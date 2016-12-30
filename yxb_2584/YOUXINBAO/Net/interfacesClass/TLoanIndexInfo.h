#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface TLoanIndexInfo : BaseData


/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 好友借贷文案
*/

@property (nonatomic, strong) NSString* documentsOfLoan;

/**
* 土豪文案
*/

@property (nonatomic, strong) NSString* documentsOfTuHao;

/**
* 闪电借出文案
*/

@property (nonatomic, strong) NSString* documentsOfStorm;

/**
* 参与人数
*/

@property (nonatomic, strong) NSString* participantsNum;

/**
* 显示用户等级变化数组
*/

@property (nonatomic, strong) NSMutableArray* iTLoanIndexPersonRank;

@end
