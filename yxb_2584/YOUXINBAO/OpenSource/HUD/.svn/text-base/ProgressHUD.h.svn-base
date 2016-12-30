//
//  ProgressHUD.h
//
//  Created by Sam Vermette on 27.03.11.
//  Copyright 2011 Sam Vermette. All rights reserved.
//
//

#import <UIKit/UIKit.h>

// To disable SVProgressHUD's control of the network activity indicator by default,
// add -DSVPROGRESSHUD_DISABLE_NETWORK_INDICATOR to CFLAGS in build settings.

enum {
    ProgressHUDMaskTypeNone = 1, // allow user interactions while HUD is displayed
    ProgressHUDMaskTypeClear, // don't allow
    ProgressHUDMaskTypeBlack, // don't allow and dim the UI in the back of the HUD
    ProgressHUDMaskTypeGradient // don't allow and dim the UI with a a-la-alert-view bg gradient
};

typedef NSUInteger ProgressHUDMaskType;

//自定义加载提示框
enum {
    ProgressHUDTipsTypeNone = 1, //屏幕中心提示
    ProgressHUDTipsTypeBottom,   //屏幕底部提示
    ProgressHUDTipsTypeLongBottom
};

typedef NSUInteger ProgressHUDTipsType;

@interface ProgressHUD : UIWindow

+ (void)show;
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString*)status networkIndicator:(BOOL)show;
+ (void)showWithStatus:(NSString*)status maskType:(ProgressHUDMaskType)maskType tipsType:(ProgressHUDTipsType)tipsType;
+ (void)showWithStatus:(NSString*)status maskType:(ProgressHUDMaskType)maskType tipsType:(ProgressHUDTipsType)tipsType networkIndicator:(BOOL)show;
+ (void)showWithMaskType:(ProgressHUDMaskType)maskType;
+ (void)showWithMaskType:(ProgressHUDMaskType)maskType networkIndicator:(BOOL)show;

+ (BOOL)isShow;

+ (void)showSuccessWithStatus:(NSString*)string;
+(void) showErrorWithStatus:(NSString*)string;

+ (void)setStatus:(NSString*)string; // change the HUD loading status while it's showing

+ (void)dismiss; // simply dismiss the HUD with a fade+scale out animation
+ (void)dismissAfterDelay:(NSTimeInterval)seconds;
+ (void)dismissWithSuccess:(NSString*)successString; // also displays the success icon image
+ (void)dismissWithSuccess:(NSString*)successString afterDelay:(NSTimeInterval)seconds;
+ (void)dismissWithError:(NSString*)errorString; // also displays the error icon image
+ (void)dismissWithError:(NSString*)errorString afterDelay:(NSTimeInterval)seconds;

@end