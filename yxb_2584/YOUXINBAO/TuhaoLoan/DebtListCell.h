//
//  DebtListCell.h
//  YOUXINBAO
//
//  Created by Feili on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlankNoteData.h"
#define DebtCellHeight 90


@interface DebtListCell : UITableViewCell

@property(nonatomic,strong)BlankNoteData *model;

@property(nonatomic,copy)NSString   *className;
@end
