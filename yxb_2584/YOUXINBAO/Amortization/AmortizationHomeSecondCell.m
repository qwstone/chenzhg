//
//  AmortizationHomeSecondCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/7/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AmortizationHomeSecondCell.h"
#import "YXBTool.h"
#import "UIImageView+WebCache.h"

#define kButtonTag 30040

@implementation AmortizationHomeSecondCell {
    UILabel *_time;
}

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //            xfq-xsth 154*31
        CGFloat topH = getScreenFitSize(66/2);
        CGFloat imageH = getScreenFitSize(31.0/2);
        CGFloat imageW = getScreenFitSize(154/2);
        
        //              190*252
        CGFloat buttonW = getScreenFitSize(190/2);
        CGFloat buttonH = getScreenFitSize(252/2);
        CGFloat gap = (kDeviceWidth-buttonW*3)/4;
        
        UIImageView *tip = [[UIImageView alloc] initWithFrame:CGRectMake(gap, (topH-imageH)/2, imageW, imageH)];
        tip.image = [UIImage imageNamed:@"xfq-xsth"];
        [self.contentView addSubview:tip];
        
        _time = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-gap-kDeviceWidth/2, 0, kDeviceWidth/2, topH)];
        _time.font = [UIFont systemFontOfSize:getScreenFitSize(11)];
        _time.textAlignment = NSTextAlignmentRight;
        _time.text = @"6.30   18:00  ~  7.2   11:00";
        _time.textColor = [YXBTool colorWithHexString:@"#e60012"];
        _time.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_time];
        
        for (int i = 0; i<3; i++) {
            AmortizationHomeSecondButton *button = [[AmortizationHomeSecondButton alloc] initWithFrame:CGRectMake(i*(buttonW+gap)+gap, topH, buttonW, buttonH)];
            button.tag = kButtonTag+i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
        }
    }
    
    return self;
}

- (void)buttonAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(amortizationHomeSecondCell:buttonDidClickedAtIndex:)]) {
        [self.delegate amortizationHomeSecondCell:self buttonDidClickedAtIndex:(button.tag-kButtonTag)];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _time.text = _seckillTimeDosplay;
    
    if (_flashList.count != 0) {
        for (int i = 0; i<_flashList.count; i++) {
            FlashSale *flash = [_flashList objectAtIndex:i];
            if ([[self.contentView viewWithTag:kButtonTag+i] isKindOfClass:[AmortizationHomeSecondButton class]]) {
                AmortizationHomeSecondButton *button = (AmortizationHomeSecondButton *)[self.contentView viewWithTag:kButtonTag+i];
                button.flashSale = flash;
                
            }
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation AmortizationHomeSecondButton {
    UIImageView *_imageView;    //图片
    UILabel *_descript;     //产品名称
    UILabel *_money;    //产品价格
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.hidden = YES;
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = rgb(237, 237, 237, 1).CGColor;
        self.layer.borderWidth = 1.0;
        
        CGFloat border = 3.0;
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(border, border, frame.size.width-border*2, frame.size.height-border*2)];
        contentView.backgroundColor = rgb(237, 237, 237, 1);
        [self addSubview:contentView];
        
//        i5   76*151
        CGFloat contentW = frame.size.width-border*2;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, getScreenFitSize(25.0/2), contentW, getScreenFitSize(151.0/2))];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [contentView addSubview:_imageView];
        
        CGFloat labelOriginX = getScreenFitSize(4.0);
        CGFloat centerGap = getScreenFitSize(4.0);
        
        _descript = [[UILabel alloc] initWithFrame:CGRectMake(labelOriginX, _imageView.bottom+centerGap, contentW-labelOriginX*2, getScreenFitSize(12.0))];
        _descript.font = [UIFont systemFontOfSize:getScreenFitSize(11)];
        _descript.textAlignment = NSTextAlignmentCenter;
        _descript.textColor = [YXBTool colorWithHexString:@"#303030"];
        _descript.backgroundColor = [UIColor clearColor];
        [contentView addSubview:_descript];
        
        _money = [[UILabel alloc] initWithFrame:CGRectMake(labelOriginX, _descript.bottom+centerGap, contentW-labelOriginX*2, getScreenFitSize(12.0))];
        _money.font = [UIFont systemFontOfSize:getScreenFitSize(11)];
        _money.textAlignment = NSTextAlignmentCenter;
        _money.textColor = [YXBTool colorWithHexString:@"#e60012"];
        _money.backgroundColor = [UIColor clearColor];
        [contentView addSubview:_money];
        
    }
    
    return self;
}

////自定义点击范围
- (UIView *) hitTest:(CGPoint) point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(self.bounds,point)) {
        return self;
    }
    
    return nil;
}

- (void)setFlashSale:(FlashSale *)flashSale {
    if (flashSale) {
        self.hidden = NO;
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:flashSale.imageUrl] placeholderImage:[UIImage imageNamed:@"i5"]];
        
        _descript.text = flashSale.descript;
        
        NSString *moneyStr = [NSString stringWithFormat:@"%@%@",flashSale.activityMoney,flashSale.oldMoney];
        NSString *oldMoney = [NSString stringWithFormat:@"%@",flashSale.oldMoney];
        NSRange range = [moneyStr rangeOfString:oldMoney];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:moneyStr];
        [attributedString addAttribute:NSFontAttributeName
                                 value:[UIFont systemFontOfSize:9]
                                 range:range];
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:rgb(171, 171, 171, 1)
                                 range:range];
        [attributedString addAttribute:NSStrikethroughStyleAttributeName
                                 value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                                 range:range];
        _money.attributedText = attributedString;
        
    }else {
        self.hidden = YES;
    }
}

@end
