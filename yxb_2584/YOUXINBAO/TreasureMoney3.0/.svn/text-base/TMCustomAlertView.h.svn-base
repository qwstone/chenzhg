//
//  TMCustomAlertView.h
//  YOUXINBAO
//
//  Created by CH10 on 15/12/15.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TMCustomAlertViewDelegate <NSObject>

-(void)btnClickedAtIndex:(NSInteger)index Tag:(NSUInteger)tag;

@end



@interface TMCustomAlertView : UIView
@property (nonatomic,assign) id<TMCustomAlertViewDelegate>delegate;

@property (weak, nonatomic)  UIView *alertView;
@property (weak, nonatomic)  UIButton *cancleBtn;
@property (weak, nonatomic)  UIButton *chongzhiBtn;
@property (weak, nonatomic)  UILabel *titleLabel;
@property (weak, nonatomic)  UILabel *messageLabel1;
@property (weak, nonatomic)  UILabel *messageLabel2;
-(void)updateAlertWithTitle:(NSString *)title Message1:(NSString *)message1 Message2:(NSString *)message2 CancleBtnTitle:(NSString *)cancleBtnTitle SureBtnTitle:(NSString *)sureBtnTitle;
@end
