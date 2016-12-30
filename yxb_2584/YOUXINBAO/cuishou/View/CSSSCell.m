//
//  CSSSCell.m
//  YOUXINBAO
//
//  Created by pro on 2016/12/7.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CSSSCell.h"

@interface CSSSCell ()

@property (strong, nonatomic) UIImageView   * Icon;//图标
@property (strong, nonatomic) UILabel       * NameLabel;//名称
@property (strong, nonatomic) UILabel       * DescribeLabel;//描述

@end


@implementation CSSSCell




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}


-(void)setModel:(CSSSmodel *)model{
    self.Icon.image = [UIImage imageNamed:model.functionIcon];
    self.NameLabel.text = model.functionName;
    self.DescribeLabel.text = model.functionDescribe;
}



-(void)initViews{
    
    self.Icon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 22, 37, 37)];
    [self.contentView addSubview:_Icon];
    
    self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_Icon.right + 9, 32, 120, 36)];
    _NameLabel.center = CGPointMake(_Icon.right + 9 + 60, _Icon.center.y);
    _NameLabel.textColor = [YXBTool colorWithHexString:@"#333333"];
    _NameLabel.font = [UIFont boldSystemFontOfSize:20];
    _NameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_NameLabel];
    
    
    self.DescribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_Icon.right + 9, _NameLabel.bottom + 20, 420*kDeviceWidth/640, 26)];
    _DescribeLabel.font = [UIFont systemFontOfSize:24*kDeviceWidth/640];
    _DescribeLabel.textColor = [YXBTool colorWithHexString:@"#808080"];
    _DescribeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_DescribeLabel];
    
    //19*35
    UIImageView * arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-15-10, _NameLabel.bottom + 24, 10, 18)];
    arrowImg.image = [UIImage imageNamed:@"cs_arrow"];
    [self.contentView addSubview:arrowImg];
    
    
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 122, kDeviceWidth, 1)];
    line.backgroundColor = [YXBTool colorWithHexString:@"#d9d9d9"];
    [self.contentView addSubview:line];
    
}












- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
