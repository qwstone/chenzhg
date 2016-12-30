//
//  PayJsonTools.m
//  YOUXINBAO
//
//  Created by sky on 15/5/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "PayJsonTools.h"
#import "HttpTools.h"

@implementation PayJsonTools


-(void) invokeClass:(NSString*) className method:(NSString*) methodName args:(NSArray*) args {
    NSData* jsonData = [HttpTools getProxyJson:className method:methodName args:args];
    NSString* paramsString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (self.iOnJsonStr != nil) {
        self.iOnJsonStr(paramsString);
    }
}


-(id) getAopInstance:(Class) class1 {
    id res = [[AopProxy alloc] initWithNewInstanceOfClass:class1 delegate:self];
    return res;
}

@end
