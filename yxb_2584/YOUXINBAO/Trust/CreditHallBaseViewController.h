//
//  CreditHallBaseViewController.h
//  YOUXINBAO
//
//  Created by zjp on 15/6/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "TCreditCenterManager.h"
#import "HttpOperator.h"

#import "CreditConfig.h"
#import "QCLoginOneViewController.h"

@interface CreditHallBaseViewController : QCBaseViewController


@property (retain, nonatomic) HttpOperator              * iHttpOperator;
@property(nonatomic,strong)UISearchBar                  *topSearchBar;
@property(nonatomic,strong)UISearchDisplayController    *mySearchDisplayController;


//跳出登陆页面
- (void)toLogin;
@end
