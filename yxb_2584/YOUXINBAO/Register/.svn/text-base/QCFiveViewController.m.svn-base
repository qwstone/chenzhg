//
//  QCFiveViewController.m
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCFiveViewController.h"
#import "HttpOperator.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AopProxy.h"
#import "UserManager.h"
#import "User.h"
#import "YXBTool.h"
#import "UIAlertView+Block.h"
#import "RealnameAuthenticationManager.h"
#import "FMDeviceManager.h"
//#import "CPBTimerManager.h"

//#define QCFiveViewControllerImageWidth 120

@interface QCFiveViewController ()<ASIHTTPRequestDelegate> {
//    UIScrollView *_scrollView;  //滚动视图
    UIImage * imageOne;
    UIImage * imageTwo;
    UIImage * imageThree;
    UIActivityIndicatorView * indicatorView;
    UIView * indicatorbgView;
    UILabel * indcatorLabel;
    NSString * string1;
    NSString * string2;
    NSString * string3;
    ASIFormDataRequest *request;
//    CPBTimerManager * timerManager;
//    NSInteger time;

}

@end

@implementation QCFiveViewController

- (void)dealloc
{
    [self.iHttpOperator cancel];
    self.iHttpOperator = nil;
    [indcatorLabel release];
    [indicatorView release];
    [indicatorbgView release];
    [imageOne release];
    [imageThree release];
    [imageTwo release];
//    [_scrollView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        string1 = [[NSString alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self  setNavigationItem];
    [self createUI];
    [self createindicatorView];
    
}
#pragma mark ----------------------------------------------------CreatUI
- (void)setNavigationItem
{
    self.title = @"照片认证";
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftAction)];
    
    //跳过按钮
//    [self setNavigationButtonItrmWithiamge:@"register_tiaoguo1.png" withRightOrleft:@"right" withtargrt:self withAction:@selector(overleapAction:)];
}

