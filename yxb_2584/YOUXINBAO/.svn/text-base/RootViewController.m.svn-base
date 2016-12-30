//
//  RootViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/3/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "MyTuhaoLoanListViewController.h"
#import "AAActivitiesListViewController.h"
#import "QCConst.h"
#import "TreasureMoneyNewViewController.h"
#import "QCLoginOneViewController.h"
#import "QCRegisterTwoViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "QCFriendsViewController.h"
#import "QCTrustViewController.h"
#import "LoanOrRepayViewController.h"
#import "YLInitSwipePasswordController.h"
#import "SetViewController.h"
#import "DebtListViewController.h"
#import "AppDelegate.h"
#import "CPBTimerManager.h"
#import "HomeModel.h"
#import "MyOrderListController.h"
#import "AmortizationHomeViewController.h"
#import "AmortizationHomeNewViewController.h"
#import "YXBTool.h"
#import "UserManager.h"
#import "MyMD5.h"
#import "HttpOperator.h"
#import "LeftViewController.h"
#import "QCHomeDataManager.h"
#import "BonusListController.h"
#import "HomePopView.h"
#import "MsgCenterMgr+Public.h"
//#import "TreasureHomeViewController.h"
#import "QCMakeMoneyViewController.h"
#import "MsgCenterMgr.h"
#import "CreditHallTuhaoListViewController.h"
#import "DishonestyListViewController.h"
#import "QCDeviceManager.h"
#import "QCRegisterOneViewController.h"
#import "UIAlertView+Block.h"
#import "AACreateViewController.h"
#import "UnReadBubbleView.h"
#import "AAShareBubbles.h"
#import "MessageCenterController.h"
#import "AmorOrderViewController.h"
#import "MyInfoViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "OverdueModel.h"
#import "CreditPopView.h"
#import "LoanAddressBookViewController.h"
#import "CreditHallMostNewViewController.h"
#import "FMDeviceManager.h"
#import "CTreasureMoneyViewController.h"

//#define RootViewControllerRightInfoUrl @"webView/explain/indexExplain.jsp?t=1"
#define RootViewControllerRightInfoUrl @"webView/helpcenter/service.jsp?"
//#define RootViewControllerRightInfoUrl @"webView/user/upSMS.jsp"//首页测试发短信接口
//#define RootViewControllerRightInfoUrl @"webView/helpcenter/index.jsp?id="
#define HomeHttpRequest_ADRESS   [NSString stringWithFormat:@"%@mobile/index.jsp?",YXB_IP_ADRESS];
@interface RootViewController ()<AAShareBubblesDelegate,CPBTimerDelegate,HomePopViewDelegate> {
    CPBTimerManager             *_timerManager;
    NSMutableArray              *_imgArray;
    NSInteger                   postion;
    UIScrollView                *_guideChartscrollView;
    NSInteger                   _timeHomeRequest;
    AAShareBubbles              *shareBubbles;

    

    AFHTTPRequestOperationManager *_httpManager;
    OverdueModel *_overdueModel;
    
    UIView *_overdueView;

    UIView *_overBgView;



}

//@property(nonatomic,strong)KYCuteView *cuteView;//消息中心 按钮上方的 红色圆点
@property(nonatomic,strong)UnReadBubbleView *cuteView;//消息中心 按钮上方的 红色圆点
@property(nonatomic,strong)UIImageView      *centerRedView;//个人中心 按钮 红点

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [NSThread sleepForTimeInterval:3.0]; //延长lanuch时间
    [self createGuideChart];//引导图
    [self setTitle:@"无忧借条"];
    [self createData];
    [self createHomeUI];
    [self createNavBar];
    [self createNotification];
    [MsgCenterMgr sharedInstance];
    [self stopDefaultAnimation];
    [self createOverdueView];


}

