//
//  UserState.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "UserState.h"

/**
 * 账户状态  0->已注册; 1->照片已提交，待审核; 2->审核通过; 3->审核失败;4->实名信息已提交
 *
 * private Integer accountStatus;
 */
@implementation UserState

+(TUserStateRes) isLv1 {
    TUserStateRes res = E_SUCESS;
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (userModel.user.accountStatus == 0) {
        res = E_NO_OPERATE;
    }
    return res;
}
+(TUserStateRes) isLv2 {
    TUserStateRes res = E_NO_OPERATE;
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    switch (userModel.user.accountStatus) {
        case 4:
        case 1:
        case 2:
        case 3: {
            res = E_SUCESS;
            break;
        }
        default:
            break;
    }
    return res;
}
+(TUserStateRes) isLv3 {
//    TUserStateRes res = E_NO_OPERATE;
//    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
//    switch (userModel.user.accountStatus) {
//        case 2: {
//            res = E_SUCESS;
//            break;
//        }
//        case 1: {
//            res = E_IN_REVIEW;
//            break;
//        }
//        case 3:
//        {
//            res = E_FAIL_UserStateRes;
//            break;
//        }
//        default:
//            break;
//    }
//    return res;
    return [self isLv2];
}


/**
 * 学生认证状态  0->已注册; 1->已提交，待审核; 2->审核通过; 3->审核失败;
 */
+(TUserStateRes) isLv4 {
    TUserStateRes res = E_NO_OPERATE;
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    switch (userModel.user.accountStatus) {
        case 4: {
            if (userModel.user.studentStatus == 2) {
                res = E_SUCESS;
            }
            else if (userModel.user.studentStatus == 1) {
                res = E_IN_REVIEW;
            }
            else if (userModel.user.studentStatus == 3) {
                res = E_FAIL_UserStateRes;
            }
            else {
                res = E_NO_OPERATE;
            }
            break;
        }
        case 0: {
            res = E_NO_OPERATE;
            break;
        }
//        case 3:
//        {
//            res = E_FAIL_UserStateRes;
//            break;
//        }
//        case 4:
//        {
//            res = E_IN_REVIEW;
//            break;
//        }
        default:
            break;
    }
    return res;
}

@end
