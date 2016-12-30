//
//  ImagePickerViewController.m
//  UIImagePickerDemo
//
//  Created by oftenfull on 15-1-6.
//  Copyright (c) 2015年 oftenfull. All rights reserved.
//

#import "ImagePickerViewController.h"
#import "PlayerViewController.h"
#import "YXBTool.h"
#import "UIAlertView+Block.h"
#import <AVFoundation/AVFoundation.h>
#import "MyLoanViewController.h"

@interface ImagePickerViewController () {
    UIImagePickerController *pickerController;
    MBProgressHUD *mbProgressHUD;
    UIImageView *imgView2;
    //倒计时
    NSInteger downTime;
    //倒计时用的定时器
    NSTimer *timer;
    
    UIView *view1;
}

@end

@implementation ImagePickerViewController


- (void)dealloc {
    NSLog(@"ImagePickerViewController dealloc 了");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        videoURLArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setLeftView];
//    [self setBackView];
    self.automaticallyAdjustsScrollViewInsets = YES;
    

    self.preview=[[UIView alloc]initWithFrame:CGRectMake(0,0, kDeviceWidth, kDeviceHeight)];
    [self.view addSubview:self.preview];
    //红点
    UIImageView *redIcon=[[UIImageView alloc]initWithFrame:CGRectMake(15,57, 60, 28)];
    redIcon.image=[UIImage imageNamed:@"play"];
    [self.view addSubview:redIcon];
    
    timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 30, 28)];
    timeLabel.textAlignment=NSTextAlignmentLeft;
    timeLabel.textColor=[UIColor whiteColor];
    [redIcon addSubview:timeLabel];
    //倒计时
    imgView2=[[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth-170)/2, redIcon.bottom+35, 170, 170)];
    imgView2.hidden=YES;
    [self.view addSubview:imgView2];

    //bottomView
    self.bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, kDeviceHeight-230, kDeviceWidth, 230)];
    self.bottomView.backgroundColor=[UIColor blackColor];
    self.bottomView.alpha=0.8;
    [self.view addSubview:self.bottomView];
    
   //进度条
    self.progressView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 3)];
    self.progressView.backgroundColor=[UIColor clearColor];
    [self.bottomView addSubview:self.progressView];
    //提示
    self.remarkLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 11, kDeviceWidth, 15)];
    self.remarkLabel.text=@"请点击录制按钮,并在30秒内清晰阅读范本";
    self.remarkLabel.font=[UIFont systemFontOfSize:14];
    self.remarkLabel.textColor=rgb(255, 255, 255, 1);
    self.remarkLabel.textAlignment=NSTextAlignmentCenter;
    [self.bottomView addSubview:self.remarkLabel];
    //读的字
    UILabel *label;
    label=[[UILabel alloc]initWithFrame:CGRectMake(0,_remarkLabel.bottom+5,kDeviceWidth,120)];
    //label.backgroundColor=[UIColor redColor];
    label.text=self.verifyText;
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.text=self.verifyText;
    label.numberOfLines=0;
    label.font=[UIFont systemFontOfSize:14.0];
    [self.bottomView addSubview:label];
    //开始录制
    self.recordButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _recordButton.frame=CGRectMake((kDeviceWidth-80)/2,kDeviceHeight-80, 80, 80);
    [_recordButton setImage:[UIImage imageNamed:@"luzhi"] forState:UIControlStateNormal];
    [_recordButton addTarget:self action:@selector(recordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.recordButton];
    
    if (_slider==nil) {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 3)];
        _slider.value=0.0f;
        [_slider setThumbImage:[UIImage imageNamed:@"slider1-1"] forState:UIControlStateNormal];
        
        [_slider setMaximumTrackImage:[UIImage imageNamed:@"Video_slider2"] forState:UIControlStateNormal];
        [_progressView addSubview:_slider];
    }
    
    //preView(控制录制视频界面的大小)
    UIView *navView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44)];
    navView.backgroundColor=[UIColor blackColor];
    navView.alpha=0.4;
    [self.view addSubview:navView];
    
    
    UILabel *labelNav=[[UILabel alloc]initWithFrame:CGRectMake((kDeviceWidth-80)/2, 0, 80, 44)];
    labelNav.text=@"录制视频";
    labelNav.textColor=[UIColor whiteColor];
    labelNav.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:labelNav];
    
    UIButton *buttonNav=[UIButton buttonWithType:UIButtonTypeCustom];
    buttonNav.frame=CGRectMake(7, 7, 30, 30);
    //navigation_abck
    [buttonNav setImage:[UIImage imageNamed:@"navigation_abck_"] forState:UIControlStateNormal];
    buttonNav.userInteractionEnabled=YES;
    [buttonNav addTarget:self action:@selector(buttonNavAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonNav];
    self.recordButton.hidden=NO;
    //打开录制视频界面
    [self recordVideo];
    
}

