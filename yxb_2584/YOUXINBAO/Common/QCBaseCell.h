//
//  QCBaseCell.h
//  DiTui
//
//  Created by Feili on 15/5/23.
//  Copyright (c) 2015年 YXBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseData.h"

@interface QCBaseCell : UITableViewCell

@property(nonatomic,assign)CGFloat cellWidth;
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,strong)NSIndexPath *indexPath;
-(void)initViews;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width height:(CGFloat)height;





/**
 *  @author chenglibin
 *
 *  生成label
 */

-(UILabel *)labelWithFrame:(CGRect)frame fontSize:(NSInteger)fontSize minimumScaleFactor:(CGFloat)minimumScaleFactor adjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor;

/**
 *  @author chenglibin
 *
 *  生成button
 */
-(UIButton *)buttonWithFrame:(CGRect)frame buttonType:(UIButtonType)buttonType backgroundColor:(UIColor *)backgroundColor title:(NSString *)title textFont:(UIFont *)textFont textColor:(UIColor *)textColor cornerRadius:(CGFloat)cornerRadius;


@end
