//
//  UIAlertView+Block.h
//  LotteryApp
//
//  Created by Feili on 14/12/10.
//  Copyright (c) 2014年 windo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CompleteBlock) (NSInteger buttonIndex);

@interface UIAlertView (Block)
// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showAlertViewWithCompleteBlock:(CompleteBlock) block;


@end
