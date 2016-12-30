//
//  QCBoardCell.h
//  YOUXINBAO
//
//  Created by CH10 on 15/4/10.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCBoardUserView.h"

#define kBoardUserWidth (kDeviceWidth-30)/2
#define kBoardUserHeight kBoardUserWidth/140*80

@protocol QCBoardCellDelegate <NSObject>
@optional
- (void)QCBoardCellUserDidClick:(QCBoardUserView *)userView;
@end

@interface QCBoardCell : UITableViewCell

@property (nonatomic,assign) id<QCBoardCellDelegate> delegate;

@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger row;

@end
