//
//  QCUserModel.m
//  YOUXINBAO
//
//  Created by 张淼 on 14-5-28.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCUserModel.h"

@implementation QCUserModel

//- (void)dealloc
//{
//    [_user release];
//    [_unreadCont release];
//    [super dealloc];
//}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
//Tuser
    [aCoder encodeObject:self.user.yxbId forKey:@"yxbId"];
//    [aCoder encodeObject:self.user.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.user.username forKey:@"username"];
    [aCoder encodeObject:self.user.yestodayMoney forKey:@"yestodayMoney"];
    [aCoder encodeObject:self.user.iconAddr forKey:@"iconAddr"];
    [aCoder encodeObject:self.user.pwd forKey:@"pwd"];
    [aCoder encodeObject:self.user.yxbToken forKey:@"yxbToken"];
    [aCoder encodeBool:self.gestureOpen forKey:@"gestureOpen"];
    [aCoder encodeBool:self.isLogin forKey:@"isLogin"];
    [aCoder encodeInteger:self.user.t_id forKey:@"t_id"];
    
    
//    [aCoder encodeObject:self.user.realname forKey:@"realname"];
//   
//
//    [aCoder encodeObject:self.user.remainMoney forKey:@"remainMoney"];
//    [aCoder encodeObject:self.user.idCardNo forKey:@"idCardNo"];
//   
//    [aCoder encodeObject:self.user.regTime forKey:@"regTime"];
//    [aCoder encodeInteger:self.user.comprehensiveLevel forKey:@"comprehensiveLevel"];
//    [aCoder encodeObject:self.user.redbag forKey:@"redbag"];
//    [aCoder encodeObject:self.user.totalMoney forKey:@"totalMoney"];
//    [aCoder encodeInteger:self.user.gender forKey:@"gender"];
//
//    [aCoder encodeObject:self.user.lendMoneyLevelDesc forKey:@"lendMoneyLevelDesc"];
//    [aCoder encodeObject:self.user.friendInviteLevelDesc forKey:@"friendInviteLevelDesc"];
//    [aCoder encodeObject:self.user.lendTimesLevelDesc forKey:@"lendTimesLevelDesc"];
//    [aCoder encodeObject:self.user.participateLevelDesc forKey:@"participateLevelDesc"];
//    [aCoder encodeObject:self.user.friendsSumLevelDesc forKey:@"friendsSumLevelDesc"];
//    [aCoder encodeObject:self.user.creditLevelDesc forKey:@"creditLevelDesc"];
//    [aCoder encodeObject:self.user.freezenMoney forKey:@"freezenMoney"];
//


    /*
    [aCoder encodeInteger:self.user.gender forKey:@"gender"];
    [aCoder encodeInteger:self.user.generosity forKey:@"generosity"];
    [aCoder encodeInteger:self.user.credit forKey:@"credit"];
    [aCoder encodeInteger:self.user.delayRepayRate forKey:@"delayRepayRate"];
    [aCoder encodeInteger:self.user.loanDishonestTimes forKey:@"loanDishonestTimes"];
    [aCoder encodeObject:self.user.lastestLoanDishonestDate forKey:@"lastestLoanDishonestDate"];
    [aCoder encodeInteger:self.user.activityDishonestTimes forKey:@"activityDishonestTimes"];
    [aCoder encodeObject:self.user.latestActivityDishonstDate forKey:@"latestActivityDishonstDate"];
    [aCoder encodeInteger:self.user.onTimeRepayTimes forKey:@"onTimeRepayTimes"];
    [aCoder encodeObject:self.user.idCardFaceAddr forKey:@"idCardFaceAddr"];
    [aCoder encodeObject:self.user.idCardBackAddr forKey:@"idCardBackAddr"];
    [aCoder encodeObject:self.user.idCardBareheadedAddr forKey:@"idCardBareheadedAddr"];
    [aCoder encodeObject:self.user.lastLoginTime forKey:@"lastLoginTime"];
    
    */
    
