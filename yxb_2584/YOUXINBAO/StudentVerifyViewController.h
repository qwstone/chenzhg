//
//  StudentVerifyViewController.h
//  YOUXINBAO
//
//  Created by Feili on 15/8/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "StudentCell.h"

@interface StudentVerifyViewController : QCBaseViewController<UITextFieldDelegate>

@property(nonatomic,strong)UIButton *commitBtn ;
@property(nonatomic,strong)UIScrollView *scrollView;

@end
