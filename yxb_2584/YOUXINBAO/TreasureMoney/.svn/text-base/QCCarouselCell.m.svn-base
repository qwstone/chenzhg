//
//  QCCarouselCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCCarouselCell.h"
#import "YXBTool.h"

@implementation QCCarouselCell {
    UILabel *_earnings;  //收益
    iCarousel *_carousel;   //
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
    }
    
    return self;
}

- (void)initViews {
    _earnings = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kDeviceWidth-10, 15)];
    _earnings.backgroundColor =[UIColor clearColor];
    _earnings.textAlignment = NSTextAlignmentRight;
    _earnings.textColor = [YXBTool colorWithHexString:@"#A8A7AA"];
    _earnings.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_earnings];

    _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 25, kDeviceWidth, [QCCarouselItem getCarouselHeightAndWidth])];
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.type = iCarouselTypeRotary;
    _carousel.centerItemWhenSelected = NO;
    _carousel.decelerationRate = 0.1;
    [self.contentView addSubview:_carousel];
    
    CGFloat xSpace = 20.0;
    
    UILabel *baoZuanQian = [[UILabel alloc] initWithFrame:CGRectMake(xSpace, _carousel.bottom+10, kDeviceWidth/2, 18)];
    baoZuanQian.backgroundColor =[UIColor clearColor];
//    baoZuanQian.textAlignment = NSTextAlignmentCenter;
    baoZuanQian.textColor = [YXBTool colorWithHexString:@"#FA5E5D"];
    baoZuanQian.text = @"宝·赚钱动态";
    baoZuanQian.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:baoZuanQian];
    
    UILabel *shouYi = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2-xSpace, _carousel.bottom+10, kDeviceWidth/2, 18)];
    shouYi.backgroundColor =[UIColor clearColor];
    shouYi.textAlignment = NSTextAlignmentRight;
    shouYi.textColor = [YXBTool colorWithHexString:@"#B5B5B5"];
    shouYi.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:shouYi];
    NSString *shouYiTex = @"随存随取，年收益10%";
    NSMutableAttributedString *shouYiAttributString = [[NSMutableAttributedString alloc] initWithString:shouYiTex];
    //设置字符串的样式   NSFontAttributeName:样式名称
    NSRange moneyRange = [shouYiTex rangeOfString:@"10%"];
    [shouYiAttributString addAttribute:NSForegroundColorAttributeName
                                value:[YXBTool colorWithHexString:@"#FD6138"]
                                range:moneyRange];
    shouYi.attributedText = shouYiAttributString;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_data.interestRate.length != 0 && _data.interestRate != nil) {
        float shouYi = _data.interestRate.floatValue*10000;
        NSString *shouYiStr = [NSString stringWithFormat:@"%.2f",shouYi];
        NSString *money = [NSString stringWithFormat:@"每万元每天收益%.2f元",shouYi];
        if (KDeviceOSVersion>5.0) {
            NSMutableAttributedString *moneyAttributString = [[NSMutableAttributedString alloc] initWithString:money];
            //设置字符串的样式   NSFontAttributeName:样式名称
            NSRange moneyRange = [money rangeOfString:shouYiStr];
            [moneyAttributString addAttribute:NSForegroundColorAttributeName
                                        value:[YXBTool colorWithHexString:@"#FD6138"]
                                        range:moneyRange];
            _earnings.attributedText = moneyAttributString;
            
        }else {
            _earnings.text = money;
        }
        
    }
    
    [_carousel reloadData];

}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return 3;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        
        view = [[QCCarouselItem alloc] initWithFrame:CGRectMake(0, 0, [QCCarouselItem getCarouselHeightAndWidth], [QCCarouselItem getCarouselHeightAndWidth]) type:index];
        
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    
    
    // index == 0 红; index == 1 黄; index == 2 蓝
    
    
    if (index == 0) {
        ((QCCarouselItem *)view).roundData = [_data.iProfitRoundDataArray objectAtIndex:1];
    }else if (index == 1) {
        ((QCCarouselItem *)view).roundData = [_data.iProfitRoundDataArray objectAtIndex:2];
    }else if (index == 2) {
        ((QCCarouselItem *)view).roundData = [_data.iProfitRoundDataArray objectAtIndex:0];
    }
    
    
    return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    // index == 0 红; index == 1 黄; index == 2 蓝
    if ([self.delegate respondsToSelector:@selector(QCCarouselCell:carouselClickedAtIndex:)]) {
        [self.delegate QCCarouselCell:self carouselClickedAtIndex:index];
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
