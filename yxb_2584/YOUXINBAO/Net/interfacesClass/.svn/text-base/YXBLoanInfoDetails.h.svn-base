#import <Foundation/Foundation.h> 
#import "BaseData.h"


@interface YXBLoanInfoDetails : BaseData

/**
* 借条id
*/

@property (nonatomic, assign) NSInteger loanID;

/**
* 请求数据者是否为放款出资人   1是; 0不是
*/

@property (nonatomic, assign) NSInteger requestPersonIsLender;

/**
* field 错误编号
*/

@property (nonatomic, assign) NSInteger errCode;

/**
* field 错误提示
*/

@property (nonatomic, strong) NSString* errString;

/**
* 放款人
*/

@property (nonatomic, strong) NSString* lendName;
/**
 * 借款人
 */
@property (nonatomic,strong) NSString *borrowName;
/**
* 金额
*/

@property (nonatomic, strong) NSString* money;

/**
*  借贷利息
*/

@property (nonatomic, strong) NSString* interest;
/**
 *  待还金额
 */

@property (nonatomic, strong) NSString* totalNeedRepay;
/**
 *  利息补偿金
 */

@property (nonatomic, strong) NSString*  interestAndBc  ;
/**
 *  补偿金
 */

@property (nonatomic, strong) NSString*  bcj  ;




/**
* 申请时间
*/

@property (nonatomic, strong) NSString* enrolmentTime;

/**
* 还款时间时间
*/

@property (nonatomic, strong) NSString* payBackTime;

/**
* 交易码
*/

@property (nonatomic, strong) NSString* tradeCode;

/**
* 证件号
*/

@property (nonatomic, strong) NSString* cardID;



/**
 * 是否显示修改利息按钮 0不显示1显示
 */
@property (nonatomic, strong) NSString* showModify;


/**
 * 是否可以输入文字聊天 "0"不可以 "1"可以
 */
@property (nonatomic, strong) NSString* canInput;







/**
* 当前借条状态 1被拒绝; 2待收款; 3待对方确认; 4待录制视频; 5待重录视频; 6还款中; 7即将到期; 8明日还款; 9视频待审核;
* 10延期待同意; 11已超时; 12已还款确认; 13已取消; 14已完成; 15已逾期;16待确认;17今日还款;18已拒绝;20利息协商
*/

@property (nonatomic, assign) NSInteger loanState;

/**
* 如果底部有2个按钮 返回数据格式为 2|5 id中间以|分隔 |号前为left button 如果只有1个按钮， 则只返回 id 例如 8
*
* buttonID 对应的图片分别为
* 100电话联系; 101发起新借款; 102拒绝收款;
* 103取消借款; 104去录制视频; 105确认收款;
* 106申请延期;
* 107提醒确认(底部只有一个确认按钮);
* 108提醒确认(底部有2个按钮，提醒确认为其中一个);
* 109提醒录制视频;
* 2030残忍拒绝(长图)
* 2031拒绝修改
* 2032同意修改
* 状态未完待补充
*/

@property (nonatomic, strong) NSString* bottomButtonID;

/**
* 联系电话
*/

@property (nonatomic, strong) NSString* contactNumber;

/**
* 状态变更数组
*/

@property (nonatomic, strong) NSMutableArray* iYXBLoanDialogue;

/**
* 文字聊天内容
*/

@property (nonatomic, strong) NSMutableArray* iYXBLoanChat;


/**
 * 同意借款二次确认对话框状态 0普通状态; 1索要视频状态; 2有逾期未还行为
 */
@property (nonatomic,assign)NSInteger agreePayConfirmMode;

/**
 * 审核视频阅读文字
 */
@property (nonatomic,strong)NSString *videoReadStr;

/**
 * 视频审核url地址跳转
 */
@property (nonatomic,strong)NSString *videoReviewUrl;
/**
 * 是否显示更多信息"0"不显示   "1"显示
 */
@property (nonatomic,strong)NSString *isShowMoreInfo;
/**
 * 是否已使用友信宝催收服务
 * "0"未使用 "1"已使用
 */
@property (nonatomic,strong)NSString *isYxbUrge;
/**
 * 催收流程界面
 */
@property (nonatomic,strong)NSString *urgeRecordUrl;
/**
 * 跳转ac的地址
 */
@property (nonatomic,strong)NSString *acUrl;
/**
 * 是否显示去公证按钮 "0"不显示 "1"显示
 */
@property (nonatomic,strong)NSString *showAC;
@end
