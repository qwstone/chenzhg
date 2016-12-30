//
//  ToUnlockView.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/22.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ToUnlockView;

//@protocol ToUnlockDelegate <NSObject>
//
////视图控制器dismiss的时候调用
//-(void)YLCheckToUnlockDidDismiss:(ToUnlockView *)viewController;
//
//@end

@interface ToUnlockView : UIView

@property (nonatomic,strong) UINavigationController *nav;
@property (nonatomic) NSUInteger unmatchCounter;
@property (nonatomic, weak) UILabel *counterLabel;


//@property (BV, assign) id<ToUnlockDelegate> delegate;


- (void)show;
@end
