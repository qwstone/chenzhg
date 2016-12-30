//
//  TFundDetailManager.h
//  YOUXINBAO
//
//  Created by CH10 on 15/4/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSkyArray.h"

@interface TFundDetailManager : NSObject

/***
 *
 * @param userToken
 * @param mode
 *            表示资金是进帐还是出帐 0进账 1出账 2全部
 * @param pageNum
 *            从1开始
 * @return
 */
- (NSSkyArray *)getFundDetail:(NSString *)userToken mode:(NSInteger)mode pageNum:(NSInteger)pageNum;

/**
 *
 * @param userToken
 * @param fundID
 *            账户详情中对应的详情id
 * @return
 */
- (NSSkyArray *)getFundDecipherByID:(NSString *)userToken fundID:(NSInteger)fundID;

@end
