//
//  CalculatorViewNew.h
//  YOUXINBAO
//
//  Created by zjp on 15/12/16.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXBTool.h"
@protocol CalculatorViewNewDelegate <NSObject>
@optional
- (void)pushChongzhiWebView;

@end
@interface CalculatorViewNew : UIView<UICollisionBehaviorDelegate,UITextFieldDelegate>

@property (nonatomic, assign) id <CalculatorViewNewDelegate>delegate;

@property (nonatomic, assign) BOOL      calculatorType;//默认为红利计算器NO   YES为理财计算器


//红包计算器
@property (nonatomic, copy)NSString     *lilv;


//理财计算器
@property (nonatomic, copy)NSString     *annualizedReturn;//年化收益
@property (nonatomic, copy)NSString     *limit;//投资期限


@end
