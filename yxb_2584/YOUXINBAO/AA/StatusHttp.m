//
//  StatusHttp.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/31.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "StatusHttp.h"
#import "QCUserManager.h"
#import "TActivityManager.h"


@implementation StatusHttp


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"dealloc");
    if (self.iHttpOperator != nil) {
        [self.iHttpOperator cancel];
    }

}

- (void)addTActivityInviteeWithMaodel:(AAActivity *)model withArrray:(NSArray *)array
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        TActivityMemberManager* _chatM = (TActivityMemberManager*)  [assginHtttperator getAopInstance:[TActivityMemberManager class] returnValue:[TResultSet class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        [_chatM addTActivityInviteeList:userModel.user.t_id activityId:model.t_id List:array];
        
        
    } complete:^(TResultSet* r, int taskid) {
       
        [this.delegate httpCompleteWithResultSet:r withHttpTag:1];
    }];
    [self.iHttpOperator connect];
}
//报名
- (void)addTActivityParticipantwithModel:(AAActivity *)model
{
        if (self.iHttpOperator == nil) {
            self.iHttpOperator = [[HttpOperator alloc]init];
            
        }
        [self.iHttpOperator cancel];
        
        __weak HttpOperator * assginHtttperator = _iHttpOperator;
        __weak StatusHttp *this = self;
        [self.iHttpOperator connetStart:^(int d) {
            [this.iHttpOperator stopAnimation];

        } cancel:^(int d) {
            
        } error:^(int d, THttpOperatorErrorCode error) {
            
            if (error == EHttp_Operator_Failed) {
                //服务器挂了
            }
            
        } param:^(NSString *s) {
            
            TActivityMemberManager* _chatM = (TActivityMemberManager*)  [assginHtttperator getAopInstance:[TActivityMemberManager class] returnValue:[TResultSet class]];
            QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
            
            [_chatM addTActivityParticipant:userModel.user.t_id activityId:model.t_id];
            //活动id

                
        } complete:^(TResultSet* r, int taskid) {

           
            [this.delegate httpCompleteWithResultSet:r withHttpTag:1];
          
        }];
        [self.iHttpOperator connect];
}

//退出活动

- (void)quitTActivityParticipant:(AAActivity *)model
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];

    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        TActivityMemberManager* _chatM = (TActivityMemberManager*)  [assginHtttperator getAopInstance:[TActivityMemberManager class] returnValue:[TResultSet class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        [_chatM quitTActivityParticipant:userModel.user.t_id activityId:model.t_id];
        //活动id

        
        
    } complete:^(TResultSet* r, int taskid) {

       
        [this.delegate httpCompleteWithResultSet:r withHttpTag:1];
       
    }];
    [self.iHttpOperator connect];
}

//拒绝活动报名
- (void)rejectTActivityParticipantWith:(AAActivity *)model with:(NSInteger)friendID
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];

    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        TActivityMemberManager* _chatM = (TActivityMemberManager*)  [assginHtttperator getAopInstance:[TActivityMemberManager class] returnValue:[TResultSet class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        [_chatM rejectTActivityParticipant:userModel.user.t_id activityId:model.t_id relatedId:friendID];
        //活动id

        
        
    } complete:^(TResultSet* r, int taskid) {
       
        [this.delegate httpCompleteWithResultSet:r withHttpTag:1];
    }];
    [self.iHttpOperator connect];
}

- (void)checkInTActivityParticipant:(AAActivity *)model Longitude:(NSString *)Longitude Latitude:(NSString *)Latitude
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];

    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        TActivityMemberManager* _chatM = (TActivityMemberManager*)  [assginHtttperator getAopInstance:[TActivityMemberManager class] returnValue:[TResultSet class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        [_chatM checkInTActivityParticipant:userModel.user.t_id activityId:model.t_id reqLongitude:Longitude reqLatitude:Latitude];
        //活动id

        
        
    } complete:^(TResultSet* r, int taskid) {
        
        [this.delegate httpCompleteWithResultSet:r withHttpTag:1];
    }];
    [self.iHttpOperator connect];
}