- (void)createUI
{
    //上传身份证按钮
//    [self createButtonWithframe:CGRectMake(0, 0, kDeviceWidth/2, 42) withImage:@"register_upsfz1.png" withView:self.view withTarget:self withAcation:@selector(upBtnClicked:) withTag:1001];
//    
//    UIButton * btn = (UIButton *)[self.view viewWithTag:1001];
//    btn.selected = YES;
//    [btn setImage:[UIImage imageNamed:@"refister_upsfz2.png"] forState:UIControlStateSelected];

    //汇款一分钱按钮
//    [self createButtonWithframe:CGRectMake(kDeviceWidth/2, 0, kDeviceWidth/2, 42) withImage:@"register_yifenqian1.png" withView:self.view withTarget:self withAcation:@selector(upBtnClicked:) withTag:1002];
//    UIButton * btn2 = (UIButton *)[self.view viewWithTag:1002];
//    btn.selected = YES;
//    [btn2 setImage:[UIImage imageNamed:@"register_yifenqian2.png"] forState:UIControlStateSelected];
//
    //滚动视图
//    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 42, kDeviceWidth, kDeviceHeight-64-32)];
//    _scrollView.contentSize = CGSizeMake(kDeviceWidth*2, kDeviceHeight-64-32);
//    _scrollView.scrollEnabled = NO;
//    [self.view addSubview:_scrollView];
/********************************身份证验证页面**************************/
    NSArray *imageArray = nil;
    if (_model != nil) {
//        imageArray = [NSArray arrayWithObjects:((_model.idCardBareheadedAddr == nil) ? @"" : _model.idCardBareheadedAddr,(_model.idCardFaceAddr == nil) ? @"": _model.idCardFaceAddr,(_model.idCardBackAddr == nil) ? @"":_model.idCardBackAddr,nil];
    }

    imageArray = [NSArray arrayWithObjects:(_model.idCardBareheadedAddr == nil) ? @"" : _model.idCardBareheadedAddr,(_model.idCardFaceAddr == nil) ? @"": _model.idCardFaceAddr,(_model.idCardBackAddr == nil) ? @"":_model.idCardBackAddr, nil];
    NSMutableArray *dImgArray = [NSMutableArray array];
    [dImgArray addObject:@"sfxx1.png"];
    [dImgArray addObject:@"sfxx2.png"];
    [dImgArray addObject:@"sfxx3.png"];

    [self CreateLabel:@"请上传真实照片并保证照片清晰,如下所示" frame:CGRectMake(0, 10, kDeviceWidth, 20) withView:self.view textAlignment:1 fontSize:14 textColor:nil];
    NSArray * nameArray = [NSArray arrayWithObjects:@"请上传手持身份证照",@"请上传身份证正面照",@"请上传身份证背面照", nil];
    
//#define leftAlign 30
#define CustomSpace 30
    CGFloat width = (kDeviceWidth - CustomSpace*3)/2;
    CGFloat x = CustomSpace,y = 40, w = width, h = width;
    
//    CGFloat spaceOfImages = (kDeviceWidth - 2 * x - 2 * w);
    
    for (int i = 0; i < nameArray.count; i++) {

        if (i == 1) {
            x = x + w + CustomSpace;
        }
        else
        {
            x = CustomSpace;
        }
        y = y + 180*(i/2);
        UIButton * btn  = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
//        btn.center = CGPointMake(self.view.center.x, btn.origin.y+50);
        btn.backgroundColor = [UIColor lightGrayColor];
        [btn setImage:[UIImage imageNamed:dImgArray[i]]  forState:UIControlStateNormal];
//        btn.layer.cornerRadius = 5.0;
        [btn addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 101+i;
        [self.view addSubview:btn];
        
//        [self CreateLabel:nameArray[i] frame:CGRectMake(x, y+h+10, w, 20) withView:self.view textAlignment:1 fontSize:14 textColor:nil];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y+h+10, w, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14.0];
        label.text = nameArray[i];
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumScaleFactor = 12.0/label.font.pointSize;
        [self.view addSubview:label];
    }
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.backgroundColor = rgb(50, 142, 250, 1.0);
    sureBtn.frame = CGRectMake(20, y+h+50, kDeviceWidth - 40, 50);
    [sureBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(overleapAction:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.layer.cornerRadius = 5.0;

    [self.view addSubview:sureBtn];
}

- (void)createindicatorView
{
    indicatorbgView = [[UIView alloc]init];
    indicatorbgView.backgroundColor = rgb(255, 255, 255, 0.9);
    indicatorbgView.hidden = YES;
    indicatorbgView.frame = CGRectMake(0, 0, kDeviceWidth, self.view.height);
    [self.view addSubview:indicatorbgView];
    
    indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.backgroundColor = rgb(0, 0, 0, 0.5);
    indicatorView.size = CGSizeMake(80, 80);
    indicatorView.layer.cornerRadius = 10;
    indicatorView.layer.masksToBounds = YES;
    [indicatorbgView addSubview:indicatorView];
    indicatorView.tag = 100;
    indicatorView.center = indicatorbgView.center;
    
    indcatorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, kDeviceWidth, 20)];
    indcatorLabel.text = @"正在准备上传";
    indcatorLabel.textAlignment = NSTextAlignmentCenter;
    indcatorLabel.backgroundColor = [UIColor clearColor];
    [indicatorbgView addSubview:indcatorLabel];
    
}

#pragma mark -----------------------------------------------------CpbTimeMangerDelegate
//- (void)CPBTimerManagerAction:(CPBTimerManager *)timer
//{
//    time ++;
////    NSLog(@"tiem = %d",time);
//    if (time > 30) {
//        if ([self isConnectionAvailable] == NO) {
//            NSLog(@"ddd%d",[self isConnectionAvailable]);
//            indicatorbgView.hidden = YES;
//            [indicatorView stopAnimating];
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络连接不正常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alertView show];
//            [alertView release];
//            [timerManager stop];
//            time = 0;
//        }else{
//            indicatorbgView.hidden = YES;
//            [indicatorView stopAnimating];
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络状况太差了.请在好点的网络状态下上传" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alertView show];
//            [alertView release];
//            [timerManager stop];
//            time = 0;
//
//        }
//    }
//
//}
#pragma mark ----------------------------------------------------- ActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",(long)buttonIndex);
    
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                    
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 0) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            } else {
                return;
                
            }
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = NO;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        [imagePickerController release];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //(2)等比压缩到宽度为800
    CGFloat width = 800;
    CGSize size = image.size;
    CGFloat height = (width * size.height)/(CGFloat)size.width;

    image = [YXBTool OriginImage:image scaleToSize:CGSizeMake(width, height)];
    
    for (int i = 0; i <3; i++) {
        UIButton * btn = (UIButton *)[self.view viewWithTag:101+i];
        if (btn.selected == YES) {
            [btn setImage:image forState:UIControlStateNormal];

            [btn setImage:image forState:UIControlStateSelected];
            if (btn.tag == 101) {
                imageOne = image;

            }else if (btn.tag == 102){
                imageTwo = image;
                

            }else if (btn.tag == 103){
                imageThree = image;

            }
        }
    }
    
//    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
//    [self.delegate changUserPhoto:image];
    //    UserManager * curruserManger = [UserManager sharedInstance];
    //    NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
    //    TUser * ccurrUser = [curruserManger getLoginUser];
    //    ccurrUser.userImage = [NSData dataWithData:UIImagePNGRepresentation(image)];
    
    //    [curruserManger setLoginUser:ccurrUser];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ------------------------------------------------- Actions


