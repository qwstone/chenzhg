//
//  LicaijiluCell.m
//  YOUXINBAO
//
//  Created by Walice on 15/12/15.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LicaijiluCell.h"

@implementation LicaijiluCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    
    return self;
}

- (void)_initViews{
    
    _timaLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_timaLabel];
    _type=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_type];
    _moneyLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_moneyLabel];
    _status=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_status];
    
    
    [self setNeedsLayout];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    _timaLabel.frame=CGRectMake(0, 15, kDeviceWidth/4, 13);
    _timaLabel.textAlignment=NSTextAlignmentCenter;
    _timaLabel.font=[UIFont systemFontOfSize:12];
    _type.frame=CGRectMake((kDeviceWidth/4)+(kDeviceWidth/4-70)/2, 15, 70, 13);
    _type.textColor=rgb(237, 46, 36, 1);
    _type.textAlignment=NSTextAlignmentCenter;
    _type.layer.borderWidth=0.5;
    _type.layer.borderColor=rgb(237, 46, 36, 1).CGColor;
    _type.layer.cornerRadius=4;
    _type.font=[UIFont systemFontOfSize:12];
    
    
    
    _moneyLabel.frame=CGRectMake(kDeviceWidth/4*2, 15, kDeviceWidth/4, 13);
    _moneyLabel.font=[UIFont systemFontOfSize:12];
    _moneyLabel.textAlignment=NSTextAlignmentCenter;
    _status.frame=CGRectMake(kDeviceWidth/4*3+(kDeviceWidth/4-65)/2, 10, 54, 22);
    _timaLabel.text=self.model.time;
    _type.text=self.model.name;
    _moneyLabel.text=[NSString stringWithFormat:@"%@元",self.model.money];
    NSRange range=[_moneyLabel.text rangeOfString:[NSString stringWithFormat:@"%@",self.model.money]];
    NSMutableAttributedString *aText=[[NSMutableAttributedString alloc]initWithString:_moneyLabel.text];
    [aText addAttribute:NSForegroundColorAttributeName value:rgb(237, 46, 36, 1) range:range];
    _moneyLabel.attributedText=aText;
    
    
    
}
-(void)setModel:(ProfitDepositListItem *)model{
    if (_model!=model) {
        _model=model;
        if (_model) {
            if (self.model.state==1) {
                _status.image=[UIImage imageNamed:@"oning.png"];
                
            }
            else{
                _status.image=[UIImage imageNamed:@"over.png"];
            }
        }
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
