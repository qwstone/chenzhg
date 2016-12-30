//
//  yuejiluCell.m
//  YOUXINBAO
//
//  Created by Walice on 15/12/15.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "yuejiluCell.h"

@implementation yuejiluCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    
    return self;
}

- (void)_initViews{
    
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_timeLabel];
    _moneyLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_moneyLabel];
    [self setNeedsLayout];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
 
    _timeLabel.frame=CGRectMake(0,0, kDeviceWidth/2, 44);
    _timeLabel.textAlignment=NSTextAlignmentCenter;
    _moneyLabel.frame=CGRectMake(_timeLabel.right, 0, kDeviceWidth/2, 44);
    _moneyLabel.textAlignment=NSTextAlignmentCenter;
    _timeLabel.text=self.model.time;
    //_moneyLabel.text=self.model.money;
    
    _moneyLabel.text=[NSString stringWithFormat:@"%@元",self.model.money];
    NSRange range=[_moneyLabel.text rangeOfString:[NSString stringWithFormat:@"%@",self.model.money]];
    NSMutableAttributedString *aText=[[NSMutableAttributedString alloc]initWithString:_moneyLabel.text];
    [aText addAttribute:NSForegroundColorAttributeName value:rgb(237, 46, 36, 1) range:range];
    _moneyLabel.attributedText=aText;
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