- (void)overleapAction:(UITapGestureRecognizer *)tap {
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"验证身份后才能申请借款,您也可以在申请之前验证" delegate:self cancelButtonTitle:@"继续验证" otherButtonTitles:@"以后验证", nil];
//    alertView.tag = 222;
//    [alertView show];
//    [alertView release];
    [self downBtnCliked];
}

//- (void)upBtnClicked:(UIButton *)button
//{
//    if (button.tag ==1001) {
//        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }
//    if (button.tag == 1002) {
//        [_scrollView setContentOffset:CGPointMake(kDeviceWidth, 0) animated:YES];
//    }
//    for (UIButton * btn in self.view.subviews) {
//        if ([btn isKindOfClass:[UIButton class]]) {
//            if (btn.tag == button.tag) {
//                btn.selected = YES;
//            }else{
//                btn.selected = NO;
//            }
//        }
//       
//    }
//}


- (void)photoAction:(UIButton *)button {

    for (UIButton * btn in self.view.subviews) {
        
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag == button.tag) {
                btn.selected = YES;

            }else{
                btn.selected = NO;

            }
        }

    }
    UIActionSheet *sheet;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}

- (void)downBtnCliked
{
//    if (btn.tag == 1003) {
        if (imageOne == nil || imageTwo == nil || imageThree == nil) {
            UIAlertView * alertiew = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请选取照片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertiew show];
            [alertiew release];
        }else{
//            timerManager = [[CPBTimerManager alloc]initWithTimeInterval:2 userInfo:nil repeats:YES];
//            timerManager.delegate = self;

            [indicatorView startAnimating];
            indicatorbgView.hidden = NO;

            [self upDataImageWithImage:imageOne type:2];
            indcatorLabel.text = @"正在上传第一张照片(1/3)";

        }
//    }
    
}

- (void)leftAction
{

    if (indicatorView.isAnimating) {
        if (request != nil) {
            [request clearDelegatesAndCancel];
            
        }
        [self.navigationController popViewControllerAnimated:YES];

    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];

    }


}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1&&alertView.tag ==222) {
        [self httpLogin];
    }else{
        
    }
}
#pragma mark -----------------------------------------------HttpDownLoad

#pragma  mark   ------- 上传照片

