//
//  PayModeCell.m
//  LotteryApp
//
//  Created by 程立彬 on 14-4-9.
//  Copyright (c) 2014年 windo. All rights reserved.
//

#import "PayModeCell.h"
#import "YXBTool.h"

@implementation PayModeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        float x = 16,y = (52-20)/2.0,w = 50, h = 30;
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_logoImageView];
        
        x = 76,y = 6,w = 215,h = 16;
        
        
        
        _logoTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _logoTitleLabel.font = [UIFont systemFontOfSize:15];
        _logoTitleLabel.textColor = rgb(49, 43, 40, 1);
        _logoTitleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_logoTitleLabel];
        
    
        _tuijianLabel = [[UILabel alloc] initWithFrame:CGRectMake(x+60, y, w, h)];
        _tuijianLabel.text = @"";
        _tuijianLabel.font = [UIFont systemFontOfSize:14];
        _tuijianLabel.textColor = [UIColor redColor];
        _tuijianLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_tuijianLabel];
                
        y = y + h + 2,h = 30;
        _logoDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(x,y, w, h)];
        _logoDetailLabel.backgroundColor = [UIColor clearColor];
        _logoDetailLabel.textColor = rgb(130, 134, 142, 1);
        _logoDetailLabel.font = [UIFont systemFontOfSize:12];
        [_logoDetailLabel setLineBreakMode:0];
        [_logoDetailLabel setNumberOfLines:2];
        [self.contentView addSubview:_logoDetailLabel];
        
        UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, y+h+5, kDeviceWidth, 1)];
        bottomLine.image = [UIImage imageNamed:@"HistorySepLine.png"];
        [self.contentView addSubview:bottomLine];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//设置model
-(void)setPayModel:(PayModeModel *)payModel
{
    if (_payModel != payModel) {
        _payModel = payModel;
        CGSize titleSize = [YXBTool getFontSizeWithString:_payModel.logoTitle font:[UIFont systemFontOfSize:15] constrainSize:CGSizeMake(kDeviceWidth, 0)];
        _logoTitleLabel.frame = CGRectMake(_logoTitleLabel.frame.origin.x, _logoTitleLabel.frame.origin.y, titleSize.width, _logoTitleLabel.frame.size.height);
        _tuijianLabel.frame = CGRectMake(_logoTitleLabel.frame.origin.x+titleSize.width, _tuijianLabel.frame.origin.y, _tuijianLabel.frame.size.width, _tuijianLabel.frame.size.height);
        _logoImageView.image = [UIImage imageNamed:_payModel.logoImageName];
        _logoTitleLabel.text = _payModel.logoTitle;
        _logoDetailLabel.text = _payModel.logoDetail;

        if (_payModel.payMode == E_LLWallet) {
            _tuijianLabel.text = @"(推荐)";
            
        }

        
    }
}

-(void)setPayMode:(Pay_Mode)payMode
{
    _payMode = payMode;
    if (_payMode == E_LLWallet) {
        _tuijianLabel.text = @"(推荐)";
        
    }

}
@end