#pragma mark - 逾期弹框
-(void)createOverdueView{
    _overBgView = [[UIView alloc] initWithFrame:self.view.bounds];
    _overBgView.hidden = YES;
    _overBgView.alpha = 0.7;
    _overBgView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_overBgView];
    _overdueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 294, 248)];
    _overdueView.center = CGPointMake(kDeviceWidth/2, (kDeviceHeight-64-49)/2);
    _overdueView.hidden = YES;
    [self.view addSubview:_overdueView];
    
    UIImageView *bgimgView = [[UIImageView alloc] initWithFrame:_overdueView.bounds];
    bgimgView.image = [UIImage imageNamed:@"yuqi-tcdiv"];
    bgimgView.userInteractionEnabled = YES;
    [_overdueView addSubview:bgimgView];
    
    UIButton *overdueCancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    overdueCancleBtn.frame = CGRectMake(294-80, 0, 80, 50);
    [overdueCancleBtn addTarget:self action:@selector(overdueCancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    overdueCancleBtn.backgroundColor = [UIColor redColor];
    [bgimgView addSubview:overdueCancleBtn];
    
    UIButton *overdueRepayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    overdueRepayBtn.frame = CGRectMake(20, 248-70, 294-40, 70);
    [overdueRepayBtn addTarget:self action:@selector(overdueRepayBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    overdueRepayBtn.backgroundColor = [UIColor greenColor];
    [bgimgView addSubview:overdueRepayBtn];
    
}
-(void)overdueCancleBtnClick{
    NSLog(@"取消");
    _overBgView.hidden = YES;
    _overdueView.hidden = YES;
}
-(void)overdueRepayBtnClick{
    NSLog(@"还款");
    [YXBTool typeToJump:@"loanDetail" info:_overdueModel.loanDetail];
}
-(void)overdueViewHiddenOrNot:(BOOL)isShow{
    [self.view bringSubviewToFront:_overdueView];
    _overdueView.hidden = isShow;
    _overBgView.hidden = isShow;
}
-(void)createHttpManager{
    _httpManager = [AFHTTPRequestOperationManager manager];

    QCUserManager *manager = [QCUserManager sharedInstance];
    QCUserModel *userModel = [manager getLoginUser];
    NSDictionary *dic = @{@"userid":[NSString stringWithFormat:@"%ld",(long)userModel.user.t_id],@"cookie":[YXBTool getYxbCookie]};
    NSString *str = [NSString stringWithFormat:@"%@webView/loan/demurrage.jsp?a=1",YXB_IP_ADRESS];
    NSLog(@"demurrage.jsp---%@",str);
    __weak RootViewController *this = self;
    [_httpManager POST:str parameters:dic  success:^(AFHTTPRequestOperation *operation, id responseobject) {

        [this jiexi:responseobject];
        

    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"yuqihttp_error:%@",error);
    }];
}
-(void)jiexi:(NSDictionary *)dict{
    _overdueModel = [OverdueModel shareOverdueModel];
    _overdueModel.needPop = [[dict objectForKey:@"needPop"] integerValue];
    _overdueModel.loanDetail = [dict objectForKey:@"loanDetail"];
    if ((!_overdueModel.showNewLoan) || [_overdueModel.showNewLoan isEqualToString:@"-1"])
    {
        _overdueModel.showNewLoan = [dict objectForKey:@"showNewLoan"];

    }

    [self overdueViewHiddenOrNot:(![[dict objectForKey:@"needPop"] integerValue]==1)];
    
    //显示个人中心小红点
    [self showRedView];
}

- (void)createData {
    postion = 0;
    self.timeradd = 0;
    self.homeAAListData = [[NSMutableArray alloc] initWithCapacity:0];
    self.homeTopData = [[NSMutableArray alloc] initWithCapacity:0];
    self.homeTopDatasss = [[NSMutableArray alloc] initWithCapacity:0];
//    [self getHomePageInfoRequest];
}

- (void)createNotification {
    //通知登录成功后 向上移动的动画
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(happyValueAction)
                                                 name:@"holleUserNotification"
                                               object:nil];
}

- (void)createGuideChart {
    
    QCDeviceModel *deviceM = [[QCDeviceManager sharedInstance] getDevieModel];

    if (deviceM.guideChart == nil || ![deviceM.guideChart isEqualToString:@"1"]) {
        
        NSArray *imgName = @[@"guideChart1.jpg",@"guideChart2.jpg",@"guideChart3.jpg",@"guideChart4.jpg"];
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        _guideChartscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        _guideChartscrollView.delegate = self;
        _guideChartscrollView.showsHorizontalScrollIndicator = NO;
        _guideChartscrollView.pagingEnabled = YES;
        _guideChartscrollView.scrollEnabled = YES;
        _guideChartscrollView.bounces = NO;
        _guideChartscrollView.contentSize = CGSizeMake(kDeviceWidth*imgName.count, kDeviceHeight);
        _guideChartscrollView.tag = 11111;
        [window  addSubview:_guideChartscrollView];
        for (int i = 0; i < imgName.count; i++) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(i*kDeviceWidth, 0, kDeviceWidth, kDeviceHeight)];
            img.userInteractionEnabled = YES;
            img.image = [UIImage imageNamed:imgName[i]];
            if (i == (imgName.count-1)) {
                UIButton *butt = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/750*250/2, kDeviceHeight/1334*1100, kDeviceWidth/750*500, kDeviceWidth/750*500/367*98)];
                [butt setBackgroundImage:[UIImage imageNamed:@"qdbut@6"] forState:UIControlStateNormal];
                [butt addTarget:self action:@selector(guideChartButAction) forControlEvents:UIControlEventTouchUpInside];
                [img addSubview:butt];
            }
            [_guideChartscrollView addSubview:img];
        }

    }

}