- (void)checkInTActivityParticipantByCreator:(AAActivity *)model friendId:(NSInteger)friendid Longitude:(NSString *)Longitude Latitude:(NSString *)Latitude
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];

    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        TActivityMemberManager* _chatM = (TActivityMemberManager*)  [assginHtttperator getAopInstance:[TActivityMemberManager class] returnValue:[TResultSet class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        [_chatM checkInTActivityParticipantByCreator:userModel.user.t_id activityId:model.t_id relatedId:friendid reqLongitude:Longitude reqLatitude:Latitude];
        //活动id

        
        
    } complete:^(TResultSet* r, int taskid) {
        
        
        [this.delegate httpCompleteWithResultSet:r withHttpTag:1];
    
    }];
    [self.iHttpOperator connect];
}

- (void)finishTActivity:(AAActivity *)model
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];

    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        TActivityManager* _chatM = (TActivityManager*)  [assginHtttperator getAopInstance:[TActivityManager class] returnValue:[TResultSet class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        [_chatM finishTActivity:userModel.user.t_id activityId:model.t_id];
        //活动id

//        NSArray * array = @[@"sdfsf",@"cdfae",@"sds",@"tgdf"];
//        [_chatM createTActivityNew:@"xuxuxuxu" arrr:array];
        
    } complete:^(TResultSet* r, int taskid) {
        
        
        [this.delegate httpCompleteWithResultSet:r withHttpTag:1];
    }];
    [self.iHttpOperator connect];
}

- (void)cancelTActivity:(AAActivity *)model
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];

    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        TActivityManager* _chatM = (TActivityManager*)  [assginHtttperator getAopInstance:[TActivityManager class] returnValue:[TResultSet class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        [_chatM cancelTActivity:userModel.user.t_id activityId:model.t_id];
        //活动id
        
        
    } complete:^(TResultSet* r, int taskid) {
        
        [this.delegate httpCompleteWithResultSet:r withHttpTag:1];
       
    }];
    [self.iHttpOperator connect];
}

// 友借友还
- (void)__yxb_service__createAndModifyTLoan:(Loan *)model
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];

    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
//        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            [ProgressHUD dismiss];
            [ProgressHUD showWithStatus:@"连接失败..." maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeBottom];
//        }
        
    } param:^(NSString *s) {
        
        LoanManagerV2* _loanManager = (LoanManagerV2*)  [assginHtttperator getAopInstance:[LoanManagerV2 class] returnValue:[TResultSet class]];
        
        [_loanManager __yxb_service__createAndModifyTLoan:model];
        
        
    } complete:^(TResultSet* r, int taskid) {
        if (r.errCode == 0) {
            if (model.operationType == MODIFY) {
                [this.delegate httpCompleteWithResultSet:r withHttpTag:666];
                
            }else{
                if (_netNumber == LoanDetailsViewControllerPostPoneAlertViewTag)
                {
                    [this.delegate httpCompleteWithResultSet:r withHttpTag:LoanDetailsViewControllerPostPoneAlertViewTag];
                    
                }
                else
                {
                    [this.delegate httpCompleteWithResultSet:r withHttpTag:1];
                    
                }
                
            }
            [ProgressHUD showSuccessWithStatus:r.errString];

        }
        else
        {
            
            [this.delegate httpCompleteWithResultSet:r withHttpTag:0];
            [ProgressHUD showErrorWithStatus:r.errString];
        }
        
    }];
    [self.iHttpOperator connect];
}

- (void)cancelTLoan:(NSInteger)borrowerId loanId:(NSInteger)loanId
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];

    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        LoanManagerV2* _loanManager = (LoanManagerV2*)  [assginHtttperator getAopInstance:[LoanManagerV2 class] returnValue:[TResultSet class]];
        [_loanManager cancelTLoan:borrowerId loanId:loanId];
        
    } complete:^(TResultSet* r, int taskid) {
        
        [this.delegate httpCompleteWithResultSet:r withHttpTag:1];
        
    }];
    [self.iHttpOperator connect];
}

