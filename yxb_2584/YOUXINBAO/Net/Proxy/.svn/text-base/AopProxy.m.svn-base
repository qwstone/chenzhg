//
//  AopProxy.m
//  AOP
//
//  Created by SKY on 14-3-20.
//  Copyright (c) 2014年 sky. All rights reserved.
//
#import "AopProxy.h"
#import "NSSkyDouble.h"
#import "BaseData.h"

@implementation AopProxy

@synthesize delegate = _delegate;

- (void)dealloc
{
    [parentObject release];
    _delegate = nil;
    [super dealloc];
}


- (id) initWithInstance:(id)anObject {
    
    parentObject = [anObject retain];
    return self;
}

//- (id) initWithNewInstanceOfClass:(Class) class {
- (id) initWithNewInstanceOfClass:(Class) class delegate:(id) aDelegate {
    
    // create a new instance of the specified class
    id newInstance = [[class alloc] init];
    
    // invoke my designated initializer
    [self initWithInstance:newInstance];
    self.delegate = aDelegate;
    
    // release the new instance
    [newInstance release];
    
    // finally return the configured self
    return self;
}

- (BOOL)isKindOfClass:(Class)aClass;
{
    return [parentObject isKindOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol;
{
    return [parentObject conformsToProtocol:aProtocol];
}

- (BOOL)respondsToSelector:(SEL)aSelector;
{
    return [parentObject respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;
{
    return [parentObject methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation;
{
    
    NSMethodSignature* sign = [anInvocation methodSignature];
    
    NSString* SELName = NSStringFromSelector([anInvocation selector]);
    NSString* className = NSStringFromClass([parentObject class]);
    
    NSInteger numberOfArgs = [[anInvocation methodSignature] numberOfArguments];
    
    NSMutableArray *args = [[[NSMutableArray alloc] initWithCapacity:5] autorelease];
//    NSInteger count3 = [args count];
    
    
    if ([SELName hasPrefix:@"__yxb__"] || [SELName hasPrefix:@"__yxb_service__"]) {
        id ref;
        [anInvocation getArgument:&ref atIndex:2];
       // BaseData* ddd = nil;
        Class subClass = [ref class];
        NSString* tmp = NSStringFromClass(subClass);
        __typeof(subClass)  subBaseData = (__typeof(subClass) ) ref;
        [args addObject:[subBaseData getYxbDic]];
        [args addObject:tmp];
        [self.delegate invokeClass:className method:SELName args:args];
        return;
    }
    
    id ref;
    for (int i = 2; i < numberOfArgs; i++) {
        [anInvocation getArgument:&ref atIndex:i];
        NSString* s = [NSString stringWithUTF8String: [sign getArgumentTypeAtIndex:i]];
        if ([s isEqualToString:@"i"] || [s isEqualToString:@"q"] || [s isEqualToString:@"l"]) {
            NSInteger intV = (NSInteger)ref;
            [args addObject:[NSNumber numberWithInteger:intV]];
        }
        else if ([s isEqualToString:@"d"]) {
            double doubleVale = 0;
            [anInvocation getArgument:&doubleVale atIndex:i];
            
            NSSkyDouble* tmp = [[[NSSkyDouble alloc] initWithDouble:doubleVale] autorelease];
            [args addObject:tmp];
            
        }

        else {
            if(ref != nil)
            {
                [args addObject:ref];

            }
        }
    }    
    [self.delegate invokeClass:className method:SELName args:args];
    
    //    //获得返回值类型
    //    const char *returnType = sign.methodReturnType;
    //    NSUInteger length = [sign methodReturnLength];
    //    //声明返回值变量
    //    id returnValue;
    ////     [anInvocation getReturnValue:&returnValue];
    //    //如果没有返回值，也就是消息声明为void，那么returnValue=nil
    //    if( !strcmp(returnType, @encode(void)) ){
    //        returnValue =  nil;
    //    }
    //    //如果返回值为对象，那么为变量赋值
    //    else if( !strcmp(returnType, @encode(id)) ){
    //        [anInvocation getReturnValue:&returnValue];
    //        if (returnValue != nil) {
    //            if ([returnValue isKindOfClass:[NSString class]]) {
    //
    //            }
    //        }
    //    }
    //    else{
    //        //如果返回值为普通类型NSInteger  BOOL
    //
    //        //返回值长度
    //        NSUInteger length = [sign methodReturnLength];
    //        //根据长度申请内存
    //        void *buffer = (void *)malloc(length);
    //        //为变量赋值
    //        [anInvocation getReturnValue:buffer];
    //
    //        NSData* dataV = [[NSData alloc] initWithBytes:buffer length:length];
    //
    ////        NSString* ss = [[[NSString alloc] initWithBytes:buffer length:length encoding:NSUTF8StringEncoding] autorelease];
    //
    //        //以下代码为参考:具体地址我忘记了，等我找到后补上，(很对不起原作者)
    //        if( !strcmp(returnType, @encode(BOOL)) ) {
    //            returnValue = [NSNumber numberWithBool:*((BOOL*)buffer)];
    //        }
    //        else if( !strcmp(returnType, @encode(NSInteger)) ){
    //            returnValue = [NSNumber numberWithInteger:*((NSInteger*)buffer)];
    //        }
    //        returnValue = [NSValue valueWithBytes:buffer objCType:returnType];
    //    }
    
    // check if the parent object responds to the selector ...
    //    if ( [parentObject respondsToSelector:aSelector] ) {
    //
    //        //
    //        // Invoke the original method ...
    //        //
    //        [anInvocation setTarget:parentObject];
    //        [anInvocation invoke];
    //    } 
    
}

@end
