//
//  HttpOperator.m
//  AOP
//
//  Created by SKY on 14-3-19.
//  Copyright (c) 2014年 sky. All rights reserved.
//

#import "HttpOperator.h"
#import "ASIFormDataRequest.h"
#import "HttpTools.h"
#import "BaseData.h"
#import "YXBTool.h"
#import "QCDeviceManager.h"
#import "QCLoginOneViewController.h"
#import "MsgCenterInstance.h"

#define TMPT_SERVER_URL [NSString stringWithFormat:@"%@api.jsp",YXB_IP_ADRESS]

@interface HttpOperator ()

@property (retain, nonatomic) NSString* iNSStringFromClass;

@end

@implementation HttpOperator

@synthesize iNSStringFromClass;

-(void) deleteBlock {
    if (_iOnStartBlock != nil) {
        Release(_iOnStartBlock);
//        self.iOnStartBlock = nil;

    }
    if (_iOnCompleteBlock != nil) {
        Release(_iOnCompleteBlock);

//        self.iOnCompleteBlock = nil;
        
    }
    if (_iOnErrorBlock != nil) {
        Release(_iOnErrorBlock);

//        self.iOnErrorBlock = nil;
        
    }

    if (_iOnParamBlock != nil) {
        Release(_iOnParamBlock);

//        self.iOnParamBlock = nil;
        
    }
    if (self.iNSStringFromClass != nil) {
        self.iNSStringFromClass = nil;
        
    }
    /*
    self.iOnStartBlock = nil;
    self.iOnCompleteBlock = nil;
    self.iOnErrorBlock = nil;
    self.iOnParamBlock = nil;
    self.iNSStringFromClass = nil;
     */
    

    
}

- (void)dealloc
{
    [self.postManager clearDelegatesAndCancel];
    _postManager = nil;
    self.iOnUserCancelBlock = nil;
    self.iNSStringFromClass = nil;
    [self deleteBlock];
    [super dealloc];
}


- (id)init
{
    self = [super init];
    if (self) {
        self.iTaskID = 1000;
    }
    return self;
}


-(id) getAopInstance:(Class) class returnValue:(Class) returnClass {
        
    self.iNSStringFromClass = NSStringFromClass(returnClass);
    
    id res = [[AopProxy alloc] initWithNewInstanceOfClass:class delegate:self];
    return res;
}

-(void)connect {
    
    _iTaskID++;
    if (_iTaskID >= 999999) {
        _iTaskID = 0;
    }
    
    
    if (self.iOnParamBlock == nil) {
        return;
    }
    
    self.iOnParamBlock(@"aa");
    
}

//-(void)connetStart:(void (^)(int d))aStart cancel:(void (^)(int d)) aCancel {
-(void)connetStart:(void (^)(int d))aStart cancel:(void (^)(int d)) aCancel error:(void (^)(int d, THttpOperatorErrorCode e)) aError param:(void (^)(NSString* s))aParam complete: (void (^) (id r, int taskid)) aComplete {
    self.iOnStartBlock = aStart;
    self.iOnUserCancelBlock = aCancel;
    self.iOnErrorBlock = aError;
    self.iOnCompleteBlock = aComplete;
    self.iOnParamBlock = aParam;
}

///
-(void) cancel {
    [self stopAnimation];
    [self.postManager clearDelegatesAndCancel];
    if (self.iOnUserCancelBlock != nil) {
        self.iOnUserCancelBlock(_iTaskID);
        self.iOnUserCancelBlock  = nil;
    }
    [self deleteBlock];
}


//开始动画
-(void)startAnimation
{
    QCBaseViewController *baseVC = (QCBaseViewController *)[[YXBTool getCurrentNav] topViewController];
    if ([baseVC respondsToSelector:@selector(stopDefaultAnimation)]) {
        [baseVC layoutDefaultAnimation];
        
    }
    
}

