#import <Foundation/Foundation.h>
#import "BaseData.h"


@interface CommerceDetailV2 : BaseData


/**
 * 商品id
 */

@property (nonatomic, assign) NSInteger commerceID;

/**
 * field 错误编号
 */

@property (nonatomic, assign) NSInteger errCode;

/**
 * field 错误提示
 */

@property (nonatomic, strong) NSString* errString;

/**
 * 底部按钮显示控制 0【不显示按钮】， 1【付款】， 2【取消订单】， 3【确认收货】， 4【取消订单】 【付款】, 5【取消订单】【选择担保人】，
 * 6【代付】【还款】
 */

@property (nonatomic, assign) NSInteger buttonType;

/**
 * 是否已经关闭 0否， 1是
 */

@property (nonatomic, strong) NSString* isClosed;

/**
 * 是否显示还款详情 0否， 1是
 */

@property (nonatomic, strong) NSString* needDisplayDetails;

/**
 * 是否为正常交易订单 0否（分期白条交易）， 1是
 */

@property (nonatomic, strong) NSString* isCommonTrade;

/**
 * 订单编号，时间等描述
 */

@property (nonatomic, strong) NSString* timeDes;

/**
 * 是否显示分期数据 0否， 1是
 */

@property (nonatomic, strong) NSString* needDisplayStages;

/**
 * 中间显示的webview数据
 */

@property (nonatomic, strong) NSString* htmlStr;

/**
 * 订单状态图片下载url地址
 */

@property (nonatomic, strong) NSString* statusImageUrl;

/**
 * 状态备注
 */

@property (nonatomic, strong) NSString* remark;

/**
 * 姓名(或者为开户行信息)
 */

@property (nonatomic, strong) NSString* name;

/**
 * 电话号码(或者为银行卡号)
 */

@property (nonatomic, strong) NSString* phone;

/**
 * 地址
 */

@property (nonatomic, strong) NSString* adress;

/**
 * 商品图片下载地址
 */

@property (nonatomic, strong) NSString* goodImageUrl;

/**
 * 商品描述
 */

@property (nonatomic, strong) NSString* goodDes;

/**
 * 商品价格
 */

@property (nonatomic, strong) NSString* goodMoney;

/**
 * 已还期次
 */

@property (nonatomic, strong) NSString* alreadyPayIssue;

/**
 * 待还期次
 */

@property (nonatomic, strong) NSString* willPayIssue;

/**
 * 已还金额
 */

@property (nonatomic, strong) NSString* alreadyPayMoney;

/**
 * 待还金额
 */

@property (nonatomic, strong) NSString* willPayMoney;

/**
 * 开始于哪一年
 */

@property (nonatomic, strong) NSString* startYear;

/**
 * 分期数据
 */

@property (nonatomic, strong) NSMutableArray* guaranteeStages;

/**
 * 还款期数
 */

@property (nonatomic, strong) NSString *thePeriodId;
/**
 * 还款金额
 */

@property (nonatomic, strong) NSString *theMoney;

@property (nonatomic, strong) NSString *allMoney;
@end
