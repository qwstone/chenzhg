//
//  LoanCalculateUtil.m
//  YOUXINBAO
//
//  Created by Feili on 15/7/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanCalculateUtil.h"

@implementation LoanCalculateUtil

/**
 *  @author chenglibin
 *
 *  计算银行存款利息 不分先息 后息
 *
 *  @param money 本金
 *  @param time  借款时长
 *  @param rate  年化利率
 *  @param type  先息还是后息
 *
 *  @return 整形的利率 默认0
 */
+(NSInteger)interestWithMoney:(NSInteger)money timelong:(LoanPeriod)time rate:(CGFloat)rate interestType:(InterestType)type
{
    CGFloat interest = 0;
    if (type == POST_INTEREST) {
        //先息特殊处理
        interest = (money *rate)/(1 + rate);
    }
    else
    {
     //后息
        interest = money * rate;
    }
    
    //根据天数计算利息
    NSInteger days = 0;
    if (time >= LoanPeriod_DAY_1 && time <= LoanPeriod_DAY_6) {
        days = time + 1;
    }else if(time >= LoanPeriod_WEEK_1 && time <= LoanPeriod_WEEK_3)
    {
        days = (time-5) * 7;
    }else if(time >= LoanPeriod_MONTH_1 && time <= LoanPeriod_MONTH_11)
    {
        days = (time-8) *30;
    }else if(time == LoanPeriod_YEAR_1)
    {
        days =  360;
    }
    
    interest = interest * days / 360.0;
    //利息向上取整
    return  ceilf(interest);
    
}


+(NSInteger)interestWithMoney:(NSInteger)money timelong:(LoanPeriod)time rate:(CGFloat)rate
{
    CGFloat interest = 0;
    interest = money * rate;
    
    //根据天数计算利息
    NSInteger days = 0;
    if (time >= LoanPeriod_DAY_1 && time <= LoanPeriod_DAY_6) {
        days = time + 1;
    }else if(time >= LoanPeriod_WEEK_1 && time <= LoanPeriod_WEEK_3)
    {
        days = (time-5) * 7;
    }else if(time >= LoanPeriod_MONTH_1 && time <= LoanPeriod_MONTH_11)
    {
        days = (time-8) *30;
    }else if(time == LoanPeriod_YEAR_1)
    {
        days =  360;
    }
    
    interest = interest * days / 360.0;
    //利息向上取整
    return  ceilf(interest);
    
}


@end
