//
//  LoanDetailInterestView.m
//  YOUXINBAO
//
//  Created by Feili on 15/7/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanDetailInterestView.h"

#define LoanDetailInterestViewTagStart 1000
@interface LoanDetailInterestView ()

@property(nonatomic,strong)UIColor *selectedBgColor;
@property(nonatomic,strong)UIColor *unSelectedBgColor;
@property(nonatomic,strong)UIColor *selectedTextColor;
@property(nonatomic,strong)UIColor *unSelectedTextColor;
@property(nonatomic,assign)NSInteger numberOfItems;

@end
@implementation LoanDetailInterestView


- (id)initWithFrame:(CGRect)frame WithArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
                [self loadDefaultColor];
        
        [self createUIWIthArray:array];
    }
    
    return self;
}

-(void)loadDefaultColor
{
    _selectedBgColor = rgb(221, 101, 115, 1.0);
    _unSelectedBgColor = [UIColor clearColor];
    _selectedTextColor = rgb(74, 74, 74, 1);
    _unSelectedTextColor = rgb(74, 74, 74, 1);
}

- (void)createUIWIthArray:(NSArray *)array
{
    self.numberOfItems = [array count];
//    CGFloat width = self.width/array.count;
    CGFloat width = 0;
    CGFloat space = 10;
    width = (self.width - 2 *space)/3.0;
//    CGFloat x = (kDeviceWidth-self.width)/2;
    CGFloat x = 0;
    x = 0;
    for (NSInteger i = 0; i<array.count; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x + i* (width+space) , 0, width , self.height)];
//        btn.backgroundColor = _unSelectedBgColor;
        UIImage *bgImage = [UIImage imageNamed:@"lxinput.png"];
        
//        UIImage *newImg= [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, bgImage.size.width - 5) resizingMode:UIImageResizingModeStretch];
        UIImage *bgImageSel = [UIImage imageNamed:@"lxinputSelected.png"];
        
//        UIImage *newImgSel= [bgImageSel resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, bgImageSel.size.width - 5) resizingMode:UIImageResizingModeStretch];

        [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
        [btn setBackgroundImage:bgImageSel forState:UIControlStateSelected];
        [btn setTitleColor:_selectedTextColor forState:UIControlStateSelected];
        [btn setTitleColor:_unSelectedTextColor forState:UIControlStateNormal];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        btn.selected = !btn.selected;
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = LoanDetailInterestViewTagStart+i;
        [self addSubview:btn];
    }
}

- (void)buttonAction:(UIButton *)sender
{
    if (sender.tag - LoanDetailInterestViewTagStart != _selectedIndex) {
        self.selectedIndex = sender.tag - LoanDetailInterestViewTagStart;
        
    }
}

-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    for (NSInteger i = 0; i < _numberOfItems; i++) {
        
        UIButton * btn = (UIButton *)[self viewWithTag:LoanDetailInterestViewTagStart+i];
        
//        btn.backgroundColor = _unSelectedBgColor;
//        [btn setTitleColor:_unSelectedTextColor forState:UIControlStateNormal];
//        [btn setTitleColor:_selectedTextColor forState:UIControlStateSelected];
        btn.selected = NO;
        if (i == _selectedIndex) {
            btn.selected = YES;
//            btn.backgroundColor = _selectedBgColor;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(headerViewSelectedIndex:)]) {
        [self.delegate headerViewSelectedIndex:_selectedIndex];
        
    }
    
    
}

@end
