//
//  AADetailTwoSectionTableViewCell.h
//  YOUXINBAO
//
//  Created by zjp on 15/5/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AADetailsSecondView.h"
#import "TActivity.h"
#import "AAActivity.h"
@interface AADetailTwoSectionTableViewCell : UITableViewCell


@property (nonatomic,retain)AAActivity * activityModel;
@property (nonatomic,strong)UIViewController *vc;

@end