- (void)buttonNavAction{

    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定放弃录制视频吗" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 1&&self.isNoOnce==YES) {
            
                NSArray *arr = self.navigationController.viewControllers;
                MyLoanViewController *myvc=nil;
                for (QCBaseViewController *vc in arr) {
                    if ([vc isKindOfClass:[MyLoanViewController class]]) {
                        myvc= (MyLoanViewController *)vc;
                        myvc.isFromVideo = NO;
                        [self.navigationController popToViewController:vc animated:YES];
                        return ;
                      
                    }
                 
         
                   
            }
        }
        else if(buttonIndex==1&&self.isNoOnce==NO){
                 [self.navigationController popViewControllerAnimated:YES];
                
            }
    
    }];
    
    


}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden=YES;
    [super viewWillAppear:animated];
    [self chlikCreame];
    [self reloSelfUI];
  
    
}
-(void)leftClicked{
    [super leftClicked];
    
    [self dismissViewControllerAnimated:YES completion:^{
                
            }];

    
}
- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];

   //[[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//      [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    [self stopCountDurTimer];
    self.navigationController.navigationBar.hidden=NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
    
}


//给视图属性初始值
- (void)reloSelfUI {
    
    timeLabel.text=@"00\"";
    _slider.value=0.0f;
    self.remarkLabel.hidden=NO;
    self.recordButton.hidden=NO;
    [self.recordButton setImage:[UIImage imageNamed:@"luzhi"] forState:UIControlStateNormal];
//    self.finishedButton.hidden=YES;
//    self.pauseButton.hidden=YES;
    imgView2.hidden=YES;
    currentRecordTime=0;
    _isRecording = NO;
    downTime = 0;
    [videoURLArray removeAllObjects];
    [self stopCountDurTimer];
}
//重新录制调用
- (void)stopLuZhi {
    
    [self reloSelfUI];
    [pickerController stopVideoCapture];
}
//点击开始录制,改变录制页面
- (void)stateLuZhi {
    self.isRecording=YES;
    self.recordButton.hidden=NO;
    self.remarkLabel.hidden=NO;
    [self.recordButton setImage:[UIImage imageNamed:@"jieshu"] forState:UIControlStateNormal];
    
    
}



- (void)recordVideo{
    
    [self createVideoFolderIfNotExist];
    currentRecordTime=0;
    if (pickerController!=nil) {
        [pickerController.view removeFromSuperview];
        pickerController = nil;
    }
    
    pickerController = [[UIImagePickerController alloc] init];

         [pickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
   
    [pickerController setVideoQuality:UIImagePickerControllerQualityTypeHigh];
    //pickerController.cameraOverlayView=view1;
    NSArray* availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    pickerController.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];
    
    pickerController.showsCameraControls = NO;
    pickerController.allowsEditing = NO;
    pickerController.cameraDevice=UIImagePickerControllerCameraDeviceFront;
    if (kDeviceWidth==320&&kDeviceHeight==480) {
        pickerController.cameraViewTransform = CGAffineTransformMakeScale(1.4, 1.4);
    }
    else{
        pickerController.cameraViewTransform = CGAffineTransformMakeScale(1, 1);
    }
    
    pickerController.view.contentMode = UIViewContentModeCenter;
    pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    pickerController.videoMaximumDuration = VIDEO_RECORD_MAX_TIME;
    [pickerController setDelegate:self];
    

    
    UIView *view = [[UIView alloc] init];
    view = pickerController.view;
    view.frame = CGRectMake(0, 0, kDeviceWidth, self.preview.frame.size.height);
    view.backgroundColor = [UIColor redColor];
    [self.preview addSubview:view];
    
}


