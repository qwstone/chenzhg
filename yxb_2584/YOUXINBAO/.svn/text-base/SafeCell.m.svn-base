//
//  SafeCell.m
//  YOUXINBAO
//
//  Created by Walice on 15/9/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "SafeCell.h"

@implementation SafeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    
    return self;
}

- (void)_initViews{
    
    _nameLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_nameLabel];
    _detailLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_detailLabel];
  
    
    
    [self setNeedsLayout];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _nameLabel.frame=CGRectMake(10, 10, 120, 20) ;
    _nameLabel.font=[UIFont systemFontOfSize:15];
    
    _detailLabel.frame=CGRectMake(kDeviceWidth-120, 10, 80, 20);
    _detailLabel.font=[UIFont systemFontOfSize:13];
    _detailLabel.textAlignment=NSTextAlignmentRight;
    _detailLabel.textColor=rgb(149, 149, 149, 1);
  
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
