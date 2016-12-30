//
//  AmortizationHomeProductCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/7/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AmortizationHomeProductCell.h"
#import "UIImageView+WebCache.h"
#import "YXBTool.h"

#define kProductTag 30020

@implementation AmortizationHomeProductCell {
    UIImageView *_tip;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)initViews {
    float originX = 10.0;
    float topViewH = 15.0;
    float topViewW = 70.0;
    
    _tip = [[UIImageView alloc] initWithFrame:CGRectMake(originX, 10, topViewW, topViewH)];
    _tip.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_tip];
    
    
    UIImageView *bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-topViewW-originX, 10, 55, topViewH)];
    bgimg.image = [UIImage imageNamed:@"moreprod"];
    bgimg.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:bgimg];
    
    UIButton *more = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
    more.backgroundColor = [UIColor clearColor];
    [more addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:more];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(-1, 165, kDeviceWidth+2, 15)];
    line.layer.borderWidth = 1;
    line.layer.borderColor = [YXBTool colorWithHexString:@"#d0d0d0"].CGColor;
    line.backgroundColor = [YXBTool colorWithHexString:@"#e9e6e9"];
    [self.contentView addSubview:line];
    float productOriginY = topViewH+25;
    float productH = 110.0;
    
    for (int i = 0; i<4; i++) {
        AmortizationHomeProductButton *button = [[AmortizationHomeProductButton alloc] initWithFrame:CGRectMake(originX+(kDeviceWidth-20)/4*i, productOriginY, (kDeviceWidth-20)/4, productH)];
        button.layer.borderWidth = 0.5f;
        button.layer.borderColor = [YXBTool colorWithHexString:@"#f5f5f5"].CGColor;
        [button addTarget:self action:@selector(productAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = kProductTag+i;
        [self.contentView addSubview:button];
    }
}

- (void)setType:(AmortizationHomeProductCellType)type {
    _type = type;
    
    NSString *tipText = nil;
    switch (type) {
        case AmortizationHomeProductCellElectry:
            tipText = @"时尚电子";
            _tip.image = [UIImage imageNamed:@"xfq-ssdz"];
            break;
        case AmortizationHomeProductCellTrain:
            tipText = @"学习培训";
            _tip.image = [UIImage imageNamed:@"xfq-jypx"];
            break;
        case AmortizationHomeProductCellBeauty:
            tipText = @"美妆护肤";
            _tip.image = [UIImage imageNamed:@"xfq-mzhf"];
            break;
        case AmortizationHomeProductCellFashion:
            tipText = @"时尚潮品";
            _tip.image = [UIImage imageNamed:@"xfq-sscp"];
            break;
        default:
            break;
    }
}

- (void)moreAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(amortizationHomeProductCellmoreButtonDidClicked:type:)]) {
        [self.delegate amortizationHomeProductCellmoreButtonDidClicked:self type:self.type];
    }
}

- (void)productAction:(UIButton *)button {
    NSInteger index = button.tag-kProductTag;
    if (index < _resumes.count) {
        if ([self.delegate respondsToSelector:@selector(amortizationHomeProductCell:productButtonDidClickedAtIndex:model:)]) {
            [self.delegate amortizationHomeProductCell:self productButtonDidClickedAtIndex:index model:[_resumes objectAtIndex:index]];
        }
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_resumes.count != 0) {
        for (int i = 0; i<_resumes.count; i++) {
            AmortizationHomeProductButton *button = (AmortizationHomeProductButton *)[self.contentView viewWithTag:i+kProductTag];
            button.goodsResume = [_resumes objectAtIndex:i];
        }
        
    }
}

@end

@implementation AmortizationHomeProductButton {
    UIImageView *_topImage;
    UILabel *_descripe;
    UILabel *_bottomLabel;
    NSMutableAttributedString *strLabel;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        float bottomH = 13;
        self.backgroundColor = [UIColor whiteColor];
        _topImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, (kDeviceWidth-20)/4-30, 55)];
        _topImage.contentMode = UIViewContentModeScaleAspectFit;
        _topImage.backgroundColor = [UIColor clearColor];
        [self addSubview:_topImage];
        
        float descripeH = 17.0;
        _descripe = [[UILabel alloc] initWithFrame:CGRectMake(0, _topImage.bottom+5, frame.size.width, descripeH)];
        _descripe.backgroundColor = [UIColor clearColor];
        _descripe.textAlignment = NSTextAlignmentCenter;
        _descripe.textColor = [YXBTool colorWithHexString:@"#303030"];
        _descripe.font = [UIFont systemFontOfSize:getScreenFitSize(11)];
        [self addSubview:_descripe];
        
        _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _descripe.bottom+5, frame.size.width, bottomH)];
        _bottomLabel.backgroundColor = [UIColor clearColor];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.numberOfLines = 0;
        [_bottomLabel setAdjustsFontSizeToFitWidth:YES];
        _bottomLabel.textColor = [YXBTool colorWithHexString:@"#303030"];
        _bottomLabel.font = [UIFont systemFontOfSize:getScreenFitSize(9)];
        [self addSubview:_bottomLabel];
    }
    
    return self;
}

- (void)setGoodsResume:(GoodsResume *)goodsResume {
    _goodsResume = goodsResume;
    if (goodsResume.descripe == nil) {
        _descripe.text = @"";
    }else {
    
        _descripe.text = goodsResume.descripe;
    }
    
    if (goodsResume.imageUrl == nil) {
            [_topImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"ipad"]];
    }else {
        
          [_topImage sd_setImageWithURL:[NSURL URLWithString:goodsResume.imageUrl] placeholderImage:[UIImage imageNamed:@"ipad"]];
    }

    
    if (goodsResume.money == nil || goodsResume.stage == 0) {
    }else {
        NSString *string = [NSString stringWithFormat:@"¥%@×%ld",goodsResume.money,(long)goodsResume.stage];
        strLabel = [[NSMutableAttributedString alloc] initWithString:string];
        [strLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:getScreenFitSize(11)]
                         range:[string rangeOfString:[NSString stringWithFormat:@"¥%@×",goodsResume.money]]];
        [strLabel addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#e60012"]
                         range:[string rangeOfString:[NSString stringWithFormat:@"¥%@×",goodsResume.money]]];
        _bottomLabel.attributedText = strLabel;
    }

}

@end