//    [aCoder encodeObject:self.user.errString forKey:@"errString"];
//    [aCoder encodeObject:self.user.yxbCookie forKey:@"yxbCookie"];
//    
//    [aCoder encodeInteger:self.user.accountStatus forKey:@"accountStatus"];
//    [aCoder encodeObject:self.user.ryId forKey:@"ryId"];
//    [aCoder encodeObject:self.user.ryToken forKey:@"ryToken"];
//   
//    [aCoder encodeObject:self.user.signature forKey:@"signature"];
//
////    TLoanNewFlagCount
//    [aCoder encodeInteger:self.unreadCont.applyingFlagCount forKey:@"applyingFlagCount"];
//    [aCoder encodeInteger:self.unreadCont.beAppliedFlagCount forKey:@"beAppliedFlagCount"];
//    [aCoder encodeInteger:self.unreadCont.needRepayFlagCount forKey:@"needRepayFlagCount"];
//    [aCoder encodeInteger:self.unreadCont.needRequestFlagCount forKey:@"needRequestFlagCount"];
//    [aCoder encodeInteger:self.unreadCont.lenderHistoryFlagCount forKey:@"lenderHistoryFlagCount"];
//    [aCoder encodeInteger:self.unreadCont.borrowerHistoryFlagCount forKey:@"borrowerHistoryFlagCount"];
//    [aCoder encodeObject:self.unreadCont.lastQueryDate forKey:@"lastQueryDate"];
//
//    [aCoder encodeInteger:self.unreadCont.newFriendRelationFlagCount forKey:@"newFriendRelationFlagCount"];
//    //    本地
    
//    [aCoder encodeBool:self.isOpenPassword forKey:@"isOpenPassword"];
//    [aCoder encodeObject:self.firstMessageTime forKey:@"firstMessageTime"];
//    [aCoder encodeObject:self.lastMessageTime forKey:@"lastMessageTime"];
//   
//    
//    //学生认证状态
//    [aCoder encodeInteger:self.user.studentStatus forKey:@"studentStatus"];
//    //白领认证状态
//    [aCoder encodeInteger:self.user.whiteCollarStatus forKey:@"whiteCollarStatus"];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.user = [[User alloc]init];
//        self.user.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.user.username = [aDecoder decodeObjectForKey:@"username"];
        self.user.yestodayMoney = [aDecoder decodeObjectForKey:@"yestodayMoney"];
        self.user.pwd = [aDecoder decodeObjectForKey:@"pwd"];
        self.user.iconAddr = [aDecoder decodeObjectForKey:@"iconAddr"];
        self.user.yxbToken = [aDecoder decodeObjectForKey:@"yxbToken"];
        self.user.yxbId = [aDecoder decodeObjectForKey:@"yxbId"];
        self.gestureOpen = [aDecoder decodeBoolForKey:@"gestureOpen"];
        self.isLogin = [aDecoder decodeBoolForKey:@"isLogin"];
        self.user.t_id = [aDecoder decodeIntegerForKey:@"t_id"];
//        self.unreadCont = [[TUnreadFlagCount alloc]init];
//        self.user.realname = [aDecoder decodeObjectForKey:@"realname"];
       
       //
       // self.user.remainMoney = [aDecoder decodeObjectForKey:@"remainMoney"];
       // self.user.idCardNo = [aDecoder decodeObjectForKey:@"idCardNo"];
       
        //self.user.regTime = [aDecoder decodeObjectForKey:@"regTime"];
        //self.user.comprehensiveLevel = [aDecoder decodeIntegerForKey:@"comprehensiveLevel"];
        //self.user.redbag = [aDecoder decodeObjectForKey:@"redbag"];
        //self.user.totalMoney = [aDecoder decodeObjectForKey:@"totalMoney"];
        //self.user.gender = [aDecoder decodeIntegerForKey:@"gender"];
        //self.user.lendMoneyLevelDesc = [aDecoder decodeObjectForKey:@"lendMoneyLevelDesc"];
        //self.user.friendInviteLevelDesc = [aDecoder decodeObjectForKey:@"friendInviteLevelDesc"];
        //self.user.lendTimesLevelDesc = [aDecoder decodeObjectForKey:@"lendTimesLevelDesc"];
        //self.user.participateLevelDesc = [aDecoder decodeObjectForKey:@"participateLevelDesc"];
        //self.user.friendsSumLevelDesc = [aDecoder decodeObjectForKey:@"friendsSumLevelDesc"];
        //self.user.creditLevelDesc = [aDecoder decodeObjectForKey:@"creditLevelDesc"];
        //self.user.freezenMoney = [aDecoder decodeObjectForKey:@"freezenMoney"];

        
