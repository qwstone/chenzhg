//
//  CTAlertView.h
//  LearningRoad
//
//  Created by CH10 on 16/3/14.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CTAlertViewDelegate;

@interface CTAlertView : UIView

@property (nonatomic,assign)id<CTAlertViewDelegate>delegate;
@property (nonatomic,weak) UIView *contentView;
/**
 *底部按钮的背景颜色
 */
@property (nonatomic,weak) UIColor *btnBgColor;
/**
 *底部按钮标题颜色
 */
@property (nonatomic,weak) UIColor *btnTextColor;
/**
 *底部按钮背景框颜色
 */
@property (nonatomic,weak) UIColor *rectColor;

@property (nonatomic,weak) UIView *btnBgView;
-(void)alertShow;
-(void)alertHidden;

-(instancetype)initWithFrame:(CGRect)frame delegate:(id<CTAlertViewDelegate>)delegate btnHeight:(CGFloat)btnHeight cancleBtnTitle:(NSString*)cancleBtnTitle otherBtnTitle:(NSArray *)otherBtnTitles;
+(instancetype)ctAlertWithFrame:(CGRect)frame delegate:(id<CTAlertViewDelegate>)delegate btnHeight:(CGFloat)btnHeight cancleBtnTitle:(NSString*)cancleBtnTitle otherBtnTitle:(NSArray *)otherBtnTitles;
@end


@protocol CTAlertViewDelegate <NSObject>
@optional
/**
 *index: 0 取消、1 2 3 other
 */
-(void)ctAlertView:(CTAlertView *)alertView didClickedBtnAtIndex:(NSInteger)index;

@end
