//
//  ImagePickerViewController.h
//  UIImagePickerDemo
//
//  Created by oftenfull on 15-1-6.
//  Copyright (c) 2015年 oftenfull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AMProgressView.h"
#import "MBProgressHUD.h"

#define VIDEO_RECORD_MAX_TIME      30.0f
#define VIDEO_RECORD_MIN_TIME      7.0f
#define COUNT_DUR_TIMER_INTERVAL 0.05



#define RGBHEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ImagePickerViewController : QCBaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    BOOL flashLightOn;
    BOOL isCameraBack;
    
    NSMutableArray *videoURLArray;
    CGFloat currentRecordTime;
    CGFloat totalRecordTime;
    UILabel *timeLabel;
}
@property(assign,nonatomic)BOOL isRecording;
@property(nonatomic,assign)BOOL isNoOnce;
@property (strong, nonatomic) UISlider *slider;
@property (strong, nonatomic) NSTimer *countDurTimer;
@property(strong,nonatomic)NSTimer *timeDown;
@property(nonatomic,strong)NSString *verifyText;
@property(nonatomic,strong)UIView *preview;
@property(nonatomic,strong)UIView *progressView;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UILabel *remarkLabel;
@property(nonatomic,strong)UIButton *finishedButton;
@property(nonatomic,strong)UIButton *recordButton;
@property(nonatomic,strong)UIButton *pauseButton;
@property(nonatomic,strong)UIImageView *timeImgView;;
@property (nonatomic,assign) NSInteger loanId;


@end
