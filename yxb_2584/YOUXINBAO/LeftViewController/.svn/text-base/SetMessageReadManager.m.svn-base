//
//  SetMessageReadManager.m
//  YOUXINBAO
//
//  Created by Walice on 15/8/7.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "SetMessageReadManager.h"
#import "AppUserManager.h"
#import "TResultSet.h"

@implementation SetMessageReadManager

+ (id)sharedInstance
{
    static id _s;
    
    if (_s == nil) {
        _s = [[[self class] alloc]init];
    }
    return _s;
}

- (void)setMessageRead:(NSString *)messageId{
    
    
    if (messageId == nil || [messageId isEqualToString:@"-1"]) {
        return;
    }
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
        }
        
    } param:^(NSString *s) {
        
        
        AppUserManager *_activityM = (AppUserManager *)[assginHtttperator getAopInstance:[AppUserManager class] returnValue:[TResultSet class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        //        if (style == L_myList) {
        NSString *userToken = userModel.user.yxbToken;
        if ((userToken != nil) && [userToken length] > 0)
        {
            
            [_activityM setMessageRead:userToken messageID:messageId];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
        
    } complete:^(TResultSet * r, int taskid) {
    
    
        
    }];
    [self.iHttpOperator connect];
    
}



//czg
- (void)setAllMessageRead
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
        }
        
    } param:^(NSString *s) {
        
        
        AppUserManager *_activityM = (AppUserManager *)[assginHtttperator getAopInstance:[AppUserManager class] returnValue:[TResultSet class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        //        if (style == L_myList) {
        NSString *userToken = userModel.user.yxbToken;
        if ((userToken != nil) && [userToken length] > 0)
        {
            [_activityM setAllMessageRead:userToken];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
        
    } complete:^(TResultSet * r, int taskid) {
        //操作成功
        if (!r.resBoolean) {
            NSLog(@"*********************操作成功");
            NSNotification * notifition = [NSNotification notificationWithName:@"MessageAllRead" object:self userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notifition];
        }
    }];
    [self.iHttpOperator connect];
    
}



@end
