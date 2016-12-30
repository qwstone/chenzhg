//
//  LoanCenterConfig.h
//  YOUXINBAO
//
//  Created by Feili on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#ifndef YOUXINBAO_LoanCenterConfig_h
#define YOUXINBAO_LoanCenterConfig_h


/**
 * 借条发起状态 1 我发起的 2我参与的
 */

typedef NS_ENUM(NSInteger, LoanCenterState) {
    LoanCenterStateMine = 1,
    LoanCenterStateNotMine = 2,
};

/**
 * 账单状态 1已经还款 2未还款 3已收齐 4未收齐
 */

typedef NS_ENUM(NSInteger, LoanCenterPay) {
    LoanCenterPayHasPayed = 1,
    LoanCenterPayNotPayed = 2,
    LoanCenterPayCollected = 3,
    LoanCenterPayNotCollected = 4,
    LoanCenterPayClosed = 5,
    
};

/**
 * 借入  借出   担保   代付  AA活动邀请   AA收款
 */

typedef NS_ENUM(NSInteger, LoanNewFriendType) {
    LoanNewFriendTypeDefault = 0,//好友管理
    LoanNewFriendTypeJieRu = 1, //借入
    LoanNewFriendTypeJieChu = 2, //借出
    LoanNewFriendTypeDanBao = 3, //担保
    LoanNewFriendTypeDaiFuDangQianQi = 4,   //代付当前期
    LoanNewFriendTypeDaiFuQuanBu= 5,// 代付全部
    LoanNewFriendTypeAAYaoQing = 6, //AA活动邀请
    LoanNewFriendTypeAAShouKuan = 7 //AA收款
    
};



#endif
