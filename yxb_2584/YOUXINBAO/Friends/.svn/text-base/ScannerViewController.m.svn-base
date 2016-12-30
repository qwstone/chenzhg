//
//  ScannerViewController.m
//  ScannerTest
//
//  Created by xiatian on 14/10/22.
//  Copyright (c) 2014年 xiatian. All rights reserved.
//

#import "ScannerViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "BoxView.h"
#import "YXBTool.h"
#import "UserManager.h"
#import "FriendDetailViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@implementation ScannerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.rotation = 90.0f;
    self.capture.layer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.capture.layer];
    self.capture.scanRect = CGRectMake(0,self.view.bounds.size.height / 2 - self.view.bounds.size.width /2, self.view.bounds.size.width,self.view.frame.size.width);
    self.capture.delegate = self;
    
    BoxView *boxView = [[BoxView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:boxView];

    [self createNavigation];
}
-(void)viewWillAppear:(BOOL)animated{
    self.capture.delegate = self;
}
//添加导航栏按钮
-(void)createNavigation{
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 30)];
    titleLabel.text = @"扫一扫";
    [titleLabel sizeToFit];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    //左侧按钮
    UIButton *backButton = [UIButton buttonWithFrame:CGRectMake(0, 0, 30, 30) title:nil normalImage:[UIImage imageNamed:@"navigation_abck_.png"] highlightImage:nil selectedImage:nil font:[UIFont systemFontOfSize:16.0] target:self action:@selector(navBtnClick:) controlEvent:UIControlEventTouchUpInside tag:0];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

    self.navigationItem.leftBarButtonItem = leftItem;

    //右侧按钮
    UIButton *scanLocalImageBtn = [UIButton buttonWithFrame:CGRectMake(10, 30, 100, 30) title:@"扫描图片" normalImage:nil highlightImage:nil selectedImage:nil font:[UIFont boldSystemFontOfSize:16.0] target:self action:@selector(navBtnClick:) controlEvent:UIControlEventTouchUpInside tag:1];
    [scanLocalImageBtn sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:scanLocalImageBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)navBtnClick:(UIButton*)btn{
    if (btn.tag==0) {//左侧
        self.capture.delegate = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag==1){//右侧
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.delegate =self;
        [self presentViewController:ipc animated:YES completion:nil];
    }
}


#pragma mark - UIImagePickerControllerDelegate
//图片选取完成
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //获取图片信息(str)
    NSString *str = [self getLocalImageInfo:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
    if (str) {
        [self goNext:str];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"很抱歉，无法识别二维码" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//点击相册右侧返回按钮
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//读取本地二维码
-(NSString *)getLocalImageInfo:(UIImage *)image{
        CGImageRef imageToDecode = image.CGImage;
    ZXLuminanceSource* source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode] ;
    ZXBinaryBitmap* bitmap = [ZXBinaryBitmap binaryBitmapWithBinarizer:[ZXHybridBinarizer binarizerWithSource:source]];
    
    NSError* error = nil;
    ZXDecodeHints* hints = [ZXDecodeHints hints];
    hints.encoding = NSUTF8StringEncoding;// StringEncoding;
    
    ZXMultiFormatReader* reader = [ZXMultiFormatReader reader];
    
    ZXResult* result = [reader decode:bitmap
                                hints:nil
                                error:&error];
    return result.text;
}

//跳转下一界面
-(void)goNext:(NSString *)str{
    
    //判断是否包含 头'http:'
    NSString *regex = @"http+:[^\\s]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //判断是否包含 头'https:'
    NSString *regex1 = @"https+:[^\\s]*";
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex1];
    if ([predicate evaluateWithObject:str] || [predicate1 evaluateWithObject:str]) {
        
        //判断是否包含友信宝头
        NSString *yxbRegex = [NSString stringWithFormat:@"%@+[^\\s]*",YXB_IP_ADRESS];
        NSPredicate *yxbPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",yxbRegex];
        
        if ([yxbPredicate evaluateWithObject:str]) {
            [self getUserBriefInfo:[str substringFromIndex:str.length-16]];
        }else {
            [YXBTool jumpSafariWithUrl:str];
        }
    }
    
    
}
- (void)getUserBriefInfo:(NSString *)yxbId {
    NSLog(@"==========str = %@",yxbId);
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak ScannerViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error)
     {
         
         if (error == EHttp_Operator_Failed) {
             //服务器挂了
             [ProgressHUD dismiss];
             UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
             [alterView show];
         }
         
         
     } param:^(NSString *s) {
         
         [this httpLoadParams:assginHtttperator yxbId:yxbId];
     } complete:^(UserBriefInfo *r, int taskid) {
         [this httpLoadComplete:r];
     }];
    
    [self.iHttpOperator connect];
}

