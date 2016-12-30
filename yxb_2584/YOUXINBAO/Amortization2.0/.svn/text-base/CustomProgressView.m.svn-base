//
//  CustomProgressView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/11/12.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CustomProgressView.h"

@implementation CustomProgressView

{
    UILabel *_progressLabel;
}
-(void)setProgress:(CGFloat)progress{
    if (_progress!=progress) {
        _progress = progress;
        _progressLabel.frame = CGRectMake(0, 0, self.frame.size.width*progress, _progressLabel.frame.size.height);
    }
}

- (instancetype)initWithFrame:(CGRect)frame progressTintColor:(UIColor *)progressTintColor trackTintColor:(UIColor *)trackTintColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.height/2;
        _progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _progressLabel.center = CGPointMake(self.center.x-self.bounds.size.width/2, self.center.y);
        self.backgroundColor = trackTintColor;
        _progressLabel.backgroundColor = progressTintColor;
        [self addSubview:_progressLabel];
    }
    return self;
}


@end
