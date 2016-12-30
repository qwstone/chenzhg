//
//  ProfitManager.h
//  DiTui
//
//  Created by Walice on 15/6/1.
//  Copyright (c) 2015年 YXBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSkyArray.h"
#import "ProfitHomeData.h"
#import "ProfitNewHomeData.h"

@interface ProfitManager : NSObject
/**
 * 获取红包明细
 *
 * @param userToken
 * @param pageNum
 * @return
 *
 * @author SKY
 * @date 2015年6月1日
 */
-(NSSkyArray *)getNewProfitList:(NSString *)userToken pageNum:(NSInteger)pageNum type:(NSInteger)type;
/**
 * 获取首页显示数据
 *
 * @param userToken
 * @return
 *
 * @author SKY
 * @date 2015年6月1日
 */
- (ProfitHomeData *)getProfitHomeData:(NSString*)userToken;

- (ProfitNewHomeData*)getProfitNewHomeData:(NSString *)userString;

@end
