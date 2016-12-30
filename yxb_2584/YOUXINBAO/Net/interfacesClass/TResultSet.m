//
//  TResultSet.m
//  YOUXINBAO
//
//  Created by CH10 on 14-6-6.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TResultSet.h"
#import <objc/runtime.h>

@implementation TResultSet
@dynamic errCode;

//- (void)dealloc {
//    self.resString = nil;
//    [super dealloc];
//}

-(void) decodeWithDic:(NSDictionary*) dic {
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([self class], &propsCount);
    for(int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        id value = nil;
        
        @try {
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            //            NSLog(@"propName %@",propName);
            value = [dic objectForKey:propName];
            if(value != nil) {
                [self setValue:value forKey:propName];
            }
        }
        @catch (NSException *exception) {
            //            [self logError:exception];
        }
        
    }
    
    
}

-(void) decode:(NSString*) str {
    
    NSError* error = nil;
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
//    NSLog(@"dict == %@",dic);
    [self decodeWithDic:dic];
}




@end
