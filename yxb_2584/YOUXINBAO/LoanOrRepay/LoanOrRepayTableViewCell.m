//
//  LoanOrRepayTableViewCell.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/5/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanOrRepayTableViewCell.h"
#import "YXBTool.h"
@implementation LoanOrRepayTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView * bgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 91)];
        bgview.image = [UIImage imageNamed:@"navbg.png"];
        //        bgview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbg.png"]];
        [self.contentView addSubview:bgview];

        _rowImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 6, 80, 80)];
        [self.contentView addSubview:_rowImage];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(112, 25, 200, 20)];
        _titleLabel.textColor = [YXBTool colorWithHexString:@"4f4f4f"];
        [self.contentView addSubview:_titleLabel];
        _stitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(112, 50, 200, 20)];
        _stitleLabel.font = [UIFont systemFontOfSize:12];
        _stitleLabel.textColor = [YXBTool colorWithHexString:@"a0a0a0"];
        [self.contentView addSubview:_stitleLabel];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
