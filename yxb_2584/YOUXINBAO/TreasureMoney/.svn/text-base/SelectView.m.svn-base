//
//  SelectView.m
//  YOUXINBAO
//
//  Created by zjp on 15/9/22.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "SelectView.h"

@implementation SelectView {
    UIView *bottomLineView;
}


- (id)initWithFrame:(CGRect)frame WithArray:(NSArray *)array  imgArray:(NSArray *)imgArray imgArraylight:(NSArray *)imgArraylight
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = self.width/array.count;
        for (int i = 0; i < array.count; i++) {

            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i* width, 0, width , 45)];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:imgArraylight[i]] forState:UIControlStateSelected];
            [btn setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
            [btn setTitle:array[i] forState:UIControlStateNormal];
            [btn.titleLabel setAdjustsFontSizeToFitWidth:YES];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(5, 15, 5, 5)];
            [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            if (i == self.selectIndex) {
                btn.selected = YES;
                self.button = btn;
                bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(i* width+20, btn.bottom, width-40, 2)];
                bottomLineView.backgroundColor = [UIColor redColor];
                [self addSubview:bottomLineView];
            }else {
                btn.selected = NO;
            }
            [self addSubview:btn];
            

        }
      UIView  *botLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width  , 1)];
        botLineView.backgroundColor = rgb(243, 243, 243, 1);
        [self addSubview:botLineView];
    }
    return self;
}

- (void)buttonAction:(UIButton *)sender {
    [UIView animateWithDuration:0.1 animations:^{
        bottomLineView.center = sender.center;
        bottomLineView.top = sender.bottom;
    } completion:^(BOOL finished) {
        
    }];

    self.button.selected = NO;
    sender.selected = YES;
    self.button = sender;
    if ([self.delegate respondsToSelector:@selector(SelectViewSelectedIndex:)]) {
        [self.delegate SelectViewSelectedIndex:sender.tag];
    }
    
}




@end