//首次安装 引导图
- (void)guideChartButAction {
    [UIView animateWithDuration:0.2 animations:^{
        _guideChartscrollView.transform = CGAffineTransformMakeScale(3, 3);
        _guideChartscrollView.alpha = 0;
    } completion:^(BOOL finished) {
        [_guideChartscrollView removeFromSuperview];
        HomePopView *view = [[HomePopView alloc] init];
        view.delegte = self;
        [view showMostHonest];
    }];
//    QCDeviceModel *deviceM = [[QCDeviceModel alloc] init];
    QCDeviceModel *deviceM = [[QCDeviceManager sharedInstance] getDevieModel];

    QCDeviceManager * um  = [QCDeviceManager sharedInstance];
    deviceM.guideChart = @"1";
    [um setPhoneDeviceModel:deviceM];

}

#pragma mark 任务体系 HomePopView - delegete
- (void)ImmediatelyJoin {
    QCRegisterOneViewController *phoneNumVC = [[QCRegisterOneViewController alloc] init];
    [self.navigationController pushViewController:phoneNumVC animated:YES];

}

- (void)createNavBar {
//左侧
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 28, 28);
    [btn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *createItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = createItem;
    self.navUserImg = [[UIImageView alloc] initWithFrame:btn.bounds];
//    self.navUserImg.layer.borderColor = rgb(249, 151, 152, 1).CGColor;
//    self.navUserImg.layer.borderColor = rgb(255, 255, 255, 1).CGColor;
    self.navUserImg.layer.borderWidth = 1;
    self.navUserImg.layer.cornerRadius = self.navUserImg.width/2;
    self.navUserImg.layer.masksToBounds = YES;
    [btn addSubview:self.navUserImg];
    
    [self setNavigationButtonItrmWithiamge:@"index-notice-icon.png" withRightOrleft:@"right" withtargrt:self withAction:@selector(rightClicked)];
    self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

}

-(void)rightClicked
{

    NSString *url = [YXBTool getURL:RootViewControllerRightInfoUrl params:nil];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"首页说明"];

//    NSLog(@"首页右上角");

}
- (void)createHomeUI{

    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64)];
    [self.view addSubview:self.bgScrollView];
    self.bgScrollView.delaysContentTouches = NO;
    _userInfoImgbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, (kDeviceWidth/2.5f))];
    _userInfoImgbg.bottom = self.bgScrollView.top;
    _userInfoImgbg.image = [UIImage imageNamed:@"welcomebgimg.jpg"];
    [self.view addSubview:_userInfoImgbg];
    
    _userInfoImg = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-_userInfoImgbg.height/2)/2, (_userInfoImgbg.height-_userInfoImgbg.height/2)/2, _userInfoImgbg.height/2,  _userInfoImgbg.height/2)];
    _userInfoImg.layer.cornerRadius = _userInfoImg.size.width/2;
    _userInfoImg.layer.borderColor = [UIColor whiteColor].CGColor;
    _userInfoImg.layer.borderWidth = 1.5f;
    _userInfoImg.layer.masksToBounds = YES;
    _userInfoImg.image = [UIImage imageNamed:@"homeUserPhoto.png"];
    [_userInfoImgbg addSubview:_userInfoImg];
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(0, _userInfoImg.bottom+10, kDeviceWidth, 20)];
    _userName.textAlignment = NSTextAlignmentCenter;
    _userName.textColor = [UIColor whiteColor];
    _userName.font = [UIFont boldSystemFontOfSize:16];
    [_userName setAdjustsFontSizeToFitWidth:YES];
    _userName.text = @"欢迎回来 : ";
    [_userInfoImgbg addSubview:_userName];
    
    NSLog(@"%f",kDeviceWidth);
    //背景上的UIScroll
    _topView = [[NoticeScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/320*151)];
    if (kDeviceHeight == 480) {
        _topView.frame = CGRectMake(0, 0, kDeviceWidth, 84);
    }else if (kDeviceHeight == 568){
        _topView.frame = CGRectMake(0, 0, kDeviceWidth, 150);
    }
    [_topView.layer setMasksToBounds:YES];
    _topView.delegate = self;
    [self.bgScrollView addSubview:_topView];

    //中间的三个按钮
    _middleView = [[HomeMiddleView alloc] initWithFrame:CGRectMake(0, _topView.bottom, kDeviceWidth, 168)];
    _middleView.delegate = self;
    if (kDeviceHeight == 480) {
        _middleView.frame = CGRectMake(0, _topView.bottom, kDeviceWidth, 125);
    }else if (kDeviceHeight == 568){
        _middleView.frame = CGRectMake(0, _topView.bottom, kDeviceWidth, 125);
    }else if (kDeviceWidth > 375){
        _middleView.frame = CGRectMake(0, _topView.bottom, kDeviceWidth, 191);
    }
    _middleView.backgroundColor = [UIColor whiteColor];
    [self.bgScrollView addSubview:_middleView];

    
    //下面的滑动列表 和 两个按钮
    _bottomView = [[HomeNewBottomView alloc] initWithFrame:CGRectMake(0, _middleView.bottom, kDeviceWidth, 200)];
    _bottomView.delegate = self;
    if (kDeviceHeight == 480) {
        _bottomView.frame = CGRectMake(0, _middleView.bottom, kDeviceWidth, 160);
    }else if (kDeviceHeight == 568){
        _bottomView.frame = CGRectMake(0, _middleView.bottom, kDeviceWidth, 165);
    }else if (kDeviceWidth > 375){
        _bottomView.frame = CGRectMake(0, _middleView.bottom, kDeviceWidth, 214);
    }
