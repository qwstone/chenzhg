//
//  MyLoanCuishouAlert.h
//  YOUXINBAO
//
//  Created by CH10 on 16/4/7.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CTAlertView.h"
@protocol MyLoanCuishouAlertDelegate <NSObject>
/**
 *selected:是否索要视频
 */
-(void)ctAlertAgreeBtnSelected:(BOOL)selected;
@end
@interface MyLoanCuishouAlert : CTAlertView
@property (nonatomic,assign)id<MyLoanCuishouAlertDelegate>delegat;
@property (nonatomic,weak)UILabel *titleLabel;
@property (nonatomic,weak)UIButton *videoRequestBtn;
//@property (nonatomic,copy)NSString *titleStr;
-(void)setMessageWithLenderName:(NSString*)lenderName BorrowName:(NSString*)borrowName;
@end
