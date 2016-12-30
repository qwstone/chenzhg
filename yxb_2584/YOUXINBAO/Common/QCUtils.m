//
//  QCUtils.m
//  YOUXINBAO
//
//  Created by CH10 on 14-3-31.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCUtils.h"
#import "User.h"
//#import "WXApi.h"
#import "YXBTool.h"
#define ImageQuality 1.0

@implementation QCUtils
//日期转换成字符串
+ (NSString *)stringFromDate:(NSDate *)date formate:(NSString *)formate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formate];
    NSString *datestring = [dateFormatter stringFromDate:date];
    
    return datestring;
}

//字符串转换成日期
+ (NSDate *)dateFromString:(NSString *)datestring formate:(NSString *)formate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *local = [NSLocale currentLocale];
    [dateFormatter setLocale:local];
    [dateFormatter setDateFormat:formate];
    NSDate *date = [dateFormatter dateFromString:datestring];
    
    return date;
}

//呼叫电话
+ (void)callTelphoneWithNum:(NSString *)num {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",num];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

////分享
//+ (void)shareSDKSendContent:(NSString *)content imgName:(UIImage *)imgName url:(NSString *)url callBackBlock:(ShareCallBackBlock)callBack talkShareAction:(SSShareActionSheetItemClickHandler)otherItemAction {
//    //构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:[content stringByAppendingString:url]
//                                       defaultContent:@""
//                                                image:[ShareSDK jpegImageWithImage:imgName quality:ImageQuality]
//                                                title:@"彩票宝"
//                                                  url:url
//                                          description:@""
//                                            mediaType:SSPublishContentMediaTypeNews];
//    
//    //定制微信朋友圈信息
//    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeNews]
//                                          content:content
//                                            title:content
//                                              url:url
//                                            image:[ShareSDK jpegImageWithImage:imgName quality:ImageQuality]
//                                     musicFileUrl:nil
//                                          extInfo:nil
//                                         fileData:nil
//                                     emoticonData:nil];
//    
//    [publishContent addWeixinSessionUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeNews]
//                                         content:content
//                                           title:@"彩票宝"
//                                             url:url
//                                           image:[ShareSDK jpegImageWithImage:imgName quality:ImageQuality]
//                                    musicFileUrl:nil
//                                         extInfo:nil
//                                        fileData:nil
//                                    emoticonData:nil];
//    
//    id<ISSShareActionSheetItem> myItem = [ShareSDK shareActionSheetItemWithTitle:@"本站说说"
//                                                                            icon:[UIImage imageNamed:@"shareShuoIcon.png"]
//                                                                    clickHandler:^{
//                                                                        if (otherItemAction) {
//                                                                            otherItemAction();
//                                                                        }
//                                                                        NSLog(@"执行你的分享代码!");
//                                                                    }];
//    
//    NSArray *shareList = [ShareSDK customShareListWithType:
//                          myItem,
//                          SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
//                          SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
//                          SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
//                          nil];
//    
//    NSArray *oneKeyShareList = [ShareSDK getShareListWithType:
//                                ShareTypeSinaWeibo,
//                                ShareTypeWeixiSession,
//                                ShareTypeWeixiTimeline,
//                                nil];
//    
//    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:nil                 //分享视图标题
//                                                              oneKeyShareList:oneKeyShareList     //一键分享菜单
//                                                               qqButtonHidden:YES                 //QQ分享按钮是否隐藏
//                                                        wxSessionButtonHidden:NO                 //微信好友分享按钮是否隐藏
//                                                       wxTimelineButtonHidden:NO                  //微信朋友圈分享按钮是否隐藏
//                                                         showKeyboardOnAppear:NO                  //是否显示键盘
//                                                            shareViewDelegate:nil                 //分享视图委托
//                                                          friendsViewDelegate:nil                 //好友视图委托
//                                                        picViewerViewDelegate:nil];               //图片浏览视图委托
//    
//    [ShareSDK showShareActionSheet:nil
//                         shareList:shareList
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:nil
//                      shareOptions:shareOptions
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                
//                                if (callBack) {
//                                    callBack();
//                                }
//                                
//                                if (state == SSResponseStateBegan) {
//                                    NSLog(@"分享开始");
//                                }
//                                else if (state == SSResponseStateSuccess)
//                                {
////                                    [ProgressHUD showSuccessWithStatus:@"分享成功"];
////                                    NSLog(@"分享成功");
////                                    shareNum++;
////                                    if (shareNum >= 100) {
////                                        shareNum = 0;
////                                    }
//                                }
//                                else if (state == SSResponseStateFail)
//                                {
////                                    [ProgressHUD showErrorWithStatus:[error errorDescription]];
////                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
//                                } else if (state == SSResponseStateCancel) {
//                                    NSLog(@"分享取消");
//                                }
//                            }];
//
//}
//
//微信登录获取用户信息

+(void)getUserInfoWithPlatform:(SSDKPlatformType)shareType successBlock:(onLoginSuccessBlock)successBlock
{
//    User *user = [[User alloc] init];
        
    [ShareSDK getUserInfo:shareType onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {       //授权返回后的回调方法
        NSLog(@"ICMErrorInfo error--%@",error);
        if (state == SSDKResponseStateSuccess)
        {
            User *hwUser = [[User alloc] init];
            hwUser = [self userWithShareType:shareType UserInfo:user];
            if (hwUser.yxbId != nil) {
                successBlock(hwUser);
                
            }
            else
            {
                NSLog(@"授权失败");
            }
            
            
        }
        else if (state == (SSDKResponseStateFail | SSDKResponseStateCancel))
        {
            
            [ProgressHUD showSuccessWithStatus:@"授权失败"];
        }
        
    }];
    
//    [ShareSDK authWithType:shareType                                              //需要授权的平台类型
//                   options:nil                                          //授权选项，包括视图定制，自动授权
//                    result:^(SSAuthState state, id<ICMErrorInfo> error) {       //授权返回后的回调方法
//                        NSLog(@"ICMErrorInfo error--%@",error);
//                        if (state == SSAuthStateSuccess)
//                        {
//                            [ShareSDK getUserInfoWithType:shareType authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
//                                if (result) {
//                                    User *user = [[User alloc] init];
//                                    user = [self userWithShareType:shareType UserInfo:userInfo];
//                                    successBlock(user);
//                                }
//                                else
//                                {
//                                    NSLog(@"错误码 %ld, 错误描述  %@",(long)[error errorCode],[error errorDescription]);
//                                    NSLog(@"%d--授权失败",shareType);
//                                }
//                            }];
//                            //                            NSLog(@"%d--授权成功",_shareType);
//                        }
//                        else if (state == SSAuthStateFail)
//                        {
//                            
//                            NSLog(@"错误码 %ld, 错误描述  %@",(long)[error errorCode],[error errorDescription]);
//                            switch ([error errorCode]) {
//                                case -6004:
//                                {
//                                    [ProgressHUD showErrorWithStatus:@"请安装QQ后重试!"];
//                                }
//                                    break;
//                                case -22003:
//                                {
//                                    [ProgressHUD showErrorWithStatus:@"请安装微信后重试!"];
//                                    break;
//                                }
//                                default:
//                                {
//                                    [ProgressHUD showErrorWithStatus:@"授权失败"];
//                                }
//                                    break;
//                            }
//                            NSLog(@"%d--授权失败",shareType);
//                        }
//                    }];
}

+(User *)userWithShareType:(SSDKPlatformType)shareType UserInfo:(SSDKUser *)userInfo
{
    User *user = [[User alloc] init];
    if (shareType == SSDKPlatformSubTypeWechatTimeline)
    {
        //微信特殊需要 unionid默认是 openId,unionid在做微信活动时会用到
        user.yxbId = [userInfo uid];
        
        NSString *unionid = [[userInfo rawData] objectForKey:@"unionid"];
        if (unionid != nil) {
            user.yxbId = unionid;

        }
        
        user.nickname = [userInfo nickname];
        user.iconAddr = [userInfo icon];
//        NSLog(@"wx data:--%@",[userInfo sourceData]);
    }
    else
    {
        user = nil;
    }
    return user;
}

@end
