//
//  AppUserManager.h
//  YOUXINBAO
//
//  Created by 冰冰 on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSSkyArray.h"
@class TResultSet;

@interface AppUserManager : NSObject
/**
 * 获取消息中心数据
 *
 * @param userToken
 *            用户token
 * @param pageNum
 *            页面索引，从1开始
 * @param type
 *            1，系统消息 2，个人消息
 * @return
 *
 * @author SKY
 * @date 2015年5月20日
 */
- (NSSkyArray *)getMessageCenterData:(NSString *)userToken pageNum:(NSInteger)pageNum;
/**
 * 获取消息中心数据（带分类）
 *
 * @param userToken
 *            用户token
 * @param pageNum
 *            页面索引，从1开始
 * @param type
 *            0,所有消息。 1，未读消息。2，已读消息。3，系统消息。
 * @return
 *
 * @author SKY
 * @date 2015年5月20日
 */
-(NSSkyArray *)getMessageCenterDataV2:(NSString *)userToken pageNum:(NSInteger)pageNum messageType:(NSInteger)messageType;
/**
 * 标识某条消息为已读
 *
 * @param userToken
 * @param messageID
 * @return
 *
 * @author SKY
 * @date 2015年8月6日
 */

- (TResultSet *)setMessageRead:(NSString *)userToken messageID:(NSString *)messageID;




//czg
/**
 * 标识全部消息为已读
 *
 * @param userToken
 *
 */
- (TResultSet *)setAllMessageRead:(NSString *)userToken;






@end
