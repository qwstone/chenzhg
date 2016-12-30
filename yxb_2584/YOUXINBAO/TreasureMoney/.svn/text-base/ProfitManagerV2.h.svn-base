//
//  ProfitManagerV2.h
//  YOUXINBAO
//
//  Created by zjp on 15/9/22.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfitHomeDataV2.h"
#import "NSSkyArray.h"
@interface ProfitManagerV2 : NSObject


/**
 * 宝赚钱2.0首页数据
 *
 * @param userToken
 * @return
 *
 * @author SKY
 * @date 2015年9月22日
 */
- (ProfitHomeDataV2*)getProfitHomeData:(NSString *)userToken;

/**
 * 获取红包记录
 *
 * @param userToken
 *            用户token
 * @param pageNum
 *            页面索引
 * @param year
 *            请求年
 * @param month
 *            请求月
 * @return ProfitListItemV2类的TList数据
 *
 * @author SKY
 * @date 2015年9月23日
 */
- (NSSkyArray *)getNewProfitList:(NSString *)userToken pageNum:(NSInteger)pageNum year:(NSString *)year month:(NSString *)month;
@end
