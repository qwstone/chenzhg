//
//  QCPopupView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/5/26.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#define kRowHeight 40
#define kVerticalGap 15
#define kColumnWidth kDeviceWidth/self.column
#define kHorizontalGap (kDeviceWidth/self.column-kButtonWidth)/2
#define kButtonWidth 50
#define kButtonHeight 25
#define kCustomButtonTag 10000

#import "QCPopupView.h"

@implementation QCPopupView {
    NSMutableArray *_buttonContainer;
}

- (id)initWithArray:(NSArray *)array withColumnCount:(NSInteger)column{
    self.array = array;
    self.column = column;
    _buttonContainer = [NSMutableArray new];
    
    NSInteger row = self.array.count/self.column+1;
    CGFloat topViewHeight = row*kRowHeight+kVerticalGap;
    if (self = [super initWithFrame:CGRectMake(0, -topViewHeight, kDeviceWidth, kDeviceHeight)]) {
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.4];
        
        [self initViewsWithTopHeight:topViewHeight andRow:row];
    }
    
    
    return self;
}

- (void)initViewsWithTopHeight:(CGFloat)height andRow:(NSInteger)row{
    UIControl *tap = [[UIControl alloc] initWithFrame:self.bounds];
    [tap addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tap];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, height)];
    topView.backgroundColor = [UIColor grayColor];
    [self addSubview:topView];
    
    NSString *title = nil;
    
    //button列数
    NSInteger column = self.column;
    for (int i = 0; i<row; i++) {
        if (i == row-1) {
            column = self.array.count%self.column;
        }
        for (int j = 0; j<column; j++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kHorizontalGap+kColumnWidth*j, kVerticalGap+kRowHeight*i, kButtonWidth, kButtonHeight)];
            title = [self.array objectAtIndex:(i*self.column+j)];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitle:title forState:UIControlStateSelected];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setBackgroundImage:[UIImage imageNamed:@"blue-but2"] forState:UIControlStateSelected];
            button.layer.cornerRadius = 2;
            button.layer.masksToBounds = YES;
            button.layer.borderColor = rgb(47, 149, 240, 1).CGColor;
            button.layer.borderWidth = 1;
            button.tag = kCustomButtonTag+i*self.column+j;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [topView addSubview:button];
            [_buttonContainer addObject:button];
            
            if (i == 0 && j == 0) {
                button.selected = YES;
            }
        }
    }
}

- (void)tapAction:(UIControl *)tap {
    if ([self.delegate respondsToSelector:@selector(QCPopupViewDismissTapAction:)]) {
        [self.delegate QCPopupViewDismissTapAction:self];
    }
    [self dismiss];
}

- (void)buttonAction:(UIButton *)button {
    for (UIButton *elseBtn in _buttonContainer) {
        elseBtn.selected = NO;
    }
    button.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(QCPopupView:buttonDidClickAtIndex:)]) {
        [self.delegate QCPopupView:self buttonDidClickAtIndex:(button.tag-kCustomButtonTag)];
    }
    
    [self dismiss];
}

- (void)show {
    [UIView animateWithDuration:0.35 animations:^{
        self.top = 0;
    }];
}

- (void)dismiss {
    NSInteger row = self.array.count/self.column+1;
    CGFloat topViewHeight = row*kRowHeight+kVerticalGap;
    [UIView animateWithDuration:0.35 animations:^{
        self.top = -topViewHeight;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
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
