//
//  HeaderView.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "HeaderView.h"
#import "QCConst.h"
#define HeaderViewTagStart 1000

@interface HeaderView ()
@property(nonatomic,strong)UIColor *selectedBgColor;
@property(nonatomic,strong)UIColor *unSelectedBgColor;
@property(nonatomic,strong)UIColor *selectedTextColor;
@property(nonatomic,strong)UIColor *unSelectedTextColor;
@property(nonatomic,assign)NSInteger numberOfItems;

@end

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setHeaderViewColorsWithUnSelectedBgColor:(UIColor *)unSelectedBgColor selectedBgColor:(UIColor *)selectedBgColor unSelectedTextColor:(UIColor *)unSelectedTextColor selectedTextColor:(UIColor *)selectedTextColor
{
    self.selectedBgColor = selectedBgColor;
    self.unSelectedBgColor = unSelectedBgColor;
    self.selectedTextColor = selectedTextColor;
    self.unSelectedTextColor = unSelectedTextColor;
//    [self refreshColor];
    self.selectedIndex  = 0;
}

- (id)initWithFrame:(CGRect)frame WithArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self loadDefaultColor];

        [self createUIWIthArray:array];
    }
    
    return self;
}

-(void)loadDefaultColor
{
    _selectedBgColor = rgb(221, 101, 115, 1.0);
    _unSelectedBgColor = [UIColor clearColor];
    _selectedTextColor = [UIColor whiteColor];
    _unSelectedTextColor = rgb(221, 101, 115, 1.0);
}

- (void)createUIWIthArray:(NSArray *)array
{
    self.numberOfItems = [array count];
    CGFloat width = self.width/array.count;
    CGFloat x = (kDeviceWidth-self.width)/2;
    x = 0;
    for (NSInteger i = 0; i<array.count; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(x + i* width, 5, width , self.height)];
        btn.backgroundColor = _unSelectedBgColor;
        [btn setTitleColor:_selectedTextColor forState:UIControlStateSelected];
        [btn setTitleColor:_unSelectedTextColor forState:UIControlStateNormal];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn.titleLabel setAdjustsFontSizeToFitWidth:YES];
        btn.selected = !btn.selected;
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = HeaderViewTagStart+i;
        [self addSubview:btn];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(x + i* width, btn.bottom - 2, width, 2)];
        bottomLineView.tag = 2 * HeaderViewTagStart + i;
        bottomLineView.hidden = YES;
        [self addSubview:bottomLineView];
    }
}

- (void)buttonAction:(UIButton *)sender
{
    if (sender.tag - HeaderViewTagStart != _selectedIndex) {
        self.selectedIndex = sender.tag - HeaderViewTagStart;

    }
    /*
    for (int i = 0; i < _numberOfItems; i ++) {
        NSInteger tempTag = HeaderViewTagStart + i;
        UIButton *btn = (UIButton *)[self viewWithTag:tempTag];
        UIView *view = [self viewWithTag:HeaderViewTagStart *2 + i];
        btn.selected = NO;
        if (sender.tag == btn.tag) {
            btn.selected = YES;
        }
        if (btn.selected)
        {
            btn.backgroundColor = _selectedBgColor;
            view.hidden = NO;
            
        }
        else
        {
            btn.backgroundColor = _unSelectedBgColor;
            view.hidden = YES;
            
        }

    }
    
    
    if ([self.delegate respondsToSelector:@selector(headerBtnAction:)]) {
        [self.delegate headerBtnAction:sender];

    }
    
    */
}

-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    for (NSInteger i = 0; i < _numberOfItems; i++) {
        
        UIButton * btn = (UIButton *)[self viewWithTag:HeaderViewTagStart+i];
        UIView * view = [self viewWithTag:2*HeaderViewTagStart+i];
        view.backgroundColor = _selectedTextColor;
        
        btn.backgroundColor = _unSelectedBgColor;
        [btn setTitleColor:_unSelectedTextColor forState:UIControlStateNormal];
        [btn setTitleColor:_selectedTextColor forState:UIControlStateSelected];
        btn.selected = NO;
        view.hidden = YES;
        if (i == _selectedIndex) {
            btn.selected = YES;
            btn.backgroundColor = _selectedBgColor;
            view.hidden = NO;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(headerViewSelectedIndex:)]) {
        [self.delegate headerViewSelectedIndex:_selectedIndex];
        
    }


}


@end
