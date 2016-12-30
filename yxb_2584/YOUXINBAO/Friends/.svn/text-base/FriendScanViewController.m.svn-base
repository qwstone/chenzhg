//
//  FriendScanViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/7/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "FriendScanViewController.h"
#import "QRCodeGenerator.h"
#import "QRCodeView.h"
#import "YXBTool.h"
#import "FriendDetailViewController.h"
#import "UserManager.h"

#define kOutputRect CGRectMake(50, (kDeviceHeight-64-(kDeviceWidth-100))/2, kDeviceWidth-100, kDeviceWidth-100)

@interface FriendScanViewController () {
    UIView*_overlayerView;
    UILabel *_urlLabel;
    UIImageView *_qrCode;
}

@end

@implementation FriendScanViewController

- (void)dealloc
{
    NSLog(@"dealloc SCAN");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"扫一扫"];
    self.view.backgroundColor = rgb(245,244,242,1);
    
    [self initViews];
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(backAction)];

}



- (void)initViews {
//    self.view.backgroundColor = [UIColor grayColor];
//    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
//    scanButton.frame = CGRectMake(100, 420, 120, 40);
//    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:scanButton];
//    
//    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(15, 40, 290, 50)];
//    labIntroudction.backgroundColor = [UIColor clearColor];
//    labIntroudction.numberOfLines=2;
//    labIntroudction.textColor=[UIColor whiteColor];
//    labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
//    [self.view addSubview:labIntroudction];
    
    
//    UIImageView * imageView = [[UIImageView alloc]initWithFrame:(50, (kDeviceHeight-64-(kDeviceWidth-100))/2, kDeviceWidth-100, kDeviceWidth-100)];
//    imageView.image = [UIImage imageNamed:@"pick_bg"];
//    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    
    _overlayerView = [[UIView alloc] initWithFrame:self.view.bounds];
    _overlayerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_overlayerView];
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-220)/2, kOutputRect.origin.y, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    _timer = [[CPBTimerManager alloc] initWithTimeInterval:0.02 userInfo:nil repeats:YES];
    _timer.delegate = self;
    
//    _urlLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, imageView.bottom+10, 200, 20)];
//    _urlLabel.backgroundColor = [UIColor clearColor];
//    _urlLabel.textColor=[UIColor whiteColor];
//    [self.view addSubview:_urlLabel];
//    
//    UIButton *create = [[UIButton alloc] initWithFrame:CGRectMake(_urlLabel.right+30, _urlLabel.top, 60, 20)];
//    [create setTitle:@"生成" forState:UIControlStateNormal];
//    [create addTarget:self action:@selector(createAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:create];
    
//    _qrCode = [[UIImageView alloc]initWithFrame:CGRectMake(10, _urlLabel.bottom+10, 300, 300)];
//    [self.view addSubview:_qrCode];
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake((kDeviceWidth-220)/2, kOutputRect.origin.y+2*num, 220, 2);
        if (2*num >= kDeviceWidth-100) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake((kDeviceWidth-220)/2, kOutputRect.origin.y+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}

//- (void)createAction:(UIButton *)button {
//
//    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
////    NSString *url = [YXBTool getURL:[NSString stringWithFormat:@"%@webView/qrCode/qrCodeJump.jsp",YXB_IP_ADRESS] params:[NSString stringWithFormat:@"id=%@%ld",userModel.user.yxbId,(long)rand()%10000]];
//    NSString *url = [NSString stringWithFormat:@"%@webView/qrCode/qrCodeJump.jsp?id=%@%ld",YXB_IP_ADRESS,userModel.user.yxbId,(long)rand()%10000];
//    UIImage *image = [QRCodeGenerator qrImageForString:url imageSize:kDeviceWidth];
//    QRCodeView *codeView = [[QRCodeView alloc] initWithImage:image withOriginationPoint:button.center];
//    [codeView show];
//}