/*
 
        self.user.gender = [aDecoder decodeIntegerForKey:@"gender"];
        self.user.generosity = [aDecoder decodeIntegerForKey:@"generosity"];
        self.user.credit = [aDecoder decodeIntegerForKey:@"credit"];
        self.user.delayRepayRate = [aDecoder decodeIntegerForKey:@"delayRepayRate"];
        self.user.loanDishonestTimes = [aDecoder decodeIntegerForKey:@"loanDishonestTimes"];
        self.user.lastestLoanDishonestDate = [aDecoder decodeObjectForKey:@"lastestLoanDishonestDate"];
        self.user.activityDishonestTimes = [aDecoder decodeIntegerForKey:@"activityDishonestTimes"];
        self.user.latestActivityDishonstDate = [aDecoder decodeObjectForKey:@"latestActivityDishonstDate"];
        self.user.onTimeRepayTimes = [aDecoder decodeIntegerForKey:@"onTimeRepayTimes"];
        self.user.idCardFaceAddr = [aDecoder decodeObjectForKey:@"idCardFaceAddr"];
        self.user.idCardBackAddr = [aDecoder decodeObjectForKey:@"idCardBackAddr"];
        self.user.idCardBareheadedAddr = [aDecoder decodeObjectForKey:@"idCardBareheadedAddr"];
        self.user.lastLoginTime = [aDecoder decodeObjectForKey:@"lastLoginTime"];
        
        */
        //self.user.errString = [aDecoder decodeObjectForKey:@"errString"];
        
        //self.user.yxbCookie = [aDecoder decodeObjectForKey:@"yxbCookie"];
        //self.user.accountStatus = [aDecoder decodeIntegerForKey:@"accountStatus"];
        //self.user.ryId = [aDecoder decodeObjectForKey:@"ryId"];
        //self.user.ryToken = [aDecoder decodeObjectForKey:@"ryToken"];
     
        //self.user.signature = [aDecoder decodeObjectForKey:@"signature"];
       
//        TLoanNewFlagCount
        //学生认证状态
//        self.user.studentStatus = [aDecoder decodeIntegerForKey:@"studentStatus"];
//        self.user.whiteCollarStatus=[aDecoder decodeIntegerForKey:@"whiteCollarStatus"];
//        
//        self.unreadCont.applyingFlagCount = [aDecoder decodeIntegerForKey:@"applyingFlagCount"];
//        self.unreadCont.beAppliedFlagCount = [aDecoder decodeIntegerForKey:@"beAppliedFlagCount"];
//        self.unreadCont.needRequestFlagCount = [aDecoder decodeIntegerForKey:@"needRequestFlagCount"];
//        self.unreadCont.needRepayFlagCount = [aDecoder decodeIntegerForKey:@"needRepayFlagCount"];
//        self.unreadCont.lastQueryDate = [aDecoder decodeObjectForKey:@"lastQueryDate"];
//        self.unreadCont.newFriendRelationFlagCount = [aDecoder decodeIntegerForKey:@"newFriendRelationFlagCount"];
//        self.unreadCont.lenderHistoryFlagCount = [aDecoder decodeIntegerForKey:@"lenderHistoryFlagCount"];
//        self.unreadCont.borrowerHistoryFlagCount = [aDecoder decodeIntegerForKey:@"borrowerHistoryFlagCount"];
////        本地
        
//        self.isOpenPassword = [aDecoder decodeBoolForKey:@"isOpenPassword"];
//        
//        self.firstMessageTime = [aDecoder decodeObjectForKey:@"firstMessageTime"];
//        self.lastMessageTime = [aDecoder decodeObjectForKey:@"lastMessageTime"];
     
    }
    return self;
}




@end
