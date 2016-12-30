//
//  LoanConfig.h
//  YOUXINBAO
//
//  Created by Feili on 15/7/2.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#ifndef YOUXINBAO_LoanConfig_h
#define YOUXINBAO_LoanConfig_h

#define LoanDetailsViewControllerMaxLoadMoney 1000000

#import "Loan.h"

//快速放款的类型
//1 快速放款普通   2 快速放款闪电

typedef NS_ENUM(NSInteger, LoanQuickType) {
    LoanQuickTypeNormal = 1,//普通
    LoanQuickTypeQuick = 2, //闪电    
};

typedef enum {
    BORROWER =9999,//借款人
    LENDERS,  //放款人
    NEWLOAN, //发起借款
    COMPILE, //编辑
    BorrowerORLendersQuickLend,//快速放款
}BorrowerORLenders;

typedef NS_ENUM(NSInteger, YXBPayWay)
{
    YXBPayWayFukuan = 0, //付款 (一次性放款)
    YXBPayWayHuankuan = 1,//还款（按期）
    
};

/**
 * 借款类型 1->友信宝好友之间借款; 2->通讯录好友之间借款; 3->微信好友之间借款;
 */
typedef NS_ENUM(NSInteger, YXBPayDes)
{
    YXBPayDesFriend = 1, //友信宝好友
    YXBPayDesContact = 2,//通讯录好友
    YXBPayDesWeChat = 3,//微信好友
    
};

/**
 * 利息类型 0——》无息  1——》后息 2 ——》先息;
 */
typedef NS_ENUM(NSInteger, LoanInterestType)
{
    LoanInterestTypeNone = 0, //无息
    LoanInterestTypePost = 1,//后息
    LoanInterestTypePre = 2,//先息
    
};

/**
 * 利息计算方式 0——》自定义利息  1——》银行息 2 ——》无息;
 */
typedef NS_ENUM(NSInteger, LoanInterestCalculateType)
{
    LoanInterestCalculateTypeCustom = 0, //自定义利息
    LoanInterestCalculateTypeBank = 1,//银行息
    LoanInterestCalculateTypeNone = 2,//无息
    
};


/**
 * 还款方式 0——》全额  1——》分期;
 */
typedef NS_ENUM(NSInteger, LoanRepayTypeMoney)
{
    LoanRepayTypeMoneyFull = 0, //全额
    LoanRepayTypeMoneyStage = 1,//分期
    
};

/**
 * 借款详情 每个cell的标记;
 */
typedef NS_ENUM(NSInteger, LoanDetailCellType)
{
    LoanDetailCellTypeJinE = 0,     //借款金额
    LoanDetailCellTypeShiJian = 1,  //用款时间
    LoanDetailCellTypeShiChang = 2, //借款时长
//    LoanDetailCellTypeYanQi = 3,    //延期
    LoanDetailCellTypeLiXi = 3,     //利息
    LoanDetailCellTypeLiXiDetail = 4,       //利息详情
    LoanDetailCellTypeHuanKuanFangShi = 5,  //还款方式
    LoanDetailCellTypeHuanKuanDetail = 6,   //还款详情
};


typedef enum {
    
    /**
     * 全部
     */
    Q_ALL,  // 0
    
    /**
     * 借款中-待同意
     */
    Q_APPLYING_NEEDCOMFIRM,  // 1
    
    /**
     * 借款中-待打款
     */
    Q_APPLYING_NEEDPAY,  // 2
    
    /**
     * 借款人-已取消
     */
    Q_BORROWERCANCELLED,    // 3
    
    /**
     * 已拒绝
     */
    Q_DECLINED, // 4
    
    /**
     * 还款中-等待对方还款
     */
    Q_NEEDREPAY_ONTIME, // 5
    
    /**
     * 还款中-等待对方确认;
     */
    Q_NEEDRECEIVE_ONTIME, // 6
    
    /**
     * 还款成功
     */
    Q_FINISHED, // 7
    
    /**
     * 还款超时-等待对方还款
     */
    Q_NEEDREPAY_DELAY, // 8
    
    /**
     * 还款超时-等待对方确认
     */
    Q_NEEDRECEIVE_DELAY, // 9
    
    
}Q_LoanQueryType;

