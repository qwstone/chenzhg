//
//  YXBHomeController.m
//  YOUXINBAO
//
//  Created by zjp on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "YXBHomeController.h"
#import "LoanOrRepayViewController.h"
#import "ImagePickerViewController.h"
#import "LoanSentSuccessfully.h"
#import "CTreasureMoneyViewController.h"
#import "TreasureMoneyNewViewController.h"
#import "BaoHongLiViewController.h"

#import "MoreInformationViewController.h"
#import "BillDetailViewController.h"
#import "YXBJieKuanController.h"
#import "YXBLoanCenterViewController.h"
#import "YXBTool.h"
#import "MsgCenterMgr.h"
#import "MsgCenterMgr+Public.h"
#import "OverdueModel.h"
#import "QCHomeDataManager.h"
#import "BorrowingShellsView.h"
#import "HomePopView.h"
#import "QCRegisterOneViewController.h"
#import "InvestListViewController.h"
#import "LiCaiViewOfHome.h"
#import "UIImage+GIF.h"

#define RootViewControllerRightInfoUrl @"webView/helpcenter/service.jsp?"

#define RootViewControllerleftInfoUrl [NSString stringWithFormat:@"%@webView/helpcenter/instruction.jsp?a=1",YXB_IP_address_web]

#define HomeHttpRequest_ADRESS   [NSString stringWithFormat:@"%@mobile/index.jsp?",YXB_IP_ADRESS];
@interface YXBHomeController ()<HomePopViewDelegate>
{
    AFHTTPRequestOperationManager *_httpManager;
    OverdueModel *_overdueModel;
    
    UIView *_overdueView;
    
    UIView *_overBgView;
    UIImageView*gif;
}
@end

@implementation YXBHomeController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.hidesBottomBarWhenPushed = NO;
    [self getHomePageInfoRequest];
    
    if ([YXBTool getLoginYesOrNo]) {
        [self createHttpManager];
    }else{
        [self overdueViewHiddenOrNot:YES];
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    
    postion = 0;
    
    [super viewDidLoad];
    [self createGuideChart];//引导图
    [self setTitle:@"无忧借条"];
    [self createNavBar];
    [self createData];
    [self createView];
    [self createOverdueView];//逾期弹框
    self.view.backgroundColor = [YXBTool colorWithHexString:@"#ededed"];
    
      }


- (void)createNavBar {
    [self setNavigationButtonItrmWithiamge:@"Aleft" withRightOrleft:@"left" withtargrt:self withAction:@selector(navLeftAction)];
    [self setNavigationButtonItrmWithiamge:@"kefuright" withRightOrleft:@"right" withtargrt:self withAction:@selector(navkefurightAction)];
}

- (void)navLeftAction {
    [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:RootViewControllerleftInfoUrl params:nil] hasTopBar:YES titleName:@"安全认证"];
}

