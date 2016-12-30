//
//  PayButton.m
//  LotteryApp
//
//  Created by 程立彬 on 14-4-10.
//  Copyright (c) 2014年 windo. All rights reserved.
//

#import "PayButton.h"

@implementation PayButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        [self valueChanged];
        
    }
    return self;
}

-(void)valueChanged
{
    if (self.selected) {
        [self setBackgroundImage:[UIImage imageNamed:@"sift_btn_selected.png"] forState:UIControlStateNormal];
        [self setTitleColor:rgb(241, 115, 28, 1) forState:UIControlStateNormal];
    }
    else
    {
        [self setBackgroundImage:[UIImage imageNamed:@"sift_btn_normal.png"] forState:UIControlStateNormal];
        [self setTitleColor:rgb(157, 117, 39, 1) forState:UIControlStateNormal];
    }

}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