//结束动画
-(void)stopAnimation
{
    QCBaseViewController *baseVC = (QCBaseViewController *)[[YXBTool getCurrentNav] topViewController];
    if ((baseVC != nil) && [baseVC respondsToSelector:@selector(stopDefaultAnimation)])
    {
        [baseVC stopDefaultAnimation];
        
    }

}
-(void) invokeClass:(NSString*) className method:(NSString*) methodName args:(NSArray*) args
{
    NSData* jsonData = [HttpTools getProxyJson:className method:methodName args:args];
    NSString* paramsString = [NSString stringWithFormat:@"json=%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
//    post date 打印
    NSData* postData = [paramsString dataUsingEncoding:NSUTF8StringEncoding];

    NSLog(@"post data:%@", paramsString);

    NSString* urlStr = TMPT_SERVER_URL;//@"http://www.baidu.com";
    NSLog(@"request's url is ===%@", urlStr);
    NSMutableURLRequest *request =
    [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]] autorelease];
    [request setHTTPMethod:@"POST"];
    [QCConfigTool setHttpSystemHeaderWithAFNManager:request];

    [request setHTTPBody:postData];

    
    self.postManager = [[[AFHTTPRequestOperationManager alloc] init] autorelease];

    __block typeof(self)this = self;
    NSOperation *operation = [self.postManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation1, id responseObject) {
        
        __strong __typeof(this)strongSelf = this;

        NSLog(@"operation1---%@,===%@",operation1,responseObject);

        
        if (![operation1 isCancelled])
        {
            [strongSelf afnetWorkingFinishedWithOperation:operation1 responseObject:responseObject];

        }

    } failure:^(AFHTTPRequestOperation *operation1, NSError *error) {
        __strong __typeof(this)strongSelf = this;
        NSLog(@"operation1---%@",operation1);

        if (![operation1 isCancelled])
        {
            [strongSelf afnetWorkingFailedWithError:error operation:operation1];

        }

    }];
    

    [self.postManager.operationQueue addOperation:operation];
    
    if (self.iOnStartBlock != nil) {
//        NSLog(@"requestHeaders ---%@",request.requestHeaders);
//        [self startAnimation];
        self.iOnStartBlock(_iTaskID);
        
        
    }
    
    
}

-(void)afnetWorkingFinishedWithOperation:(AFHTTPRequestOperation *)operation responseObject:(NSDictionary *)response
{
 
    __block typeof(self)this = self;
    [this stopAnimation];

    if ((![response isKindOfClass:[NSDictionary class]])  && (![response isKindOfClass:[NSArray class]])) {
        [ProgressHUD showErrorWithStatus:@"返回数据格式错误"];
        return;
        
    }
    NSError * err;
    NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:response options:0 error:&err];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonString);
    if (operation.response.statusCode != 200) {
        if (this.iOnErrorBlock) {
            this.iOnErrorBlock(this.iTaskID, EHttp_Operator_StatusCodeError);
            
        }
        return;
    }
    //request.responseString 数据打印
    NSLog(@"request.responseString = %@", operation.response);
    
    if (this.iOnCompleteBlock != nil) {
        
        if (this.iNSStringFromClass != nil) {
            Class class = NSClassFromString(this.iNSStringFromClass);
            BaseData* obj = [[[class alloc] init] autorelease];
            
            [obj decode:jsonString];
            
            
            //跳转前置条件处理  登录失败、轮询
            if ([self isPreprocessingFinishedWithObject:obj]) {
                this.iOnCompleteBlock(obj, _iTaskID);
                
            };
            
        }
        else {
            this.iOnCompleteBlock(nil, _iTaskID);
        }
        
        
    }
    
    
}

-(void)afnetWorkingFailedWithError:(NSError *)error operation:(AFHTTPRequestOperation *)operation
{
    __block typeof(self)this = self;
    [this stopAnimation];

    //-999 取消请求的时候会提示
    if (error.code != -999 && operation.response.statusCode != 200) {
        NSLog(@"operation.response.statusCode===%ld",(long)operation.response.statusCode);
        
        NSLog(@"operation.response.statusString===%ld",(long)operation.responseString);

//        [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error.localizedDescription]];
        if (operation.response.statusCode == 500) {
//            [KVNProgress dismiss];
//            [ProgressHUD showErrorWithStatus:@"服务器异常!"];
            if (self.iOnErrorBlock) {
                self.iOnErrorBlock(0,EHttp_Operator_StatusCodeError);
            }
        }
        else
        {
            if (![operation isCancelled])
            {
                self.iOnErrorBlock(0,EHttp_Operator_Failed);

                [KVNProgress dismiss];
                [ProgressHUD showErrorWithStatus:@"网络连接错误!"];

            }

        }
        

    }
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"以前的ASI已替换成afn请求回调-requestFinished");
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"以前的ASI已替换成afn请求回调-requestFailed");

}

-(void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"以前的ASI已替换成afn请求回调-requestStarted");

}


/**
 成功block回调之前的处理
 */

-(BOOL)isPreprocessingFinishedWithObject:(BaseData *)baseData
{
    BOOL isSuccess = YES;
    if (baseData) {
        //处理轮询
        if (baseData.hasNewMsg > 0) {
            [MsgCenterInstance invokePollingRequest];
        }
        //编号为 -9999跳转登录
        if (baseData.errCode == [YXBToLoginKey integerValue]) {
            QCUserModel *um = [[QCUserManager sharedInstance] getLoginUser];
            //                NSString *username = um.user.username;
            um.isLogin = NO;
            //                um = nil;
            //                um.user.username = username;
            [[QCUserManager sharedInstance] setLoginUser:um];
            
            QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
            UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
            loginView.isShixiao = YES;
            [[YXBTool getCurrentNav] presentViewController:loginNav animated:YES completion:nil ];
            //                [YXBTool toLoginYXB];
            isSuccess = NO;
        }
        
    }
    return isSuccess;
}


@end
