//
//  AmortizationTableViewCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/5/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AmortizationTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MyOrderScheduleTopView.h"
#import "AADetailsSecondView.h"

@implementation AmortizationTableViewCell {
    UIImageView *_image;
    myUILabel *_title;
    UILabel *_money;
    UIImageView *_service;
//    MyOrderScheduleTopView *_topView;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat HorizontalGap = 10.0;
        CGFloat verticalGap = 10.0;
        
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(HorizontalGap, verticalGap, 170.0/2, 180.0/2)];
        _image.backgroundColor = [YXBTool colorWithHexString:@"#F7F7F7"];
        [self.contentView addSubview:_image];
        
        _title = [[myUILabel alloc] initWithFrame:CGRectMake(_image.right+HorizontalGap, _image.top, kDeviceWidth-_image.width-HorizontalGap*3, 50)];
        _title.textColor = [YXBTool colorWithHexString:@"#616161"];
        _title.font = [UIFont systemFontOfSize:getScreenFitSize(14)];
        _title.verticalAlignment = VerticalAlignmentTop;
        _title.numberOfLines = 2;
        _title.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_title];
        
        CGFloat serviceH = getScreenFitSize(26);
        
        _service = [[UIImageView alloc] initWithFrame:CGRectMake(_image.right+HorizontalGap, _image.bottom-serviceH, kDeviceWidth-_image.width-HorizontalGap*3, serviceH)];
        //图片缩放
        UIImage *serviceImage = [UIImage imageNamed:@"xfq-ygbg.png"];
        
        _service.contentMode = UIViewContentModeScaleAspectFill;
        
//        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _service.size.width, _service.size.height)];
//        [btn setBackgroundImage:serviceImage forState:UIControlStateNormal];
//        [_service addSubview:btn];
        
//        CGSize imgSize = _service.frame.size;
//        UIGraphicsBeginImageContext(imgSize);
//        [serviceImage drawInRect:CGRectMake(0,0,imgSize.width,imgSize.height)];
//        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
        _service.image = serviceImage;
//        _service.backgroundColor = [UIColor colorWithPatternImage:serviceImage];
        [self.contentView addSubview:_service];
        
        CGFloat moneyOriginX = 25.0;
        _money = [[UILabel alloc] initWithFrame:CGRectMake(moneyOriginX, 0, _service.width-moneyOriginX, serviceH)];
        _money.font = [UIFont systemFontOfSize:getScreenFitSize(12)];
        _money.textColor = [UIColor whiteColor];
        _money.backgroundColor = [UIColor clearColor];
        [_service addSubview:_money];
        
//        _topView=[[MyOrderScheduleTopView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, AmortizationCellHeight)];
//        [self.contentView addSubview:_topView];
//        self.clipsToBounds = YES;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.data != nil) {
//        _topView.model = self.data;
        [_image sd_setImageWithURL:[NSURL URLWithString:self.data.imageUrl] placeholderImage:[UIImage imageNamed:@"yxblogo-gray"]];
        _title.text = self.data.descripe;
//        [_title sizeToFit];
        NSString *monthStr = [NSString stringWithFormat:@"月供:￥%@×%ld",self.data.money,(long)self.data.stage];
        NSString *moneyStr = [NSString stringWithFormat:@"￥%@",self.data.money];
        NSRange range = [monthStr rangeOfString:moneyStr];
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:monthStr];
        [attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:getScreenFitSize(14)] range:range];
        _money.attributedText = attributed;
        
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
