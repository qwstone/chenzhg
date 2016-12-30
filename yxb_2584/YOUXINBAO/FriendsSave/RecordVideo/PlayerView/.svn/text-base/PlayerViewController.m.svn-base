//
//  PlayerViewController.m
//  UIImagePickerDemo
//
//  Created by oftenfull on 15-1-7.
//  Copyright (c) 2015年 oftenfull. All rights reserved.
//

#import "PlayerViewController.h"
#import "MBProgressHud.h"
#import "AFHTTPRequestOperationManager.h"
#import "ImagePickerViewController.h"
#import "YXBTool.h"
#import "UIAlertView+Block.h"
#import "KVNProgress.h"
#import "LoanDetailsViewController.h"
#import "YXBTool.h"
#import "LoanManagerV2.h"
#import "SDShowItem.h"
#import "MyLoanViewController.h"
@interface PlayerViewController ()
{
    MBProgressHUD *mbProgressHUD;
    MPMoviePlayerController *player;
    MPMoviePlayerViewController *playViewController;
    UILabel *rightLabel;
    UILabel *leftLabel;
    UIButton *playButton;
    UIButton *pauseButton;
}
@end

@implementation PlayerViewController

- (void)dealloc{


    NSLog(@"PlayerViewController dealloc 了");
}
- (id)initWithUrlPath:(NSURL *)videoPath {
    if (self) {
        _videoPath = videoPath;
        // 注册一个播放结束的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(movieFinishedCallback:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:player];
        
        //视频时长已读取
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(durationAvailableAction)
                                                     name:MPMovieDurationAvailableNotification
                                                   object:nil];
        
        //播放状态改变
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playStateDidChange:)
                                                     name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                   object:nil];
        //播放结束
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.barTintColor = rgb(0, 0, 0, 0.5);
      self.navigationController.navigationBar.hidden=YES;
    // Do any additional setup after loading the view from its nib.
    [self setBackView];
    [self initView];
   

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
     self.navigationController.navigationBar.hidden=YES;
}

