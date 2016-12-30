//
//  AopProxy.h
//  AOP
//
//  Created by SKY on 14-3-20.
//  Copyright (c) 2014年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AopProxyDelegate <NSObject>

-(void) invokeClass:(NSString*) className method:(NSString*) methodName args:(NSArray*) args;

@end

/**
 *  借助NSProxy实现aop横向切片监视接口调用
 *
 *  @author SKY
 */
@interface AopProxy : NSProxy <NSObject> {
    
    id<AopProxyDelegate> _delegate;
@protected
    id parentObject;
}

@property (assign, nonatomic)  id<AopProxyDelegate> delegate;


/*!
 @method     initWithInstance:
 @abstract   Creates a new proxy with using the instance provided as the parameter.
 */
- (id) initWithInstance:(id)anObject;

/*!
 @method     initWithNewInstanceOfClass:
 @abstract   Creates a new proxy and forwards all calls to a new instance of the specified class
 */
- (id) initWithNewInstanceOfClass:(Class) classTMP delegate:(id) aDelegate;

@end