-(void)backAction
{
    [_session stopRunning];
    
//    [self dismissViewControllerAnimated:YES completion:^{
//        [timer stop];
//    }];
    [self.navigationController popViewControllerAnimated:YES];
    [_timer stop];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
}
- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if(!_device){
        [self deviceIsNotSupport];
        return;
    }
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    if(!_input){
        [self deviceIsNotSupport];
        return;
    }
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
//    //设置扫描范围
//    [_output setRectOfInterest:CGRectMake(kOutputRect.origin.y/(kDeviceHeight-64), kOutputRect.origin.x/kDeviceWidth, kOutputRect.size.height/(kDeviceHeight-64), kOutputRect.size.width/kDeviceWidth)];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
//    // 条码类型 AVMetadataObjectTypeQRCode
//    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,nil]];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;

    _preview.frame = kOutputRect;
//    _preview.frame = self.view.bounds;
    
//    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    [self.view.layer insertSublayer:self.preview below:_overlayerView.layer];
    
    // Start
    [_session startRunning];
}

- (void)deviceIsNotSupport{
    //判断是不是允许访问相机
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请在系统设置中开启相机（设置>隐私>相机>开启无忧借条）" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alertView show];
    
}

#pragma mark - CPBTimerManager delegate
- (void)CPBTimerManagerAction:(CPBTimerManager *)timer {
    [self animation1];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    //判断是否包含 头'http:'
    NSString *regex = @"http+:[^\\s]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //判断是否包含 头'https:'
    NSString *regex1 = @"https+:[^\\s]*";
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex1];
    if ([predicate evaluateWithObject:stringValue] || [predicate1 evaluateWithObject:stringValue]) {
        
        //判断是否包含友信宝头
        NSString *yxbRegex = [NSString stringWithFormat:@"%@+[^\\s]*",YXB_IP_ADRESS];
        NSPredicate *yxbPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",yxbRegex];
        
        if ([yxbPredicate evaluateWithObject:stringValue]) {
//            [ProgressHUD showWithStatus:@"正在加载..." maskType:ProgressHUDMaskTypeBlack tipsType:ProgressHUDTipsTypeLongBottom networkIndicator:YES];
            [self getUserBriefInfo:[stringValue substringFromIndex:stringValue.length-16]];
            
        }else {
            [YXBTool jumpSafariWithUrl:stringValue];
//            [self dismissViewControllerAnimated:YES completion:^
//             {
//                 NSLog(@"%@",stringValue);
//             }];
            [_session stopRunning];
            [_timer stop];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        
    }
 
    
}

- (void)getUserBriefInfo:(NSString *)yxbId {
    
    if (self.isConnect == YES) {
        return;
    }
    
    self.isConnect = YES;
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak FriendScanViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error){
         
         [this httpLoadError:error];
         
     } param:^(NSString *s) {
         
         [this httpLOadParams:s httpOperation:assginHtttperator YXBId:yxbId];
     } complete:^(UserBriefInfo *r, int taskid) {
         [this httpLoadComplete:r];
     }];
    
    [self.iHttpOperator connect];
    
    

}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation YXBId:(NSString *)yxbId
{
    QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
    User *userMe = localUser.user;
    
    UserManager *userManager = (UserManager *)[httpOperation getAopInstance:[UserManager class] returnValue:[UserBriefInfo class]];
    [userManager getUserBriefInfo:userMe.yxbToken searchYXBId:yxbId];

}
//请求完成
-(void)httpLoadComplete:(UserBriefInfo *)r{
    [ProgressHUD dismiss];
    
    if(r.errCode == 0)
    {
        //             [this.navigationController popViewControllerAnimated:YES];
        
        
        //             [this.navigationController popViewControllerAnimated:NO];
        
        User *friendUser = [[User alloc] init];
        friendUser.yxbId = r.yxbUserID;
        friendUser.username = r.loginNum;
        friendUser.nickname = r.nickName;
        friendUser.iconAddr = r.imageUrl;
        friendUser.signature = r.signingMessages;
        friendUser.t_id = r.userID;
        
        [self.session stopRunning];
        [self.timer stop];
        FriendDetailViewController *controller = [[FriendDetailViewController alloc] init];
        controller.user = friendUser;
        //             controller.isCheckFriend = !r.isFriend;  //已在controller内部判断
        //             controller.isFriend = r.isFriend; //已在controller内部判断
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
