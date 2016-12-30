//
//  UserState.h
//  YOUXINBAO
//
//  Created by zjp on 15/6/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum UserStateRes{
    E_SUCESS = 0,
    E_FAIL_UserStateRes = 1,  //失败
    E_IN_REVIEW = 2, //审核中
    E_NO_OPERATE = 3,  //没有进行任何操作
}TUserStateRes;

@interface UserState : NSObject


+(TUserStateRes) isLv1;
+(TUserStateRes) isLv2;
+(TUserStateRes) isLv3;
+(TUserStateRes) isLv4;

@end
