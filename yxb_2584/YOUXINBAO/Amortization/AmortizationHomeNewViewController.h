//
//  AmortizationHomeNewViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/7/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "YXBTool.h"
#import "HttpOperator.h"
#import "CommerceIndexPageData.h"

@interface AmortizationHomeNewViewController : QCBaseViewController 

@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (nonatomic,strong) CommerceIndexPageData *data;

@end
