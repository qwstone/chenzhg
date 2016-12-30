//
//  YXBLevelView.m
//  YOUXINBAO
//
//  Created by Feili on 15/7/16.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBLevelView.h"
#define YXBLevelViewImageTagStart 3000

@implementation YXBLevelView

-(void)initViews
{
    // 160 X 25
    CGFloat x = 0, y = 2, w = 15, h = 15;
    CGFloat space = 5;
    for (int i = 0; i < 5; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        imageView.tag = YXBLevelViewImageTagStart + i;
//        imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:imageView];
        
        x = x + w + space;
        
    }
}

-(void)setStateString:(NSString *)stateString
{   if(stateString != nil)
    {
        while ([stateString length] < 5) {
            stateString = [NSString stringWithFormat:@"%@0",stateString];
        }
        _stateString = stateString;
        for (int i = 0; i < 5; i ++) {
            UIImageView *imageView = (UIImageView *)[self viewWithTag:YXBLevelViewImageTagStart + i];
            imageView.image = [UIImage imageNamed:[self imageNameWithIndex:i]] ;
            
        }

    }
}

-(NSString *)imageNameWithIndex:(NSInteger)index
{
    NSString *imageName = @"";
    NSArray *nameOnArray = [NSArray arrayWithObjects:@"hao-icon-on.png",@"yxl-icon-on.png",@"hyd-icon-on.png",@"yi-icon-on.png",@"mai-icon-on.png", nil];
    NSArray *nameOffArray = [NSArray arrayWithObjects:@"hao-icon.png",@"yxl-icon.png",@"hyd-icon.png",@"yi-icon.png",@"mai-icon.png", nil];
    
    NSString *s = [self.stateString substringWithRange:NSMakeRange(index, 1)];
    NSLog(@"sss-%@",s);
    if ([s integerValue] == 1) {
        imageName = nameOnArray[index];
    }
    else
    {
        imageName = nameOffArray[index];
    }
    
    return imageName;

}

@end
