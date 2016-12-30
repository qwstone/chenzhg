//
//  QCMessageCell.m
//  YOUXINBAO
//
//  Created by 冰冰 on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCMessageCell.h"
#import "UIImageView+WebCache.h"

@implementation QCMessageCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    
    return self;
}

- (void)_initViews{

    //icon
    iconImg=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:iconImg];
    //小红点
    _img=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:_img];

    _titleLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_titleLabel];
    
    _subTitleLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_subTitleLabel];
    
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:_timeLabel];
    //向右方向的箭头
    imgView=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:imgView];
   
    [self setNeedsLayout];

}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat timeWidth=120;
    CGFloat rightIconWidth=20;
    CGFloat iconImgWidth=40;
    
    //icon
    iconImg.frame=CGRectMake(10, 25, iconImgWidth, iconImgWidth);
    
    //小红点
    _img.frame=CGRectMake(iconImgWidth, 25, 13, 13);
    _img.image=[UIImage imageNamed:@"dot-red.png"];
    
    
    _titleLabel.frame=CGRectMake(iconImg.right+5, 20, kDeviceWidth-iconImg.right-5-timeWidth-rightIconWidth, 20);
    _titleLabel.font=[UIFont systemFontOfSize:14];
    _titleLabel.textColor=rgb(50, 49, 49, 1);

    
    _subTitleLabel.frame=CGRectMake(_titleLabel.origin.x, _titleLabel.origin.y+_titleLabel.height+10, kDeviceWidth-rightIconWidth-_titleLabel.origin.x, 30);
    _subTitleLabel.numberOfLines=2;
    _subTitleLabel.font=[UIFont systemFontOfSize:12];
    _subTitleLabel.textColor=rgb(132, 130, 130, 1);
    
    _timeLabel.frame=CGRectMake(kDeviceWidth-timeWidth-rightIconWidth, 20, timeWidth, 12);
    [_timeLabel setAdjustsFontSizeToFitWidth:YES];
    _timeLabel.font=[UIFont systemFontOfSize:12];
    _timeLabel.textColor=rgb(193, 191, 191, 1);
    _timeLabel.textAlignment=NSTextAlignmentRight;
    
    imgView.frame=CGRectMake(kDeviceWidth-20, _timeLabel.origin.y+_timeLabel.height+10, 20, 20);
    imgView.contentMode = UIViewContentModeCenter;
    imgView.image=[UIImage imageNamed:@"next.png"];
 
    _titleLabel.text=self.model.title;
    _subTitleLabel.text=self.model.des;
    _timeLabel.text=self.model.subTitle;
    
    
    [iconImg sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl]];

    if ([self.model.hasRead integerValue]==1) {
        _img.hidden=YES;
    }
    else{
    
        _img.hidden=NO;
    }

    
}
/*

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawLine:context];

}

- (void)drawLine:(CGContextRef)context
{

    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 0, 90);
    
    CGPathAddLineToPoint(path, NULL, kDeviceWidth, 90);
    
    CGContextAddPath(context, path);
 
    CGContextSetRGBStrokeColor(context, 214/255.0, 214/255.0, 214/255.0, 1);
    
    CGContextSetLineWidth(context, 1);
    
    //5.绘制路径
    CGContextDrawPath(context, kCGPathStroke);
    
    //6.释放路径
    CGPathRelease(path);
    
    
    
}
 */





@end