//上传照片
- (void)upDataImageWithImage:(UIImage *)image type:(NSInteger)type
{
    QCUserModel *_currUser = [[QCUserManager sharedInstance] getLoginUser];
    NSString *userName = _currUser.user.username;
    NSLog(@"userName tt =%@",userName);
    NSData *imgData = UIImageJPEGRepresentation(image, 1);
    NSString *Urlstring=[NSString stringWithFormat:@"%@uploadBatchPhoto.jsp?type=1",YXB_IP_ADRESS];
    NSURL *url = [NSURL URLWithString:[Urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url----%@",url);
    request = [ASIFormDataRequest requestWithURL:url];
//    [request setData:imgData forKey:@"image.png"];
    [request setAuthImageData:imgData forKey:@"image.png"];
//    [request setContentLength:imgData.length];
//    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [imgData length]]];
//    NSLog(@"imdddd =%d",imgData.length);
    [request setFailedBlock:^{
        if (![self isConnectionAvailable]) {
//            NSLog(@"ddd%d",[self isConnectionAvailable]);
            indicatorbgView.hidden = YES;
            [indicatorView stopAnimating];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络连接不正常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            [alertView release];
        }else{
//            [self upDataImageWithImage:imageOne type:2];

            if (type == 2) {
                [self upDataImageWithImage:imageOne type:2];
            }
            if (type == 3) {
                [self upDataImageWithImage:imageTwo type:3];
            }
            if (type == 4) {
                [self upDataImageWithImage:imageThree type:4];
            }

        }
    }];
    [request setCompletionBlock:^{
        NSLog(@"response:   --%@",request.responseString);
        NSMutableString *responseString = [NSMutableString stringWithFormat:@"%@",request.responseString];
        NSString *search = @"\n";
        NSString *replace = @"";
        
        NSRange substr = [responseString rangeOfString:search];
        
        while (substr.location != NSNotFound) {
            [responseString replaceCharactersInRange:substr withString:replace];
            substr = [responseString rangeOfString:search];
        }
        
        if (type == 2) {
//            _currUser.user.idCardFaceAddr = responseString;
            QCUserManager * um = [QCUserManager sharedInstance];
            [um setLoginUser:_currUser];
            
            _model.idCardBareheadedAddr = responseString;
            
            [self upDataImageWithImage:imageTwo type:3];
            indcatorLabel.text = @"正在上传第二张照片(2/3)";

        }else if (type == 3){
//            _currUser.user.idCardBackAddr = responseString;
            QCUserManager * um = [QCUserManager sharedInstance];
            [um setLoginUser:_currUser];

            _model.idCardFaceAddr = responseString;

            [self upDataImageWithImage:imageThree type:4];
            indcatorLabel.text = @"正在上传第三张照片(3/3)";
        }else if (type == 4){
//            _currUser.user.idCardBareheadedAddr = responseString;
            QCUserManager * um = [QCUserManager sharedInstance];
            [um setLoginUser:_currUser];

            _model.idCardBackAddr = responseString;

//            [self uploadIdCardPhoto];
            [self summitAuth];
//            [indicatorView stopAnimating];
//            indicatorbgView.hidden = YES;

            indcatorLabel.text = @"";
        }
    }];
    [request startAsynchronous];
}

//提交整体完善信息
-(void)summitAuth
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[[HttpOperator alloc]init]autorelease];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCFiveViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {

        [this httploadParamsOme:assginHtttperator];
    } complete:^(TResultSet* r, int taskid) {
        [this httpLoadComplete:r];
        
    }];
    [self.iHttpOperator connect];
    
}
- (void)httploadParamsOme:(HttpOperator *)assginHtttperator{

    RealnameAuthenticationManager *manager = (RealnameAuthenticationManager *)[assginHtttperator getAopInstance:[RealnameAuthenticationManager class] returnValue:[TResultSet class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    
    self.model.userId = userModel.user.t_id;
    self.model.userToken = userModel.user.yxbToken;
    [manager __yxb_service__updateIdCardImgInfo:_model];

}
- (void)httpLoadComplete:(TResultSet *)r{
    [indicatorView stopAnimating];
    indicatorbgView.hidden = YES;
    
    [YXBTool showAlertViewWithString:r.errString];
    
}

/*

//完成验证
- (void)uploadIdCardPhoto
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[[HttpOperator alloc]init]autorelease];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCFiveViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        QCUserModel * yzUser = [[QCUserManager sharedInstance]getLoginUser];
        UserManager* _currUser = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[TResultSet class]];
        NSLog(@"User类变了，正面照地址没了");
//        [_currUser uploadIdCardPhotoByUsername:yzUser.user.username realname:this.realName idCardNo:this.idCardNo idCardFaceAddr:yzUser.user.idCardFaceAddr idCardBackAddr:yzUser.user.idCardBackAddr idCardBareheadedAddr:yzUser.user.idCardBareheadedAddr];
        //        [_currUser release];
        
    } complete:^(TResultSet* r, int taskid) {
        [indicatorView stopAnimating];
        indicatorbgView.hidden = YES;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: r.errString delegate:this cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        if (r.errCode == 0) {
//            [this httpLogin];
            [self.navigationController popViewControllerAnimated:YES];
        }

    }];
    [self.iHttpOperator connect];
    
}

*/

- (void)httpLogin
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[[HttpOperator alloc]init]autorelease];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCFiveViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {

        [this httpLoadParamsTwo:assginHtttperator];
    } complete:^(User* r, int taskid) {
        [this httpLoadCompleteTwo:r];
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParamsTwo:(HttpOperator *)assginHtttperator{

    UserManager* _currUser = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[User class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
//    [_currUser userLogin:userModel.user.username pass:userModel.user.pwd];
    NSString *blackBox = [YXBTool getFMString];
    [_currUser userLoginWithFraudmetrix:userModel.user.username pwd:userModel.user.pwd fraudmetrixToken:blackBox];

}
- (void)httpLoadCompleteTwo:(User *)r{

    QCUserModel * currUser = [[QCUserModel alloc]init];
    currUser.isLogin = YES;
    currUser.user = r;
    TUnreadFlagCount * loanCount = [[TUnreadFlagCount alloc]init];
    currUser.unreadCont = loanCount;
    [loanCount release];
    currUser.unreadCont.lastQueryDate = @"";
    QCUserManager * um  = [QCUserManager sharedInstance];
    
    [um setLoginUser:currUser];
    [currUser release];
    if (r.errCode ==0) {
        //            [self.navigationController dismissModalViewControllerAnimated:YES];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        NSString * string = r.errString;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }

}


-(void) setID:(NSInteger) tID {
    self.iHttpTaskID = tID;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.iHttpOperator = Nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadView {
    [super loadView];
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - 64)];
    scroll.contentSize = CGSizeMake(kDeviceWidth, 460);
    scroll.bounces = YES;
    scroll.backgroundColor = [UIColor greenColor];
    
    self.view = scroll;
}

//处理数据 为nil的替换为""
-(void)updateMyData
{
    
//
//    if (_model.mo) {
//        <#statements#>
//    }
}

@end
