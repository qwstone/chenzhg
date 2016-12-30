//
//  PlayerViewController.h
//  UIImagePickerDemo
//
//  Created by oftenfull on 15-1-7.
//  Copyright (c) 2015年 oftenfull. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#define DEVICE_OS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define COUNT_DUR_TIMER_INTERVAL 0.05

@interface PlayerViewController : QCBaseViewController{
    
    float currentRecordTime;
    
}
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (strong, nonatomic) NSURL *videoPath;
@property(nonatomic,strong)UIImageView *thumbImageView;
@property (strong, nonatomic) NSTimer *countDurTimer;
@property(nonatomic,assign)float allTime;
@property(nonatomic,strong) UISlider *slider;
@property(nonatomic,assign) NSInteger loanId;
@property(nonatomic,strong)UIView *progressView;
@property(nonatomic,strong)UILabel *remarkLabel;
@property(nonatomic,strong)NSString *veryfyText;
- (id)initWithUrlPath:(NSURL *)videoPath;

@end
