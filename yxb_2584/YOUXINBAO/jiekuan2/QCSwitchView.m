//
//  QCSwitchView.m
//  YOUXINBAO
//
//  Created by Feili on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCSwitchView.h"
#define QCSwitchViewBaseTabNumbers 1024

@interface QCSwitchView ()
@property (nonatomic,strong) NSArray *imageArray;
@end

@implementation QCSwitchView

//imageArray 二维数组 两个按钮 [0]->高亮,普通 [1]->高亮,普通
-(void)setImageArray:(NSArray *)imageArray
{
    self.imageArray = imageArray;
    CGFloat imageWidth = self.width /([_imageArray count]);
    
    //创建button
    if ([_imageArray count] > 0) {
        
        for (int i = 0; i < [_imageArray count]; i ++) {
            
            CGFloat x = i * imageWidth;
            CGFloat y = 0, w = imageWidth,h = self.height;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = ccr(x, y, w, h);
            btn.tag = i + QCSwitchViewBaseTabNumbers;
            NSString *stringNameSelected = imageArray[i][0];
            NSString *stringNameUnSelected = imageArray[i][1];
            [btn setImage:[UIImage imageNamed:stringNameSelected] forState:UIControlStateSelected];
            [btn setImage:[UIImage imageNamed:stringNameUnSelected] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
        }

    }
    else
    {
        NSLog(@"按钮个数为0");
    }

}

-(void)btnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    NSInteger index = sender.tag - QCSwitchViewBaseTabNumbers;
    if (_delegate && [_delegate respondsToSelector:@selector(switchViewDidSelectedIndex:)]) {
        [_delegate switchViewDidSelectedIndex:index];
    }
}



@end
