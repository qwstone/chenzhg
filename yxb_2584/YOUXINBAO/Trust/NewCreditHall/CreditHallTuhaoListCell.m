//
//  CreditHallTuhaoListCell.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CreditHallTuhaoListCell.h"
#import "YXBTool.h"

@implementation CreditHallTuhaoListCell {

    UIImageView         *_RankingImg;
    UIImageView         *_RankingImg1;
    UILabel             *_RankingLabel;
    UIImageView         *_UserImg;
    UILabel             *_nameLabel;
    UILabel             *_lvLabel;
    UILabel             *_moneyLabel;
    UIImageView         *_usercheckImg;
    UIImageView         *lvImg;
    YXBLevelView        *_levelView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.backgroundColor = [UIColor whiteColor];
        
//        UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(10, 7.5, kDeviceWidth-20, 65)];
//        viewbg.layer.cornerRadius = 5;
//        viewbg.layer.masksToBounds = YES;
//        viewbg.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:viewbg];
        UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kDeviceWidth, 1)];
        viewbg.backgroundColor = [YXBTool colorWithHexString:@"#e0dede"];
        [self.contentView addSubview:viewbg];
        
        _RankingImg = [[UIImageView alloc] initWithFrame:CGRectMake(19, 17, 33, 30)];
        [self.contentView addSubview:_RankingImg];
        _RankingImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(23, 20, 25, 25)];
        _RankingImg1.image = [UIImage imageNamed:@"numbg"];
        [self.contentView addSubview:_RankingImg1];
        
        _RankingLabel = [[UILabel alloc] initWithFrame:_RankingImg1.frame];
        _RankingLabel.center = _RankingImg1.center;
        _RankingLabel.textColor = [UIColor whiteColor];
        _RankingLabel.textAlignment = NSTextAlignmentCenter;
        _RankingLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView  addSubview:_RankingLabel];
        
        UIImageView *img = [self borderImageViewWithImage:nil frame:CGRectMake(kDeviceWidth/5+5, 7.5f, 50, 50)];
        [self.contentView  addSubview:img];
        
        
        _usercheckImg = [[UIImageView alloc] initWithFrame:CGRectMake(img.right-18, img.top, 18, 18)];
        _usercheckImg.image = [UIImage imageNamed:@"usercheck"];
        [self.contentView  addSubview:_usercheckImg];
//        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expertUserImg.png"]];
////        bgImageView.clipsToBounds = YES;
//        bgImageView.frame = CGRectMake(_RankingImg.right+20, 8, 48.5, 48.5);
//        [viewbg addSubview:bgImageView];
//        
//        CGFloat space = 4;
//        
//        CGFloat x = space;
//        CGFloat y = space-2;
//        CGFloat w = bgImageView.frame.size.width - 2 * space;
//        CGFloat h = bgImageView.frame.size.height - 2 * space;
//        
//        _UserImg = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
//        _UserImg.layer.cornerRadius = _UserImg.width/2;
//        _UserImg.layer.masksToBounds = YES;
//        _UserImg.layer.shadowOpacity = 1;
//        _UserImg.layer.shadowRadius = 3;
//        _UserImg.layer.shadowOffset = CGSizeMake(2,3);
//        [bgImageView addSubview:_UserImg];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(img.right+10, img.top+2, kDeviceWidth, 22)];
        if (kDeviceWidth >= 375) {
            _nameLabel.left = img.right+20;
        }
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [YXBTool colorWithHexString:@"#474646"];
        [self.contentView addSubview:_nameLabel];
        
        //添加等级
        _levelView = [[YXBLevelView alloc] initWithFrame:CGRectMake(_nameLabel.left, img.bottom-20, 200, 15)];

        [self.contentView addSubview:_levelView];
        
        lvImg = [[UIImageView alloc] initWithFrame:CGRectMake(img.right+10,2, 25, 15)];
        lvImg.image = [UIImage imageNamed:@"class-icon1"];
        [self.contentView  addSubview:lvImg];
//
//        _lvLabel = [[UILabel alloc] initWithFrame:CGRectMake(lvImg.right+5, lvImg.top-5, 100, 20)];
//        _lvLabel.font = [UIFont systemFontOfSize:14];
//        _lvLabel.textColor = [UIColor orangeColor];
//        [self.contentView  addSubview:_lvLabel];
        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth - 100, 0, 100, 65)];
        _moneyLabel.font = [UIFont systemFontOfSize:24];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.textColor = [YXBTool colorWithHexString:@"#f46956"];
        [_moneyLabel setAdjustsFontSizeToFitWidth:YES];
        [self.contentView  addSubview:_moneyLabel];
    }
    
    return self;
}

-(UIImageView*)borderImageViewWithImage:(UIImage *)image frame:(CGRect)frame
{
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"expertUserImg.png"]];
    bgImageView.clipsToBounds = YES;
    bgImageView.frame = frame;
    
    CGFloat space = 3;
    
    CGFloat x = space;
    CGFloat y = space-1.5;
    CGFloat w = frame.size.width - 2 * space;
    CGFloat h = frame.size.height - 2 * space;
    
    _UserImg = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _UserImg.layer.cornerRadius = _UserImg.width/2;
    _UserImg.clipsToBounds = YES;
    _UserImg.image = image;
    [bgImageView addSubview:_UserImg];

    return bgImageView;
}

- (void)setModel:(CreditCenter *)model {
    if (_model != model) {
        _model = model;
        [self createData];
    }
}


- (void)createData {
    if ([self.model.rankId integerValue] == 1) {
        _RankingImg1.hidden = YES;
        _RankingImg.hidden = NO;
        _RankingLabel.hidden = YES;
         _RankingImg.image = [UIImage imageNamed:@"numone"];
    }else if ([self.model.rankId integerValue] == 2) {
        _RankingImg.hidden = NO;
        _RankingImg1.hidden = YES;
        _RankingLabel.hidden = YES;
        _RankingImg.image = [UIImage imageNamed:@"numtwo"];
    }else if ([self.model.rankId integerValue] == 3) {
        _RankingImg.hidden = NO;
        _RankingImg1.hidden = YES;
        _RankingLabel.hidden = YES;
        _RankingImg.image = [UIImage imageNamed:@"numthree"];
    }else {
        _RankingImg.hidden = YES;
        _RankingImg1.hidden = NO;
        _RankingLabel.hidden = NO;
        _RankingImg.image = [UIImage imageNamed:@"numbg"];
        _RankingLabel.text = self.model.rankId;
    }
    
    if (self.model.friendFlag == 1) {
        _usercheckImg.hidden = NO;
    }else {
        _usercheckImg.hidden = YES;
    }
    
    
    [_UserImg sd_setImageWithURL:[NSURL URLWithString:self.model.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
    
    _nameLabel.text = self.model.realName;

     NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0f]};
   CGSize requiredSize = [_nameLabel.text boundingRectWithSize:CGSizeMake(1000, 16) options:\
                    NSStringDrawingTruncatesLastVisibleLine |
                    NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingUsesFontLeading
                                        attributes:attribute context:nil].size;
    lvImg.left = _nameLabel.left+requiredSize.width;
    if ([self.model.level integerValue] < 14) {
        lvImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"class-icon%@",self.model.level]];
    }else {
        lvImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"class-icon%@",self.model.level]];
    }
    
//    _lvLabel.text = [NSString stringWithFormat:@"%@",self.model.level];
    
    _moneyLabel.text = [NSString stringWithFormat:@"%@",self.model.score];
}
@end
