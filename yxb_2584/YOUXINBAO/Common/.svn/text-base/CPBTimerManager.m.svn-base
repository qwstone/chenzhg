//
//  CPBTimerManager.m
//  Test
//
//  Created by CH10 on 14-3-11.
//  Copyright (c) 2014年 CH10. All rights reserved.
//

#import "CPBTimerManager.h"

@interface CPBTimerManager () {
    NSTimer *_timer;
}

@end

@implementation CPBTimerManager


- (void)dealloc
{
    [self stop];
    [_timer release];
    [super dealloc];
}


-(void) stop {
    if (_timer != nil) {
        [_timer invalidate];
//        [_timer release];
//        _timer = nil;//by clb
    }
}

- (void)state {
    if (_timer != nil) {
        [_timer fire];
    }
}
- (id)initWithTimeInterval:(NSTimeInterval)ti userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    self = [super init];
    if (self) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(timerAction:) userInfo:userInfo repeats:yesOrNo];
        [_timer retain];

    }
    return self;
}
- (void)timerAction:(NSTimer *)timer {
    if ([self.delegate respondsToSelector:@selector(CPBTimerManagerAction:)]) {
        [self.delegate CPBTimerManagerAction:self];
    }
}


-(BOOL) timerExist
{
    if (_timer == nil) {
        return NO;
    }
    return YES;
}
@end
