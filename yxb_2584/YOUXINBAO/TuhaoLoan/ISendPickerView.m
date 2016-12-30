//
//  ISendPickerView.m
//  YOUXINBAO
//
//  Created by zjp on 15/4/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ISendPickerView.h"

@implementation ISendPickerView



- (void)sureAction:(UIButton *)button {
    [self showPickerView];
    NSArray *array = [self.listArray objectAtIndex:0];
    NSString *text = [array objectAtIndex:self.row];
    if (self.selectedBlock != nil) {
        self.selectedBlock(text,self);
    }
    if ([self.delegate respondsToSelector:@selector(ISendPickerViewOK)]) {
        [self.delegate ISendPickerViewOK];
    }
}
- (void)showPickerView {
    [UIView animateWithDuration:.3 animations:^{
        if (!_isShowing) {
            self.top -= self.height;
        }else {
            self.top += self.height;
        }
    }];
    _isShowing = !_isShowing;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSArray *array = [self.listArray objectAtIndex:component];
    NSString *text = [array objectAtIndex:row];
    self.row = row;
    if (self.selectedBlock != nil) {
        self.selectedBlock(text,self);
    }
}

@end