typedef enum {
    /**
     * 【  申请中   】	100-> 借款中-待放款人同意
     */
    APPLYING_NEEDCONFIRM = 100,
   
    /**
     * 【  申请中   】	200-> 借款中-待借款人确认
     */
    APPLYING_NEEDCONFIRM_NEEDAGREE_BYBORROWER = 200,
    
    /**
     * 【  申请中   】	300-> 借款中-待打款
     */
    APPLYING_NEEDPAY = 300,
    
    /**
     * 【  申请中   】	310-> 借款中-已打款-待录制视频
     */
    APPLYING_NEEDRECORD=310,
    
    /**
     * 【  申请中   】	320-> 借款中-已打款-待确认视频
     */
    APPLYING_NEEDCONFIRMRECORD=320,

    /**
     * 【  申请中   】	350-> 线下打款确认
     */
    OFFLINE_LENDMONEY_CONFIRM = 350,
    
    /**
     * 【  还款中   】	400-> 待还款
     */
    NEEDREPAY = 400,
    
    /**
     * 【  还款中   】	500-> 申请修改-放款方确认
     */
    MODIFY_AFTERLEND_NEEDCONFIRM_BYLENDER = 500,
    
    /**
     * 【  还款中   】	600-> 线下还款确认(全额)
     */
    NEEDRECEIVE = 600,
    
    /**
     * 【历史记录】	700-> 还款成功
     */
    REPAYED = 700,
    
    /**
     * 【历史记录】	800-> 已取消
     */
    BORROWERCANCELLED = 800,
    /**
     * 【历史记录】	810-> 已拒绝
     */
    DECLINED = 810,
    /**
     * 【历史记录】	820-> 已关闭
     */
    CLOSED = 820,
    /**
     * 【  申请中   】	380-> 快速放款带你确认
     */
    
    QUICKLEND_NEEDCONFIRM = 380,//
    /**
     * 【历史记录】	830-> 已拒绝(快速放款)
     */
    QUICKLEND_DECLINED = 830,
    /**
     * 【历史记录】	840-> 已关闭(快速放款)
     */
    QUICKLEND_CLOSED = 840,
    
    
    
}L_LoanStatus;


typedef enum {
    APPLY = 1,
    
    /**
     * 【借款中】    11->修改
     */
    MODIFY = 11,
    
    /**
     * 【还款中】    41->申请修改(延期)
     */
    POSTPONE_AFTERPAY = 41,
}OPERATIONTYPE;

typedef enum{
    
    /**
     * 1天
     */
    LoanPeriod_DAY_1 =0,  // 0
    
    /**
     * 2天
     */
    LoanPeriod_DAY_2,  // 1
    
    /**
     * 3天
     */
    LoanPeriod_DAY_3,  // 2
    
    
    /**
     * 4天
     */
    LoanPeriod_DAY_4,  // 3
    
    /**
     * 5天
     */
    LoanPeriod_DAY_5,  // 4
    
    /**
     * 6天
     */
    LoanPeriod_DAY_6,  // 5
    
    /**
     * 一周
     */
    LoanPeriod_WEEK_1,  // 6
    
    /**
     * 两周
     */
    LoanPeriod_WEEK_2,  // 7
    
    /**
     * 三周
     */
    LoanPeriod_WEEK_3,  // 8
    
    /**
     * 1月
     */
    LoanPeriod_MONTH_1,  // 9
    
    /**
     * 2月
     */
    LoanPeriod_MONTH_2,  // 10
    
    /**
     * 3月
     */
    LoanPeriod_MONTH_3,  // 11
    
    
    /**
     * 4月
     */
    LoanPeriod_MONTH_4,  // 12
    
    /**
     * 5月
     */
    LoanPeriod_MONTH_5,  // 13
    
    /**
     * 6月
     */
    LoanPeriod_MONTH_6,  // 14
    
    /**
     * 7月
     */
    LoanPeriod_MONTH_7,  // 15
    
    /**
     * 8月
     */
    LoanPeriod_MONTH_8,  // 16
    
    /**
     * 9月
     */
    LoanPeriod_MONTH_9,  // 17
    
    /**
     * 10月
     */
    LoanPeriod_MONTH_10,  // 18
    
    /**
     * 11月
     */
    LoanPeriod_MONTH_11,  // 19
    
    /**
     * 1年
     */
    LoanPeriod_YEAR_1,  // 20
}LoanPeriod;

/**
 * 扣息方式
 */
typedef enum{
    /**
     * 无息
     */
    FREE = 0, // 0
    
    /**
     * 后息
     */
    PRE_INTEREST = 2, // 1
    
    /**
     * 先息
     */
    POST_INTEREST =1, // 2
    
    /**
     *  @author chenglibin
     *
     *  银行利息
     */
    BANK_INTEREST = 3,
}InterestType;

typedef NS_ENUM(NSInteger, LoanFriendCellType)
{
    LoanFriendCellTypeBorrow = 100, //借入
    LoanFriendCellTypeLend,//借出
    LoanFriendCellTypeSelectPeople,//其它选择好友
    
};




@protocol LoanDetailValueChangedDelegate <NSObject>

-(void)updateLoanDetailWithLoan:(id)loan;

@end

#endif
