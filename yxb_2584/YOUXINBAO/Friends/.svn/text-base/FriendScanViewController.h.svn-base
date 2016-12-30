//
//  FriendScanViewController.h
//  YOUXINBAO
//
//  Created by CH10 on 15/7/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CPBTimerManager.h"
#import "HttpOperator.h"

@interface FriendScanViewController : QCBaseViewController<AVCaptureMetadataOutputObjectsDelegate,CPBTimerDelegate>
{
    int num;
    BOOL upOrdown;

}

@property (assign, nonatomic) BOOL isConnect;

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;

@property(nonatomic,strong)HttpOperator * iHttpOperator;
@property (nonatomic,strong) CPBTimerManager * timer;

@end