- (void)finishedButtonAction{

        _isRecording = YES;
        [self stopCountDurTimer];
        [pickerController stopVideoCapture];
    

}
- (void)finishResult{
    
    if (!mbProgressHUD) {
        mbProgressHUD = [[MBProgressHUD alloc] initWithView:self.preview];
        mbProgressHUD.labelText = @"正在处理视频，请稍等...";
    }
    [mbProgressHUD show:YES];
    [self.preview addSubview:mbProgressHUD];
    [self mergeAndExportVideosAtFileURLs:videoURLArray];
}

- (void)recordButtonAction:(UIButton *)sender{


        if (!_isRecording) {
            [self stateLuZhi];
            //开始
            if (timer==nil) {
                imgView2.hidden=NO;
                downTime=0;
                [self timeAction];
                timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    
            }
            
        }
        else{
        
        
            [self finishedButtonAction];
        
        }


}


- (void)startt{

    [_recordButton setImage:[UIImage imageNamed:@"jieshu"] forState:UIControlStateNormal];
    
    if ([self respondsToSelector:@selector(onTimer:)]) {
        self.countDurTimer = [NSTimer scheduledTimerWithTimeInterval:COUNT_DUR_TIMER_INTERVAL target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    }
    
    
}
- (void)timeAction{
    
    downTime+=1;
    [_recordButton setImage:[UIImage imageNamed:@"luzhidao"] forState:UIControlStateNormal];
    NSLog(@"======%ld",(long)downTime);
    if (downTime==1) {
        [imgView2 setImage:[UIImage imageNamed:@"d3.png"]];
    }
    else if (downTime==2) {
        [imgView2 setImage:[UIImage imageNamed:@"d2.png"]];
    }
    else if(downTime==3){
        [imgView2 setImage:[UIImage imageNamed:@"d1.png"]];
        
    }
    else{
        [timer invalidate];
        imgView2.hidden=YES;
        timer=nil;
        [self startt];
        [pickerController startVideoCapture];
        
    }
    
    
}


//重新录制
//- (IBAction)localVideoButtonAction:(UIButton *)sender {
//    [self stopLuZhi];
//}

- (void)localVideoButtonAction:(UIButton *)sender{

    [self stopLuZhi];
}

#pragma mark - uiimagepickercontroller delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSLog(@"imagePickerController didFinishPickingMediaWithInfo %@",info);
    if(_isRecording)
    {
        [videoURLArray addObject:info];
        [self finishResult];
        
    }
    
}


- (void)onTimer:(NSTimer *)timer
{
    currentRecordTime += COUNT_DUR_TIMER_INTERVAL;
    if (currentRecordTime >= VIDEO_RECORD_MAX_TIME) {
        _isRecording = YES;
        [self stopCountDurTimer];
        [pickerController stopVideoCapture];
    }
    
    _slider.value=((_progressView.frame.size.width/ VIDEO_RECORD_MAX_TIME)*  (currentRecordTime))/_progressView.frame.size.width;
//    timeLabel.text=[NSString stringWithFormat:@"00:%02.0f", _slider.value*VIDEO_RECORD_MAX_TIME];
    timeLabel.text=[NSString stringWithFormat:@"%02.0f\"", _slider.value*VIDEO_RECORD_MAX_TIME];
    
}


