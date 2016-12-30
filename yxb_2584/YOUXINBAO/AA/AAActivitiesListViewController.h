//
//  AAActivitiesListViewController.h
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AABaseViewController.h"
#import "AAFiltrateView.h"

@class HttpOperator;

typedef enum{
    L_nearByList = 0,
    L_friendList,
    L_myList,
}ListStyle;

@interface AAActivitiesListViewController : AABaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign)ListStyle listStyle;

@property (retain, nonatomic) HttpOperator* iHttpOperator;

@property (nonatomic,assign) FiltrateType filtrateType;

@property (nonatomic,assign) BOOL isFromRoot;

//跳转发起活动
- (void)createAction;

@end
