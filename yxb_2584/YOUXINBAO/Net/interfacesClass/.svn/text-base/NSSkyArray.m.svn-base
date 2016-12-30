//
//  NSSkyArray.m
//  AOP
//
//  Created by SKY on 14-4-8.
//  Copyright (c) 2014年 sky. All rights reserved.
//
#import <objc/runtime.h>
#import "NSSkyArray.h"
#import "BaseData.h"
#import "AAFlowImageModel.h"


@implementation NSSkyArray
@dynamic errCode;

//- (void)dealloc
//{
//    self.iArray = nil;
//    self.iClassName = nil;
//    [super dealloc];
//}

- (id)init
{
    self = [super init];
    if (self) {
        self.iArray = [[NSMutableArray alloc] init];
        self.iClassName = nil;
    }
    return self;
}


-(void) decode:(NSString*) str {
    //    self.name = @"ZM";
    NSError* error = nil;
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    
    id arrValue = [dic objectForKey:@"value"];
    id className = [dic objectForKey:@"className"];
    NSNumber  *errCode = [dic objectForKey:@"errCode"];
    id errString = [dic objectForKey:@"errString"];
    NSNumber *hasNewMsg = [dic objectForKey:@"hasNewMsg"];

    
    if (arrValue != nil && className != nil) {
        NSArray* arr = (NSArray*) arrValue;
//        NSLog(@"arr = %@", arr);
        self.iClassName = (NSString*) className;
        self.errCode = [errCode integerValue];
        self.errString = (NSString *)errString;
        self.hasNewMsg = [hasNewMsg integerValue];

        Class class = NSClassFromString(className);
        
        if ([self.iClassName isEqualToString:@"Map"]) {
            for (int i = 0; i < [arr count]; i++) {
                NSDictionary* dicClass = [arr objectAtIndex:i];
                [self.iArray addObject:dicClass];
            }
        }else {
            for (int i = 0; i < [arr count]; i++) {
                NSDictionary* dicClass = [arr objectAtIndex:i];
                BaseData* obj = [[class alloc] init];
                [obj decodeWithDic:dicClass];
                [self.iArray addObject:obj];
            }
            
        }
        
        
       
    }
    
}


@end