- (void)stopCountDurTimer
{
    [self.countDurTimer invalidate];
    self.countDurTimer = nil;
    
}


- (void)mergeAndExportVideosAtFileURLs:(NSArray *)fileURLArray
{
    NSError *error = nil;
    CGSize renderSize = CGSizeMake(0, 0);
    NSMutableArray *layerInstructionArray = [[NSMutableArray alloc] init];
    
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    
    CMTime totalDuration = kCMTimeZero;
    NSMutableArray *assetArray = [[NSMutableArray alloc] init];
    NSMutableArray *assetTrackArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [fileURLArray count]; i++) {
        NSURL *path = [[fileURLArray objectAtIndex:i] objectForKey:UIImagePickerControllerMediaURL];
        AVAsset *avAsset = [AVAsset assetWithURL:path];
        if (!avAsset) {
            continue;
        }
        NSArray *metadata = [avAsset commonMetadata];
        NSLog(@"metadata = %@",metadata);
        [assetArray addObject:avAsset];
        AVAssetTrack *assetTrack = [[avAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
        [assetTrackArray addObject:assetTrack];
        
        renderSize.width = assetTrack.naturalSize.width ;
        renderSize.height = assetTrack.naturalSize.height;
    }
    
    
    
    CGFloat renderW = renderSize.width;
    CGFloat renderH = renderSize.height;
    
    NSLog(@"renderW = %f,renderH = %f",renderW,renderH);
    
    for (int i = 0; i < [assetArray count] ; i++) {
        
        AVAsset *asset = [assetArray objectAtIndex:i];
        AVAssetTrack *assetTrack = [assetTrackArray objectAtIndex:i];
        
        AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
        
        
        NSArray *assetArr = [asset tracksWithMediaType:AVMediaTypeAudio];
        [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                            ofTrack:[assetArr count] > 0 ? [assetArr objectAtIndex:0] : 0
                             atTime:totalDuration
                              error:nil];
        
        
        AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
        
        [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration)
                            ofTrack:assetTrack
                             atTime:totalDuration
                              error:&error];
        
        //fix orientationissue
        AVMutableVideoCompositionLayerInstruction *layerInstruciton = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
        
        totalDuration = CMTimeAdd(totalDuration, asset.duration);
        //layerTransform = (a = 0, b = 1, c = -1, d = 0, tx = 480, ty = 0) 竖拍
        //layerTransform = (a = -1, b = 0, c = 0, d = -1, tx = 640, ty = 480) 右横
        //layerTransform = (a = 1, b = 0, c = 0, d = 1, tx = 0, ty = 0) 左横
        // layerTransform = (a = 0, b = -1, c = 1, d = 0, tx = 0, ty = 640) 倒拍
        
        CGAffineTransform layerTransform = CGAffineTransformMake(assetTrack.preferredTransform.a, assetTrack.preferredTransform.b, assetTrack.preferredTransform.c, assetTrack.preferredTransform.d, assetTrack.preferredTransform.tx, assetTrack.preferredTransform.ty);
        
        // 如果是竖拍或倒拍 将宽高对换
        if ((layerTransform.a ==0 && layerTransform.b == 1 && layerTransform.c == -1 && layerTransform.d == 0) || (layerTransform.a ==0 && layerTransform.b == -1 && layerTransform.c == 1 && layerTransform.d == 0)) {
            CGFloat tmp = renderW;
            renderW = renderH;
            renderH = tmp;
        }
        //    layerTransform = CGAffineTransformScale(layerTransform, 1, 1);//放缩，解决前后摄像结果大小不对称
        
        [layerInstruciton setTransform:layerTransform atTime:kCMTimeZero];
        [layerInstruciton setOpacity:0.0 atTime:totalDuration];
        
        //data
        [layerInstructionArray addObject:layerInstruciton];
    }
    //get save path
    NSURL *mergeFileURL = [NSURL fileURLWithPath:[self getVideoMergeFilePathString]];
    
    //export
    AVMutableVideoCompositionInstruction *mainInstruciton = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruciton.timeRange = CMTimeRangeMake(kCMTimeZero, totalDuration);
    mainInstruciton.layerInstructions = layerInstructionArray;
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    mainCompositionInst.instructions = @[mainInstruciton];
    mainCompositionInst.frameDuration = CMTimeMake(1, 30);
    
    mainCompositionInst.renderSize = CGSizeMake(renderW, renderH);
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                      presetName:AVAssetExportPresetMediumQuality];
    exporter.videoComposition = mainCompositionInst;
    exporter.outputURL = mergeFileURL;
    exporter.outputFileType = AVFileTypeMPEG4;
    exporter.shouldOptimizeForNetworkUse = YES;
    __weak ImagePickerViewController *this =self;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"_______________mergeFileURL = %@",mergeFileURL);
            
            [this pushtototot:mergeFileURL];
            
        });
    }];
    
}

