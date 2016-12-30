//
//  CreditHallMostNewViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/11/16.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CreditHallMostNewViewController.h"
#import "DishonestyListViewController.h"
#import "CreditHallTuhaoListViewController.h"
#import "YXBTool.h"
#import "DituScrollView.h"
#import "CreditMapManager.h"
#import "CBAutoScrollLabel.h"
#import "CreditMapData.h"
#import "CreditProviceMapData.h"
#import "DituScorllviewSX.h"

#define botViewHight    kDeviceWidth/6/140*191
@interface CreditHallMostNewViewController () {
    UIView *_view1;
    UIView *_view2;
    QCUserModel *_userModel;
}

@property(nonatomic,strong)DituScrollView *scrollView;
@property(nonatomic,strong)DituScorllviewSX *scrollViewshixin;
@property(nonatomic,strong) CBAutoScrollLabel *CBAlabel;
@property(nonatomic,strong)UISegmentedControl *segment;
@end

@implementation CreditHallMostNewViewController

- (void)dealloc {
    NSLog(@"CreditHallMostNewViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    
    [self createView];
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.hidesBottomBarWhenPushed = YES;
        [self.CBAlabel scrollLabelIfNeeded];
    
    [self.webView removeFromSuperview];
    _userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *url = [YXBTool getURL:[NSString stringWithFormat:@"wap/creditmaps/grade-meter.jsp?userId=%ld",(long)_userModel.user.t_id] params:nil];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //    YXBWebViewController   *searchVC = [[YXBWebViewController alloc] initWithURL:url];
    //    searchVC.view.top -= 64;
    //    [self.view addSubview:searchVC.view];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, kDeviceWidth, kDeviceHeight-20)];
    //    webView.backgroundColor = rgb(0, 0, 0, 1);
    //    webView.backgroundColor = rgb(217, 29, 61, 1);
    self.webView.backgroundColor = rgb(255, 255, 255, 1);
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:self.webView];
    
    [self.activity removeFromSuperview];
    self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];//指定进度轮的大小
    self.activity.backgroundColor = rgb(0, 0, 0, 0.7);
    self.activity.layer.cornerRadius = 5;
    [self.activity setCenter:CGPointMake(160, 140)];//指定进度轮中心点
    self.activity.center = self.view.center;
    [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];//设置进度轮显示类型
    [self.view addSubview:self.activity];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
