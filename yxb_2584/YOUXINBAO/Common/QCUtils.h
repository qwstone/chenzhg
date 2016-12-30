//
//  QCUtils.h
//  YOUXINBAO
//
//  Created by CH10 on 14-3-31.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import "User.h"

//基于iphone5下的尺寸获取视图尺寸
#define getScreenFitSize(x) ((x)/320.0*kDeviceWidth)

//分享回调方法
typedef void (^ShareCallBackBlock)(void);

//登录回调方法
typedef void (^onLoginSuccessBlock)(User *user);

@interface QCUtils : NSObject

//日期转换成字符串
+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate;

//字符串转换成日期
+ (NSDate *)dateFromString:(NSString *)datestring formate:(NSString *)formate;

//呼叫电话
+ (void)callTelphoneWithNum:(NSString *)num;


////分享
//+ (void)shareSDKSendContent:(NSString *)content imgName:(UIImage *)imgName url:(NSString *)url callBackBlock:(ShareCallBackBlock)callBack talkShareAction:(SSShareActionSheetItemClickHandler)otherItemAction;
////微信登录获取用户信息
//
//+(void)getUserInfoWithPlatform:(ShareType)shareType successBlock:(onLoginSuccessBlock)successBlock;

+(void)getUserInfoWithPlatform:(SSDKPlatformType)shareType successBlock:(onLoginSuccessBlock)successBlock;


@end
