//
//  QCConsultLixiView.h
//  YOUXINBAO
//
//  Created by pro on 16/5/24.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXBLoanInfoDetails.h"
#import "JieKuanConfig.h"


@protocol ConsultLixiViewDelegate <NSObject>

-(void)ConsultlixiConfirmClick:(NSString*)_newlixi;

@end





@interface QCConsultLixiView : UIView<UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,retain)YXBLoanInfoDetails *model;

@property(assign,nonatomic)id<ConsultLixiViewDelegate>delegate;

-(void)setdata;
@end
