//
//  LoanMessageSecondTypeTableViewCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/9/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanMessageSecondTypeTableViewCell.h"
#import "YXBTool.h"
@implementation LoanMessageSecondTypeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _jingImageView = [[UIImageView alloc] init];
        _desLabel = [[UILabel alloc] init];
        [self addSubview:_jingImageView];
        [self addSubview:_desLabel];
    }
    return self;
}
- (void)setLoanLog:(TLoanLog *)loanLog
{
    _loanLog = loanLog;
    
    _desLabel.text = loanLog.msgDetail;
    _desLabel.numberOfLines = 0;
    _desLabel.font = [UIFont systemFontOfSize:14];
    CGSize size = [YXBTool getFontSizeWithString:_desLabel.text font:[UIFont systemFontOfSize:14] constrainSize:CGSizeMake(kDeviceWidth-60-30, 1000000)];
    _desLabel.frame = CGRectMake(60+15, 15, kDeviceWidth-60-30, size.height);
    if (loanLog.msgType == 2) {
        _jingImageView.image = [UIImage imageNamed:@"jing"];
        _desLabel.textColor = [UIColor redColor];
    }else if (loanLog.msgType == 3){
        _jingImageView.image = [UIImage imageNamed:@"jing2"];
        _desLabel.textColor = [UIColor blueColor];
    }
}
- (void)setLoanWithLog:(TLoanWithLog *)loanWithLog
{
    _loanWithLog = loanWithLog;
    _jingImageView.frame = CGRectMake(15, 15, 45, 45);
    _desLabel.frame = CGRectMake(60, 0, kDeviceWidth-60, 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
