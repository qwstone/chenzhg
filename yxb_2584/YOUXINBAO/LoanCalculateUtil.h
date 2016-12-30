//
//  LoanCalculateUtil.h
//  YOUXINBAO
//
//  Created by Feili on 15/7/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LoanConfig.h"
@interface LoanCalculateUtil : NSObject
/**
 *  @author chenglibin
 *
 *  计算银行存款利息
 *
 *  @param money 本金
 *  @param time  借款时长
 *  @param rate  年化利率
 *  @param type  先息还是后息
 *
 *  @return 整形的利率 默认0
 */
+(NSInteger)interestWithMoney:(NSInteger)money timelong:(LoanPeriod)time rate:(CGFloat)rate interestType:(InterestType)type;

+(NSInteger)interestWithMoney:(NSInteger)money timelong:(LoanPeriod)time rate:(CGFloat)rate;

@end
