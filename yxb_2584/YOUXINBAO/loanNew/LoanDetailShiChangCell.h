//
//  LoanDetailShiChangCell.h
//  YOUXINBAO
//
//  Created by Feili on 15/8/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseCell.h"
#import "LoanDetaildSliderView.h"
#import "LoginModel.h"
@interface LoanDetailShiChangCell : QCBaseCell

@property (nonatomic, assign)id<SliderViewDelegate>delegate;
@property(nonatomic,strong)LoginModel *model;

@end
