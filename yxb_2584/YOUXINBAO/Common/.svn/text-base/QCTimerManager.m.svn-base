//
//  QCTimerManager.m
//  YOUXINBAO
//
//  Created by 张淼 on 14-7-9.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCTimerManager.h"
#import "QCUserManager.h"
#import "UserManager.h"
#import "HttpOperator.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "QCConst.h"

@implementation QCTimerManager

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self]; //关闭通知
    self.iHttpOperator = nil;
    [super dealloc];
}

+ (id)sharedInstanceTimer
{
    static id _s;
    if (_s == nil) {
        _s = [[self alloc]initWithTimeInterval:10.0 userInfo:nil repeats:YES];

    }
    
    return _s;
}

//获取new count
- (void)getUnreadLoanFlagByUserInfo
{
//    QCRootViewController *rootVC = (QCRootViewController *)[[[UIApplication sharedApplication].delegate window] rootViewController];
    
    QCUserManager * um = [QCUserManager sharedInstance];
    QCUserModel * currUser = [um getLoginUser];
    if (currUser.isLogin == NO) {
        return;
    }
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[[HttpOperator alloc]init]autorelease];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCTimerManager *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }

    } param:^(NSString *s) {
        QCUserModel * user = [[QCUserManager sharedInstance]getLoginUser];
        UserManager* _currUser = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[TUnreadFlagCount class]];
        NSLog(@"lanss = %ld",(long)user.unreadCont.newFriendRelationFlagCount);
        [_currUser getUnreadNoticeFlagByUserInfo:user.user.username last_query_date:@""];
//        [_currUser getUnreadLoanFlagByUserInfo:user.user.username last_query_date:user.LoanNew.lastQueryDate];

        //        [_currUser release];
        
    } complete:^(TUnreadFlagCount* r, int taskid) {
        
        currUser.unreadCont.applyingFlagCount = r.applyingFlagCount;
        currUser.unreadCont.beAppliedFlagCount = r.beAppliedFlagCount;
        currUser.unreadCont.needRequestFlagCount = r.needRequestFlagCount;
        currUser.unreadCont.needRepayFlagCount = r.needRepayFlagCount;
        currUser.unreadCont.lastQueryDate = r.lastQueryDate;
        currUser.unreadCont.newFriendRelationFlagCount = r.newFriendRelationFlagCount;
        currUser.unreadCont.lenderHistoryFlagCount = r.lenderHistoryFlagCount;
        currUser.unreadCont.borrowerHistoryFlagCount = r.borrowerHistoryFlagCount;
//        currUser.user.credit = r.credit;
//        currUser.user.generosity =r.generosity;
        [um setLoginUser:currUser];
        if (currUser.unreadCont.beAppliedFlagCount != 0||currUser.unreadCont.needRepayFlagCount !=0 ||currUser.unreadCont.needRequestFlagCount !=0 ||currUser.unreadCont.borrowerHistoryFlagCount != 0 || currUser.unreadCont.lenderHistoryFlagCount != 0) {
            //如果有新借贷提示信息 就调用代理协议
            if ([this.t_delegate respondsToSelector:@selector(GetUnreadNoticeFlagByUserInfoChange)]) {
                [this.t_delegate GetUnreadNoticeFlagByUserInfoChange];
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNewFriendChangeNotification object:nil];
        
//        [rootVC addFriendsCount];
//        if ([this.t_delegate respondsToSelector:@selector(newFriendChange)]) {
//            //如果有新好友调用这个方法
//            [this.t_delegate newFriendChange];
//        }

    }];
    [self.iHttpOperator connect];

}

//- (BOOL) isConnectionAvailable
//{
//    SCNetworkReachabilityFlags flags;
//    BOOL receivedFlags;
//    
//    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [@"dipinkrishna.com" UTF8String]);
//    receivedFlags = SCNetworkReachabilityGetFlags(reachability, &flags);
//    CFRelease(reachability);
//    
//    if (!receivedFlags || (flags == 0) )
//    {
//        return FALSE;
//    } else {
//        return TRUE;
//    }
//}

@end