//    _bottomView.layer.contents = (id)[UIImage imageNamed:@"indexbgrepeat2.png"].CGImage;
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    line1.backgroundColor = [YXBTool colorWithHexString:@"#e4e1dc"];
    [_bottomView addSubview:line1];

    _bottomView.backgroundColor = [YXBTool colorWithHexString:@"#f0efed"];

    
    [self.bgScrollView addSubview:_bottomView];
    
    
    [self createBottomView];
    [self createTimer];
}

- (void)createTimer {
    _timerManager = [[CPBTimerManager alloc]initWithTimeInterval:3 userInfo:Nil repeats:YES];
    _timerManager.delegate = self;
    _timeHomeRequest = 0;
}


//底部 tabbar  视图创建
- (void)createBottomView {

    UIView *myView = [[UIView alloc] init];
    myView.hidden = YES;
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    line2.backgroundColor = rgb(202, 202, 202, 1);
    [myView addSubview:line2];
    myView.frame = CGRectMake(0, _bottomView.bottom, kDeviceWidth, kDeviceHeight-_bottomView.bottom-64);
//    myView.backgroundColor = [YXBTool colorWithHexString:@"#f0efed"];
    myView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myView];
    NSArray *ImgArray = @[@"yxbsy-footnav1",@"yxbsy-footnav2",@"yxbsy-footnav3",@"yxbsy-footnav4"];
    NSArray *ImgArrayon = @[@"yxbsy-footnav1-on",@"yxbsy-footnav2-on",@"yxbsy-footnav3-on",@"yxbsy-footnav4-on"];
    for (int i = 0; i < ImgArray.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/ImgArray.count*i, 0, kDeviceWidth/ImgArray.count, myView.height)];
        [button setImage:[UIImage imageNamed:ImgArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:ImgArrayon[i]] forState:UIControlStateHighlighted];
        button.tag = i+10;
        [button addTarget:self action:@selector(bottomButAction:) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:button];
        if (i == 0) {

        }
        if (i == 1) {
            self.centerRedView =[[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/4/96*50+3, 5, 12, 12)];
            self.centerRedView.image = [UIImage imageNamed:@"red-indexbot"];
            [button addSubview:self.centerRedView];
        }
        if (i == 2) {
            self.cuteView =[[UnReadBubbleView alloc] initWithFrame:CGRectMake(kDeviceWidth/4/96*50, 5, 20, 20)];
            self.cuteView.showGameCenterAnimation = YES;
            self.cuteView.viscosity  = 25;
            self.cuteView.bubbleWidth = 20;
            [button addSubview:self.cuteView];
        }
    }
}

