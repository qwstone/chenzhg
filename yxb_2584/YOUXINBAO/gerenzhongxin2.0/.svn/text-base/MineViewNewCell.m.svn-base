//
//  MineViewNewCell.m
//  LotteryApp
//
//  Created by Feili on 15/1/15.
//  Copyright (c) 2015年 windo. All rights reserved.
//

#import "MineViewNewCell.h"
#import "YXBTool.h"

@implementation MineViewNewCell


//- (void)setFrame:(CGRect)frame {
//    frame.origin.x = -20;
//    frame.size.width = 360;
//    
//    [super setFrame:frame];
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.logoImageView = [[UIImageView alloc] initWithFrame:ccr(15, 7, 30, 30)];
        self.logoImageView.image = [UIImage imageNamed:@"mine_iget.png"];
        [self.contentView addSubview:self.logoImageView];
        
        self.jiantouImage = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth - 40, 17, 13, 12)];
        _jiantouImage.contentMode = UIViewContentModeCenter;
        self.jiantouImage.image = [UIImage imageNamed:@"next.png"];
        [self.contentView addSubview:self.jiantouImage];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.logoImageView.right + 10, 10, 60, 24)];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.text = @"我收到的";
        self.titleLabel.textColor = kRGB(49, 43, 40);
        self.titleLabel.backgroundColor = [UIColor clearColor];
        //        self.titleLabel1.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.titleLabel];
        
        self.theNewImage = [[UIImageView alloc] initWithImage:nil];
        _theNewImage.frame = ccr(_titleLabel.frame.origin.x + _titleLabel.frame.size.width, 2, 20,20);
        _theNewImage.hidden = YES;
        [self.contentView addSubview:_theNewImage];

        
    }
    return self;
}

-(void)setModel:(MineViewModel *)model
{

    if(_model != model)
    {
        _model = model;
    }
   
    
    self.logoImageView.image = [UIImage imageNamed:_model.itemImageName];
    self.titleLabel.text = _model.itemTitle;
    
    CGSize titleSize = [YXBTool getFontSizeWithString:_model.itemTitle font:_titleLabel.font constrainSize:CGSizeMake(kDeviceWidth, 44)];
    self.titleLabel.frame = ccr(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y, titleSize.width, _titleLabel.height);
    if (_model.itemAddImageName != nil) {
        _theNewImage.frame = ccr(_titleLabel.frame.origin.x + _titleLabel.frame.size.width, 4, 10,10);
        
        _theNewImage.hidden = NO;
        _theNewImage.image = [UIImage imageNamed:_model.itemAddImageName];
    }
    else
    {
        _theNewImage.hidden = YES;
        _theNewImage.image = nil;

    }
}


@end
