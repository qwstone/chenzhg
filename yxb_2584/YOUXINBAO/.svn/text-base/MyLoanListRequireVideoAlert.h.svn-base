//
//  MyLoanListRequireVideoAlert.h
//  YOUXINBAO
//
//  Created by CH10 on 16/3/23.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CTAlertView.h"
@protocol MyLoanListRequireVideoAlertDelegate <NSObject>
/**
 *selected:是否索要视频
 */
-(void)ctAlertVideoBtnSelected:(BOOL)selected;
@end

@interface MyLoanListRequireVideoAlert : CTAlertView

@property (nonatomic,assign)id<MyLoanListRequireVideoAlertDelegate>delegat;
@property (nonatomic,weak)UILabel *titleLabel;
@property (nonatomic,weak)UILabel *messageLabel;
@property (nonatomic,weak)UIButton *videoRequestBtn;
@property (nonatomic,copy)NSString *titleStr;
@end
