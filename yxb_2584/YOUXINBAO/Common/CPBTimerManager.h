//
//  CPBTimerManager.h
//  Test
//
//  Created by CH10 on 14-3-11.
//  Copyright (c) 2014年 CH10. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CPBTimerManager;

@protocol CPBTimerDelegate <NSObject>

@optional
- (void)CPBTimerManagerAction:(CPBTimerManager *)timer;

@end

@interface CPBTimerManager : NSObject

@property (nonatomic, assign) id<CPBTimerDelegate> delegate;

- (id)initWithTimeInterval:(NSTimeInterval)ti userInfo:(id)userInfo repeats:(BOOL)yesOrNo;

-(void) stop;
-(void) state;
-(BOOL) timerExist;
@end
