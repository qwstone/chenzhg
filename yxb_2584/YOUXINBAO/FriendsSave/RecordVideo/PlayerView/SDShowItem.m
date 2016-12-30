//
//  SDShowItem.m
//  YOUXINBAO
//
//  Created by Cher on 16/2/3.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "SDShowItem.h"
#import "SDItemView.h"

static SDShowItem *item = nil;

@interface SDShowItem ()

@property(nonatomic,strong)SDItemView *itemView;
@property(nonatomic,strong)UIView *bgView;

@end


@implementation SDShowItem


+ (id)instanceShow{
     
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          item = [SDShowItem new];
     });
     return item;
}

- (void)showView{
     
     if (_itemView) {
          [_itemView removeFromSuperview];
          _itemView = nil;
     }
     
     UIWindow *keyWidow = [UIApplication sharedApplication].keyWindow;
     
     _bgView = [UIView new];
     _bgView.frame = keyWidow.bounds;
     _bgView.backgroundColor = [UIColor blackColor];
     _bgView.alpha = 0.2;
     [keyWidow addSubview:_bgView];
     
     CGFloat y = (kDeviceHeight - 170)/2.0f;
     
     _itemView = [[SDItemView alloc] initWithFrame:CGRectMake((kDeviceWidth-170)/2, y, 170, 170)];
     _itemView.center = keyWidow.center;
     _itemView.progressViewWidth = 103;
     [keyWidow addSubview:_itemView];
}

- (void)progressValue:(CGFloat)progress{
    NSLog(@"progress~~~~~~~%f",progress);
     
     if (progress < 1.0) {
          //设置进度
          [_itemView returnSDLoopProgressView].progress = progress;
          // 循环
     }
    else{
        //上传成功之后调用该方法
        [_itemView successChange];
        //设置视图消失时间
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        progress = 0;
    }
}

- (void)hiddenShowView{
    
     [_bgView removeFromSuperview];
     _bgView = nil;
     [_itemView removeFromSuperview];
     _itemView = nil;

}


- (void)timerAction:(NSTimer *)sender{
     
     static int i = 0;
     i++;
     if (i == 2) {
          i = 0;
          [sender invalidate];
          [self hiddenShowView];
     }
}



@end
