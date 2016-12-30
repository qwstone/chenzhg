//
//  PayJsonTools.h
//  YOUXINBAO
//
//  Created by sky on 15/5/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AopProxy.h"


typedef void (^onJsonStr) (NSString* str);

@interface PayJsonTools : NSObject<AopProxyDelegate>

@property (copy, nonatomic) onJsonStr iOnJsonStr;

-(id) getAopInstance:(Class)class1;

@end
