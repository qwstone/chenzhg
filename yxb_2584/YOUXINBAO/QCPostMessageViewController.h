//
//  QCPostMessageViewController.h
//  YOUXINBAO
//
//  Created by Walice on 15/7/7.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "QCAddressListViewController.h"
#import "HttpOperator.h"
#define  allNum 70

@interface QCPostMessageViewController : QCBaseViewController<MySecretaryDelegate,UITextViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)NSString *string;

@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel * currentNum;
@property(nonatomic,assign)NSInteger allnumber;
@property(nonatomic,strong)UIButton *button;
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property(nonatomic,assign)NSInteger promptID;

@property(nonatomic,strong)UIButton *postButton;


@end
