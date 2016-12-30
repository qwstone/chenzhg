//
//  AmortizationHomeViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/5/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//



#import "QCBaseViewController.h"
#import "HttpOperator.h"
#import "CommerceHomePageData.h"
#import "CommerceBanner.h"
#import "YXBTool.h"
@interface AmortizationHomeViewController : QCBaseViewController

@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (nonatomic,strong) CommerceHomePageData *homePageData;

@end