-(void)navkefurightAction {
    NSString *url = [YXBTool getURL:RootViewControllerRightInfoUrl params:nil];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"首页说明"];
}
- (void)createData {

    self.homeTopData = [[NSMutableArray alloc] initWithCapacity:0];

}
- (void)createView {
    _tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-49) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.delaysContentTouches = NO;
    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = [YXBTool colorWithHexString:@"#ededed"];
    [self.view addSubview:_tableView];
    
    
    CGFloat line  = kDeviceWidth/750*10;
    
    self.bgview=[[UIView alloc]init];
    if (kDeviceWidth <= 320) {
        line  = kDeviceWidth/750*20;
    }


    
    _gonggao = [[GongGaoView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/750*58)];
    _gonggao.backgroundColor = rgb(202, 0, 0, 1);
    [self.bgview addSubview:_gonggao];
    gif = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/750*525,0,kDeviceWidth/750*85,kDeviceWidth/750*60)];
    NSData *data = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"aaa" ofType:@"gif"]];
    gif.image = [UIImage sd_animatedGIFWithData:data];
    
    _topView = [[NoticeScrollView alloc] initWithFrame:CGRectMake(0, kDeviceWidth/750*58, kDeviceWidth, kDeviceWidth/750*310)];
    [_topView.layer setMasksToBounds:YES];
    _topView.delegate = self;
    _topView.noticeImgnomel = @"Newbanner";
    [self.bgview addSubview:_topView];

    CGRect midFrame = CGRectMake(0, _topView.bottom, kDeviceWidth,kDeviceWidth/750*144+kDeviceWidth/640*357);
    if (kDeviceWidth <= 320) {
        midFrame = CGRectMake(0, _topView.bottom, kDeviceWidth,kDeviceWidth/750*180+kDeviceWidth/640*357);
    }
    _midView = [[HomeCtrMidView alloc] initWithFrame:midFrame];
    [self.bgview addSubview:_midView];
    //无忧理财
    _licaiNew = [[LiCaiViewOfHome alloc] initWithFrame:CGRectMake(0, _midView.bottom+line, kDeviceWidth, kDeviceWidth/640*216)];
    [self.bgview addSubview:_licaiNew];
    //失信大厅
    _homeofshixinView = [[HomeOfShiXinView alloc] initWithFrame:CGRectMake(0, _licaiNew.bottom+line, kDeviceWidth, kDeviceWidth/750*420)];
    [self.bgview addSubview:_homeofshixinView];

    _botView = [[HomeCtrBotView alloc] initWithFrame:CGRectMake(0, _homeofshixinView.bottom+line, kDeviceWidth, kDeviceWidth/750*264)];
    [self.bgview addSubview:_botView];

    self.bgview.frame=CGRectMake(0, 0, kDeviceWidth, _gonggao.height+_topView.height+_midView.height+_licaiNew.height+_homeofshixinView.height+_botView.height+line*3);
        _tableView.tableHeaderView = self.bgview;
    
    [_tableView setContentOffset:CGPointMake(0, self.tableView.bounds.size.height+7) animated:NO];

    [UIView animateWithDuration:1 animations:^{
        
        [_tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    }];
    [self createTimer];
}
//隐藏理财模块
- (void)setLicaidic:(NSDictionary *)licaidic {
    _licaidic = licaidic;
    NSString*show = licaidic[@"show"];
    CGFloat line  = kDeviceWidth/750*10;
   
    if ([show isEqualToString:@"1"]) {
        if (kDeviceWidth <= 320) {
            line  = kDeviceWidth/750*20;
        }
        _licaiNew.height = kDeviceWidth/640*216;
        _licaiNew.hidden = NO;
        _homeofshixinView.top=_licaiNew.bottom+line;
        _botView.top = _homeofshixinView.bottom+line;
        self.bgview.frame=CGRectMake(0, 0, kDeviceWidth, _gonggao.height+_topView.height+_midView.height+_licaiNew.height+_homeofshixinView.height+_botView.height+line*2);
        _tableView.tableHeaderView = self.bgview;
//        [_tableView setContentOffset:CGPointMake(0, self.bgview.height-_tableView.height) animated:NO];

    }else {
        _licaiNew.height = 0;
        _licaiNew.hidden = YES;
        _homeofshixinView.top=_midView.bottom+line;
        _botView.top = _homeofshixinView.bottom+line;
        self.bgview.frame=CGRectMake(0, 0, kDeviceWidth, _gonggao.height+_topView.height+_midView.height+_botView.height+_homeofshixinView.height+line);
        _tableView.tableHeaderView = self.bgview;
    }
}
//隐藏红包模块
- (void)setHongbaodic:(NSDictionary *)control {
    _hongbaodic = control;
    NSString* show = control[@"showRedBag"];
    CGFloat line  = kDeviceWidth/750*10;
    if (kDeviceWidth <= 320) {
        line  = kDeviceWidth/750*20;
    }
        if ([show isEqualToString:@"1"]) {
            _botView.hidden = NO;
            _botView.height = kDeviceWidth/750*264;
        self.bgview.frame=CGRectMake(0, 0, kDeviceWidth, _gonggao.height+_topView.height+_midView.height+_licaiNew.height+_homeofshixinView.height+_botView.height+line*2);
        _tableView.tableHeaderView = self.bgview;
       
        
    }else {
        _botView.height = 0;
        _botView.hidden = YES;
        self.bgview.frame=CGRectMake(0, 0, kDeviceWidth, _gonggao.height+_topView.height+_midView.height+_licaiNew.height+_botView.height+_homeofshixinView.height+line);
        _tableView.tableHeaderView = self.bgview;
       

    }
}



