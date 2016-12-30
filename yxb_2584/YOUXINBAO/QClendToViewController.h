//
//  QClendToViewController.h
//  YOUXINBAO
//
//  Created by Walice on 15/7/2.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"

@interface QClendToViewController : QCBaseViewController<UITextFieldDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UITextField *field;
@property(nonatomic,strong)UILabel *textViewplacehide;
@property(nonatomic,assign)NSInteger friendID;
@property(nonatomic,strong)UIButton *button;

@end
