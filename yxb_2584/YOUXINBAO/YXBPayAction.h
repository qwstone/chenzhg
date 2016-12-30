//
//  YXBPayAction.h
//  YOUXINBAO
//
//  Created by Feili on 15/7/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LoanConfig.h"
#import "jiekuanConfig.h"

@interface YXBPayAction : NSObject

@property (nonatomic,retain)YXBLoan * loan;

@property (nonatomic,assign)YXBPayWay payWay;//是付款还是还款

@property (nonatomic,strong)NSMutableArray *selectedArray;//选择的期数数组

@property (nonatomic,assign)BOOL isQuickLend;//是否是快速放款


-(void)payAction;

@end
