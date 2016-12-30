//
//  CreditPopUpView.h
//  YOUXINBAO
//
//  Created by Feili on 15/6/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseView.h"
#import "TCreditCenter.h"
#import "CreditConfig.h"

typedef void (^onAddFriend) (NSInteger userId);

@interface CreditPopUpView : QCBaseView

@property(nonatomic,strong)CreditCenter *model;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,copy)onAddFriend iOnAddFriend;

//显示
-(void)show;

//隐藏
-(void)hidden;

@end
