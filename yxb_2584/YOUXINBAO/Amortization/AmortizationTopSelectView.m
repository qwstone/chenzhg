//
//  AmortizationTopSelectView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/6/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#define kButtonTag 3000

#import "AmortizationTopSelectView.h"

@implementation AmortizationTopSelectView {
    NSMutableArray *_buttonContainer;
    UIImageView *_selectedImage;
}

- (id)initWithFrame:(CGRect)frame andArray:(NSArray *)array {
    if (self = [super initWithFrame:frame]) {
        if (array.count == 0) {
            return self;
        }
        
        _buttonContainer = [NSMutableArray new];
        
        NSInteger buttonCount = array.count;
        NSInteger lineCount = buttonCount-1;
        CGFloat lineWidth = 1.0;
        CGFloat buttonWidth = (frame.size.width-lineCount*lineWidth)/buttonCount;
        
        for (int i = 0; i<array.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((lineWidth+buttonWidth)*i, 0, buttonWidth, frame.size.height)];
//            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:rgb(150, 150, 150, 1) forState:UIControlStateNormal];
            [button setTitleColor:rgb(206, 42, 48, 1) forState:UIControlStateSelected];
            button.tag = kButtonTag+i;
            if (i == 0) {
                button.selected = YES;
            }
            button.titleLabel.minimumScaleFactor = 0.1;
            button.titleLabel.adjustsFontSizeToFitWidth = YES;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [_buttonContainer addObject:button];
            
            if (i != array.count-1) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(button.right, (frame.size.height-12.5)/2, lineWidth, 12.5)];
                line.backgroundColor = rgb(221, 221, 221, 1);
                [self addSubview:line];
            }
        }
        
        self.array = array;
        
        _selectedImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-2, buttonWidth-20, 2)];
        _selectedImage.image = [[UIImage imageNamed:@"titlenav-bottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.5, 5, 0.5, 5)];
        [self addSubview:_selectedImage];
        
        self.selectedIndex = 0;
        
//        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
//        bottomLine.backgroundColor = rgb(221, 221, 221, 1);
//        [self addSubview:bottomLine];
    }
    
    return self;
}

- (void)buttonAction:(UIButton *)button {
    for (UIButton *elseButton in _buttonContainer) {
        elseButton.selected = NO;
    }
    
    button.selected = YES;
    
    self.selectedIndex = button.tag-kButtonTag;
    
    if ([self.delegate respondsToSelector:@selector(AmortizationTopSelectView:selectedAtIndex:)]) {
        [self.delegate AmortizationTopSelectView:self selectedAtIndex:self.selectedIndex];
    }
        
}

- (void)setArray:(NSArray *)array {
    _array = array;
    
    //防止数组越界,隐藏多余button
    if (array.count < _buttonContainer.count) {
        for (NSInteger i = array.count; i<_buttonContainer.count; i++) {
            UIButton *button = [_buttonContainer objectAtIndex:i];
            button.hidden = YES;
        }
    }
    
    for (int i = 0; i<array.count && i < [_buttonContainer count]; i++) {
        UIButton *button = [_buttonContainer objectAtIndex:i];
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    UIButton *button = [_buttonContainer objectAtIndex:selectedIndex];
    [UIView animateWithDuration:0.2 animations:^{
        _selectedImage.center = CGPointMake(button.center.x, self.frame.size.height-1);
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
