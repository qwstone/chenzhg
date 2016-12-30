//
//  HttpRequest.m
//  YOUXINBAO
//
//  Created by zjp on 15/5/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HttpRequest.h"
#import "YXBTool.h"
@implementation HttpRequest


- (id)initWithURL:(NSURL *)newURL
{

    if (self = [super initWithURL:newURL]) {
        [self setDefaultResponseEncoding:NSUTF8StringEncoding];
        [self setNumberOfTimesToRetryOnTimeout:1];
        [self setTimeOutSeconds:10];
        
        [self addRequestHeader:@"x-requested-with" value:@"XMLHttpRequest"];
        [self addRequestHeader:@"Content-Type" value:@"application/json"];
        [self addRequestHeader:@"x-phoneType" value:@"ios"];
        
        [self addRequestHeader:@"x-sysver" value:[[UIDevice currentDevice] systemVersion]];

    }
    return self;
}
@end
