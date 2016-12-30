//
//  CategoryTitleView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/5/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CategoryTitleView.h"

@implementation CategoryTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, (frame.size.height-20)/2, frame.size.width-22, 20);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:20.0f];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        arrowImageView = [[UIImageView alloc] init];
        [self addSubview:arrowImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    _isSelected = selected;
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self setNeedsLayout];
}

- (BOOL)isSelected
{
    return _isSelected;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    UIFont *font = [UIFont systemFontOfSize:20.0f];
//    CGSize fontSize = [self.title sizeWithFont:font];
//    
//    titleLabel.frame = self.bounds;
    
    
    NSLog(@"title %@",self.title);
    titleLabel.text = self.title;
    [titleLabel sizeToFit];
    arrowImageView.frame = CGRectMake(titleLabel.right+5, self.bounds.size.height/2 - 8.0f/2, 11.0f, 8.0f);
    if (self.selected) {
        arrowImageView.image = [UIImage imageNamed:@"whiteUpArrow"];
    } else {
        arrowImageView.image = [UIImage imageNamed:@"whiteDownArrow"];
    }
}

-(void)resetTitle:(NSString *)myTitle
{
    self.title = myTitle;
}

@end
