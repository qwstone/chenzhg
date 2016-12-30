//
//  MessageCodeMangger.h
//  YOUXINBAO
//
//  Created by Walice on 16/1/13.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageCodeMangger;

@protocol MessageCodeManggerDelegate <NSObject>

@optional
- (void)MessageCodeManggerAction:(MessageCodeMangger *)messageManage;

@end


@interface MessageCodeMangger : NSObject


@property(nonatomic,assign)NSInteger time;
@property(nonatomic,strong) NSTimer *timer;
@property (nonatomic, strong) id<MessageCodeManggerDelegate> delegate;
+(MessageCodeMangger *)sharedInstanceWithDelegate:(id<MessageCodeManggerDelegate>)delegate;
-(void) stop;
- (void)state;
-(void)start;
@end
