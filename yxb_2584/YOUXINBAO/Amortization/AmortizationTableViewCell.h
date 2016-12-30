//
//  AmortizationTableViewCell.h
//  YOUXINBAO
//
//  Created by CH10 on 15/5/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CommerceHomePageData.h"
#import "GoodsResume.h"

#define AmortizationCellHeight 110

@interface AmortizationTableViewCell : UITableViewCell

@property (nonatomic,strong) GoodsResume *data;

@end
