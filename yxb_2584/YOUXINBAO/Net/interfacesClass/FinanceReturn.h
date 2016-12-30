//
//  FinanceReturn.h
//  YOUXINBAO
//
//  Created by 密码是111 on 16/7/28.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TResultSet.h"

//投资收益
@interface FinanceReturn : TResultSet
/**
 * 昨日收益
 * 2.01
 */

@property (nonatomic, strong) NSString* yesterdayIncome;
/**
 * 累计收益
 * 500.12
 */
@property (nonatomic, strong) NSString* allIncome;
/**
 * 宣传图片
 */
@property (nonatomic, strong) NSString* img;

@end
