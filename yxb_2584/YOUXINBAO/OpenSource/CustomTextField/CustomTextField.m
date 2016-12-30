//
//  CustomTextField.m
//  YOUXINBAO
//
//  Created by Feili on 16/3/7.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CustomTextField.h"
#import "YXBTool.h"

@implementation CustomTextField


-(void)drawPlaceholderInRect:(CGRect)rect
{

    if (_placeHolderFont != nil) {
        rect = ccr(rect.origin.x, rect.origin.y, rect.size.width, self.height);
        CGSize size = [YXBTool getFontSizeWithString:self.placeholder font:_placeHolderFont constrainSize:CGSizeMake(NSIntegerMax, NSIntegerMax)];
        CGFloat x = rect.size.width - size.width;
        CGFloat y = (rect.size.height - size.height)/2;
        CGFloat w = size.width;
        CGFloat h = size.height;
        rect = ccr(x, y, w, h);

    }
    [super drawPlaceholderInRect:rect];
}




@end
