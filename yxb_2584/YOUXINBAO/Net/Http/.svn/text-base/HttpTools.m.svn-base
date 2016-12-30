//
//  HttpTools.m
//  AOP
//
//  Created by SKY on 14-3-20.
//  Copyright (c) 2014年 sky. All rights reserved.
//

#import "HttpTools.h"
#import "NSSkyDouble.h"

@implementation HttpTools


+(NSData*) getProxyJson:(NSString*) class method: (NSString*) method args:(NSArray*) argsV {
    NSMutableDictionary* dic = [[[NSMutableDictionary alloc] init] autorelease];
    
    NSString* methodName = method;

    NSRange range = [method rangeOfString:@":"];
    if (range.length == 1 && range.location >= 1) {
        methodName = [method substringToIndex:range.location];
    }
    
    [dic setObject:methodName forKey:@"methodName"];
    [dic setObject:class forKey:@"proxy"];
    NSMutableArray* args = [[[NSMutableArray alloc] initWithCapacity:[argsV count] + 1] autorelease];
    NSMutableArray* argsclass = [[[NSMutableArray alloc] initWithCapacity:[argsV count] + 1] autorelease];
    
    for (id obj in argsV) {
        
        NSString* agrsclassV = @"java.lang.String"; //java.lang.Integer
        
        if ([obj isKindOfClass:[NSSkyDouble class]]) {
            agrsclassV = @"java.lang.Double";
            NSSkyDouble* tmp = (NSSkyDouble*) obj;
            [args addObject:[NSNumber numberWithDouble:tmp.iDoubleValue]];
        }
        else {
            [args addObject:obj];
        }
        
        if ([obj isKindOfClass:[NSNumber class]]) {
            agrsclassV = @"java.lang.Integer";
        }
        [argsclass addObject:agrsclassV];
    }
    
    [dic setObject:args forKey:@"args"];
    [dic setObject:argsclass forKey:@"argsclass"];
    
//    return nil;
    NSError *error;
    return [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];

}

@end
