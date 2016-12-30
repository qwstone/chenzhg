//
//  HttpTools.h
//  AOP
//
//  Created by SKY on 14-3-20.
//  Copyright (c) 2014年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTools : NSObject


+(NSData*) getProxyJson:(NSString*) class method: (NSString*) method args:(NSArray*) args;

@end
