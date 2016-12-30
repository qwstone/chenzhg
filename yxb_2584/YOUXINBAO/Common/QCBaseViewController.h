//
//  QCBaseViewController.h
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCConst.h"
#import "QCUserModel.h"
#import "QCUserManager.h"
#import "UIView+ViewFrameGeometry.h"
#import "QCBaseTableView.h"
#import "HttpOperator.h"
#import "UITabBar+badge.h"

@interface QCBaseViewController : UIViewController


- (void)toLogin;
// 设置UINvigationBar 左右键方法
- (void)setNavigationButtonItrmWithiamge:(NSString *)imagename withRightOrleft:(NSString*)f withtargrt:(id)t withAction:(SEL)s;

//创建一个UITextField 方法
- (void)CreateTextFieldWithFrame:(CGRect)frame withCapacity:(NSString *)placeholder withSecureTextEntry:(BOOL)isSecoure withTargrt:(id)t withTag:(NSInteger)tag view:(UIView *)view;
//创建一个UIButton 方法
- (void)createButtonWithframe:(CGRect)btnframe withImage:(NSString *)image withView:(UIView *)cview withTarget:(id)t withAcation:(SEL)s withTag:(NSInteger)tag;
//创建一个UIlabel 方法
- (void)CreateLabel:(NSString *)text frame:(CGRect)frame withView:(UIView *)view textAlignment:(NSInteger)num fontSize:(NSInteger)size textColor:(UIColor*)color;
//是否有网络连接
- (BOOL) isConnectionAvailable;

//提示
- (void)showLoadingWithTitle:(NSString *)text imageName:(NSString *)fileName;
- (void)hideLoading;


- (void)getkeyboundheight;

- (void)removeKeyBoundNotification;

- (void)keyboardShow:(NSNotification *)aNotification;

- (void)keyboardHide:(NSNotification *)aNotification;

-(void)backDefault;

-(void)setBackView;

-(void)setLeftView;

-(void)leftClicked;

//添加默认动画
-(void)layoutDefaultAnimation;

//结束动画
-(void)stopDefaultAnimation;

- (void)httpLoadCancel;
- (void)httpLoadError:(THttpOperatorErrorCode) error;
- (void)httpLoadComplete:(id)r;

@end
