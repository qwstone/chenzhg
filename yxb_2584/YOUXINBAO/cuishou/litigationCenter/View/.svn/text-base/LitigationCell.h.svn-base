//
//  LitigationCell.h
//  YOUXINBAO
//
//  Created by pro on 2016/12/7.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverdueLoanData.h"

typedef void (^BackSelectBtnIndex)(NSInteger index);

@interface LitigationCell : UITableViewCell

@property (copy, nonatomic) BackSelectBtnIndex  backselectBtnIndex;

@property (nonatomic, strong)OverdueLoanData * model;

@property (weak, nonatomic) UIButton    * selectBtn;//选择按钮

//更新选择按钮状态
-(void)updateSelectBtnWithCurrentIndex:(NSInteger)current;

@end
