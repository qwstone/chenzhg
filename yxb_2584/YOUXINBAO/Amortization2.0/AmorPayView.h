//
//  AmorPayView.h
//  YOUXINBAO
//
//  Created by Feili on 15/9/18.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmorConfig.h"

@protocol AmorPayViewDelegate <NSObject>

-(void)amorPayViewPayButtonSelectedWithAmorType:(AmorOrderPayType)payType;

@end

@interface AmorPayView : UIView

@property(nonatomic,assign)id <AmorPayViewDelegate> delegate;
@property(nonatomic,assign)NSInteger buttonType;//按钮个数类型
@end