- (void)createGuideChart {
    
    QCDeviceModel *deviceM = [[QCDeviceManager sharedInstance] getDevieModel];
    
    if (deviceM.guideChart == nil || ![deviceM.guideChart isEqualToString:@"1"]) {
        
        NSArray *imgName = @[@"youxin2",@"youxin3"];
        if (kDeviceHeight == 480) {
            imgName = @[@"youxin2",@"yxb1"];
        }else if (kDeviceHeight == 568){
            imgName = @[@"youxin22",@"yxb11",];
        }else if (kDeviceHeight == 667){
            imgName = @[@"youxin222",@"yxb111"];
        }else if (kDeviceWidth > 375){
            imgName = @[@"youxin2222",@"yxb1111"];
        }else{
            imgName = @[@"youxin2222",@"yxb1111"];
        }

        UIWindow * window =[[[UIApplication sharedApplication] delegate] window] ;
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
//                [butt setBackgroundImage:[UIImage imageNamed:@"qdbut@6"] forState:UIControlStateNormal];
                [butt addTarget:self action:@selector(guideChartButAction) forControlEvents:UIControlEventTouchUpInside];
                [img addSubview:butt];
            }
            [_guideChartscrollView addSubview:img];
        }
        
    }
    
}
//公告页处理数据
-(NSMutableArray *)disposeArrayData:(NSMutableArray *)array content:(NSString *)content{
    
    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys: content, @"content", @"1" ,@"loanmark",nil];
    NSMutableArray * array1 = [[NSMutableArray alloc] initWithArray:array];
    [array1 addObject:dic];
    return array1;
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
    phoneNumVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:phoneNumVC animated:YES];
    
}
- (void)createTimer {
    _timerManager = [[CPBTimerManager alloc]initWithTimeInterval:3 userInfo:Nil repeats:YES];
    _timerManager.delegate = self;
    _timeHomeRequest = 0;
}

