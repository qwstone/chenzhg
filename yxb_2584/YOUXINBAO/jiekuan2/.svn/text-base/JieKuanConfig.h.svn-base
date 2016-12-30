//
//  JieKuanConfig.h
//  YOUXINBAO
//
//  Created by Feili on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#ifndef JieKuanConfig_h
#define JieKuanConfig_h
#import "YXBLoan.h"
#import "JieKuanInstance.h"
#define JieKuanBaseFontSize 16

/**
 * 借款用途 1临时周转。 2交房租。3消费。4还信用卡。5报培训班。6考驾照。7其他。
 */

typedef NS_ENUM(NSInteger,JieKuanYongTu)
{
    JieKuanYongTuLiShiZhouZhuan = 1,//资金周转
    JieKuanYongTuJiaoFangZu,//交房租
    JieKuanYongTuXiaoFei,//消费
    JieKuanYongTuHuanXinYongKa,//还信用卡
    JieKuanYongTuBaoPeiXunBan, //报培训班
    JieKuanYongTuKaoJiaZhao,//考驾照
    JieKuanYongTuQiTa//其它


};


typedef NS_ENUM(NSInteger,JieKuanDays)
{
    JieKuanDaysOneWeek,//一周
    JieKuanDaysTwoWeek,//两周
    JieKuanDaysOneMonth,//一个月
    JieKuanDaysThreeMonth, //三个月
    JieKuanDaysSixMonth,//六个月
    JieKuanDaysOneYear//一年
};


typedef NS_ENUM(NSInteger,YXBRepayType)
{
    YXBRepayTypeQuanE,//全额
    YXBRepayTypeFenQi,//分期
};


typedef NS_ENUM(NSInteger,YXBUseBankRate)
{
    YXBUseBankRateNO,//不使用
    YXBUseBankRateYES,//使用
};

/**
 * field 扣息方式 0->无息。 1->有息。
 */

typedef NS_ENUM(NSInteger,YXBInterestType)
{
    YXBInterestTypeNO,//无息
    YXBInterestTypeYES,//有利息
};


/**
 * 借款单类型 0->普通借款; 1->快速放款-常规借款; 2->快速放款-闪电借出
 */

typedef NS_ENUM(NSInteger,YXBLoanType)
{
    YXBLoanTypeChangGuiJieKuan,//
    YXBLoanTypeKuaiSuChangGuiJieKuan,//
    YXBLoanTypeKuaiShanDianJieKuan
};

typedef NS_ENUM(NSInteger,HiddenKeyboardType)
{
    HiddenKeyboardTypeHeaderButton,//
    HiddenKeyboardTypeSureButton//
};


@protocol QCSwitchViewDelegate <NSObject>

-(void)switchViewDidSelectedIndex:(NSInteger)index;

@end

@protocol JieKuanCellDelegate <NSObject>

@optional
    //借款
    -(void)updateJieKuanJinEWithMoney:(NSString *)money;
    -(void)updateHuanKuanShiJian:(NSString *)time;
    -(void)updateJieKuanYongTu:(JieKuanYongTu)yongtu;

    //还款
    -(void)updateHuanKuanFangShi:(YXBRepayType)repayType;
    -(void)updateHuanKuanInterestType:(YXBInterestType)interestType userBankRate:(YXBUseBankRate)userBankRate interest:(NSString *)interest rate:(NSString *)rate;
    //结束键盘事件
    -(void)jiekuanEndEdit;
    //开始键盘事件
    -(void)jiekuanBeginEditIsMoveKeyBoard:(BOOL)isMove;
    //金额输入框是否正在编辑
    -(BOOL)isMoneyCellEdit;
    //更新利率
    -(void)updateHuanKuanRate:(NSString *)rate;


@end


@protocol JieKuanSquareViewDelegate <NSObject>

-(void)squareViewSelectedDate:(NSString *)date;

@end

@protocol YXBJieKuanControllerDelegate <NSObject>

- (void)httpJiekuanRequest:(YXBLoan*)yxbLoanModel;

@end

#endif /* JieKuanConfig_h */
