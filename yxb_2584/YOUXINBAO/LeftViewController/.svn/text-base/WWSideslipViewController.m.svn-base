//
//  WWSideslipViewController.m
//  WWSideslipViewControllerSample
//
//  Created by 王维 on 14-8-26.
//  Copyright (c) 2014年 wangwei. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "WWSideslipViewController.h"
#import "YXBTool.h"
#import "FMDeviceManager.h"
#import "UserManager.h"
@interface WWSideslipViewController () {
    UIView *_gestureView;       //用于添加手势的视图
}
@property (retain, nonatomic) HttpOperator* iHttpOperator;

@end

@implementation WWSideslipViewController
@synthesize speedf,sideslipTapGes;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


/**
 *  @author zhangjinpeng
 *
 *
 *  @param 只有在容器类(容器类控制器) 里面复写这个方法才有效
 *
 *  @return 修改状态栏颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.view addSubview:mainControl.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(instancetype)initWithLeftView:(UIViewController *)LeftView
                    andMainView:(UIViewController *)MainView
                   andRightView:(UIViewController *)RighView
                        andBackgroundImage:(UIImage *)image;
{
    if(self){
        self.view.backgroundColor = [YXBTool colorWithHexString:@"#32323A"];
        speedf = 0.5;
        
        leftControl = LeftView;
        if ([MainView isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)MainView;
            gestureRecognizerVC = nav.topViewController;
            mainControl = MainView;
        }else {
            gestureRecognizerVC = MainView;
            mainControl = MainView;
        }
        
        righControl = RighView;
        
        UIImageView * imgview = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [imgview setImage:image];
        [self.view addSubview:imgview];
        
        _gestureView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.8*kDeviceWidth, 0.8*kDeviceHeight)];
        _gestureView.center = CGPointMake(kDeviceWidth/320*270+kDeviceWidth*0.4,[UIScreen mainScreen].bounds.size.height/2);
        [self.view addSubview:_gestureView];
        
        //滑动手势
        _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
//        [gestureRecognizerVC.view addGestureRecognizer:_pan];
        [_gestureView addGestureRecognizer:_pan];
        
        //单击手势
        sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [sideslipTapGes setNumberOfTapsRequired:1];
        
        [_gestureView addGestureRecognizer:sideslipTapGes];
        
        leftControl.view.hidden = YES;
        righControl.view.hidden = YES;
        _gestureView.hidden = YES;
        self.leftcenter = leftControl.view.center;
        leftControl.view.center = CGPointMake(leftControl.view.center.x -kDeviceWidth/320*270*speedf,mainControl.view.center.y);
        leftControl.view.transform = CGAffineTransformMakeScale(0.4, 0.4);
        [self.view addSubview:leftControl.view];
        [self.view addSubview:righControl.view];
        
        [self.view addSubview:mainControl.view];
        
        [self.view bringSubviewToFront:_gestureView];
    }
    return self;
}

//获取mainViewController
-(UIViewController *)mainViewController {
    return mainControl;
}

#pragma mark - 滑动手势

//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec{

    CGPoint point = [rec translationInView:self.view];
    CGFloat scaleRate = kDeviceWidth/64*270;

    
    //根据视图位置判断是左滑还是右边滑动
    if (mainControl.view.frame.origin.x>0 || point.x < 0){
//        if (point.x < 0) {
//            return;
//        }
        scalef = (point.x*speedf+scalef);
        mainControl.view.center = CGPointMake(mainControl.view.center.x + point.x*speedf,mainControl.view.center.y);
        mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1-scalef/scaleRate,1-scalef/scaleRate);
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
        
        leftControl.view.center = CGPointMake(leftControl.view.center.x +point.x*speedf/2,mainControl.view.center.y);
        leftControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1-(1-scalef/(scaleRate/5))/2,1-(1-scalef/(scaleRate/5))/2);
        leftControl.view.alpha = scalef/(scaleRate/5);
    }else if (mainControl.view.frame.origin.x < 0){

    }
//    CATransform3D trasm = CATransform3DMakeScale(scalef/(scaleRate/5), scalef/(scaleRate/5), scalef/(scaleRate/5));
//        CATransform3D trasm = CATransform3DMakeTranslation(point.x, 0, 0);
//    [leftControl.view.layer setTransform:CATransform3DScale(trasm, 1-(1-scalef/(scaleRate/5))/3, 1-(1-scalef/(scaleRate/5))/3, 1-(1-scalef/(scaleRate/5))/3)];
//    [leftControl.view.layer setTransform:CATransform3DTranslate(trasm, -point.x, 1, 0)];
    
//    leftControl.view.transform = CGAffineTransformScale(self.view.transform,1-(1-scalef/(scaleRate/5))/3, 1-(1-scalef/(scaleRate/5))/3);
//    leftControl.view.alpha = scalef/(scaleRate/5);
//    leftControl.view.transform = CGAffineTransformTranslate(leftControl.view.transform, -point.x, 0);

//    else
//    {
//        rec.view.center = CGPointMake(rec.view.center.x + point.x*speedf,rec.view.center.y);
//        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1+scalef/1000,1+scalef/1000);
//        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
//    
//        
//        righControl.view.hidden = NO;
//        leftControl.view.hidden = YES;
//    }

    //手势结束后修正位置
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (scalef>kDeviceWidth/2){
            [self showLeftView];
        }
        else if (scalef<-kDeviceWidth/2) {
//            [self showRighView];
        }
        else
        {
            [self showMainView];
            scalef = 0;
        }
    }
    
//    //手势结束后修正位置
//    if (rec.state == UIGestureRecognizerStateEnded) {
//        if (scalef>100*speedf){
//            [self showLeftView];
//        }
//        else if (scalef<-100*speedf) {
////            [self showRighView];
//        }
//        else
//        {
//            [self showMainView];
//            
//        }
//    }

}


#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if (tap.state == UIGestureRecognizerStateEnded) {
        [self showMainView];

    }

}

#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    mainControl.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    leftControl.view.center = CGPointMake(leftControl.view.center.x -kDeviceWidth/320*270*speedf,mainControl.view.center.y);
    leftControl.view.transform = CGAffineTransformMakeScale(0.4, 0.4);
    leftControl.view.alpha = 0;
    [UIView commitAnimations];
    
    scalef = 0;
    
    _gestureView.hidden = YES;
//    [_gestureView removeGestureRecognizer:_pan];
//    [gestureRecognizerVC.view addGestureRecognizer:_pan];
}

//显示左视图
-(void)showLeftView{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
    mainControl.view.center = CGPointMake(kDeviceWidth/320*270+kDeviceWidth*0.4,[UIScreen mainScreen].bounds.size.height/2);
    leftControl.view.center =self.leftcenter;
    leftControl.view.transform = CGAffineTransformIdentity;
    leftControl.view.alpha = 1;
    [UIView setAnimationDidStopSelector:@selector(leftAnimationDidStop)];
    [UIView commitAnimations];
    
    scalef = kDeviceWidth/320*270;
    
    righControl.view.hidden = YES;
    leftControl.view.hidden = NO;
    
    _gestureView.hidden = NO;
    
//    [gestureRecognizerVC.view removeGestureRecognizer:_pan];
//    [_gestureView addGestureRecognizer:_pan];

}

//显示右视图
-(void)showRighView{
    [UIView beginAnimations:nil context:nil];
    mainControl.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
    mainControl.view.center = CGPointMake(-60,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
    
    righControl.view.hidden = NO;
    leftControl.view.hidden = YES;
}

-(void)leftAnimationDidStop
{
    NSString *token = [YXBTool getUserToken];
    if (token != nil) {
        if (self.iHttpOperator == nil) {
            self.iHttpOperator = [[HttpOperator alloc]init];
            
        }
        [self.iHttpOperator cancel];
        __weak HttpOperator * assginHtttperator = _iHttpOperator;
        __weak typeof(self) this = self;
        [self.iHttpOperator connetStart:^(int d) {
            [this.iHttpOperator stopAnimation];
        } cancel:^(int d) {
            
        } error:^(int d, THttpOperatorErrorCode error) {
            
        } param:^(NSString *s) {
            UserManager* _currUser = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[User class]];
            QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
            //        NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:userModel.user.pwd]]];
//            [_currUser userLogin:userModel.user.username pass:userModel.user.pwd];
            NSString *blackBox = [YXBTool getFMString];
            [_currUser userLoginWithFraudmetrix:userModel.user.username pwd:userModel.user.pwd fraudmetrixToken:blackBox];
            
        } complete:^(User* r, int taskid) {
            
            
            if (r.errCode == 0) {
                QCUserModel * currUser = [[QCUserModel alloc]init];
                currUser.isLogin = YES;
                currUser.user = r;
                TUnreadFlagCount * unReaderCount = [[TUnreadFlagCount alloc]init];
                currUser.unreadCont = unReaderCount;
                currUser.unreadCont.lastQueryDate = @"";
                currUser.firstMessageTime = @"";
                currUser.lastMessageTime = @"";
                QCUserManager * um  = [QCUserManager sharedInstance];
                QCUserModel * oldUser = [um getLoginUser];
                if (![oldUser.user.username isEqualToString:r.username]) {
                    currUser.gestureOpen = NO;
                    [YXBTool setGesturePassWord:nil];

                }
                else
                {
                    currUser.gestureOpen = oldUser.gestureOpen;
                    
                }
                
                [um setLoginUser:currUser];
                
//                [leftControl refreshData];
                
            }else{
                NSString * string = r.errString;
                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:this cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
        }];
        [self.iHttpOperator connect];

    }
}

//#warning 为了界面美观，所以隐藏了状态栏。如果需要显示则去掉此代码
- (BOOL)prefersStatusBarHidden
{
    return NO; //返回NO表示要显示，返回YES将hiden
}

@end
