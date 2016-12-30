//
//  DetailsFooterView.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DetailsFooterView.h"

@implementation DetailsFooterView
{
//    ListStyle flistStyle;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithNameArr:(NSArray *)nameArr
{
    self = [super initWithFrame:CGRectMake(0, kDeviceHeight-50-64, kDeviceWidth, 50)];
    if (self) {
//        flistStyle = style;
        self.backgroundColor = rgb(241, 240, 248, 1);
     
//        NSArray *imageArr = @[@""]
        
        if (nameArr.count != 0) {
            for (NSInteger i = 0; i < nameArr.count; i++) {
                UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i * kDeviceWidth/nameArr.count, 0, kDeviceWidth/nameArr.count, 50)];
                [btn setTitle:nameArr[i] forState:UIControlStateNormal];
                btn.layer.borderColor = rgb(191, 191, 191, 1).CGColor;
                btn.layer.borderWidth = 0.5;
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
                btn.tag = i+1;
                [btn setTitleColor:rgb(62, 163, 255, 1) forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                //            [btn setBackgroundImage:[UIImage imageNamed:@"blue-but.png"] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor whiteColor];
                [self addSubview:btn];
            }
            
        }

//        if (style == F_nearByList) {
//            
//        }
    }
    return self;
}

- (void)buttonAction:(UIButton *)sender
{
    [self.delegate footerViewbuttonActionWithSender:sender];
}

@end