#pragma mark AAShareBubbles
//安全认证 五个认证按钮 点击回调
-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType
{
    switch (bubbleType) {
        case AAShareBubbleTypeFacebook:
            NSLog(@"CA认证");
            break;
        case AAShareBubbleTypeTwitter:
            NSLog(@"互联网认证");
            break;
        case AAShareBubbleTypeMail:
            NSLog(@"备案");
            break;
        case AAShareBubbleTypeGooglePlus:
            NSLog(@"公安认证");
            break;
        case AAShareBubbleTypeTumblr:
            NSLog(@"可信任认证");
            break;
            
        default:
            break;
    }
}


//下边 四个按钮点击事件
- (void)bottomButAction:(UIButton *)sender {
    if (sender.tag == 10) {
        //安全认证
        if(shareBubbles) {
            shareBubbles = nil;
        }
        shareBubbles = [[AAShareBubbles alloc] initWithPoint:CGPointMake(sender.center.x, sender.origin.y+_bottomView.bottom+64+30) radius:250 inView:nil];
        shareBubbles.bubbleRadius = 30;
        shareBubbles.delegate = self;
        shareBubbles.showFacebookBubble = YES;
        shareBubbles.showTwitterBubble = YES;
        shareBubbles.showGooglePlusBubble = YES;
        shareBubbles.showMailBubble = YES;
        shareBubbles.showTumblrBubble = YES;
        [shareBubbles show];
    }else if (sender.tag == 11){
        [self leftAction];
    }else if (sender.tag == 12){
        //消息中心
        [self messageAction];
    }else if (sender.tag == 13){
        [self rightClicked];
    }
}

#pragma mark ----- HomeTopScorllViewDelegate
- (void)HomeTopScorllViewAction:(NSInteger)index info:(NSString *)info type:(NSString *)type{
    [YXBTool typeToJump:type info:info];
}

#pragma mark ----- HomeMiddleViewDelegate
- (void)HomeMiddleViewAction:(NSInteger)senderTag {
    if (senderTag == 1000) {
        LoanOrRepayViewController * loanViewController = [[LoanOrRepayViewController alloc]init];
        [self.navigationController pushViewController:loanViewController animated:YES];
        
        
    }else if (senderTag == 1001){
        AmortizationHomeNewViewController *amortization = [[AmortizationHomeNewViewController alloc] init];
        [self.navigationController pushViewController:amortization animated:YES];
        
//        AmorOrderViewController *amortization = [[AmorOrderViewController alloc] init];
//        [self.navigationController pushViewController:amortization animated:YES];

//        LoanAddressBookViewController *controller = [[LoanAddressBookViewController alloc] init];
//        [self.navigationController pushViewController:controller animated:YES];
        
    }else if (senderTag == 1002){
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        if (!userModel.isLogin || (userModel.user.nickname == nil)) {
            [self toLogin];
            return;
        }
//        QCMakeMoneyViewController *treasure = [[QCMakeMoneyViewController alloc] init];
//        [self.navigationController pushViewController:treasure animated:YES];
//        CTreasureMoneyViewController *ctr = [[CTreasureMoneyViewController alloc] init];
//        [self.navigationController pushViewController:ctr animated:YES];
//        TreasureMoneyNewViewController *treasure = [[TreasureMoneyNewViewController alloc] init];
//        [self.navigationController pushViewController:treasure animated:YES];
        CTreasureMoneyViewController *ctr = [[CTreasureMoneyViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];

    }

}

#pragma mark --- HomeBottomViewDelegate
- (void)HomeNewBottomViewAction:(NSInteger)senderTag {
    if (senderTag == 66666) {//AA附近
        AAActivitiesListViewController * aaViewController = [[AAActivitiesListViewController alloc]init];
        [self.navigationController pushViewController:aaViewController animated:YES];
//        AAActivitiesListViewController * aaViewController = [[AAActivitiesListViewController alloc]init];
//        aaViewController.filtrateType = filtrateTypeStudy;
//        [self.navigationController pushViewController:aaViewController animated:YES];
    }else if (senderTag == 77777) {//创建AA活动
        AAActivitiesListViewController * aaViewController = [[AAActivitiesListViewController alloc]init];
        [self.navigationController pushViewController:aaViewController animated:NO];
        aaViewController.isFromRoot = YES;
        [aaViewController createAction];
    }else if (senderTag == 88888) {//土豪白条

        NSString *url = @"webView/goods/purchase.jsp";
        [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:url params:nil] hasTopBar:NO titleName:@"商品秒杀"];
    }else if (senderTag == 1000){
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        if (!userModel.isLogin) {
            [self toLogin];
            return;
        }
        if (kDeviceHeight <= 480) {
            //        NSString *creditUrl = @"webView/user/credit-hall.jsp";
            NSString *creditUrl = @"wap/creditmaps/index.jsp";
            
            [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:creditUrl params:nil] hasTopBar:YES titleName:@"信用大厅"];
        }else {
            CreditHallMostNewViewController *CreditHall = [[CreditHallMostNewViewController alloc] init];
            [self.navigationController pushViewController:CreditHall animated:YES];
        }
    }
    /*
    else if (senderTag == 1001){//设置

        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        if (!userModel.isLogin) {
            [self toLogin];
            return;
        }
        SetViewController * setViewController = [[SetViewController alloc]init];
        [self.navigationController pushViewController:setViewController animated:YES];
    }*/
    else if (senderTag == 1002){//好友列表
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        if (!userModel.isLogin) {
            [self toLogin];
            return;
        }
        QCFriendsViewController * friendsViewController = [[QCFriendsViewController alloc]init];
        [self.navigationController pushViewController:friendsViewController animated:YES];
    }

}

