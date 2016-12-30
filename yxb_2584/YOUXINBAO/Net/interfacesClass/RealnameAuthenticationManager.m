//
//  RealnameAuthenticationManager.m
//  YOUXINBAO
//
//  Created by Feili on 15/6/4.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "RealnameAuthenticationManager.h"

@implementation RealnameAuthenticationManager
/**
 * 获取实名认证信息
 *
 * @param userToken 用户token
 * @return
 */
-(RealnameAuthentication *)getInfo:(NSString *)userToken
{
    return [[RealnameAuthentication alloc] init];
}

/**
 * 更新实名认证信息
 *
 * @param realInfo 实名认证信息
 * @return
 */
-(TResultSet*)__yxb_service__updateInfo:(RealnameAuthentication *)realInfo
{
    return [[TResultSet alloc] init];
}

/**
 * 更新实名认证信息(身份证号)
 *
 * @param realInfo 实名认证信息
 * @return
 */
-(TResultSet*)__yxb_service__updateRealnameInfo:(RealnameAuthentication*) realInfo {
    return [[TResultSet alloc] init];
}

/**
 * 更新实名认证信息(身份证照片)
 *
 * @param realInfo 实名认证信息
 * @return
 */
-(TResultSet*)__yxb_service__updateIdCardImgInfo:(RealnameAuthentication *)realInfo {
    return [[TResultSet alloc] init];
}

@end
