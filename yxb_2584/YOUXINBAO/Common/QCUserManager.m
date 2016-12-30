//
//  QCUserManager.m
//  YOUXINBAO
//
//  Created by 张淼 on 14-5-29.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCUserManager.h"
//#import "RongChat.h"

@implementation QCUserManager

//- (void)dealloc
//{
//    _currUser = nil;
//    [_currUser release];
//    [super dealloc];
//}
+ (id)sharedInstance
{
    static id _s;
    
    if (_s == nil) {
        _s = [[[self class] alloc]init];
    }
    return _s;
}

- (NSString *)getCurrUserFiler
{
    return [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(),
            @"Library/Caches/CurrUser"];
//    return [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(),
//                @"Library/Caches/CurrUserNew"];

}

- (void)setLoginUser:(QCUserModel *)m
{
    
    //保存本地
    if ([self isUserInfoChangedWithNewUserModel:m]) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self saveToLocal];
        });
        
    }
    
    if(![_currUser.user.ryToken isEqualToString:m.user.ryToken])
    {
        if (m.isLogin) {
            //登陆融云服务器
//            [[RongChat shareRongChat] connectRongServerWithRongToken:nil];
            
        }
        else
        {
            //退出登录事件时候调用
//            //断开融云连接   不接受推送消息
//            [[RCIM sharedRCIM] disconnect:NO];
            
        }

    }
    
    _currUser = m;
    
}

- (void)saveToLocal{
    
    @synchronized(self) {
        NSString * filer = [self getCurrUserFiler];
        [NSKeyedArchiver archiveRootObject:_currUser toFile:filer];

    }
    
}


//- (QCUserModel *)getLoginUser
//{
//    NSString * filer = [self getCurrUserFiler];
////    NSLog(@"ddd = %@",filer);
//    //change by pengcheng
//    if (_currUser != Nil) {
//
//    }else{
//        
//        //model初始化
//        _currUser = [[QCUserModel alloc]init];
//    }
//    
//    //获取本地数据
//    _currUser = [NSKeyedUnarchiver unarchiveObjectWithFile:filer];
//    return _currUser;
//
//}


- (QCUserModel *)getLoginUser
{

    if (_currUser == Nil) {
        _currUser = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getCurrUserFiler]];
        if (_currUser == nil) {
            _currUser = [[QCUserModel alloc] init];
        }
    }
    return _currUser;
}

//用户信息是否改变，需要存储
-(BOOL)isUserInfoChangedWithNewUserModel:(QCUserModel *)userModel
{
    BOOL isChanged = NO;
    if (![_currUser.user.username isEqualToString:userModel.user.username] ||
        ![_currUser.user.pwd isEqualToString:userModel.user.pwd] ||
        ![_currUser.user.yxbToken isEqualToString:userModel.user.yxbToken] ||
        ![_currUser.user.iconAddr isEqualToString:userModel.user.iconAddr] ||
        !(_currUser.gestureOpen == userModel.gestureOpen) ||
        !(_currUser.isLogin == userModel.isLogin))
    {
        isChanged = YES;
    }
        
    return isChanged;
}

@end
