//
//  SDItemView.m
//  SDPieLoopProgressView
//
//  Created by Cher on 16/2/2.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import "SDItemView.h"

@interface SDItemView ()

@property(nonatomic,strong)UIImageView *bgImgView;
@property (nonatomic, strong) SDLoopProgressView *sdProgressView;

@end

@implementation SDItemView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setProgressViewWidth:(CGFloat)progressViewWidth
{
    if (_progressViewWidth != progressViewWidth) {
        _progressViewWidth = progressViewWidth;
        [self initView];
    }
}

- (SDLoopProgressView *)returnSDLoopProgressView{
    
    return _sdProgressView;
}

- (void)initView{
    
    _bgImgView = [UIImageView new];
    _bgImgView.frame = self.bounds;
    _bgImgView.image = [UIImage imageNamed:@"Video_chuanzhong"];
    [self addSubview:_bgImgView];
    
    CGFloat x = (self.frame.size.width-_progressViewWidth)/2.0f;
    _sdProgressView = [[SDLoopProgressView alloc] initWithFrame:CGRectMake(x, 30, _progressViewWidth, _progressViewWidth)];
    [self addSubview:_sdProgressView];
}

- (void)successChange{
    
    _bgImgView.image = [UIImage imageNamed:@"Video_chenggong"];
    [_sdProgressView removeFromSuperview];
    _sdProgressView = nil;
    
}





@end
