//
//  QCMoneyListCell.h
//  YOUXINBAO
//
//  Created by CH10 on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FundDetail.h"

#define kMoneyCellHeight 60
#define QCMoneyListViewLeftAlign 10
#define QCMoneyListCellFont 15.0
#define QCMoneyListCellMoneyWidth 80



@interface QCMoneyListCell : UITableViewCell {
    UIImageView *_portrait;
    UILabel *_type;
    UILabel *_date;
    UILabel *_money;
}

@property (nonatomic,strong) FundDetail *model;
@property (nonatomic,assign) CGFloat detailHeight;//字符串的高度

@end
