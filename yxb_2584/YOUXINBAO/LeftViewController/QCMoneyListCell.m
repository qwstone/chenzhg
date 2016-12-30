//
//  QCMoneyListCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCMoneyListCell.h"
#import "UIImageView+WebCache.h"

@implementation QCMoneyListCell


-(void)setFrame:(CGRect)frame
{
    frame.origin.x = QCMoneyListViewLeftAlign;
    frame.size.width = frame.size.width - 2 * QCMoneyListViewLeftAlign;
    [super setFrame:frame];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    
    return self;
}

- (void)_initViews {
//    _portrait = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kMoneyCellHeight-20, kMoneyCellHeight-20)];
    UIImageView *imageView  = [self borderImageViewWithImage:[UIImage imageNamed:@"expertUserImg.png"] frame:CGRectMake(5, 5, kMoneyCellHeight-10, kMoneyCellHeight-10)];
    
//    _portrait.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:imageView];
    
    _type = [[UILabel alloc] initWithFrame:CGRectMake(kMoneyCellHeight, 10, kDeviceWidth - 150, 50)];
    _type.text = @"快速提现";
    _type.numberOfLines = 0;
    _type.lineBreakMode = 0;
    _type.backgroundColor = [UIColor clearColor];
    _type.textColor = [UIColor blackColor];
    _type.font = [UIFont boldSystemFontOfSize:QCMoneyListCellFont];
//    _type.numberOfLines = 2;
//    _type.lineBreakMode = 0;
//    _type.minimumScaleFactor = 12.0/_type.font.pointSize;
//    _type.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_type];
    
    _date = [[UILabel alloc] initWithFrame:CGRectMake(_type.origin.x, _type.frame.origin.y + _type.height + 5, _type.width, 30)];
    _date.text = @"03-02   13:31";
    _date.backgroundColor = [UIColor clearColor];
    _date.font = [UIFont systemFontOfSize:14];
    _date.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_date];
    
    _money = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-100, (kMoneyCellHeight-20)/2, 80, 20)];
    _money.textAlignment = NSTextAlignmentRight;
    _money.text = @"+200   元";
    _money.minimumScaleFactor = 12.0/_type.font.pointSize;
    _money.adjustsFontSizeToFitWidth = YES;

    _money.backgroundColor = [UIColor clearColor];
    _money.font = [UIFont systemFontOfSize:16];
    _money.textColor = [UIColor blackColor];
    [self.contentView addSubview:_money];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _type.height = self.detailHeight;
    _date.top = _type.bottom;
    _money.center = CGPointMake(_money.center.x, self.height/2);

    [_portrait sd_setImageWithURL:[NSURL URLWithString:self.model.imgUrl]];
    _type.text = self.model.title;
    _date.text = self.model.createTime;
    if (self.model.mode == 0) {
        //进账
        _money.textColor = [UIColor redColor];
        _money.text = [NSString stringWithFormat:@"+%@",self.model.money];
        if ([_model.money floatValue] == 0) {
            _money.text = [NSString stringWithFormat:@"%@",self.model.money];

        }

    }else {
        //出账
        _money.textColor = [UIColor greenColor];
        _money.text = [NSString stringWithFormat:@"-%@",self.model.money];
        if ([_model.money floatValue] == 0) {
            _money.text = [NSString stringWithFormat:@"%@",self.model.money];
            
        }


    }
    _type.text = self.model.title;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UIImageView*)borderImageViewWithImage:(UIImage *)image frame:(CGRect)frame
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expertUserImg.png"]];
    bgImageView.clipsToBounds = YES;
    bgImageView.frame = frame;
    
    CGFloat space = 2;
    
    CGFloat x = space;
    CGFloat y = space-2;
    CGFloat w = frame.size.width - 2 * space;
    CGFloat h = frame.size.height - 2 * space;
    
    _portrait = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _portrait.layer.cornerRadius = _portrait.width/2;
    _portrait.clipsToBounds = YES;
    _portrait.image = image;
    [bgImageView addSubview:_portrait];
    
    return bgImageView;
}


@end