- (void)initView{
    

    
    _thumbImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    
    UIImage *image = [self thumbnailImageForVideo:_videoPath atTime:1];
    NSLog(@"image[width = %f,height = %f]",image.size.width,image.size.height);
    _thumbImageView.image = image;
    _thumbImageView.userInteractionEnabled=YES;
    NSLog(@"videoPath = %@",_videoPath);
    [self.view addSubview:_thumbImageView];
    
    player=[[MPMoviePlayerController alloc]initWithContentURL:_videoPath];
    player.view.backgroundColor = [UIColor clearColor];
    player.scalingMode=MPMovieScalingModeAspectFill;
    player.controlStyle=MPMovieControlStyleNone;
    player.view.frame=self.thumbImageView.bounds;
    [self.thumbImageView addSubview:player.view];
    
    //播放按钮
    playButton=[[UIButton alloc]initWithFrame:CGRectMake((kDeviceWidth-110)/2, 150, 110, 110)];
    playButton.tag=1001;
    playButton.userInteractionEnabled=YES;
    [playButton setImage:[UIImage imageNamed:@"Video_play.png"] forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    //暂停的大按钮
    pauseButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 44, kDeviceWidth, kDeviceHeight-230)];
    [pauseButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    pauseButton.tag=1005;
    pauseButton.userInteractionEnabled=NO;
    pauseButton.backgroundColor=[UIColor clearColor];
    [self.view addSubview:pauseButton];
    
    //下部黑色视图
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, kDeviceHeight-230, kDeviceWidth,230)];
    view.userInteractionEnabled=NO;
    view.backgroundColor=[UIColor blackColor];
    view.alpha=0.8;
    [self.view addSubview:view];
    
    //进度条
    self.progressView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 3)];
    self.progressView.backgroundColor=[UIColor clearColor];
    [view addSubview:self.progressView];
    
    if (_slider==nil) {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 3)];
        _slider.value=0.0f;
        [_slider setThumbImage:[UIImage imageNamed:@"slider1-1"] forState:UIControlStateNormal];
        
        [_slider setMaximumTrackImage:[UIImage imageNamed:@"Video_slider2"] forState:UIControlStateNormal];
        [_progressView addSubview:_slider];
    }
    
    //提示
    self.remarkLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 11, kDeviceWidth, 15)];
    self.remarkLabel.text=@"请点击录制按钮,并在30秒内清晰阅读范本";
    self.remarkLabel.font=[UIFont systemFontOfSize:14];
    self.remarkLabel.textColor=rgb(255, 255, 255, 1);
    self.remarkLabel.textAlignment=NSTextAlignmentCenter;
    [view addSubview:self.remarkLabel];
    //读的字
    UILabel *label;
    label=[[UILabel alloc]initWithFrame:CGRectMake(0,_remarkLabel.bottom+5,kDeviceWidth,120)];
   // label.backgroundColor=[UIColor redColor];
    label.text=self.veryfyText;
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    //label.text=self.verifyText;
    label.numberOfLines=0;
    label.font=[UIFont systemFontOfSize:14.0];
    [view addSubview:label];
    
    //重新录制按钮
    UIButton *reButton=[[UIButton alloc]initWithFrame:CGRectMake(15,kDeviceHeight-60, 140, 42)];
    reButton.tag=1002;
    [reButton setImage:[UIImage imageNamed:@"Video_chonglu"] forState:UIControlStateNormal];
    [reButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reButton];
    //上传按钮
    UIButton *chuanButton=[[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-155,kDeviceHeight-60, 140, 42)];
    chuanButton.tag=1003;
    [chuanButton setImage:[UIImage imageNamed:@"Video_shangchuan"] forState:UIControlStateNormal];
    [chuanButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chuanButton];
    
    if (_slider==nil) {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 3)];
        _slider.value=0.0f;
        [_slider setThumbImage:[UIImage imageNamed:@"slider1"] forState:UIControlStateNormal];
        
        [_slider setMaximumTrackImage:[UIImage imageNamed:@"slider2"] forState:UIControlStateNormal];
        [_progressView addSubview:_slider];
    }
    
    UIView *navView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44)];
    navView.backgroundColor=[UIColor blackColor];
    navView.alpha=0.4;
    [self.view addSubview:navView];
    
    UILabel *labelNav=[[UILabel alloc]initWithFrame:CGRectMake((kDeviceWidth-80)/2, 0, 80, 44)];
    labelNav.text=@"播放视频";
    labelNav.textColor=[UIColor whiteColor];
    labelNav.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:labelNav];
    
    UIButton *buttonNav=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonNav.frame=CGRectMake(7, 7, 30, 30);
    [buttonNav setBackgroundImage:[UIImage imageNamed:@"navigation_abck_"] forState:UIControlStateNormal];
    buttonNav.userInteractionEnabled=YES;
    [buttonNav addTarget:self action:@selector(buttonNavAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonNav];
    
}

- (void)buttonNavAction{
   
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定放弃录制视频吗" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            
            NSArray *array=self.navigationController.viewControllers;
            for (UIViewController *viewCtrl in array) {
                if ([viewCtrl isKindOfClass:[MyLoanViewController class]]) {
                    MyLoanViewController *ctrl=(MyLoanViewController *)viewCtrl;
                    ctrl.isFromVideo=YES;
                    [self.navigationController popToViewController:ctrl animated:YES];
                    
                }
                
                
            }
            

             [player pause];
        }
    }];
   }