- (void)httpLoadParams:(HttpOperator *)assginHtttperator yxbId:(NSString *)yxbId{

    QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
    User *userMe = localUser.user;
    
    UserManager *userManager = (UserManager *)[assginHtttperator getAopInstance:[UserManager class] returnValue:[UserBriefInfo class]];
    [userManager getUserBriefInfo:userMe.yxbToken searchYXBId:yxbId];


}
- (void)httpLoadComplete:(UserBriefInfo *)r{

    [ProgressHUD dismiss];
    
    if(r.errCode == 0)
    {
        User *friendUser = [[User alloc] init];
        friendUser.yxbId = r.yxbUserID;
        friendUser.username = r.loginNum;
        friendUser.nickname = r.nickName;
        friendUser.iconAddr = r.imageUrl;
        friendUser.signature = r.signingMessages;
        friendUser.t_id = r.userID;
        FriendDetailViewController *controller = [[FriendDetailViewController alloc] init];
        controller.user = friendUser;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }

}

#pragma mark - Private Methods
- (NSString *)barcodeFormatToString:(ZXBarcodeFormat)format {
    switch (format) {
        case kBarcodeFormatAztec:
            return @"Aztec";
            
        case kBarcodeFormatCodabar:
            return @"CODABAR";
            
        case kBarcodeFormatCode39:
            return @"Code 39";
            
        case kBarcodeFormatCode93:
            return @"Code 93";
            
        case kBarcodeFormatCode128:
            return @"Code 128";
            
        case kBarcodeFormatDataMatrix:
            return @"Data Matrix";
            
        case kBarcodeFormatEan8:
            return @"EAN-8";
            
        case kBarcodeFormatEan13:
            return @"EAN-13";
            
        case kBarcodeFormatITF:
            return @"ITF";
            
        case kBarcodeFormatPDF417:
            return @"PDF417";
            
        case kBarcodeFormatQRCode:
            return @"QR Code";
            
        case kBarcodeFormatRSS14:
            return @"RSS 14";
            
        case kBarcodeFormatRSSExpanded:
            return @"RSS Expanded";
            
        case kBarcodeFormatUPCA:
            return @"UPCA";
            
        case kBarcodeFormatUPCE:
            return @"UPCE";
            
        case kBarcodeFormatUPCEANExtension:
            return @"UPC/EAN extension";
            
        default:
            return @"Unknown";
    }
}

#pragma mark - ZXCaptureDelegate Methods
//扫一扫
- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    
    if (!result) return;
    self.capture.delegate = nil;
//     NSString *formatString = [self barcodeFormatToString:result.barcodeFormat];
    
    NSString *symbolStr = result.text;
    if ([result.text canBeConvertedToEncoding:NSShiftJISStringEncoding]){
        symbolStr = [NSString stringWithCString:[result.text cStringUsingEncoding:NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        
    }
    
//    NSLog(@"扫描结果:%@",symbolStr);
//    _str = symbolStr;
    
    [self goNext:symbolStr];
    
    [self.delegate backAction:symbolStr];

//    NSString *display = [NSString stringWithFormat:@"Scanned!\n\nFormat: %@\n\nContents:\n%@", formatString, result.text];
//    NSLog(@"扫描结果:%@",display);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
