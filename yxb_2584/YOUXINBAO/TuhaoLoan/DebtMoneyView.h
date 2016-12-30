//
//  DebtMoneyView.h
//  YOUXINBAO
//
//  Created by Feili on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlankNoteData.h"
#import "QCBaseView.h"

@interface DebtMoneyView : QCBaseView

@property(nonatomic,strong)BlankNoteData *model;
@property(nonatomic,strong)UILabel *userNameLabel;//用户名label

@end