- (void)buttonAction:(UIButton *)button{
    if (button.tag==1001) {
        //播放
        if (player.playbackState == MPMoviePlaybackStatePaused||player.playbackState == MPMoviePlaybackStateStopped) {
            [player play];
            playButton.hidden=YES;
            playButton.userInteractionEnabled=NO;
            pauseButton.userInteractionEnabled=YES;
        }
    }//重新录制
    else if (button.tag==1002){
        [player pause];
        [self.navigationController popViewControllerAnimated:YES];
        //暂停
    }else if (button.tag==1005){
    
        [player pause];
        playButton.hidden=NO;
        playButton.userInteractionEnabled=YES;
        pauseButton.userInteractionEnabled=NO;
    
    }
    else{//上传视频
        [player pause];
        [self uploadVideo];
        
    }


    
}
- (void)startCountDurTimer
{
    self.countDurTimer = [NSTimer scheduledTimerWithTimeInterval:COUNT_DUR_TIMER_INTERVAL target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}

- (void)onTimer:(NSTimer *)timer
{
    currentRecordTime += COUNT_DUR_TIMER_INTERVAL;
    _slider.value=((kDeviceWidth-110/ _allTime)* (currentRecordTime))/(kDeviceWidth-110);
    
}
- (void)stopCountDurTimer
{
    [_countDurTimer invalidate];
    self.countDurTimer = nil;
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];
     [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
     self.navigationController.navigationBar.hidden=YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time
{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode =AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef] : nil;
    
    return thumbnailImage;
}


-(void)movieFinishedCallback:(NSNotification*)notify
{
    NSLog(@"视频播放完成");
    
    [player pause];
    playButton.hidden=NO;
    playButton.userInteractionEnabled=YES;
    pauseButton.userInteractionEnabled=NO;
    //视频播放对象
    MPMoviePlayerController* theMovie = [notify object];
    //销毁播放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:theMovie];
    
    
}
- (BOOL)prefersStatusBarHidden
{
    return YES; // 返回NO表示要显示，返回YES将hiden
}

- (void)uploadVideo {
    
    [[SDShowItem instanceShow] showView];
     
    NSString *videoPath = [[self videoPathwithUrl:[_videoPath absoluteString]] absoluteString];
    //    NSData *videoData = [NSData dataWithContentsOfFile:videoPath];
    NSData *videoData = [NSData dataWithContentsOfURL:[self videoPathwithUrl:[_videoPath absoluteString]]];
    NSLog(@"videoDataLength:---%lu",(unsigned long)videoData.length);
    
    NSArray *array  = [videoPath componentsSeparatedByString:@"/"];
    NSString *str = [array lastObject];
    //    http://60.195.254.33:8083/uploadVideo.jsp
//<<<<<<< .mine
//    NSString *url = @"https://www.51jt.com/uploadVideo.jsp";
//=======
//>>>>>>> .r2454
    
    
    
//    NSString *url = @"http://60.195.254.33:8083/uploadVideo.jsp";
    
    NSString *url = [NSString stringWithFormat:@"%@uploadVideo.jsp",YXB_IP_ADRESS];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",
                                                         @"text/plain",
                                                         @"application/json",nil];
    //
    NSDictionary *parameters = @{@"foo": @"bar"};
    AFHTTPRequestOperation *operation = [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
    [formData appendPartWithFileData:videoData name:@"file" fileName:str mimeType:@"video/quicktime"];
                                             
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(mbProgressHUD != nil)
            {
                [mbProgressHUD removeFromSuperview];
        }
            NSString *str = [YXBTool decodeFromPercentEscapeString:responseObject];
            [self httpRequest:str];
            NSLog(@"上传成功");
        NSArray *array=self.navigationController.viewControllers;
        for (UIViewController *viewCtrl in array) {
            if ([viewCtrl isKindOfClass:[MyLoanViewController class]]) {
                [self performSelector:@selector(afterThreeSecond:) withObject:viewCtrl afterDelay:3];
                
            }
            
            
        }

                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        //移除上传视图
                        [[SDShowItem instanceShow] hiddenShowView];
                        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth-170)/2, (kDeviceHeight - 170)/2.0, 170, 170)];
                        img.image=[UIImage imageNamed:@"Video_shibai"];
                        [self.view addSubview:img];
                         
                        NSLog(@"operation-- %@====\nerror---%@",operation,error);
                        NSLog(@"上传失败");

                                [mbProgressHUD removeFromSuperview];
                        
                        
                                         }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat progress=((float)totalBytesWritten)/totalBytesExpectedToWrite;

         [[SDShowItem instanceShow] progressValue:progress];
        
        
    }];
    
}
- (void)afterThreeSecond:(UIViewController *)viewCtrl{
    MyLoanViewController *ctrl=(MyLoanViewController *)viewCtrl;
    ctrl.isFromVideo=YES;
    [self.navigationController popToViewController:ctrl animated:YES];
    
}
-(void)httpRequest:(NSString *)path{
    
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak PlayerViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        [this stopDefaultAnimation];
    } cancel:^(int d) {
        //        [ProgressHUD showErrorWithStatus:@"操作失败！"];
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
        }
        
    } param:^(NSString *s) {
        
        
        [this httpLOadParams:s httpOperation:assginHtttperator WithLoanID:this.loanId path:path];
        
    } complete:^(TResultSet* r, int taskid) {
        
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
}

- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation WithLoanID:(NSInteger)loanId path:(NSString *)path
{
    LoanManagerV2* _Loanmanger = (LoanManagerV2*)  [httpOperation getAopInstance:[LoanManagerV2 class] returnValue:[Loan class]];
    [_Loanmanger uploadVerifyVideo:[YXBTool getUserToken] verifyVideoUrl:path loanId:loanId];
}
-(void)httpLoadComplete:(TResultSet *)r{
 
    if (r.errCode == 0) {
        //移除上传视图
        [[SDShowItem instanceShow] hiddenShowView];
        [ProgressHUD showSuccessWithStatus:r.errString];
        

    }

}
-(NSURL *)videoPathwithUrl:(NSString *)videoPath
{
    if (videoPath == nil || [videoPath isEqualToString:@""]) {
        return [NSURL URLWithString:@""];
    }
    NSURL *videoUrl = nil;
    if ([videoPath hasPrefix:@"https://"]) {
        videoUrl = [NSURL URLWithString:videoPath];
    }else{
        if([videoPath hasPrefix:@"file://"]){
            videoPath = [videoPath stringByReplacingOccurrencesOfString:@"file://" withString:@""];
        }
        
        if(DEVICE_OS_VERSION <=7.0){
            if ([videoPath hasPrefix:@"localhost"]) {
                videoPath =[videoPath stringByReplacingOccurrencesOfString:@"localhost" withString:@""];
            }
        }
        videoUrl = [[NSURL alloc] initFileURLWithPath:videoPath];
    }
    
    NSLog(@"videoUrl = %@",videoUrl);
    
    return videoUrl;
}
-(void)setBackView
{
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    
}
- (void)setNavigationButtonItrmWithiamge:(NSString *)imagename withRightOrleft:(NSString*)f withtargrt:(id)t withAction:(SEL)s
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn addTarget:self action:s forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    
    UIBarButtonItem * navItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if ([f isEqualToString:@"right"]) {
        self.navigationItem.rightBarButtonItem = navItem;
        
    }else if ([f isEqualToString:@"left"]){
        self.navigationItem.leftBarButtonItem = navItem;
    }
}


-(void)leftClicked
{
    
    [self.navigationController popViewControllerAnimated:YES];
    [player pause];
    
}
//新的

//设置右边Label总时长
-(void)durationAvailableAction
{
    //    rightLabel.text = [self formatPlayTime:player.duration];
}
-(NSString *)formatPlayTime:(NSTimeInterval) duration
{
    int minute = 0, hour = 0, second = duration;
    hour = second/3600;
    minute = (second%3600)/60;
    second = second%60;
    
    return [NSString stringWithFormat:@"00:%02d",  second];
}
//收到播放状态改变的通知
- (void)playStateDidChange:(NSNotification *)notification
{
    if (player.playbackState == MPMoviePlaybackStatePlaying){
        [self performSelector:@selector(movieProgressDutationAction) withObject:nil afterDelay:0.1];
        //[playButton setImage:[UIImage imageNamed:@"video-suspend-but.png"] forState:UIControlStateNormal];

    }else {
       
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(movieProgressDutationAction) object:nil];
        //[playButton setImage:[UIImage imageNamed:@"video-bsee-but.png"] forState:UIControlStateNormal];
        [playButton setImage:[UIImage imageNamed:@"Video_play"] forState:UIControlStateNormal];
        
    }
}
#pragma mark - 收到通知设置属性
//跟踪播放进度
-(void)movieProgressDutationAction
{
    leftLabel.text = [self formatPlayTime:player.currentPlaybackTime];
    _slider.value = player.currentPlaybackTime/player.duration;
    
    //    NSLog(@"dutation");
    [self performSelector:@selector(movieProgressDutationAction) withObject:nil afterDelay:1];
}
//视频播放完成
- (void)playDidFinish:(NSNotification *)notification
{  
    _slider.value = 0;
    player.currentPlaybackTime = 0;
    leftLabel.text = [self formatPlayTime:0];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
    self.navigationController.navigationBar.hidden=NO;
   
    
}
@end
