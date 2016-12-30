//
//  PersonCenterManager.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TResultSet.h"

@interface PersonCenterManager : NSObject

- (TResultSet *)changeUserNickName:(NSString *)yxbToken newNickName:(NSString *)newNickName;

- (TResultSet *)changeUserSignature:(NSString *)yxbToken newSignature:(NSString *)newSignature;

- (TResultSet *)userFeedback:(NSString *)yxbToken feedBackStr:(NSString *)feedBackStr;
/**
 * 修改性别(身份认证前)
 *
 * @param yxbToken 用户token
 * @param gender   性别
 * @return
 */
- (TResultSet *)changeGender:(NSString *)yxbToken gender:(NSInteger)gender;

/**
 * 修改性别(身份认证前) 和 昵称
 *
 * @param yxbToken 用户token
 * @param gender   性别
 * @param nickname 昵称
 * @return
 */
- (TResultSet *)changeGenderAndNickname:(NSString *)yxbToken gender:(NSInteger)gender nickname:(NSString *)nickname;

@end
