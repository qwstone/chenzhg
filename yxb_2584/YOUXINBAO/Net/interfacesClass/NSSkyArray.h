//
//  NSSkyArray.h
//  AOP
//
//  Created by SKY on 14-4-8.
//  Copyright (c) 2014年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseData.h"

@interface NSSkyArray : BaseData

-(void) decode:(NSString*) str;

@property (retain, nonatomic) NSMutableArray* iArray;
@property (copy, nonatomic) NSString* iClassName;

@property (copy,nonatomic) NSString * errString;
@property (assign,nonatomic) NSInteger errCode;

@end
