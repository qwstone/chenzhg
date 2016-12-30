//
//  BuyView.h
//  YOUXINBAO
//
//  Created by pro on 16/7/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorViewNew.h"
#import "AssetDetails.h"


@interface BuyView : UIView<CalculatorViewNewDelegate>


@property (nonatomic, strong)AssetDetails * model;

@end
