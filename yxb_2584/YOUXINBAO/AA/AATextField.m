//
//  AATextField.m
//  YOUXINBAO
//
//  Created by CH10 on 15/3/27.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AATextField.h"

@implementation AATextField

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
     UIColor *color = [UIColor blackColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: color}];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