- (void)pushtototot:(NSURL *)mergeFileURL {
    
    [mbProgressHUD hide:YES];
    
    PlayerViewController *playerViewController=[[PlayerViewController alloc]initWithUrlPath:mergeFileURL];
    playerViewController.veryfyText=self.verifyText;
    playerViewController.loanId = self.loanId;
    playerViewController.allTime=currentRecordTime;
//    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:playerViewController];
    [self.navigationController pushViewController:playerViewController animated:YES];
//    [self presentViewController:nav animated:YES completion:^{
//        
//    }];
    

}

- (NSString *)getVideoMergeFilePathString
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"videos"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    NSString *fileName = [[path stringByAppendingPathComponent:nowTimeStr] stringByAppendingString:@".mp4"];
    
    return fileName;
}

- (BOOL)createVideoFolderIfNotExist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *folderPath = [path stringByAppendingPathComponent:@"videos"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建图片文件夹失败");
            return NO;
        }
        return YES;
    }
    return YES;
}


//-(void)leftClicked{
//    isRecording = NO;
//    currentRecordTime=0;
//    [self stopCountDurTimer];
//    [pickerController stopVideoCapture];
//
//    [self.navigationController popViewControllerAnimated:YES];
//
//}

- (void)chlikCreame {
    
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        __weak ImagePickerViewController *this = self;
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"对不起，您的设备不支持拍摄功能。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
//            
//            if (buttonIndex == 0) {
//                [this.navigationController popViewControllerAnimated:YES];
//            }
//        }];
//        return;
//    }
//    
    NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    NSLog(@"---cui--authStatus--------%ld",(long)authStatus);
    // This status is normally not visible—the AVCaptureDevice class methods for discovering devices do not return devices the user is restricted from accessing.
    if(authStatus ==AVAuthorizationStatusRestricted){
        NSLog(@"Restricted");
    }else if(authStatus == AVAuthorizationStatusDenied){
        // The user has explicitly denied permission for media capture.
        NSLog(@"Denied");     //应该是这个，如果不允许的话
                    __weak ImagePickerViewController *this = self;
        
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请去设置-隐私-无忧借条打开相机功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                            [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        
                                if (buttonIndex == 0) {
                                    [this.navigationController popViewControllerAnimated:YES];
                                }
                            }];
                    
        return;
    }
    else if(authStatus == AVAuthorizationStatusAuthorized){//允许访问
        // The user has explicitly granted permission for media capture, or explicit user permission is not necessary for the media type in question.
        NSLog(@"Authorized");
        
    }else if(authStatus == AVAuthorizationStatusNotDetermined){
        // Explicit user permission is required for media capture, but the user has not yet granted or denied such permission.
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            if(granted){//点击允许访问时调用
                //用户明确许可与否，媒体需要捕获，但用户尚未授予或拒绝许可。
                NSLog(@"Granted access to %@", mediaType);
            }
            else {
                NSLog(@"Not granted access to %@", mediaType);
            }
            
        }];
    }else {
        NSLog(@"Unknown authorization status");
    }

}




@end
