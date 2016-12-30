//
//  NSDictionary+Value.h
//  LotteryApp
//
//  Created by Kiefer on 13-4-2.
//  Copyright (c) 2013年 windo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Value)

- (NSString *)stringValueForKey:(id)aKey;
- (int)intValueForKey:(id)aKey;
- (float)floatValueForKey:(id)aKey;
- (double)doubleValueForKey:(id)aKey;
- (BOOL)boolValueForKey:(id)aKey;
- (NSInteger)integerValueForKey:(id)aKey;
- (long long)longLongValueForKey:(id)aKey;

@end
