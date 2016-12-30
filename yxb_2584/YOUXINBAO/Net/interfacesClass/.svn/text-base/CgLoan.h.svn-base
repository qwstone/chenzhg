//
//  CgLoan.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/5/5.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BaseData.h"
#import "OpLoan.h"

@interface CgLoan : BaseData


/**
 * field  操作者id
 */

@property (nonatomic,assign) NSInteger userId;

/**
 * field  yxbToken
 */

@property (nonatomic,copy) NSString * yxbToken;

/**
 * field  借款单主id
 */

@property (nonatomic,assign) NSInteger mainId;

/**
 * field  借款单分期id
 */

//    private List<Integer> periodNoList;
@property (nonatomic,copy) NSString * periodNoList;

/**
 * field  总金额
 */

@property (nonatomic,copy) NSString * totalMoney;


/**
 * field  操作类型
 */

@property (nonatomic,assign) LoanOperation operationType;

/**
 * 0-全额  1-分期
 */

@property (nonatomic,assign) NSInteger repayType;

@end
