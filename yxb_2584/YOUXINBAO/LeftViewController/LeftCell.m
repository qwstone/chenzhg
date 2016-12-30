//
//  LeftCell.m
//  YOUXINBAO
//
//  Created by CH10 on 15/6/7.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LeftCell.h"
#import "YXBTool.h"
#import "LeftHeaderView.h"

@implementation LeftCell {
    UIImageView *_leftImage;
    UILabel *_leftLabel;
    UIImageView *_newIcon;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, getScreenFitSize(1), kDeviceWidth/320*270, kLeftCellHeight-getScreenFitSize(2))];
        view.backgroundColor = [YXBTool colorWithHexString:@"#28282E"];
        self.selectedBackgroundView = view;
        
        [self addLineWithPoint:CGPointMake(getScreenFitSize(24), 0) inView:view];
        [self addLineWithPoint:CGPointMake(getScreenFitSize(24), kLeftCellHeight-getScreenFitSize(0.5)) inView:view];
        
        _leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(getScreenFitSize(44), getScreenFitSize(45.0-20)/2, getScreenFitSize(20), getScreenFitSize(20))];
        [self.contentView addSubview:_leftImage];
        
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(_leftImage.right+getScreenFitSize(10), (kLeftCellHeight-getScreenFitSize(20))/2, getScreenFitSize(150), getScreenFitSize(20))];
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.font = [UIFont systemFontOfSize:getScreenFitSize(13)];
        _leftLabel.textColor = [YXBTool colorWithHexString:@"#95A0AA"];
        [self.contentView addSubview:_leftLabel];
        
        [self addLineWithPoint:CGPointMake(getScreenFitSize(24), kLeftCellHeight-getScreenFitSize(0.5)) inView:self.contentView];
        
        _newIcon = [[UIImageView alloc] initWithFrame:CGRectMake(kLeftHeaderWidth-getScreenFitSize(60), (kLeftCellHeight-getScreenFitSize(20))/2, getScreenFitSize(20), getScreenFitSize(20))];
        _newIcon.image = [UIImage imageNamed:@"new-icon"];
        [self.contentView addSubview:_newIcon];
    }
    
    return self;
}

- (void)addLineWithPoint:(CGPoint)point inView:(UIView *)view  {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, kLeftHeaderWidth-point.x-getScreenFitSize(20), getScreenFitSize(0.5))];
    line.backgroundColor = [YXBTool colorWithHexString:@"#777777"];
    [view addSubview:line];
}

- (void)setLeftImage:(UIImage *)image {
    _leftImage.image = image;
}
- (void)setLeftText:(NSString *)text {
    _leftLabel.text = text;
    
}

- (void)setHasNewIcon:(BOOL)hasNewIcon {
    if (hasNewIcon) {
        _newIcon.hidden = NO;
    }else {
        _newIcon.hidden = YES;
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
