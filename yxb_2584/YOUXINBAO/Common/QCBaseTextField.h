//
//  QCBaseTextField.h
//  YOUXINBAO
//
//  Created by CH10 on 15/3/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QCBaseTextField;

@protocol QCBaseTextFieldDelegate <NSObject>

- (void)baseTextFieldSureButtonDidselected:(QCBaseTextField *)textField;

@end

@interface QCBaseTextField : UITextField

@property (nonatomic,assign) id<QCBaseTextFieldDelegate> selectedDelegate;

@end
