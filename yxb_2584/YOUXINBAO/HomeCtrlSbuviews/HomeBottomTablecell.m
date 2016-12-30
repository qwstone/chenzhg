//
//  HomeBottomTablecell.m
//  YOUXINBAO
//
//  Created by zjp on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HomeBottomTablecell.h"

@implementation HomeBottomTablecell {
    UIImageView         *_bgImgView;
    UIImageView         *_userImg;
    UILabel             *_userLabel;
    UILabel             *_activityLabel;
    UILabel             *_numberLabel;
    NSMutableAttributedString *strLabel;
    
    UIImageView         *_mianImg;
    UIImageView         *_timeImg;
}

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _bgImgView = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, self.widths, self.heights)];
//        _bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImgView.image = [UIImage imageNamed:@"index-hdbg111"];
        [self.contentView addSubview:_bgImgView];
        
        _userImg = [[UIImageView alloc ] initWithFrame:CGRectMake(12, 12, self.widths, self.heights)];
        _userImg.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _userImg.layer.borderWidth = 3;
        _userImg.layer.masksToBounds = YES;
        [self.contentView addSubview:_userImg];
        
        _userLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 200, 20)];
        _userLabel.font = [UIFont systemFontOfSize:13];
        _userLabel.text = @"AA活动 2-5";
        _userLabel.textColor = [UIColor whiteColor];
        [_userLabel setAdjustsFontSizeToFitWidth:YES];
        [self.contentView addSubview:_userLabel];
        
        _activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        _activityLabel.font = [UIFont systemFontOfSize:12];
        _activityLabel.text = @"三文鱼寿司聚会";
//        [_activityLabel setAdjustsFontSizeToFitWidth:YES];
        [self.contentView addSubview:_activityLabel];
        
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        _numberLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_numberLabel];
        
        
        
        _mianImg = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, self.widths, self.heights)];
        [self.contentView addSubview:_mianImg];
        
//        _timeImg = [[UIImageView alloc ] initWithFrame:CGRectMake(0, 0, self.widths, self.heights)];
//        [self.contentView addSubview:_timeImg];
    }
    
    return self;
}

- (void)setModel:(HomeModel *)model {
    if (_model != model) {
        _model = model;
        [self createData];
    }
//    self.contentView.alpha = 0;
//    [UIView animateWithDuration:1 animations:^{
//        self.contentView.alpha = 1;
//    } completion:^(BOOL finished) {
//        
//    }];
}

- (void)createData {

    UIImage *img = [UIImage imageNamed:@"register_photo.png"];
    [_userImg sd_setImageWithURL:[NSURL URLWithString:self.model.imgUrl] placeholderImage:img];
    
    _userLabel.text = self.model.title;
    
    _activityLabel.text = self.model.des;
    
    NSString    *string = [NSString stringWithFormat:@"%@人已参加",self.model.people];
    strLabel = [[NSMutableAttributedString alloc] initWithString:string];
    [strLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0,strLabel.length)];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0,strLabel.length)];
    [strLabel addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14]
                     range:[string rangeOfString:@"人已参加"]];
    [strLabel addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor]
                     range:[string rangeOfString:@"人已参加"]];
    _numberLabel.attributedText = strLabel;
    
    if ([self.model.type isEqualToString:@"付"]) {
        _mianImg.image = [UIImage imageNamed:@"fu-icon"];
    }else {
        _mianImg.image = [UIImage imageNamed:@"mian-icon"];
    }
    
    
//    _timeImg.image = [UIImage imageNamed:@"AA_time-icon-blue"];
}

- (void)setWidths:(CGFloat)widths {
    if (_widths != widths) {
        _widths = widths;
        _bgImgView.width = _widths;
    }

}

- (void)setHeights:(CGFloat)heights {
    if (_heights != heights) {
        _heights = heights;
        _bgImgView.height = _heights;
        _userImg.width = (_heights-24);
        _userImg.height = (_heights-24);
        
        _userLabel.left = _userImg.right+5;
//        _userLabel.top = _userImg.top-3;
        _userLabel.width = (_widths - _userLabel.left - 60);
        
        _activityLabel.center = _userImg.center;
        _activityLabel.left = _userImg.right+5;
        _activityLabel.width = _widths - _activityLabel.left-5;
        
        _numberLabel.left = _userImg.right+5;
        _numberLabel.bottom = _userImg.bottom;
        
        _userImg.layer.cornerRadius = _userImg.width/2;
        
        _mianImg.left = _widths-45;
        _mianImg.top = _userLabel.top+2;
        _mianImg.width = _widths/13;
        _mianImg.height = _widths/13;
        
//        _timeImg.left = _widths-35;
//        _timeImg.top = _userLabel.top+2;
//        _timeImg.width = _widths/13;
//        _timeImg.height = _widths/13;
    }
}

- (void)setIndex:(NSInteger)index {
    if (_index != index) {
        _index = index;
        if (_index % 2 == 0) {
            _bgImgView.image = [UIImage imageNamed:@"index-hdbg111"];
//            _userLabel.top -= 2;
        }else if (_index % 2 == 1){
            _bgImgView.image = [UIImage imageNamed:@"index-hdbg222"];
//            _userLabel.top += 2;
        }
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
