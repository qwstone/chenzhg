//
//  QCLoginOneViewController.h
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCBaseViewController.h"

@class HttpOperator;

@protocol loginViewDelegate <NSObject>

- (void)loginSucceed;

@end

@interface QCLoginOneViewController : QCBaseViewController<UITextFieldDelegate>

@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (assign, nonatomic) NSInteger iHttpTaskID;
@property (assign, nonatomic)id<loginViewDelegate>delegte;

@property (nonatomic,copy)NSString      *nameLabe;
@property (nonatomic,copy)NSString      *passLabe;
@property (nonatomic,assign)BOOL        isLog;

@property (nonatomic,assign)BOOL        isShixiao;

- (void)httpLOadParams:(NSString *)s userName:(NSString *)userName pwd:(NSString *)password httpOperation:(HttpOperator *)httpOperation;
- (void)httpLoadParams:(NSString *)s httpOperator:(HttpOperator *)httpOperator;
@end
