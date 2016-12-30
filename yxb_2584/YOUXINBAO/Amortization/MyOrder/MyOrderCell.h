//
//  MyOrderCell.h
//  YOUXINBAO
//
//  Created by Walice on 15/9/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommerceOrderV2.h"

@interface MyOrderCell : UITableViewCell

@property(nonatomic,strong)UILabel *numberLabel;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIImageView *status;


@property(nonatomic,strong)CommerceOrderV2 *model;

@end
