//
//  DebtDetailFooterView.h
//  YOUXINBAO
//
//  Created by Feili on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DebtDetailFooterViewDelegate <NSObject>

@required
-(void)findToLoan;//找他借款点击事件

@end

@interface DebtDetailFooterView : UIView

@property(nonatomic,assign)id<DebtDetailFooterViewDelegate>delegate;
@end
