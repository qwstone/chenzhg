#import <Foundation/Foundation.h> 
#import "BaseData.h"


typedef enum {
    LOAN_APPLY = 1,//申请
    LOAN_MODIFY = 11, //修改
    LOAN_BORROWERCANCEL = 12, //借款人取消
    LOAN_CONFIRM = 21, //同意
    LOAN_DECLINE = 22, //婉拒
    LOAN_CONFIRM_MODIFY = 23, //同意就该并借款
    LOAN_PAY_YXB = 24, //借款(友信宝)
    LOAN_PAY_NOTYXB = 25,//借款(非友信宝)
    LOAN_PAY_NOTYXB_BE_PAID = 26,//确认借款已收款(非友信宝)
    LOAN_PAY_NOTYXB_NOT_BE_PAID = 27,//确认借款未收款(非友信宝)
    LOAN_REPAY_YXB = 31,//还款(友信宝)
    LOAN_REPAY_NOTYXB = 32,//还款(非友信宝)
    LOAN_REPAY_NOTYXB_BE_PAID = 33,//确认还款已收款(非友信宝)
    LOAN_REPAY_NOTYXB_NOT_BE_PAID = 34,//确认还款未收款(非友信宝)
    LOAN_APPLY_MODIFY_AFTERPAY = 41,//申请修改(延期)
    LOAN_CONFIRM_MODIFY_AFTERPAY = 42,//同意修改(延期)
    LOAN_DECLINE_MODIFY_AFTERPAY = 43,//拒绝修改(延期)
    
    /**
     *  @author chenglibin
     *
     *  [取消延期]
     */
    CANCEL_POSTPONE_AFTERPAY = 44,
    
    //快速放款
    LOAN_QUICK_SEND_QUICK_LEND = 51,
    
    /**
     * 【借款中】    52->确认快速放款
     */

    CONFIRM_QUICK_LEND = 52,
    /**
     * 【借款中】    53->拒绝快速放款
     */
    DECLINE_QUICK_LEND = 53,
    /**
     * 【借款中】    61->放款人已放款，借款方录制验证视频
     */
    UPLOAD_VERIFY_VIDEO = 61,
    /**
     * 【借款中】    62->审核通过借款方已录制验证视频
     */
    CHECK_PASS_UPLOAD_VIDEO = 62,
    /**
     * 【借款中】    63->审核失败借款方已录制验证视频
     */
    CHECK_FAIL_UPLOAD_VIDEO = 63,
    /**
     * 【借款中】    64->提醒借款方录制验证视频
     */
    REMIND_NEED_UPLOAD_VIDEO = 64,
    /**
     * 【借款中】    65->提醒放款方审核验证视频
     */
     REMIND_CHECK_UPLOAD_VIDEO = 65

}LoanOperation;

@interface OpLoan : BaseData

@property (nonatomic, assign) NSInteger userId;

/**
 * field  yxbToken
 */

@property (nonatomic,copy) NSString * yxbToken;

@property (nonatomic, assign) NSInteger loanId;

@property (nonatomic, assign) NSInteger operationType;

/**
 * 借款类型 1->友信宝好友之间借款; 2->通讯录好友之间借款; 3->微信好友之间借款;
 */
@property (nonatomic, assign) NSInteger loanFriendType;

@end
