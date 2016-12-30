//
//  PostponeView.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/5/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "PostponeView.h"
#import "AppDelegate.h"

@implementation PostponeView{
}


- (id)initWithbtnTitleArray:(NSArray *)array
{
    self = [super initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    if (self) {
        self.backgroundColor = [UIColor brownColor];
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth-40, 200)];
        view.center = self.center;
        view.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, view.width, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"是否为该借款单延期一个月？\n给与补偿金成功率会更高哦";
        label.numberOfLines = 2;
        label.lineBreakMode = 0;
        [view addSubview:label];
        
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(view.width-60, 50, 40, 20)];
        [view addSubview:_textField];
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, view.width, 20)];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.text = @"请联系放款人在7天内处理，过期自动取消。";
        [view addSubview:label2];
        
//        for (NSInteger i = 0; i < 2; i++) {
//            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i* view.width/2, view.height-30, view.width/2, 30)];
//            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//            [btn setTitle:array[i] forState:UIControlStateNormal];
//            btn.tag = i+1;
//            [view addSubview:btn];
//        }
        
        [self addSubview:view];

    }
    return self;
}


- (void)btnAction:(UIButton *)sender{
    [self.delegate postponetView:self clickedButtonAtIndex:self.tag];
}

- (void)show
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
}

- (void)remove
{
    [self removeFromSuperview];
}

@end
