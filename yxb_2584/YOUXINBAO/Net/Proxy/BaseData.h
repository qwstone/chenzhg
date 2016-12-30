//
//  BaseData.h
//  AOP
//
//  Created by SKY on 14-3-20.
//  Copyright (c) 2014年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseData : NSObject

/**  field  错误编号 */

@property (nonatomic, assign) NSInteger  errCode;
@property (nonatomic, assign) NSInteger  hasNewMsg;//是否有轮询请求

-(void) decode:(NSString*) str;

-(void) decodeWithDic:(NSDictionary*) dic;

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name;

-(NSMutableDictionary*) getYxbDic;

@end
