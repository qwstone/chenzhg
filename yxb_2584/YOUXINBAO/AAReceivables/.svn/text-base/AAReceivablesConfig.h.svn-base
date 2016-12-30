//
//  AAReceivablesConfig.h
//  YOUXINBAO
//
//  Created by Feili on 15/6/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#ifndef YOUXINBAO_AAReceivablesConfig_h
#define YOUXINBAO_AAReceivablesConfig_h

//* 当前状态 0，不做处理 | 100，已付款 | 200， 未付款 | 300， 未知

typedef NS_ENUM(NSInteger, AAMoneyState) {
    AAMoneyStateNone = 0,
    AAMoneyStatePayed = 100,
    AAMoneyStateNotPay = 200,
    AAMoneyStateUnknown = 300,
    
};

/**
 * 0，不做处理 | 100，付款中 | 200， 已关闭 | 300， AA活动已退款| 400， 已收齐|700, 已关闭未付款 | 800，已付款 | 900， 未付款 |950, 成员已退款
 */
typedef NS_ENUM(NSInteger, AAMoneyTotalState) {
    AAMoneyTotalStateNone = 0,  //不做处理
    AAMoneyTotalStatePaying = 100,  //付款中
    AAMoneyTotalStateClosed = 200,  //已关闭
    AAMoneyTotalStateAARefund = 300, //活动已退款
    AAMoneyTotalStateOK = 400,       //已收齐
    AAMoneyTotalStateClosedNotPayed = 700, //已关闭未付款
    AAMoneyTotalStatePayed = 800,    //已付款
    AAMoneyTotalStateNotPayed = 900, //未付款
    AAMoneyTotalStateMemberRefund = 950,  //成员已退款
    
};


#endif
