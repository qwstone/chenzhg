//
//  AAReceivablesDetailHeaderView.h
//  YOUXINBAO
//
//  Created by Feili on 15/6/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseView.h"
#import "GatheringRecordDetail.h"

#define AAReceivablesDetailHeaderViewBottomHeight 120
@protocol ButtonClickDelegate <NSObject>

- (void)ButtonClickDelegate:(NSInteger)tag;

//付款
-(void)payButtonClicked;

//关闭AA收款
-(void)closeAAPay;

//查看好友详情
-(void)userImageClickedWithUserId:(NSInteger)uId;


@end

@interface AAReceivablesDetailHeaderView : QCBaseView

@property(nonatomic,strong)GatheringRecordDetail *model;
@property(nonatomic,assign)CGFloat remarkHeight;
@property(nonatomic,assign)BOOL isSelectFriend;


@property(nonatomic,assign)id<ButtonClickDelegate>delegate;
@end
