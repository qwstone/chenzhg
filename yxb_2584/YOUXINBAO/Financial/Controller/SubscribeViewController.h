//
//  SubscribeViewController.h
//  YOUXINBAO
//
//  Created by pro on 16/7/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"
@interface SubscribeViewController : QCBaseViewController
@property (nonatomic, strong)HttpOperator        *iHttpOperator;
@property (nonatomic,strong)NSString *assetID;
@end
