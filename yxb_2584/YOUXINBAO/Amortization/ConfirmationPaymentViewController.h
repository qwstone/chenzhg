//
//  ConfirmationPaymentViewController.h
//  YOUXINBAO
//
//  Created by zjp on 15/6/2.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"
#import "CommerceManager.h"
#import "YXBTool.h"
#import "OrderDownPayment.h"
#import "MyOrderScheduleTopView.h"
@interface ConfirmationPaymentViewController : QCBaseViewController


@property(nonatomic,strong)HttpOperator   *iHttpOperator;
@property(nonatomic,assign)NSInteger        orderId;
@property(nonatomic,strong)OrderDownPayment     *model;
@end
