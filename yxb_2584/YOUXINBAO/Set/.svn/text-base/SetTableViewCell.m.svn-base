//
//  SetTableViewCell.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "SetTableViewCell.h"

@implementation SetTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _rownameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 200, 20)];
        [self.contentView addSubview:_rownameLabel];
        
        if ([reuseIdentifier isEqualToString:IMAGECELLID]) {
            
            _rownameLabel.frame = CGRectMake(20, 30, 120, 20);
            _userimageView = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth-100, 10, 60, 60)];
            _userimageView.backgroundColor = [UIColor clearColor];
            _userimageView.layer.masksToBounds = YES;
            _userimageView.layer.cornerRadius = 30;
            [self.contentView addSubview:_userimageView];
        }else{
            _detailsLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth- 230, 15, 200, 20)];
            _detailsLabel.textAlignment = NSTextAlignmentRight;
            _detailsLabel.textColor = [UIColor grayColor];
            _detailsLabel.font = [UIFont systemFontOfSize:14];
            [self.contentView addSubview:_detailsLabel];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
