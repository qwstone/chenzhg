//
//  BorrowManageCell.m
//  YOUXINBAO
//
//  Created by Walice on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BorrowManageCell.h"

@implementation BorrowManageCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    
    return self;
}

- (void)_initViews{
    
    _nameLabel=[[UILabel alloc]init];
    _nameLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:_nameLabel];
    
    _timeLabel=[[UILabel alloc]init];
    _timeLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:_timeLabel];
    
    _imgView=[[UIImageView alloc]init];
    [self addSubview:_imgView];
    
    _stateLabel=[[UILabel alloc]init];
    _stateLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:_stateLabel];
    
    
    [self setNeedsLayout];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _imgView.frame=CGRectMake(10, 10, 50, 50);
    
    _imgView.layer.cornerRadius=25;
    _imgView.clipsToBounds = YES;
    
    _nameLabel.frame=CGRectMake(_imgView.right+10, 20, 70, 30);
    _nameLabel.textColor=rgb(48, 48, 48, 1);
    _timeLabel.frame=CGRectMake(_nameLabel.right+10, 20, 100, 30);
    _timeLabel.textColor=rgb(120, 120, 120, 1);
    _stateLabel.frame=CGRectMake(_timeLabel.right+10, 20, kDeviceWidth-_imgView.width-_nameLabel.width-_timeLabel.width-40, 30);
    if (kDeviceWidth==375||kDeviceWidth==414) {
        _stateLabel.frame=CGRectMake(_timeLabel.right+10, 20, kDeviceWidth-_imgView.width-_nameLabel.width-_timeLabel.width-50-10, 30);
         _stateLabel.textAlignment=NSTextAlignmentRight;
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
