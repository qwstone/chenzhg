#import <Foundation/Foundation.h> 
#import "BaseData.h"
#import "LoanConfig.h"
#import "LoanConfig.h"

@interface Loan : BaseData



/**
 * identifier field 
 */
@property (nonatomic,assign) NSInteger t_id;

/**  field  auto_increment */

/**
 * field  错误编号
 */
@property (nonatomic,assign)  NSInteger errCode;

/**
 * field  错误提示
 */
@property (nonatomic,copy) NSString * errString;

/**
 * field  借款人id
 */
@property (nonatomic,assign) NSInteger borrowerId;

/**
 * field  贷款人id
 */
@property (nonatomic,assign) NSInteger lenderId;



/**
 * field  创建时间
 */
@property (nonatomic,copy) NSString * createDate;

/**
 *  @author chenglibin
 *
 *  快速借款关闭时间 默认2天
 */
@property (nonatomic,copy) NSString *closeDate;
/**
 * field  借款单主状态
 * 0->借款中; 1->还款中; 2->按时还款成功; 3->超时还款成功; 4->已取消; 5->已拒绝; 6->已关闭
 */
@property (nonatomic,assign) NSInteger mainStatus;

/**
 * field  借款单状态
 * 0->借款中-待同意; 1->借款中-待打款; 2->借款人-已取消; 3->已拒绝; 4->还款中-等待对方还款;
 * 5->还款中-等待对方确认; 6->还款成功; 7->还款超时-等待对方还款; 8->还款超时-等待对方确认;
 */
@property (nonatomic,assign) NSInteger status;

/**
 * field  最后修改时间
 */
@property (nonatomic,copy) NSString * lastModifyDate;

/**
 * field  借贷金额
 */
@property (nonatomic,copy) NSString * money;

/**
 * field  扣息方式 0->无息; 1->先息; 2->后息
 */
@property (nonatomic,assign) NSInteger interestType;

/**
 * field  借贷利息
 */
@property (nonatomic,copy) NSString * interest;

/**
 * field  待还金额
 */
@property (nonatomic,copy) NSString * needRepayMoney;

/**
 * field  备注
 */
@property (nonatomic,copy) NSString * note;

/**
 * field  期待借款时间
 */
@property (nonatomic,copy) NSString * expectBorrowDate;

/**
 * field  实际借款时间(放款人打款时间)
 */
@property (nonatomic,copy) NSString * realBorrowDate;


/**
 * field  期待还款时间
 */
@property (nonatomic,copy) NSString * expectRepayDate;

/**
 * field  借款时长
 */
@property (nonatomic,assign) NSInteger loanPeriod;


/**
 * field  还款方式 0->全额; 1->分期
 */
@property (nonatomic,assign) NSInteger repayType;

/**
 * field  借款人未读 flag
 */
@property (nonatomic,assign) NSInteger borrowerUnreadFlag;

/**
 * field  贷款人未读 flag
 */
@property (nonatomic,assign) NSInteger lenderUnreadFlag;

/**
 * 好友姓名
 */
@property (nonatomic,copy) NSString * friendRealname;

/**
 * 好友 头像地址
 */
@property (nonatomic,copy) NSString * friendIconAddr;

/**
 * 弹窗消息内容（借款方）
 */
@property (nonatomic,copy) NSString * borrowerMessage;

/**
 * 弹窗消息内容（放款方）
 */
@property (nonatomic,copy) NSString * lenderMessage;

/**
 * 是否显示弹窗消息
 */
@property (nonatomic,assign) NSInteger messageFlag;

//    /**
//     * 借款单id关联关系
//     */
//    private String idRelation;
//
//    /**
//     * 最初始借款单id
//     */
//    private Integer originalId;
//
//    /**
//     * 父借款单id
//     */
//    private Integer pid;
//
//    /**
//     * 子借款单id
//     */
//    private Integer extendId;
//
//    /**
//     * 指向最新借款单id
//     */
//    private Integer currentId;

/**
 * 是否显示标志-借款人
 */
@property (nonatomic,assign) NSInteger borrowerShowFlag;
/**
 * 是否显示标志-发款人
 */
@property (nonatomic,assign) NSInteger lenderShowFlag;

/**
 * 分期详情(存储用)
 */
@property (nonatomic,copy) NSString * installmentDetail;

/**
 * 分期描述
 */
@property (nonatomic,copy) NSString * installmentDesc;

/**
 * 分期详情列表
 */
@property (nonatomic,retain) NSArray * installmentList;


/**
 * 聊天组id
 */
@property (nonatomic,copy) NSString * chatId;

/**
 * 聊天组name
 */
@property (nonatomic,copy) NSString * chatName;


/**
 * yxbToken
 */
@property (nonatomic,copy) NSString * yxbToken;

/**
 * 操作类型
 */
@property (nonatomic,assign) NSInteger operationType;


/**
 * 超时标志
 */
@property (nonatomic,assign) NSInteger delayFlag;

//    /**
//     * 延期次数（每次一个月）
//     */
//    private Integer postponeTimes;

/**
 * 延期时常（单位:月）
 */
@property (nonatomic,assign) NSInteger postponePeriod;

/**
 * 本次补偿金
 */
@property (nonatomic,copy) NSString * currentCompensation;

/**
 * 累计补偿金
 */
@property (nonatomic,retain) NSString * sumCompensation;

/**
 * 补偿金履历描述
 */
@property (nonatomic,retain) NSArray * compensationNoteList;
/**
 * 好友用户名(手机号)
 */
@property (nonatomic,copy) NSString * friendUsername;

/**
 * 借款单类型 1常规借款单类型 2闪电借出类型
 */


@property(nonatomic,assign)NSInteger loanType;
/**
 * 是否使用银行利率 0不使用， 1使用
 */

@property (nonatomic, assign) NSInteger useBankRate;

//@property (nonatomic, assign) LoanInterestCalculateType loanInterestCalculateType;

/**
 * 借款类型 1->友信宝好友之间借款; 2->通讯录好友之间借款; 3->微信好友之间借款;
 */
@property (nonatomic, assign) NSInteger loanFriendType;

/**
 * 通讯录好友电话
 */
@property (nonatomic, copy) NSString *phoneNumberOfAddressBook;
/**
 *  @author chenglibin
 *
 *  未读消息数
 */
//@property (nonatomic,assign) NSInteger unReadCount;
/**
 * 验证视频地址
 */
@property(nonatomic,strong)NSString *verifyVideoUrl;

/**
 * 认证视频文字
 */
@property(nonatomic,strong)NSString *verifyText;
/**
 * 跳转验证页
 */
@property(nonatomic,copy)NSString *jumpToCheckUrl;

+ (NSString *)getLoanPeriodWith:(NSInteger)loanPeriod;

- (CGFloat)interestCalculatedWithLoanPeriod:(NSInteger)loanPeriod money:(NSInteger)money interestRate:(CGFloat)interestRate;//利息
- (CGFloat)interestRateWithLoanPeriod:(NSInteger)loanPeriod money:(NSInteger)money interest:(CGFloat)interest;//利率

//-(LoanInterestCalculateType)loanInterestCalculateType;
@end


