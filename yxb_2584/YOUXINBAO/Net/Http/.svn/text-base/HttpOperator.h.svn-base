//
//  HttpOperator.h
//  AOP
//
//  Created by SKY on 14-3-19.
//  Copyright (c) 2014年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "AopProxy.h"
#import "AFHTTPRequestOperationManager.h"

//typedef void(^BetNumberBlock)(NSInteger);
@class ASIFormDataRequest;

//http请求错误码
typedef enum {
    //联网失败
    EHttp_Operator_Failed = 1,
    //解析失败
    EHttp_Operator_Parser,
    //服务器返回码非200错误
    EHttp_Operator_StatusCodeError,
}THttpOperatorErrorCode;

typedef void (^onStartBlock) (int aTaskID);
typedef void (^onUserCancelBlock) (int aTaskID);
typedef void (^onCompleteBlock) (id result, int aTaskID);
typedef void (^onErrorBlock) (int aTaskID, THttpOperatorErrorCode errorCode);
typedef void (^onParamBlock) (NSString* str);

@interface HttpOperator : NSObject <ASIHTTPRequestDelegate, AopProxyDelegate>


//@property (retain, nonatomic) ASIFormDataRequest* postASIRequset;
@property (nonatomic,strong) AFHTTPRequestOperationManager *postManager;

@property (assign, nonatomic) int iTaskID;
@property (copy, nonatomic) onStartBlock iOnStartBlock;
@property (copy, nonatomic) onUserCancelBlock iOnUserCancelBlock;
@property (copy, nonatomic) onCompleteBlock iOnCompleteBlock;
@property (copy, nonatomic) onErrorBlock iOnErrorBlock;
@property (copy, nonatomic) onParamBlock iOnParamBlock;

-(void) cancel;

-(void)connetStart:(void (^)(int d))aStart cancel:(void (^)(int d)) aCancel error:(void (^)(int d, THttpOperatorErrorCode e)) aError param:(void (^)(NSString* s))aParam complete: (void (^) (id r, int taskid)) aComplete;
-(void)connect;


- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;
- (void)requestStarted:(ASIHTTPRequest *)request;


-(id) getAopInstance:(Class) classTMP returnValue:(Class) returnClass;
//结束动画
-(void)stopAnimation;

@end
