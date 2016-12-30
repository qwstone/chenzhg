//
//  HuankuanDetailCell.m
//  YOUXINBAO
//
//  Created by Walice on 16/2/18.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HuankuanDetailCell.h"

@interface HuankuanDetailCell ()


@property(nonatomic,retain)UILabel *leftLabel;
@property(nonatomic,retain)UILabel *rightLabel;


@end


@implementation HuankuanDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    
    return self;
}
- (void)initViews{
    
    _button=[[UIButton alloc]initWithFrame:CGRectMake(15, 7, 40, 40)];
    [_button setImage:[UIImage imageNamed:@"AA-checked"] forState:UIControlStateSelected];
    [_button setImage:[UIImage imageNamed:@"AA-check"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_button];
    _leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 7, 100, 40)];
    _leftLabel.text=@"122";
    [self.contentView addSubview:_leftLabel];
    
    _rightLabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 7, 100, 40)];
    _rightLabel.text=@"223";
    [self.contentView addSubview:_rightLabel];

}
- (void)buttonAction{
    
    _button.selected=!_button.selected;
    if ([self.delegate respondsToSelector:@selector(buttonDidClick)]){
        [self.delegate buttonDidClick];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
