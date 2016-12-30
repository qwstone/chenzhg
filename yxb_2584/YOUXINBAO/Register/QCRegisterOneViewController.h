//
//  QCRegisterOneViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/6/24.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"

@interface QCRegisterOneViewController : QCBaseViewController

@property (nonatomic,strong) HttpOperator *iHttpOperator;


@end

@interface RegisterTextField : QCBaseTextField

- (id)initWithFrame:(CGRect)frame withLeftText:(NSString *)text;

@end

//增大响应范围
@interface EnlargeButton : UIButton

@property (nonatomic,assign) UIEdgeInsets enlargeInsets;

@end
