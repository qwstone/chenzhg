//
//  MyCodeViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/8/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyCodeViewController.h"
#import "UIImageView+WebCache.h"
#import "KVNProgress.h"
#import "YXBTool.h"
#import <QuartzCore/QuartzCore.h>
@interface MyCodeViewController () <UIActionSheetDelegate>{
    UIImageView *_bageView;
    
    UIView *_shareView;
    UIButton *_shareBackView;
}

@end

@implementation MyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我的二维码"];
    self.view.backgroundColor = rgb(30, 30, 30, 1);
    [self createBackView];
    [self initViews];
    [self createShareView];
    
}
-(void)createShareView{
    _shareBackView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    _shareBackView.backgroundColor = [UIColor blackColor];
    _shareBackView.alpha = 0.7;
    _shareBackView.hidden = YES;
    [_shareBackView addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shareBackView];
    _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - 150-64, kDeviceWidth, 150)];
//    _shareView.hidden = YES;
    _shareView.transform = CGAffineTransformMakeTranslation(0, 150);
    _shareView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_shareView];
    [self.view bringSubviewToFront:_shareView];
    
    NSArray *imageNameArray = @[@"Share-wechat",@"Share-pyq"];

    for (int i = 0; i <2; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20+80*i, 10, 60, 84);
        [btn setImage:[UIImage imageNamed:imageNameArray[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageNameArray[i]] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.tag = i+100;
        [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:btn];
    }

    UIButton *cancleBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    cancleBtn.layer.borderColor =  rgb(244, 240, 240, 1).CGColor;
    cancleBtn.layer.borderWidth = 1.0;
    cancleBtn.frame = CGRectMake(-1, 150-45, kDeviceWidth+2, 46);
    [cancleBtn setTitle:@"取    消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:rgb(103, 196, 250, 1) forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    cancleBtn.backgroundColor = [UIColor whiteColor];
    [cancleBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_shareView addSubview:cancleBtn];

}
-(void)shareClick:(UIButton *)btn{
    if (btn.tag == 100) {//微信好友
        
        [YXBTool shareToWeixinSessionContent:@"注册就送钱，能免费分期，还能白拿利息，听说是个主打诚信的软件，快试试…" imgName:nil url:self.shareUrlStr title:@"无忧借条我做主，守信用有朋友，讲信用，宝赚钱！" callBackBlock:^{
            
        }];
    }else{//朋友圈
        [YXBTool shareToWeixinTimelineContent:@"注册就送钱，能免费分期，还能白拿利息，听说是个主打诚信的软件，快试试…" imgName:nil url:self.shareUrlStr title:@"无忧借条我做主，守信用有朋友，讲信用，宝赚钱！" callBackBlock:^{
            
        }];
    }
}
-(void)cancleBtnClick:(UIButton *)btn{
    _shareBackView.hidden = YES;
//    _shareView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _shareView.transform = CGAffineTransformMakeTranslation(0, 150);
    }];
}
-(void)createBackView{
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 44);
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}
//分享到朋友圈
-(void)rightClick:(UIButton *)btn{
    NSLog(@"%@",self.shareUrlStr);
    _shareBackView.hidden = NO;
//    _shareView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _shareView.transform = CGAffineTransformIdentity;
    }];

}
- (void)initViews {
    CGFloat infoW = kDeviceWidth-getScreenFitSize(80);
    _bageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, infoW, infoW*640/500)];
    _bageView.center = CGPointMake(kDeviceWidth/2, (kDeviceHeight-64)/2);
    _bageView.userInteractionEnabled= YES;
    [self.view addSubview:_bageView];
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, infoW, infoW*640/500)];
//    infoView.center = CGPointMake(kDeviceWidth/2, (kDeviceHeight-64)/2);
    infoView.backgroundColor = [UIColor whiteColor];
    infoView.userInteractionEnabled= YES;
    infoView.layer.cornerRadius = 5;
    infoView.layer.masksToBounds = YES;
    [_bageView addSubview:infoView];
    
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    
    CGFloat portraitGap = 20.0;
    CGFloat portraitW = 40.0;
    UIImageView *portraitView = [[UIImageView alloc] initWithFrame:CGRectMake(portraitGap, portraitGap, portraitW, portraitW)];
    portraitView.layer.cornerRadius = 5;
    portraitView.layer.masksToBounds = YES;
    [portraitView sd_setImageWithURL:[NSURL URLWithString:userModel.user.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
    [infoView addSubview:portraitView];
    
    CGFloat nickNameLeft = 10.0;
    CGFloat nickNameH = 15.0;
    UILabel *nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(portraitView.right+nickNameLeft, portraitView.top, infoW-(portraitView.right+nickNameLeft)-portraitGap, nickNameH)];
    nickNameLabel.backgroundColor = [UIColor clearColor];
    nickNameLabel.font = [UIFont systemFontOfSize:nickNameH];
    nickNameLabel.textColor = rgb(30, 30, 30, 1);
    nickNameLabel.text = userModel.user.nickname;
    [infoView addSubview:nickNameLabel];
    
    UILabel *signLabel = [[UILabel alloc] initWithFrame:CGRectMake(portraitView.right+nickNameLeft, portraitView.top+portraitW/2+(portraitW/2-nickNameH)/2, infoW-(portraitView.right+nickNameLeft)-portraitGap, nickNameH)];
    signLabel.backgroundColor = [UIColor clearColor];
    signLabel.font = [UIFont systemFontOfSize:nickNameH];
    signLabel.textColor = [UIColor lightGrayColor];
    signLabel.text = userModel.user.signature;
    [infoView addSubview:signLabel];
    
    CGFloat codeBoardW = 15.0;
    CGFloat codeGap = infoW/10-codeBoardW;
    UIImageView *codeView = [[UIImageView alloc] initWithFrame:CGRectMake(codeGap, portraitView.bottom+codeGap, infoW-codeGap*2, infoW-codeGap*2)];
    codeView.image = _image;
    codeView.userInteractionEnabled= YES;
    [infoView addSubview:codeView];
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [codeView addGestureRecognizer:singleRecognizer];
//    UILongPressGestureRecognizer *longa = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)] ;
//    [codeView addGestureRecognizer:longa];
    
    UILabel *tips = [[UILabel alloc] initWithFrame:CGRectMake(0, codeView.bottom-codeBoardW, infoW, infoView.height-codeView.bottom+codeBoardW)];
    tips.backgroundColor = [UIColor clearColor];
    tips.font = [UIFont systemFontOfSize:12.0];
    tips.textAlignment = NSTextAlignmentCenter;
    tips.textColor = rgb(24, 93, 191, 1);
    tips.text = @"使用无忧借条的扫一扫加我吧";
    [infoView addSubview:tips];
}



-(void)longPress:(UITapGestureRecognizer *)Press
{
//    if (Press.state == UIGestureRecognizerStateBegan)
//    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:nil
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"保存到手机"
                                      otherButtonTitles:nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
        
//    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIGraphicsBeginImageContextWithOptions(_bageView.bounds.size, _bageView.opaque, 0.0);
        [_bageView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self saveImageToPhotos:image];
    }else if(buttonIndex == 1) {
        NSLog(@"取消");
    }
    
}

- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存失败" ;
        [KVNProgress showErrorWithStatus:msg];
    }else{
        msg = @"保存成功" ;
        [KVNProgress showSuccessWithStatus:msg];
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
