//
//  SetMessageReadManager.h
//  YOUXINBAO
//
//  Created by Walice on 15/8/7.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpOperator.h"

@interface SetMessageReadManager : NSObject

@property (retain, nonatomic) HttpOperator* iHttpOperator;

+ (id)sharedInstance;

- (void)setMessageRead:(NSString *)messageId;



- (void)setAllMessageRead;

@end
