//
//  CTreasureMoneyViewController.h
//  YOUXINBAO
//
//  Created by zjp on 15/12/14.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "CPBTimerManager.h"
@interface CTreasureMoneyViewController : QCBaseViewController<CPBTimerDelegate>{
    
    NSInteger                       postion;
    
}



@property(nonatomic,strong)CPBTimerManager              *timerManager;

@property(nonatomic,strong)HttpOperator *iHttpOperator;
@end
