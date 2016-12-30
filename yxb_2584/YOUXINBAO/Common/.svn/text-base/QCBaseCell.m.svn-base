//
//  QCBaseCell.m
//  DiTui
//
//  Created by Feili on 15/5/23.
//  Copyright (c) 2015年 YXBao. All rights reserved.
//

#import "QCBaseCell.h"

@implementation QCBaseCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)width height:(CGFloat)height
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellWidth = width;
        self.cellHeight = height;
        [self initViews];
        
    }
    
    return self;
}

-(void)initViews
{
    
}

/**
 *  @author chenglibin
 *
 *  @return UILabel
 */
-(UILabel *)labelWithFrame:(CGRect)frame fontSize:(NSInteger)fontSize minimumScaleFactor:(CGFloat)minimumScaleFactor adjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = backgroundColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.minimumScaleFactor = minimumScaleFactor;
    label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
    label.textColor = textColor;
    
    return label;
}

/**
 *  @author chenglibin
 *  生成button
 */
-(UIButton *)buttonWithFrame:(CGRect)frame buttonType:(UIButtonType)buttonType backgroundColor:(UIColor *)backgroundColor title:(NSString *)title textFont:(UIFont *)textFont textColor:(UIColor *)textColor cornerRadius:(CGFloat)cornerRadius
{
    UIButton *button = [UIButton buttonWithType:buttonType];
    button.frame = frame;
    button.layer.cornerRadius = cornerRadius;
    button.clipsToBounds = YES;
    if (backgroundColor != nil) {
        [button setBackgroundColor:backgroundColor];
    }
    if (textFont != nil) {
        button.titleLabel.font = textFont;
    }
    if (textColor != nil) {
        button.titleLabel.textColor = textColor;
    }
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    return button;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
