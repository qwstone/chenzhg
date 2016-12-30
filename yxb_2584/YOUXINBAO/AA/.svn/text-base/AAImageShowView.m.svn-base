//
//  AAImageShowView.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/24.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//


#import "AAImageShowView.h"
#import "UIImageView+WebCache.h"

@implementation AAImageShowView

- (id)initWithFrame:(CGRect)frame withUrlArr:(NSArray *)array withIndex:(NSInteger)index {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        [self _initViews];
        
        self.urlArray = array;
        self.index = index;
    }
    
    return self;
}

- (void)_initViews {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    [_scrollView addGestureRecognizer:tap];
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-100, self.height-25, 100, 25)];
    _countLabel.backgroundColor = [UIColor clearColor];
    _countLabel.font = [UIFont systemFontOfSize:15];
    _countLabel.textColor = [UIColor whiteColor];
    [self addSubview:_countLabel];
    
}

- (void)setUrlArray:(NSArray *)urlArray {
    _urlArray = urlArray;
    
    _scrollView.contentSize = CGSizeMake(self.width*urlArray.count, self.height);
    
    for (int i = 0; i < urlArray.count; i++)
    {
        NSString* urlStr = [urlArray objectAtIndex:i];
        //默认图片
        UIImageView* imgview = [[UIImageView alloc] initWithFrame:CGRectMake(self.width*i, 0, self.width, self.height)];
        imgview.tag = i + 10000;
        //        imgview.layer.contentsGravity = kCAGravityCenter;
        [imgview sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        imgview.contentMode = UIViewContentModeScaleAspectFit;
        //开启触摸事件
        imgview.userInteractionEnabled = YES;
        [_scrollView addSubview:imgview];
        
        //保存图片
        //保存相片方法
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(savePhoto:)];
        [imgview addGestureRecognizer:longPress];
        
    }
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    
    _countLabel.text = [NSString stringWithFormat:@"%ld   /   %ld",(long)(index+1),(long)self.urlArray.count];
    
    _scrollView.contentOffset = CGPointMake(kDeviceWidth*index, _scrollView.contentOffset.y);
}


- (void)backAction:(UITapGestureRecognizer *)tap {
    if (self.superview != nil) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            // animate it to the identity transform (100% scale)
            self.transform = CGAffineTransformMakeScale(1.3, 1.3);
            self.alpha = 0;
        } completion:^(BOOL finished){
            [self removeFromSuperview];
        }];
        
    }
    else
    {
        
    }

}

- (void)savePhoto:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始长按");
        //取到手势所在图片的tag值
        _longPressTag = [longPress view].tag;
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"请选择是否保存图片"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"保存"
                                      otherButtonTitles:nil,nil];
        actionSheet.actionSheetStyle = UIBarStyleDefault;
        [actionSheet showInView:self];
    }
    else if(longPress.state == UIGestureRecognizerStateEnded) {
        NSLog(@"结束长按");
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //2.将大图图片保存到相册
        UIImageView *imageview = (UIImageView *)[_scrollView viewWithTag:_longPressTag];
        UIImage *image = imageview.image;
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else if (buttonIndex == 1) {
        NSLog(@"取消");
    }
    
}

//保存图片到相册成功之后调用的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    //保存成功
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alterView show];
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/self.width;
    _countLabel.text = [NSString stringWithFormat:@"%ld   /   %ld",(long)(page+1),(long)self.urlArray.count];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
