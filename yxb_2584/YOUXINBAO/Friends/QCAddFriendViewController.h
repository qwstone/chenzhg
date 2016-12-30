//
//  QCAddFriendViewController.h
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "QCAddressBook.h"
#import "HttpOperator.h"

@interface QCAddFriendViewController : QCBaseViewController

@property (nonatomic,assign) BOOL isAdd;
@property (nonatomic,retain) QCAddressBook *addressBook;

@property (retain, nonatomic) HttpOperator* iHttpOperator;

- (id)initWithUserType:(BOOL)isAdd;

@end