//    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)requestdata {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak CreditHallMostNewViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        [this httpLoadParams:assginHtttperator];
    } complete:^(NSSkyArray* r, int taskid) {
        [this httpLoadComplete:r];
        
    }];
    [self.iHttpOperator connect];

}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    
    CreditMapManager* manager = (CreditMapManager*)  [assginHtttperator getAopInstance:[CreditMapManager class] returnValue:[CreditMapData class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [manager getCreditMapData:userModel.user.yxbToken];
}
- (void)httpLoadComplete:(CreditMapData *)r{
    [self.CBAlabel setText:r.winString refreshLabels:YES];
    self.scrollView.dataAll = r;
    self.scrollViewshixin.dataAll = r;
}

- (void)createNav {
    [self setTitle:@"信用大厅"];
    [self setBackView];
}

- (void)createView {
    /*
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _view1 = [[UIView alloc] initWithFrame:self.view.bounds];
    _view2 = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_view1];
    [self.view addSubview:_view2];
    _view2.hidden = YES;
    _view1.clipsToBounds = YES;
    _view2.clipsToBounds = YES;
    
    //地图
    self.scrollView = [[DituScrollView alloc] initWithFrame:CGRectMake(0,80, kDeviceWidth, kDeviceHeight-botViewHight-80-64)];
    self.scrollView.clipsToBounds = NO;
    [_view1 addSubview:self.scrollView];
    
    //地图
    self.scrollViewshixin = [[DituScorllviewSX alloc] initWithFrame:CGRectMake(0,80, kDeviceWidth, kDeviceHeight-botViewHight-80-64)];
    self.scrollViewshixin.clipsToBounds = NO;
    [_view2 addSubview:self.scrollViewshixin];
    
    
    UIImageView *imgg1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, kDeviceHeight-64-botViewHight-kDeviceWidth/4/73*78-10-49, kDeviceWidth/4, kDeviceWidth/4/73*78)];
    imgg1.contentMode = UIViewContentModeScaleAspectFit;
    imgg1.layer.cornerRadius = 5;
    imgg1.layer.masksToBounds = YES;
    imgg1.image = [UIImage imageNamed:@"map2"];
    [_view1 addSubview:imgg1];
    
    UIImageView *imgg2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, kDeviceHeight-64-botViewHight-kDeviceWidth/4/73*78-10-49, kDeviceWidth/4, kDeviceWidth/4/73*78)];
    imgg2.layer.cornerRadius = 5;
    imgg2.contentMode = UIViewContentModeScaleAspectFit;
    imgg2.layer.masksToBounds = YES;
    imgg2.image = [UIImage imageNamed:@"map1"];
    [_view2 addSubview:imgg2];
    
    
    NSArray *arr = [[NSArray alloc]initWithObjects:@"诚信地图",@"失信地图", nil];
    self.segment = [[UISegmentedControl alloc]initWithItems:arr];
    [self.segment setTintColor:[YXBTool colorWithHexString:@"#e32f4e"]];
    self.segment.backgroundColor = [UIColor whiteColor];
    self.segment.selectedSegmentIndex = 0;
    self.segment.layer.cornerRadius = 5.0;
    self.segment.frame = CGRectMake(25, 10, kDeviceWidth-50, 30);
    [self.segment addTarget:self action:@selector(segmentchange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segment];


    UIView *effectview1 = [[UIView alloc] initWithFrame:CGRectMake(35, self.segment.bottom+10, kDeviceWidth-70, 25)];
    effectview1.backgroundColor = rgb(255, 255, 255, 0.8);
    effectview1.layer.cornerRadius = 5;
    effectview1.alpha = 0.8;
    effectview1.layer.masksToBounds = YES;
    [_view1 addSubview:effectview1];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 16)];
    img.image = [UIImage imageNamed:@"la"];
    
    self.CBAlabel = [[CBAutoScrollLabel alloc] initWithFrame:CGRectMake(img.right+5, 5, effectview1.width-img.right-5, 16)];
    self.CBAlabel.textColor = [UIColor redColor];
    self.CBAlabel.labelSpacing = self.CBAlabel.width; // distance between start and end labels
    self.CBAlabel.pauseInterval = 1.5; // seconds of pause before scrolling starts again
    self.CBAlabel.scrollSpeed = 35; // pixels per second
    self.CBAlabel.textAlignment = NSTextAlignmentCenter; // centers text when no auto-scrolling is applied
    self.CBAlabel.font = [UIFont systemFontOfSize:13];;
    self.CBAlabel.fadeLength = 15.f;
    self.CBAlabel.scrollDirection = CBAutoScrollDirectionLeft;
    [effectview1 addSubview:img];
    [effectview1 addSubview:self.CBAlabel];
    
    */
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = rgb(224, 54, 55, 1);


//    if (KDeviceOSVersion >= 8.0) {
//        
//        //底部视图
//        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
//        effectview.frame = CGRectMake(0, kDeviceHeight-botViewHight-49, kDeviceWidth, botViewHight);
//        //    effectview.alpha = 0.9;
//        effectview.userInteractionEnabled = YES;
//        [self.view addSubview:effectview];
//        NSArray *botTitles = @[@"map-foot1",@"map-foot2",@"map-foot3",@"map-foot4",@"map-foot5",@"map-foot6"];
//        for (int i = 0; i < botTitles.count; i++) {
//            UIButton *botbutton = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/6*i, 0, kDeviceWidth/6, effectview.height)];
//            botbutton.tag = 100+i;
//            [botbutton setImage:[UIImage imageNamed:botTitles[i]] forState:UIControlStateNormal];
//            [botbutton addTarget:self action:@selector(botAction:) forControlEvents:UIControlEventTouchUpInside];
//            [effectview addSubview:botbutton];
//        }
//        
//    }else {
//
//        //底部视图
//        UIView *effectview = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-botViewHight-64-49, kDeviceWidth, botViewHight)];
//        effectview.backgroundColor = rgb(255, 255, 255, 0.8);
//        [self.view addSubview:effectview];
//        NSArray *botTitles = @[@"map-foot1",@"map-foot2",@"map-foot3",@"map-foot4",@"map-foot5",@"map-foot6"];
//        for (int i = 0; i < botTitles.count; i++) {
//            UIButton *botbutton = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/6*i, 0, kDeviceWidth/6, effectview.height)];
//            botbutton.tag = 100+i;
//            [botbutton setImage:[UIImage imageNamed:botTitles[i]] forState:UIControlStateNormal];
//            [botbutton addTarget:self action:@selector(botAction:) forControlEvents:UIControlEventTouchUpInside];
//            [effectview addSubview:botbutton];
//        }
//    }

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [KVNProgress dismiss];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


#pragma mark - UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    //    [webView  ]
    NSLog(@"return value : %@",request.URL);
    NSString *urlStr = [request.URL absoluteString];
    NSString *newStr = [self decodeFromPercentEscapeString:urlStr];
    NSLog(@"return value : %@",newStr);
    if ([newStr hasPrefix:@"yxbaoback://"]) {
        self.tabBarController.selectedIndex = 0;
        return NO;
    }
    
    //信用大厅
    NSString* creditURL = @"credit://";
    if ([urlStr hasPrefix:creditURL]) {
        NSString* contentDic = [urlStr substringFromIndex:[creditURL length]];
        
        NSString *str = [self  decodeFromPercentEscapeString:contentDic];
        NSError* error = nil;
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",dic);
        QCBoardType creditType = [dic[@"type"] integerValue];
        if (creditType >= QCBoardTypeTuHao && creditType <= QCBoardTypeShiXin) {
            
            
            if (creditType == QCBoardTypeShiXin) {
                DishonestyListViewController *boardVCs = [[DishonestyListViewController alloc] init];
                [[YXBTool getCurrentNav] pushViewController:boardVCs animated:YES];
                
            }
            else
            {
                CreditHallTuhaoListViewController *boardVC = [[CreditHallTuhaoListViewController alloc] init];
                boardVC.type = creditType;
                [[YXBTool getCurrentNav] pushViewController:boardVC animated:YES];
                
                
            }
            
        }
        else
        {
            NSLog(@"信用大厅  type错误");
        }
        
        return NO;
        
    }

    
    //分享
    NSString* shareURL = @"share://";
    if ([urlStr hasPrefix:shareURL]) {
        NSString* shareDic = [urlStr substringFromIndex:[shareURL length]];
        
        NSString *sharestr = [self  decodeFromPercentEscapeString:shareDic];
        NSError* error1 = nil;
        NSDictionary* sharestrdic = [NSJSONSerialization JSONObjectWithData:[sharestr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error1];
        NSLog(@"%@",sharestrdic);
        
        NSString * shareType = sharestrdic[@"type"];
        NSString * shareAddress = sharestrdic[@"link"];
        NSString * content = sharestrdic[@"desc"];
        NSString * title = sharestrdic[@"title"];
        NSString * imgUrl = sharestrdic[@"imgUrl"];
        UIImage *imgwechat = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
        if ([shareType isEqualToString:@"weChatFriend"]) {
            NSLog(@"shareAddress : %@",shareAddress);//分享地址
            NSLog(@"content : %@",content);//分享内容
            NSLog(@"name : %@",title);//分享标题
            [YXBTool shareToWeixinSessionContent:content imgName:imgwechat url:shareAddress title:title callBackBlock:^{
                
            }];
        }else if ([shareType isEqualToString:@"weChat"]) {
            NSLog(@"shareAddress : %@",shareAddress);//分享地址
            NSLog(@"content : %@",content);//分享内容
            NSLog(@"name : %@",title);//分享标题
            [YXBTool shareToWeixinTimelineContent:content imgName:imgwechat url:shareAddress title:title callBackBlock:^{
                
            }];
        }
        return NO;
        
    }
    


    
    
    //返回首页
    NSString* backIndexPage = @"backIndexPage://";
    if ([urlStr hasPrefix:backIndexPage]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        self.tabBarController.selectedIndex = 0;
        return NO;
        
    }
    

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activity startAnimating];
    //        [KVNProgress show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activity stopAnimating];
    //        [KVNProgress dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activity stopAnimating];
    //    [ProgressHUD showErrorWithStatus:@"加载失败"];
    [KVNProgress showErrorWithStatus:@"加载失败"];
}

- (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}



#pragma mark --- 选择
-(void)segmentchange:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %ld", (long)Index);
    switch (Index) {
        case 0:
            _view1.hidden = NO;
            _view2.hidden = YES;
            break;
        case 1:
            _view1.hidden = YES;
            _view2.hidden = NO;
            break;
    }
}

#pragma mark --- 底部按钮点击事件
- (void)botAction:(UIButton *)sender {
    if (sender.tag == 105) {
        DishonestyListViewController *boardVCs = [[DishonestyListViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:boardVCs animated:YES];
        
    }
    else
    {
        CreditHallTuhaoListViewController *boardVC = [[CreditHallTuhaoListViewController alloc] init];
        if (sender.tag == 100) {
            boardVC.type = QCBoardTypeRenYuan;
        }else if (sender.tag == 101) {
        boardVC.type = QCBoardTypeHaoZhaoLi;
        }else if (sender.tag == 102) {
            boardVC.type = QCBoardTypeHuoYue;
        }else if (sender.tag == 103) {
            boardVC.type = QCBoardTypeTuHao;
        }else if (sender.tag == 104) {
            boardVC.type = QCBoardTypeYiQi;
        }
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:boardVC animated:YES];
        
        
    }
}

@end
