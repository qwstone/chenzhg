//
//  CreditMapManager.h
//  YOUXINBAO
//
//  Created by zjp on 15/11/16.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CreditMapData.h"
@interface CreditMapManager : NSObject

/**
 * 获取诚信地图数据
 *
 * @param userToken
 *            用户token
 * @return
 *
 * @author SKY
 * @date 2015年11月16日
 */
- (CreditMapData *)getCreditMapData:(NSString *)userToken;
@end