#pragma mark -- CPBTimerDelegate
- (void)CPBTimerManagerAction:(CPBTimerManager *)timer {
    
    [self.topView CPBTimerManagerAction];//滚动
    self.timeradd++;
    if (self.timeradd == 10) {
        self.timeradd = 0;
        //AA列表 滑动
        if ([self.homeAAListData count]>1) {
            //淡入淡出
            //            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:postion inSection:0];
            //            UITableViewCell * cell = [self.bottomView.HomeLiseTableView cellForRowAtIndexPath:indexPath];
            //            [UIView animateWithDuration:0.3 animations:^{
            //                cell.contentView.alpha = 0;
            //                 cell.transform = CGAffineTransformMakeScale(1.5, 1.5);
            //            } completion:^(BOOL finished) {
            //                cell.contentView.alpha = 1;
            //                cell.transform = CGAffineTransformMakeScale(1, 1);
            //            }];
            
            if ((postion + 2) <= [self.homeAAListData count]-1) {
                postion += 2;
            }else {
                postion++;
            }
            
            /*
            if (postion >= [self.homeAAListData count]-1) {
                postion = 0;
                NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:postion inSection:0];
                [_bottomView.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
                postion++;
                NSIndexPath *scrollIndexPath1 = [NSIndexPath indexPathForRow:postion inSection:0];
                [_bottomView.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath1 atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }else {
                
                NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:postion inSection:0];
                [_bottomView.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            */
            
        }
    }
    _timeHomeRequest++;
    //3秒一次  200次  十分钟
    if (_timeHomeRequest == 200) {
        _timeHomeRequest = 0;
        [self getHomePageInfoRequest];
    }


//    轮询
    if ([[MsgCenterMgr sharedInstance] hasNewFriend]) {
        _bottomView.hasNewfbut.hidden = NO;
    }else {
        _bottomView.hasNewfbut.hidden = YES;
    }
    
    if ([QCHomeDataManager sharedInstance].ishasNewLoanMess == YES) {
        _middleView.hasNewfbut.hidden = NO;
    }else {
        _middleView.hasNewfbut.hidden = YES;
    }
}


#pragma mark -- 数据请求
-(void)getHomePageInfoRequest
{
    NSString *userTok = [YXBTool getUserToken];
    if (userTok == nil) {
        userTok = @"";
    }
    NSString* url = HomeHttpRequest_ADRESS;
    NSString *URLString = [NSString stringWithFormat:@"%@&pt=ios&userToken=%@&v=%@", url,userTok,YXB_VERSION_CODE];
    NSURL *requestURL = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *postData = [@"{}" dataUsingEncoding:NSUTF8StringEncoding];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:requestURL];
    
    __weak ASIFormDataRequest* weakRequest = request;
    
