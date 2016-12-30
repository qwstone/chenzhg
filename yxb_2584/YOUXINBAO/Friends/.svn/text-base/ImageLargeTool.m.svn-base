//
//  ImageLargeTool.m
//  YOUXINBAO
//
//  Created by Feili on 15/8/10.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ImageLargeTool.h"


@implementation ImageLargeTool
-(void)actionTap
{
    
    self.fullImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, [UIScreen mainScreen].bounds.size.height)];
    _fullImageView.backgroundColor=[UIColor blackColor];
    _fullImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)];
    [_fullImageView addGestureRecognizer:tap];
//    [_fullImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)]];
    _fullImageView.contentMode=UIViewContentModeScaleAspectFit;
    
    //保存图片
    //保存相片方法
    //        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(savePhoto:)];
    //        [_fullImageView addGestureRecognizer:longPress];
    
    if (![_fullImageView superview]) {
        
        _fullImageView.image=_baseImageView.image;
        //            _fullImageView.image = [YXBTool imageWithColor:[UIColor redColor]];
        UIWindow *mWindow = [[[UIApplication sharedApplication] delegate] window];
        if (!mWindow.isKeyWindow) {
            [mWindow makeKeyAndVisible];
            
        }
        
        [mWindow addSubview:_fullImageView];
        
        
        
        //            _fullImageView.frame=frame_first;
        /*
         [UIView animateWithDuration:0.3 animations:^{
         
         _fullImageView.frame=CGRectMake(0, 0, kDeviceWidth, [UIScreen mainScreen].bounds.size.height);
         
         
         } completion:^(BOOL finished) {
         
         [UIApplication sharedApplication].statusBarHidden=YES;
         
         }];
         */
    }
    
    
    
}

//-(void)actionTap2:(UITapGestureRecognizer *)sender
-(void)hideView
{
    
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        //        _fullImageView.frame = CGRectMake(10, 10, _baseImageView.width, _baseImageView.height);
        
        
    } completion:^(BOOL finished) {
        //        if (_fullImageView && _fullImageView.superview) {
        //            [_fullImageView removeFromSuperview];
        //
        //        }
        
        
    }];
    
    
    //    [UIApplication sharedApplication].statusBarHidden=NO;
    
    
}


- (void)savePhoto:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始长按");
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"请选择是否保存图片"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"保存"
                                      otherButtonTitles:nil,nil];
        actionSheet.actionSheetStyle = UIBarStyleDefault;
        actionSheet.tag = 355;
        UIWindow *mWindow = [[[UIApplication sharedApplication] delegate] window];
        if (!mWindow.isKeyWindow) {
            [mWindow makeKeyAndVisible];
            
        }

        [actionSheet showInView:mWindow];
    }
    else if(longPress.state == UIGestureRecognizerStateEnded) {
        NSLog(@"结束长按");
    }
    
}

//保存图片到相册成功之后调用的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    //保存成功
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alterView show];
}

@end
