//
//  QCFiltrateButton.m
//  YOUXINBAO
//
//  Created by CH10 on 15/5/18.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCFiltrateButton.h"

@implementation QCFiltrateButton

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self adjustsView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self adjustsView];
}

- (void)adjustsView {
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = rgb(47, 149, 240, 1).CGColor;
    self.layer.borderWidth = 1;
    
//    [self setImage:[UIImage imageNamed:@"blue-but2"] forState:UIControlStateSelected];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
