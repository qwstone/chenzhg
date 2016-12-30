#import <Foundation/Foundation.h> 
#import "BaseData.h"

//标的详情Model
@interface AssetDetails : BaseData



/**
 * field 错误编号
 */
@property (nonatomic, assign) NSInteger errCode;

/**
 * field 错误提示
 */
@property (nonatomic, strong) NSString* errString;


/**
 * 标的ID
*/

@property (nonatomic, strong) NSString* assetID;

/**
* 标的标题
*/

@property (nonatomic, strong) NSString* assetTitle;

/**
* 年化收益 10.00
*/

@property (nonatomic, strong) NSString* annualizedReturn;

/**
* 投资期限 90
*/

@property (nonatomic, strong) NSString* limit;

/**
* 起头金额
*/

@property (nonatomic, strong) NSString* minimumMoney;

/**
* 进度百分比
*/

@property (nonatomic, strong) NSString* percentage;

/**
* 标的总额
*/

@property (nonatomic, strong) NSString* sumMoney;

/**
* 已投总额
*/

@property (nonatomic, strong) NSString* alreadyMoney;

/**
* 剩余金额
*/

@property (nonatomic, strong) NSString* surplusMoney;

/**
 * 产品信息URL
 */
@property (nonatomic, strong) NSString * assetInfoUrl;


/**
* 债权信息URL
*/

@property (nonatomic, strong) NSString* assignmentUrl;

/**
* 常见问题
*/

@property (nonatomic, strong) NSString* faqUrl;

/**
* 投标记录
*/

@property (nonatomic, strong) NSMutableArray* participationList;
/**
 * 安全保障
 */

@property (nonatomic, strong) NSString* aqbzUrl;


@end
