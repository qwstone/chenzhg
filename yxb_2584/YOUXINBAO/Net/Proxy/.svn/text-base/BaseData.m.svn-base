//
//  BaseData.m
//  AOP
//
//  Created by SKY on 14-3-20.
//  Copyright (c) 2014年 sky. All rights reserved.
//

#import "BaseData.h"
#import <objc/runtime.h>

@implementation BaseData

- (void)dealloc
{
    [super dealloc];
}

-(void) decodeWithDic:(NSDictionary*) dic {
    unsigned int propsCount;
    //新增 遍历基类属性  //by clb
    NSObject *obj = [[[self class] alloc] init];
    
    while (obj) {
        objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
        for(int i = 0;i < propsCount; i++) {
            objc_property_t prop = props[i];
            id value = nil;
            
            @try {
                NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
                
                //            NSString* tmpStr = [NSString stringWithUTF8String:property_getAttributes(prop)];
                //            NSLog(@"propName %@",propName);
                value = [dic objectForKey:propName];
                if(value != nil) {
                    
                    if ([value isKindOfClass:[NSArray class]]) {
                        NSArray* arrValue = (NSArray*) value;
                        [self decodeWithSubArray:arrValue withPropertyName:propName];
                    }
                    else {
                        [self setValue:value forKey:propName];
                    }
                    
                }
            }
            @catch (NSException *exception) {
                //            [self logError:exception];
            }
            
        }
        
        obj = [[obj.superclass alloc] init];
        
    }
    
    
}

-(void) decode:(NSString*) str {
    
    NSError* error = nil;
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"dict == %@",dic);
    [self decodeWithDic:dic];
}


-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {

}

-(NSMutableDictionary*) getYxbDic {
    NSMutableDictionary* dic = [[[NSMutableDictionary alloc] init] autorelease];
//    [dic setObject:@"aaa" forKey:@"key"];
    
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([self class], &propsCount);
    for(int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        id value = nil;
        
        @try {
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
//                        NSLog(@"propName %@",propName);
            value = [self valueForKey:propName];
//            Class subClass = [value class];
//            NSString* tmp = NSStringFromClass(subClass);
//            NSLog(@"tmp class name  = %@", tmp);
            if(value != nil) {
                
                if ([value isKindOfClass:[NSArray class]]) {

                }
                else {
                    [dic setObject:value forKey:propName];
                }
                
            }
        }
        @catch (NSException *exception) {
            //            [self logError:exception];
        }
        
    }
    
    return dic;
}


@end