#pragma mark -- CPBTimerDelegate
- (void)CPBTimerManagerAction:(CPBTimerManager *)timer {
    if(self.gonggao.DataArray!=nil){
        [_gonggao addSubview:gif];
        gif.hidden=NO;
    postion++;
    if (postion >= self.gonggao.DataArray.count) {
        postion = 0;
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:postion inSection:0];
        [self.gonggao.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        postion++;
        NSIndexPath *scrollIndexPath1 = [NSIndexPath indexPathForRow:postion inSection:0];
        [self.gonggao.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath1 atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }else {
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:postion inSection:0];
        [self.gonggao.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    }
    else{
        NSLog(@"网络错误！");
        gif.hidden=YES;
    }
    
    [self.topView CPBTimerManagerAction];//滚动

    _timeHomeRequest++;
    //3秒一次  200次  十分钟
    if (_timeHomeRequest == 200) {
        _timeHomeRequest = 0;
        [self getHomePageInfoRequest];
    }
    
    if ([[MsgCenterMgr sharedInstance] hasNewFriend]) {
        [self.tabBarController.tabBar showBadgeOnItemIndex:1 number:0];
    }else {
        [self.tabBarController.tabBar hideBadgeOnItemIndex:1];
    }

    //昨日收益
    self.botView.str = [QCHomeDataManager sharedInstance].zuorishouyi;
    
//    if ([[OverdueModel shareOverdueModel].showNewLoan isEqualToString:@"-1"]) {
//        [self.tabBarController.tabBar hideBadgeOnItemIndex:3];
//    }else {
//        [self.tabBarController.tabBar showBadgeOnItemIndex:3];
//    }
    //消息数 小红点  显示
    NSInteger   mesNumber = [[[MsgCenterMgr sharedInstance] newMessageNumber] integerValue];
//    [self.tabBarController.tabBar showBadgeOnItemIndex:3 number:mesNumber];
    if (mesNumber > 0) {
        [self.tabBarController.tabBar showBadgeOnItemIndex:3 number:mesNumber];
    }else {
        [self.tabBarController.tabBar hideBadgeOnItemIndex:3];
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
              //失信大厅
           NSMutableArray *ShiXin = object[@"dishoestVal"];
            _homeofshixinView.DataArray=ShiXin;
            
            
            NSDictionary *licaidic = object[@"financial"];
            self.licaidic = licaidic;
            _licaiNew.dic = licaidic;
            
            NSDictionary  *control = object[@"control"];
            self.hongbaodic=control;
            
            QCHomeDataManager *manger = [QCHomeDataManager sharedInstance];
            [manger saveDataWithDic:control];
//            _gonggao.str = control[@"jkdes"];
            
            self.botView.str1 = control[@"nhhl"];
            self.botView.str2 = control[@"wfhl"];
            
            //首页广告数据
            NSMutableArray*guanggaoAry=object[@"recentlyLoans"];
             NSMutableArray * newArray = [self disposeArrayData:guanggaoAry content:control[@"jkdes"]];
            _gonggao.DataArray=[NSMutableArray arrayWithArray:newArray];
            
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

        } else {
            
        }
        [_tableView reloadDeals];

    }];
    
    [request setFailedBlock:^{
        NSLog(@"首页请求失败");
        CGFloat line  = kDeviceWidth/750*10;
        if (kDeviceWidth <= 320) {
            line  = kDeviceWidth/750*20;
        }
        _botView.height = 0;
        _botView.hidden = YES;
        _licaiNew.height = 0;
        _licaiNew.hidden = YES;
        _homeofshixinView.top=_midView.bottom+line;
        _botView.top = _homeofshixinView.bottom+line;
        self.bgview.frame=CGRectMake(0, 0, kDeviceWidth, _gonggao.height+_topView.height+_midView.height+_botView.height+_homeofshixinView.height+line);
        _tableView.tableHeaderView = self.bgview;

        if (self.homeTopData != nil) {
            [self.homeTopData removeAllObjects];
        }
        [_tableView reloadDeals];
    }];
    
    [request startAsynchronous];
    NSLog(@"request.requestHeaders---%@",request.requestHeaders);
    
}


#pragma mark ----- HomeTopScorllViewDelegate
- (void)HomeTopScorllViewAction:(NSInteger)index info:(NSString *)info type:(NSString *)type{
    [YXBTool typeToJump:type info:info];
}
#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self getHomePageInfoRequest];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
    [bgimgView addSubview:overdueCancleBtn];
    
    UIButton *overdueRepayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    overdueRepayBtn.frame = CGRectMake(20, 248-70, 294-40, 70);
    [overdueRepayBtn addTarget:self action:@selector(overdueRepayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgimgView addSubview:overdueRepayBtn];
    
}
-(void)overdueCancleBtnClick{
    NSLog(@"取消");
    _overBgView.hidden = YES;
    _overdueView.hidden = YES;
}
-(void)overdueRepayBtnClick{
    NSLog(@"还款");
    [YXBTool typeToJump:@"loanV2" info:_overdueModel.loanDetail2];
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
    __weak YXBHomeController *this = self;
    [_httpManager POST:str parameters:dic  success:^(AFHTTPRequestOperation *operation, id responseobject) {
        
        [this jiexi:responseobject];
        
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"yuqihttp_error:%@",error);
    }];
}
-(void)jiexi:(NSDictionary *)dict{
    _overdueModel = [OverdueModel shareOverdueModel];
    _overdueModel.needPop = [[dict objectForKey:@"needPop"] integerValue];
    _overdueModel.loanDetail2 = [dict objectForKey:@"loanDetail2"];
    if ((!_overdueModel.showNewLoan) || [_overdueModel.showNewLoan isEqualToString:@"-1"])
    {
        _overdueModel.showNewLoan = [dict objectForKey:@"showNewLoan"];
        
    }
    
    [self overdueViewHiddenOrNot:(![[dict objectForKey:@"needPop"] integerValue]==1)];
    
    //显示个人中心小红点
//    [self showRedView];
}


@end
