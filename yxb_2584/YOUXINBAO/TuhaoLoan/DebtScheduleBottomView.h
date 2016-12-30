//
//  DebtScheduleBottomView.h
//  YOUXINBAO
//
//  Created by Feili on 15/5/5.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^onCancelAllBlock)();

@interface DebtScheduleBottomView : UIView
@property(nonatomic,copy)onCancelAllBlock cancelBlock;//取消全部白条

-(instancetype)initWithFrame:(CGRect)frame cancelBlock:(void(^)())cancelBlock;

@end