//    [QCConfigTool setHttpSystemHeaderWithRequest:request];
        [request setPostBody:[NSMutableData dataWithData:postData]];
        [request setCompletionBlock:^{

            if ([weakRequest.responseString length] > 0) {

                NSError* error = nil;
                id object = [NSJSONSerialization JSONObjectWithData:[weakRequest.responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
                
                
                if (error != nil) {
                    return;
                }
                
                //保存 control
                NSDictionary  *control = object[@"control"];
                QCHomeDataManager *manger = [QCHomeDataManager sharedInstance];
                [manger saveDataWithDic:control];

                
                //轮播
                NSMutableArray  *toparray = object[@"picVal"];

                if (self.homeTopData != nil) {
                    [self.homeTopData removeAllObjects];
                }
                for (NSDictionary *topdata in toparray) {
                    HomeModel *topModel = [[HomeModel alloc] initWithDictionary:topdata];
                    [self.homeTopData addObject:topModel];
                }
                self.topView.imgMuArray = self.homeTopData;//轮播图赋值
                if (self.topView.imgMuArray != nil && self.topView.imgMuArray.count > 0) {
                    self.topView.isNoData = NO;
                }else {
                    self.topView.isNoData = YES;
                }
                /*
                //AA
                NSMutableArray  *aalistarray = object[@"aaVal"];
                if (self.homeAAListData != nil) {
                    [self.homeAAListData removeAllObjects];
                }
                for (NSDictionary *AAListdata in aalistarray) {
                    HomeModel *aaListModel = [[HomeModel alloc] initWithDictionary:AAListdata];
                    [self.homeAAListData addObject:aaListModel];
                }
                if (self.homeAAListData.count == 1) {
                    [self.homeAAListData addObject:[self.homeAAListData objectAtIndex:0]];
                    [self.homeAAListData addObject:[self.homeAAListData objectAtIndex:0]];
                    [self.homeAAListData addObject:[self.homeAAListData objectAtIndex:0]];
                }
                if (self.homeAAListData.count == 2) {
                    [self.homeAAListData addObject:[self.homeAAListData objectAtIndex:0]];
                    [self.homeAAListData addObject:[self.homeAAListData objectAtIndex:1]];
                }
                if (self.homeAAListData.count == 3) {
                    [self.homeAAListData addObject:[self.homeAAListData objectAtIndex:0]];
                    [self.homeAAListData addObject:[self.homeAAListData objectAtIndex:1]];
                }
                self.bottomView.bottomViewMuArray = self.homeAAListData;
                if (self.bottomView.bottomViewMuArray != nil && self.bottomView.bottomViewMuArray.count > 0) {
                    self.bottomView.isNoData = NO;
                }else {
                    self.bottomView.isNoData = YES;
                }
                
                */
                if (self.topView.imgMuArray != nil || self.bottomView.bottomViewMuArray != nil) {
                    self.isNoHomeData = NO;//首页数据是否加载失败
                }
            } else {

            }
            
        }];
        
        [request setFailedBlock:^{
            NSLog(@"首页请求失败");
            if (self.homeTopData != nil) {
                [self.homeTopData removeAllObjects];
            }
            self.topView.isNoData = YES;
//            self.bottomView.isNoData = YES;
            self.isNoHomeData = YES;
        }];
        
        [request startAsynchronous];
    NSLog(@"request.requestHeaders---%@",request.requestHeaders);

}

#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpLogin
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    LeftViewController *leftVC = [appDelegate getLeftViewController];
    [appDelegate showLeftVC];
    [leftVC refreshData];
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak RootViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {

        [this httpLoadParams:assginHtttperator];
    } complete:^(User* r, int taskid) {
        [this httpLoadCompleteOne:r appDelegate:appDelegate leftVC:leftVC];

    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    
    UserManager* _currUser = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[User class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    //        NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:userModel.user.pwd]]];
//    [_currUser userLogin:userModel.user.username pass:userModel.user.pwd];
    NSString *blackBox = [YXBTool getFMString];
    [_currUser userLoginWithFraudmetrix:userModel.user.username pwd:userModel.user.pwd fraudmetrixToken:blackBox];

}
- (void)httpLoadCompleteOne:(User *)r appDelegate:(AppDelegate *)appDelegate leftVC:(LeftViewController *)leftVC {

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
        [self.navUserImg sd_setImageWithURL:[NSURL URLWithString:currUser.user.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
        
        [leftVC refreshData];
        
    }else{
        //延迟调用复位，不然看起来很不协调
        [self performSelector:@selector(returnMainView) withObject:nil afterDelay:0.3f];
        [self toLogin];
        //            NSString * string = r.errString;
        //            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:this cancelButtonTitle:@"确定" otherButtonTitles: nil];
        //            [alertView show];
    }

}
- (void)httpLoginWithMyCenter
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak RootViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        [ProgressHUD showErrorWithStatus:@"网络异常"];

        
    } param:^(NSString *s) {
 
        [this httpLoadParamsTwo:assginHtttperator];
    } complete:^(User* r, int taskid) {
        
        [this httpLoadCompleteTwo:r];
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParamsTwo:(HttpOperator *)assginHtttperator{

    UserManager* _currUser = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[User class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    //        NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:userModel.user.pwd]]];
//    [_currUser userLogin:userModel.user.username pass:userModel.user.pwd];
    NSString *blackBox = [YXBTool getFMString];
    [_currUser userLoginWithFraudmetrix:userModel.user.username pwd:userModel.user.pwd fraudmetrixToken:blackBox];
}
- (void)httpLoadCompleteTwo:(User *)r{
    
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
        [self.navUserImg sd_setImageWithURL:[NSURL URLWithString:currUser.user.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
        
        [self toMyCenter];
    }else{
        [self toLogin];
        //            NSString * string = r.errString;
        //            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:this cancelButtonTitle:@"确定" otherButtonTitles: nil];
        //            [alertView show];
    }

}

-(void)toMyCenter
{
    MyInfoViewController *controller = [[MyInfoViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];

}

- (void)returnMainView {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    LeftViewController *leftVC = [appDelegate getLeftViewController];
    [leftVC returnMainView];
}


#pragma mark ---delegate 登录成功
- (void)loginSucceed {

}
#pragma mark ---Notification 登录成功
- (void)happyValueAction {
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [_userInfoImg sd_setImageWithURL:[NSURL URLWithString:userModel.user.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
    _userName.text = [NSString stringWithFormat:@"欢迎回来 : %@",userModel.user.nickname];

    self.bgScrollView.transform = CGAffineTransformMakeTranslation(0, _userInfoImgbg.height);
    _userInfoImgbg.bottom = self.bgScrollView.top;
    [UIView animateWithDuration:2.0f animations:^{
        self.bgScrollView.transform = CGAffineTransformIdentity;
        _userInfoImgbg.bottom = self.bgScrollView.top;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)messageAction {
    
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.isLogin == YES) {
        MessageCenterController *messageVC=[[MessageCenterController alloc]init];
        [self.navigationController pushViewController:messageVC animated:YES];
    }else {
        [self toLogin];
    }
    
}

- (void)leftAction
{
    
    
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.isLogin == YES && userModel.user.nickname != nil) {
//        [self httpLogin];
        [self toMyCenter];
//        [self httpLoginWithMyCenter];
    }else {
        [self toLogin];
    }
    
    
    
    
}

//跳出登陆页面
- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    loginView.delegte = self;
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
//    loginNav.navigationBar.barTintColor = rgb(231, 27, 27, 1);
//    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        loginView.modalPresentationStyle = UIModalPresentationPopover;
    [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
}



- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //    [_timerManager stop];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //判断登录与否显示导航栏左边按钮
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.isLogin == YES) {
        self.navUserImg.layer.borderColor = rgb(255, 255, 255, 0.8).CGColor;
        [self.navUserImg sd_setImageWithURL:[NSURL URLWithString:userModel.user.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
    }else {
        self.navUserImg.layer.borderColor = [UIColor clearColor].CGColor;
        [self.navUserImg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"index-user-icon.png"]];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //如果上次加载，首页无数据，下次进入首页时重新请求，如果上次请求成功，那么跳过请求
//    if (self.isNoHomeData == YES) {
        [self getHomePageInfoRequest];
//    }
    if ([[MsgCenterMgr sharedInstance] hasNewFriend]) {
        _bottomView.hasNewfbut.hidden = NO;
    }else {
        _bottomView.hasNewfbut.hidden = YES;
    }

    if ([QCHomeDataManager sharedInstance].ishasNewLoanMess == YES) {
        _middleView.hasNewfbut.hidden = NO;
    }else {
        _middleView.hasNewfbut.hidden = YES;
    }
    //消息数 小红点  显示
    NSInteger   mesNumber = [[[MsgCenterMgr sharedInstance] newMessageNumber] integerValue];
    if (mesNumber > 0) {
        [self.cuteView showView];
        if (mesNumber > 99) {
            self.cuteView.bubbleLabel.text = @"99";
        }else {
            self.cuteView.bubbleLabel.text = [NSString stringWithFormat:@"%ld",(long)mesNumber];
        }
    }else {
        [self.cuteView hiddenView];
    }
    
//    [self createHttpManager];
    if ([YXBTool getLoginYesOrNo]) {
        [self createHttpManager];
    }else{
        [self overdueViewHiddenOrNot:YES];
    }
    
    [self showRedView];


}

-(void)showRedView
{
    if ([[OverdueModel shareOverdueModel].showNewLoan isEqualToString:@"-1"]) {
        self.centerRedView.hidden = YES;
    }else {
        self.centerRedView.hidden = NO;
    }
    
//    if ([YXBTool getLoginYesOrNo]) {
//        [self createHttpManager];
//    }else{
//        [self overdueViewHiddenOrNot:YES];
//    }
    
}

- (void)dealloc {
    [_timerManager stop];
}

@end
