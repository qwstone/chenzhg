//
//  CTSegmentControl.m
//  CustomSegmentControl
//
//  Created by CH10 on 16/3/16.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CTSegmentControl.h"

@interface CTSegmentControl ()
/**
 *标题
 */
@property (nonatomic,strong)NSMutableArray *items;
@end


@implementation CTSegmentControl
-(void)setDisplayRect:(BOOL)displayRect{
    _displayRect = displayRect;
    if (_displayRect) {
        self.layer.borderWidth = 1;
    }else{
        self.layer.borderWidth = 0.0;
    }
}
-(void)setRectColor:(UIColor *)rectColor{
    _rectColor = rectColor;
    self.layer.borderColor = _rectColor.CGColor;
    for (int i = 0; i < _items.count; i ++ ) {
        UIView *view = (UIView *)[self viewWithTag:3500+i];
        view.backgroundColor = _rectColor;
    }
    if (_displayRect) {
        [self setDisplayRect:YES];
    }
}
-(void)setSelectedItemColor:(UIColor *)selectedItemColor{
    _selectedItemColor = selectedItemColor;
    for (int i = 0;i < _items.count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i+3000];
        [button setTitleColor:_selectedItemColor forState:UIControlStateSelected];
    }
    _sliderLine.backgroundColor = _selectedItemColor;
}
-(void)setSegmentTintColor:(UIColor *)segmentTintColor{
    _segmentTintColor = segmentTintColor;
    for (int i = 0;i < _items.count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i+3000];
        [button setTitleColor:_segmentTintColor forState:UIControlStateNormal];
    }
}
-(void)setSelectedIndex:(NSInteger)selectedIndex{

    _selectedIndex = selectedIndex;
    for (int i = 0;i < _items.count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i+3000];
        button.selected = NO;
    }
    UIButton *btn = (UIButton *)[self viewWithTag:selectedIndex+3000];
    btn.selected = YES;
    CGFloat bW = self.frame.size.width/_items.count;
    if (_startAnimation) {
        [UIView animateWithDuration:0.1 animations:^{
            _sliderLine.frame = CGRectMake(bW * selectedIndex+2, _sliderLine.frame.origin.y, _sliderLine.frame.size.width, _sliderLine.frame.size.height);
        }];
    }else{
        _sliderLine.frame = CGRectMake(bW * selectedIndex, _sliderLine.frame.origin.y, _sliderLine.frame.size.width, _sliderLine.frame.size.height);
    }
        
        

}
-(void)setItemFont:(UIFont *)itemFont{
    _itemFont = itemFont;
    for (int i = 0 ; i < _items.count; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i+3000];
        btn.titleLabel.font = _itemFont;
    }
}
+ (instancetype)CTSegmentControlWithFrame:(CGRect)frame andItems:(NSArray *)items andItemFont:(UIFont *)itemFont{
    CTSegmentControl *control = [[CTSegmentControl alloc] initWithFrame:frame andItems:items andItemFont:itemFont];

    return control;
}
- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items andItemFont:(UIFont *)itemFont
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _items = [NSMutableArray arrayWithArray:items];
        _startAnimation = YES;
        _rectColor = [UIColor grayColor];
        CGFloat bW = frame.size.width/items.count;
        CGFloat bH = frame.size.height-3.5;
        for (int i = 0; i < items.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(bW*i, 0, bW, bH);
            [button setTitle:[items objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            button.titleLabel.font = itemFont;
            button.tag = 3000+i;
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            if(i<items.count-1){
                CGFloat bR = button.frame.origin.x+button.frame.size.width;
                UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(bR-1, 2, 1, bH-2)];
                vLine.backgroundColor = [UIColor grayColor];
                vLine.tag = 3500+i;
                [self addSubview:vLine];
            }
        }
        UIView *tSliderView = [[UIView alloc] initWithFrame:CGRectMake(2, bH, bW-5, 5)];
        tSliderView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tSliderImg"]];
        [self addSubview:tSliderView];
        _sliderLine = tSliderView;
    }
    return self;
}
-(void)btnClick:(UIButton *)btn{
    self.selectedIndex = btn.tag - 3000;
    [self.delegate segmentControlDidSelectedIndex:_selectedIndex];
}


@end