- (void)comfirmTLoan:(NSInteger)lenderId loanId:(NSInteger)loanId
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];

    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        LoanManagerV2* _loanManager = (LoanManagerV2*)  [assginHtttperator getAopInstance:[LoanManagerV2 class] returnValue:[TResultSet class]];
        [_loanManager comfirmTLoan:lenderId loanId:loanId];
        
    } complete:^(TResultSet* r, int taskid) {
        
        [this.delegate httpCompleteWithResultSet:r withHttpTag:1];
        
    }];
    [self.iHttpOperator connect];
}


- (void)declineTLoan:(NSInteger)lenderId loanId:(NSInteger)loanId
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];

    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        LoanManagerV2* _loanManager = (LoanManagerV2*)  [assginHtttperator getAopInstance:[LoanManagerV2 class] returnValue:[TResultSet class]];
        [_loanManager declineTLoan:lenderId loanId:loanId];
        
    } complete:^(TResultSet* r, int taskid) {
        
        [this.delegate httpCompleteWithResultSet:r withHttpTag:1];
        
    }];
    [self.iHttpOperator connect];
}

- (void)__yxb_service__operateTLoan:(LoanOperation)LoanOperation withTloan:(Loan *)loan
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];

    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        LoanManagerV2* _Loanmanger = (LoanManagerV2*)  [assginHtttperator getAopInstance:[LoanManagerV2 class] returnValue:[Loan class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        OpLoan * oploan = [[OpLoan alloc]init];
        
        oploan.userId = userModel.user.t_id;
        oploan.loanId = loan.t_id;
        oploan.operationType = LoanOperation;
        oploan.yxbToken = userModel.user.yxbToken;
        oploan.loanFriendType = loan.loanFriendType;
        
        [_Loanmanger __yxb_service__operateTLoan:oploan];
        
    } complete:^(TResultSet* r, int taskid) {
        
        [this.delegate httpCompleteWithResultSet:r withHttpTag:888];

        
    }];
    [self.iHttpOperator connect];
    
}

- (void)__yxb__chargeTLoanwithTloan:(CgLoan *)loan
{//
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];

    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        LoanManagerV2* _Loanmanger = (LoanManagerV2*)  [assginHtttperator getAopInstance:[LoanManagerV2 class] returnValue:[Loan class]];
      
        [_Loanmanger __yxb_service__chargeTLoan:loan];
        
    } complete:^(TResultSet* r, int taskid) {
        [this.delegate httpCompleteWithResultSet:r withHttpTag:999];
        
        
    }];
    [self.iHttpOperator connect];
    
}

- (void)__yxb_service__userActivityOperate:(ActivityOperate *)ao complete:(StatusHttpCompletedBlock)block {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];

    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        AAManager* _AAManager = (AAManager*)  [assginHtttperator getAopInstance:[AAManager class] returnValue:[AAActivity class]];
        
        [_AAManager __yxb_service__userActivityOperate:ao];
        
    } complete:^(AAActivity* r, int taskid) {
        block(r);
        
    }];
    [self.iHttpOperator connect];
    

}


-(void)addTActivityInviteeListActivityId:(NSInteger)activityId userIdStr:(NSString *)userIdStr complete:(StatusHttpResultSetBlock)block {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StatusHttp *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];

    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        AAManager* _AAManager = (AAManager*)  [assginHtttperator getAopInstance:[AAManager class] returnValue:[TResultSet class]];
        
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        [_AAManager addTActivityInviteeList:userModel.user.yxbToken activityId:activityId userIdStr:userIdStr];
        
    } complete:^(TResultSet* r, int taskid) {
        block(r);
        
    }];
    [self.iHttpOperator connect];
    
    

}


@end
