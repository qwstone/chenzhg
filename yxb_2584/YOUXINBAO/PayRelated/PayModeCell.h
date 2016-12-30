//
//  PayModeCell.h
//  LotteryApp
//
//  Created by 程立彬 on 14-4-9.
//  Copyright (c) 2014年 windo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayModeModel.h"
#import "PayHomeViewController.h"
#import "RTLabel.h"
@interface PayModeCell : UITableViewCell
{
    UIImageView *_logoImageView;  //商标logo
    UILabel     *_logoTitleLabel;  //商标标题
    UILabel     *_logoDetailLabel;  //支付简介
    UILabel     *_tuijianLabel; // 添加红色推荐
    
}


@property(nonatomic, retain)PayModeModel *payModel;
@property(nonatomic, assign)Pay_Mode     payMode;
@end
