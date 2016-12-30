//
//  MessageCodeMangger.m
//  YOUXINBAO
//
//  Created by Walice on 16/1/13.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MessageCodeMangger.h"
static MessageCodeMangger *messageManage=nil;
@implementation MessageCodeMangger

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.time=60;
    }
    return self;
}

+(MessageCodeMangger *)sharedInstanceWithDelegate:(id<MessageCodeManggerDelegate>)delegate {
    @synchronized(self){
        if(messageManage == nil){
            messageManage = [[MessageCodeMangger alloc] init];
            
        }
    }
    messageManage.delegate = delegate;
    return messageManage;
}
- (void)timerAction:(NSTimer *)timer {
    
    _time--;
    if ([self.delegate respondsToSelector:@selector(MessageCodeManggerAction:)]) {
        [self.delegate MessageCodeManggerAction:messageManage];
    }
}

- (void)setTime:(NSInteger)time{
    if (_time!=time) {
        _time=time;
    }
    
    
}

-(void)start
{
    messageManage.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:messageManage selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
}

-(void) stop {
    if (_timer != nil) {
        [_timer invalidate];
        _timer=nil;
    }
}

- (void)state {
    if (_timer != nil) {
        [_timer fire];
    }
}


@end
