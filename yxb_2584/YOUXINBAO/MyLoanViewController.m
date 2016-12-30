//
//  MyLoanListViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 16/2/16.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.


#import "MyLoanViewController.h"
#import "ILAlertView.h"
#define UPDATE_TIME 5.0f


@interface MyLoanViewController ()
{
    BOOL _hasSelectedDialog;//是否选择过对话语境模板
    BOOL _flag;//判断是不是需要滚动最后一条对话
    NSString *compensationMoney;
    NSString *daleyTime;
    
    NSString *newlixi;
    NSString *Timestr;
}


@property (nonatomic,weak)MyLoanListDialogBgView *bgView;
@property (nonatomic,weak)QCBaseTableView *myTableView;
@property (nonatomic,weak)MyLoanListBottomView *bottomView;
@property (nonatomic,weak)UIImageView *checkMoreImgView;
@property (nonatomic,strong)NSMutableArray *dialogArray;//对话List
@property (nonatomic,strong)NSMutableArray *dialogTextArray;//对话文字模板List
@property (nonatomic,strong)YXBLoanInfoDetails *loanInforDetailsModel;
@property (nonatomic,strong)Payment_loanPayPartLoan *Payment_loanPayPartLoanModel;
@property (nonatomic,strong)YanqiView    *yanqi;
@property (nonatomic,strong)BuFenJieKuan *bufenjiekuan;
@property (nonatomic,strong)QCConsultLixiView * consultlixi;

//同意并支付索要视频弹框是否需要录制视频
@property (nonatomic,assign)BOOL requireVideoSelected;
@property (nonatomic,weak) MyLoanCuishouAlert *cuishouAlert;
@property (nonatomic, strong) NSTimer * updateDialogTimer;
@property (nonatomic, strong) NSString * title;
@end

@implementation MyLoanViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        _hasSelectedDialog = NO;
        //默认为需要视频认证
        _requireVideoSelected = YES;
        _dialogArray = [[NSMutableArray alloc] init];
        _dialogTextArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.hidden=NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
    //加入定时器   5秒刷新一次聊天
    self.updateDialogTimer = [NSTimer scheduledTimerWithTimeInterval: UPDATE_TIME target:self selector:@selector(updateDialogData) userInfo:nil repeats:YES];
    [self starTimer];

}
 //启动定时器
-(void)starTimer{
    //开启定时器
    self.updateDialogTimer.fireDate=[NSDate distantPast];
    
}
 //暂停定时器
-(void)stopTimer{
    self.updateDialogTimer.fireDate=[NSDate distantFuture];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.myTableView) {
        [self.myTableView beginRefreshing];
    }
    if (_cuishouAlert!=nil) {
        _cuishouAlert.hidden = NO;
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.updateDialogTimer invalidate];
    self.updateDialogTimer = nil;
//    [self stopTimer];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的借条";
    [self initUI];
    [self setLeftView];
//    //注册利息修改通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Moditylixi:) name:@"Moditylixi" object:nil];
}


-(void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Moditylixi" object:nil];
}



-(void)initUI{
    [self createBgView];
    [self createTableView];
    [self createBottomView];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//    [self.myTableView addGestureRecognizer:tap];
}
-(void)createRightNav{
    if (self.type == 0) {
        UIImage *rightImg = [UIImage imageNamed:@"myLoan_qugongzheng"];
        UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
        right.frame = CGRectMake(0, 0, rightImg.size.width, rightImg.size.height);
        [right setImage:rightImg forState:UIControlStateNormal];
        [right addTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:right];
        
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}
//对话框部分的背景框图
-(void)createBgView{
   MyIOUHeaderView *headerView =[[MyIOUHeaderView alloc]initWithFrame:CGRectMake(15, 13, kDeviceWidth-30, 190)];
    headerView.delegateTwo=self;
    headerView.tag=1001;
    [self.view addSubview:headerView];
    MyLoanListDialogBgView *tbgView = [[MyLoanListDialogBgView alloc] initWithFrame:CGRectMake(15.5, headerView.bottom, kDeviceWidth-31, kDeviceHeight-64-headerView.height-67)];
    tbgView.delegate = self;
    self.bgView = tbgView;
    [self.view addSubview:_bgView];

    //查看更多
    CGFloat sWidth = tbgView.width;
    UIImageView *topImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyLoanList_checkMore"]];
    topImgView.frame = CGRectMake(0, 7, topImgView.image.size.width, topImgView.image.size.height);
    topImgView.center = CGPointMake(sWidth/2.0, topImgView.center.y);
    [_bgView addSubview:topImgView];
    _checkMoreImgView = topImgView;
}
//创建对话tableview
-(void)createTableView{
    QCBaseTableView *tMyTableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(1, _checkMoreImgView.bottom+7,_bgView.width-2, _bgView.height-57/2.0-_checkMoreImgView.bottom-7) style:UITableViewStylePlain refreshFooter:NO];
    
    tMyTableView.delegate = self;
    tMyTableView.dataSource = self;
    tMyTableView.refreshDelegate = self;
    [tMyTableView reloadDeals];
    
    tMyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tMyTableView.showsHorizontalScrollIndicator = YES;
    tMyTableView.showsVerticalScrollIndicator = YES;
    
    
    [self.bgView addSubview:tMyTableView];
    self.myTableView = tMyTableView;
    
    
    //添加手势  用于收起键盘
    UITapGestureRecognizer * tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TableviewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.myTableView addGestureRecognizer:tableViewGesture];
}
//创建底部按钮
-(void)createBottomView{
    MyLoanListBottomView *bottomView = [[MyLoanListBottomView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-42-64, kDeviceWidth, 42)];
    bottomView.delegate = self;
    [self.view addSubview:bottomView];
    _bottomView = bottomView;
}
//处理  从视频页面跳转过来view整体下移
- (void)setIsFromVideo:(BOOL)isFromVideo{

    _isFromVideo=isFromVideo;
    
    if (_isFromVideo&&[[[UIDevice currentDevice] systemVersion] floatValue]>8.0) {
        MyIOUHeaderView *view=[self.view viewWithTag:1001];
        view.frame=CGRectMake(15, 13+64, kDeviceWidth-30, 190);
        
        _bgView.frame=CGRectMake(15.5, view.bottom, kDeviceWidth-31, kDeviceHeight-64-view.height-67);
        _bottomView.frame=CGRectMake(0, kDeviceHeight-42-64+64, kDeviceWidth, 42);
    }else{
        MyIOUHeaderView *view=[self.view viewWithTag:1001];
        view.frame=CGRectMake(15, 13, kDeviceWidth-30, 190);
        
        _bgView.frame=CGRectMake(15.5, view.bottom, kDeviceWidth-31, kDeviceHeight-64-view.height-67);
        _bottomView.frame=CGRectMake(0, kDeviceHeight-42-64, kDeviceWidth, 42);
    
        
    }
}
//数据请求后刷新整个界面
-(void)refreshAllUIWith:(YXBLoanInfoDetails *)model{
    
    if ([model.showAC isEqualToString:@"1"]) {
        [self createRightNav];
    }
    //刷新头部借款信息
    MyIOUHeaderView *view=(MyIOUHeaderView *)[self.view viewWithTag:1001];
    
    view.model=model;
    
    _dialogArray = self.loanInforDetailsModel.iYXBLoanDialogue;
    _dialogTextArray = self.loanInforDetailsModel.iYXBLoanChat;
    
    //	是否可以输入文字聊天
    [_bgView setCaninput:[model.canInput integerValue]];
    //对话
    _bgView.dataArray = _dialogTextArray;
    _flag = YES;
    [self.myTableView reloadData];
    if (self.myTableView.contentSize.height>_myTableView.height) {
        [self.myTableView setContentOffset:CGPointMake(0, _myTableView.contentSize.height-_myTableView.height)];
    }

    if((model.requestPersonIsLender == 1&&(model.loanState == 14||model.loanState == 11||model.loanState == 13||model.loanState == 18))||[model.bottomButtonID isEqualToString:@""]){//放款人
        
        _bgView.frame=CGRectMake(15.5, view.bottom, kDeviceWidth-31, kDeviceHeight-64-view.height-67+42);
        [_bgView updateRectViewWithFrame:_bgView.frame];
        
        _myTableView.frame = CGRectMake(1, _checkMoreImgView.bottom+7,_bgView.width-2, _bgView.height-57/2.0-_checkMoreImgView.bottom-7);
        
        _bottomView.frame=CGRectMake(0, kDeviceHeight-64, kDeviceWidth, 42);
        
        _bottomView.hidden = YES;
    }else{
        //底部按钮
        _bottomView.hidden = NO;
        NSArray *array = [model.bottomButtonID componentsSeparatedByString:@"|"]; //从字符A中分隔成2个元素的数组
        [_bottomView displayWithBtnIds:array];
    }
}
//完善信息
- (void)toAuthentication {
    
    AuthenticationViewController *authentic = [[AuthenticationViewController alloc] init];
    [self.navigationController pushViewController:authentic animated:YES];
}



//#pragma mark ---------------- 利息修改通知
//-(void)Moditylixi:(NSNotification*)info
//{
//    consultlixi = [info.userInfo objectForKey:@"newlixi"];
//    [self httpConsultLixiRequest];
//}



//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//}


#pragma mark - 点击tableview收起键盘
-(void)TableviewTouchInSide{
    [self.view endEditing:YES];
}



#pragma mark ------------------------------Action

//更多信息被点击
- (void)moreInforButtonDidClick{
    
    MoreInformationViewController *moreInfo=[[MoreInformationViewController alloc]init];
    moreInfo.loanId=self.loanInforDetailsModel.loanID;
    [self.navigationController pushViewController:moreInfo animated:YES];
}

//修改利息按钮被点击
- (void)consultButtonDidClick{
    [self stopTimer];
    self.consultlixi = [[QCConsultLixiView alloc] initWithFrame:[[UIApplication sharedApplication].delegate window].bounds];
    _consultlixi.delegate = self;
    self.consultlixi.model = _loanInforDetailsModel;
    [self.consultlixi setdata];
    [[UIApplication sharedApplication].keyWindow addSubview:self.consultlixi];

}


//利息修改提交
- (void)ConsultlixiConfirmClick:(NSString *)_newlixi
{
    newlixi = _newlixi;
    [self httpConsultLixiRequest];
}
//导航左侧按钮被点击
- (void)leftClicked {
    
    NSArray *ctrlArray = self.navigationController.viewControllers;
    
    for (UIViewController *ctrl in ctrlArray) {
        if ([ctrl isKindOfClass:[YXBLoanCenterViewController class]]) {
            [self.navigationController popToViewController:ctrl animated:YES];
            return;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)rightClicked1{
//    YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
//    NSString*fuwufei;
//    if (([loan.money integerValue]>=100)&&([loan.money integerValue]<=5000))
//    {
//        fuwufei=@"2";
//    }
//    else  if (([loan.money integerValue]>5000)&&([loan.money integerValue]<=10000))
//    {
//        fuwufei=@"5";
//    }
//    if ([loan.money integerValue]>10000)
//    {
//        fuwufei=@"10";
//    }
//    
//    NSString *AlertMessage = [NSString stringWithFormat:@"借款成功后无忧借条将收取%@元服务费",fuwufei];
//    
//    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:AlertMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    alterView.tag = queRenShouKuan;
//    [alterView show];
//
//   
//}
-(void)rightClicked{
     [YXBTool jumpSafariWithUrl:_loanInforDetailsModel.acUrl];
    
}

#pragma mark - MyLoanListBottomViewDelegate 底部按钮点击
-(void)bottomClickedBtnId:(myLoanListBottomImgCode)bottomBtnId{
    
    
    //完善信息
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.user.accountStatus == 0) {
        [self toAuthentication];
        return;
    }
    
    NSLog(@"bottomBtnId========%d",bottomBtnId);
    self.bgView.myTableViewHidd = YES;
    [self.bgView myTableViewHidden:YES];
    switch (bottomBtnId) {
        case quLuZhiShiPin:
        case chongXinLuZhiShiPin:{//去录制视频、重新录制视频
            
            ImagePickerViewController *imgPic=[[ImagePickerViewController alloc]init];
            imgPic.isNoOnce=self.isFromVideo;
            imgPic.verifyText = self.loanInforDetailsModel.videoReadStr;
            imgPic.loanId=self.loanInforDetailsModel.loanID;
            [self.navigationController pushViewController:imgPic animated:YES];
        }break;
        case quShenHeShiPin:{//去审核视频
            [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:self.loanInforDetailsModel.videoReviewUrl params:nil] hasTopBar:YES titleName:@"审核视频" type:4];
        }break;
        case tongYiBingZhiFu:{//同意并支付
            [self secondSureAlert];
        }break;
        case canRenJuJue:{//残忍拒绝
            NSString *mes = [NSString stringWithFormat:@"权衡利弊，决定靠义气！确认拒绝%@的借款请求吗？",self.loanInforDetailsModel.borrowName];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:mes delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            alert.tag = 3000;
            [alert show];
        }break;
        case woYaoHuanKuan://我要还款
        case woYaoHuanKuanLong:{
            [self jumpToPayWithNeedVideo:NO andOperationType:@"1"];
        }break;
        case dianHuaLianXi:{//电话联系
            
            [YXBTool callTelphoneWithNum:self.loanInforDetailsModel.contactNumber];
        }break;
        case faQiXinJieKuan:{//发起新借款
            YXBJieKuanController *controller = [[YXBJieKuanController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }break;
        case shenQingYanQi:{//申请延期
            [self stopTimer];
            [self shenQingYanQiAlertView];
        }break;
        case cuiShouFuWu:{//催收服务
            if ([_loanInforDetailsModel.isYxbUrge isEqualToString:@"0"]) {//弹框
                [self cuiShouAlertView];
                
            }else{//直接跳转
                NSString *url = [NSString stringWithFormat:@"%@%@",YXB_IP_ADRESS,_loanInforDetailsModel.urgeRecordUrl];
                [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"催收进度"];
            }

        }break;
        case canRenJuJueLong:{
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"您修改了利息，正等待对方回复，是否确定拒绝借款给TA？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 3004;
            [alert show];
        }break;
        case queRenShouKuan:{
                        NSString*fuwufei;
            if (([self.loanInforDetailsModel.money integerValue]>=100)&&([self.loanInforDetailsModel.money integerValue]<=5000))
            {
                fuwufei=@"2";
            }
            else  if (([self.loanInforDetailsModel.money integerValue]>5000)&&([self.loanInforDetailsModel.money integerValue]<=10000))
            {
                fuwufei=@"5";
            }
            if ([self.loanInforDetailsModel.money integerValue]>10000)
            {
                fuwufei=@"10";
            }
            
           
            NSString *AlertMessage = [NSString stringWithFormat:@"借款成功后无忧借条将收取 %@ 元服务费",fuwufei];
            [ILAlertView showWithTitle:nil
                               message:AlertMessage
                      closeButtonTitle:@"确定"
                     secondButtonTitle:@"取消"
                    tappedSecondButton:^{
                        [self httpClickedBottomBtnRequestWithBtnId:queRenShouKuan];}];
            ILAlertView *alterView = [[ILAlertView alloc] init];
//            [alterView show];
           
               

            alterView.tag = 3008;
            
        }break;
            
        case queRenYiShouKuanxianxia:{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"请务必确认是否收到对方还款，否则造成您的财产损失无法挽回。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag = 3009;
            [alert show];
        }break;

        default:{
            [self httpClickedBottomBtnRequestWithBtnId:bottomBtnId];
            
        }break;
    }
}
-(void)cuiShouAlertView{
    CGFloat tw = kDeviceWidth==320?kDeviceWidth-60:280;
    CGFloat th = kDeviceWidth==320?155+35:155+45;
    MyLoanCuishouAlert *alert = [[MyLoanCuishouAlert alloc] initWithFrame:CGRectMake(0, 0, tw, th) delegate:self btnHeight:50 cancleBtnTitle:@"取消" otherBtnTitle:@[@"确认"]];
    
    [alert setMessageWithLenderName:_loanInforDetailsModel.lendName BorrowName:_loanInforDetailsModel.borrowName];
    alert.tag = 2300;
    alert.delegat = self;
    _cuishouAlert = alert;
    [alert alertShow];
}
#pragma mark-申请延期弹框
-(void)shenQingYanQiAlertView{
    _yanqi = [[YanqiView alloc] initWithFrame:[[UIApplication sharedApplication].delegate window].bounds];
    _yanqi.HuanKuanTimestr=_loanInforDetailsModel.payBackTime;
    //应还本金
    UILabel *moneyLabel=[_yanqi.whiteView viewWithTag:190002];
     NSString*totalNeedRepay=self.loanInforDetailsModel.money;
    moneyLabel.text=[NSString stringWithFormat:@"%@",totalNeedRepay ];
    //利息&补偿
    NSString*lixibuchangstr=self.loanInforDetailsModel.interestAndBc;
    UILabel *lixibuchang=[_yanqi.whiteView viewWithTag:200002];
    lixibuchang.text=[NSString stringWithFormat:@"%@",lixibuchangstr ];
    
    //延期一个月
    NSArray *array = [[NSMutableString stringWithString:self.loanInforDetailsModel.payBackTime] componentsSeparatedByString:@"-"];
    NSString *month;
    NSString *year;
    if ([array[1] integerValue]>=9&&[array[1] integerValue]<12) {
        year=[NSString stringWithFormat:@"%ld",(long)[array[0] integerValue]];
        month=[NSString stringWithFormat:@"%ld",(long)[array[1] integerValue]+1];
    }
    else if ([array[1] integerValue]>0&&[array[1] integerValue]<9){
        year=[NSString stringWithFormat:@"%ld",(long)[array[0] integerValue]];
        month=[NSString stringWithFormat:@"0%ld",(long)[array[1] integerValue]+1];
    }
    else{
        year=[NSString stringWithFormat:@"%ld",(long)[array[0] integerValue]+1];
        month=@"01";
    }
    NSString *str=[NSString stringWithFormat:@"%@-%@-%@",year,month,array[2]];
    _yanqi.DataTimestr=str;
       
    UIButton *TimeBtn=[_yanqi.Timebtn viewWithTag:9000001];
     [TimeBtn setTitle:str forState:UIControlStateNormal];
    _yanqi.delegate=self;
   [[[UIApplication sharedApplication].delegate window] addSubview:_yanqi];
}
#pragma mark-部分还款延期弹框
-(void)BuFenHuanKuanAlertView{
    _bufenjiekuan = [[BuFenJieKuan alloc] initWithFrame:[[UIApplication sharedApplication].delegate window].bounds];
    //应还本金
    UILabel *moneyLabel=[_bufenjiekuan.whiteView viewWithTag:1990002];
    NSString*totalNeedRepay=self.loanInforDetailsModel.money;
    moneyLabel.text=[NSString stringWithFormat:@"%@",totalNeedRepay ];
    //利息&补偿
    NSString*lixibuchangstr=self.loanInforDetailsModel.interestAndBc;
    UILabel *lixibuchang=[_bufenjiekuan.whiteView viewWithTag:2200002];
    lixibuchang.text=[NSString stringWithFormat:@"%@",lixibuchangstr];
    
     _bufenjiekuan.HuanKuanTimestr=_loanInforDetailsModel.payBackTime;
    //延期一个月
    NSArray *array = [[NSMutableString stringWithString:self.loanInforDetailsModel.payBackTime] componentsSeparatedByString:@"-"];
    NSString *month;
    NSString *year;
    if ([array[1] integerValue]>=9&&[array[1] integerValue]<12) {
        year=[NSString stringWithFormat:@"%ld",(long)[array[0] integerValue]];
        month=[NSString stringWithFormat:@"%ld",(long)[array[1] integerValue]+1];
    }
    else if ([array[1] integerValue]>0&&[array[1] integerValue]<9){
        year=[NSString stringWithFormat:@"%ld",(long)[array[0] integerValue]];
        month=[NSString stringWithFormat:@"0%ld",(long)[array[1] integerValue]+1];
    }
    else{
        year=[NSString stringWithFormat:@"%ld",(long)[array[0] integerValue]+1];
        month=@"01";
    }
    NSString *str=[NSString stringWithFormat:@"%@-%@-%@",year,month,array[2]];
    _bufenjiekuan.DataTimestr=str;
    Timestr=str;
    UIButton *TimeBtn=[_bufenjiekuan.Timebtn viewWithTag:9000001];
    [TimeBtn setTitle:str forState:UIControlStateNormal];
    _bufenjiekuan.delegate=self;
    [[[UIApplication sharedApplication].delegate window] addSubview:_bufenjiekuan];
}

//同意并支付弹框
-(void)secondSureAlert{


    if (self.loanInforDetailsModel.agreePayConfirmMode==0) {//普通
        NSString *mes = [NSString stringWithFormat:@"确认同意借钱给%@吗?",self.loanInforDetailsModel.borrowName];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:mes delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alert.tag = 3001;
        [alert show];
    }else if(self.loanInforDetailsModel.agreePayConfirmMode==1){//索要视频
        NSString *str = [NSString stringWithFormat:@"确认同意借钱给%@吗?",self.loanInforDetailsModel.borrowName];
        CGFloat tw = kDeviceWidth==320?kDeviceWidth-60:280;
        CGFloat th = kDeviceWidth==320?155+35:155+45;
        MyLoanListRequireVideoAlert *alert = [[MyLoanListRequireVideoAlert alloc] initWithFrame:CGRectMake(0, 0, tw, th) delegate:self btnHeight:50 cancleBtnTitle:@"取消" otherBtnTitle:@[@"确认"]];
        alert.titleStr = str;
        alert.delegat = self;
        [alert alertShow];
    }else{//有逾期未还行为
        NSString *mes = [NSString stringWithFormat:@"TA当前有2笔借款逾期未还，请慎重借款！确定借款给%@吗?",self.loanInforDetailsModel.borrowName];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:mes delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 3002;
        [alert show];
    }
}
#pragma mark - UIAlertViewDelegate
//残忍拒绝，同意并支付（普通、信用不好）
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {//确认
        
        if (alertView.tag==3000) {//残忍拒绝
            [self httpClickedBottomBtnRequestWithBtnId:canRenJuJue];
        }else if (alertView.tag==3001){//同意并支付(低额)
            [self jumpToPayWithNeedVideo:NO andOperationType:@"0"];
        }else if (alertView.tag == 3002){//同意并支付(对方信用不好)
            [self jumpToPayWithNeedVideo:YES andOperationType:@"0"];
        }else if (alertView.tag == 3003){//催款超过3次
            [YXBTool callTelphoneWithNum:self.loanInforDetailsModel.contactNumber];
        }
        else if (alertView.tag == 3004){//残忍拒绝Long
            [self httpClickedBottomBtnRequestWithBtnId:canRenJuJueLong];
        }
        else if (alertView.tag == 3009){//线下收款
            [self httpClickedBottomBtnRequestWithBtnId:queRenYiShouKuanxianxia];
        }
        

    }
}
-(void)ctAlertView:(CTAlertView *)alertView didClickedBtnAtIndex:(NSInteger)index{
    
    if (index==1) {
        if (alertView.tag == 2300) {//催收
            NSString *url = [NSString stringWithFormat:@"%@%@",YXB_IP_ADRESS,_loanInforDetailsModel.urgeRecordUrl];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"催收进度"];
        }else{
            [self jumpToPayWithNeedVideo:_requireVideoSelected andOperationType:@"0"];
        }
    }
}
//索要视频按钮选中？
-(void)ctAlertVideoBtnSelected:(BOOL)selected{
    _requireVideoSelected = selected;
    
    
}
//同意催收服务协议按钮选中？
-(void)ctAlertAgreeBtnSelected:(BOOL)selected{
    _cuishouAlert.hidden = YES;
    NSString *urlStr = [NSString stringWithFormat:@"%@webView/helpcenter/agreement-cs.jsp",YXB_IP_ADRESS];
    [YXBTool jumpInnerSafaryWithUrl:urlStr hasTopBar:NO titleName:nil];
}
#pragma mark-申请延期确认提交服务器
- (void)YanqiConfirmClick{
    if ([_yanqi.textFiled2.text isEqualToString:@""]||[_yanqi.Timebtn.titleLabel.text isEqualToString:@"请选择时间"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您尚有内容未填写" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        compensationMoney=_yanqi.textFiled2.text;
        daleyTime=_yanqi.Timebtn.titleLabel.text;
        [self httpApplyYanqiRequest];
    }
}
#pragma mark-部分还款确认提交服务器
- (void)BuFenJieKuanConfirmClick{
    if ([_bufenjiekuan.textFiled2.text isEqualToString:@""]||[_bufenjiekuan.Timebtn.titleLabel.text isEqualToString:@"请选择时间"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您尚有内容未填写" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
         _bufenjiekuan.hidden=YES;
        self.title = @"付款单";
        _Payment_loanPayPartLoanModel = [[Payment_loanPayPartLoan alloc] init];
//        _Payment_loanPayPartLoanModel.loanId=
//         NSString*repayMoney=_Payment_loanPayPartLoanModel.repayMoney;
        _Payment_loanPayPartLoanModel.loanId=[NSString stringWithFormat:@"%ld",(long)self.loanInforDetailsModel.loanID];
        _Payment_loanPayPartLoanModel.repayMoney=_bufenjiekuan.textFiled2.text;
        
       _Payment_loanPayPartLoanModel.bcj=_bufenjiekuan.textFiled1.text;
        _Payment_loanPayPartLoanModel.repayDate=Timestr;
        NSString *url = [YXBPaymentUtils getFullWebUrl:_Payment_loanPayPartLoanModel];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"付款单"];

               
    }
}

//跳转支付界面
-(void)jumpToPayWithNeedVideo:(BOOL)needVideo andOperationType:(NSString *)operationType{
    Payment_loanPayCgLoanV2 *payModel = [[Payment_loanPayCgLoanV2 alloc] init];
    payModel.loanId=self.loanInforDetailsModel.loanID;
    payModel.operationType=operationType;
    payModel.needVideo=needVideo?@"1":@"0";
    NSString *url = [YXBPaymentUtils getFullWebUrl:payModel];

    self.title = nil;
    if ([operationType integerValue]==0) {//付款
        self.title = @"付款单";
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:self.title type:3];
    }else{//还款
        UIActionSheet *titleSheet = [[UIActionSheet alloc] initWithTitle:@"我要还款" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"我要全部还款",@"我要部分还款", nil];
        [titleSheet showInView:self.view];
       
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
         self.title = @"还款详情";
        Payment_loanPayCgLoanV2 *payModel = [[Payment_loanPayCgLoanV2 alloc] init];
        NSString *url = [YXBPaymentUtils getFullWebUrl:payModel];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:self.title type:3];
       
    }else if (buttonIndex == 1) {
        [self BuFenHuanKuanAlertView];
        
    }
    
}

#pragma mark - MyLoanListDialogBgViewDelegate 点击发送按钮

-(void)inputTextViewChangedHeight:(CGFloat)height
{
    [_myTableView setFrame:CGRectMake(1, _checkMoreImgView.bottom+7,_bgView.width-2, _bgView.height-height-_checkMoreImgView.bottom-7)];
}




-(void)sendBtnWasClickedWithChatType:(NSInteger)chatType content:(NSString *)content{
//    NSLog(@"sending......");
//    NSLog(@"%ld",[content integerValue]);
    //会话类型 1.固定会话 2.输入会话
    if (chatType == 1) {
        YXBLoanChat *chatModel = [_dialogTextArray objectAtIndex:[content integerValue]];
        [self httpSendMesRequestWithChatType:chatType Content:chatModel.textNum];
    }
    else{
        //2输入会话
        [self httpSendMesRequestWithChatType:chatType Content:content];
    }
}
-(void)dialogTextDidSelectedAtIndex:(NSInteger)index{
    _hasSelectedDialog = YES;
    if (_dialogTextArray.count>index) {
        YXBLoanChat *chatModel = [_dialogTextArray objectAtIndex:index];
        _bgView.inputTextview.text = chatModel.text;
        
        
        CGFloat sHeight = _bgView.frame.size.height;
        CGFloat sWidth = _bgView.frame.size.width;

        [_bgView.rectView setFrame:CGRectMake(0, sHeight-57.0/2, sWidth, 57.0/2)];
        _bgView.sendBtn.frame = CGRectMake(sWidth-62, 0, 62, 57.0/2);
        _bgView.dialogBtn.frame = CGRectMake(0, 0, 75, 57.0/2);
        [_bgView.inputTextview setFrame:CGRectMake(_bgView.dialogBtn.right-2, 0, sWidth-_bgView.dialogBtn.width-_bgView.sendBtn.width+2, 57.0/2)];
        

    }
}
//点击空白处隐藏对话弹框
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _bgView.myTableViewHidd = YES;
    [_bgView myTableViewHidden:YES];
}
-(void)tapAction{
    self.bgView.myTableViewHidd = YES;
    [self.bgView myTableViewHidden:YES];
}

#pragma mark - 定时器刷新聊天内容
- (void)updateDialogData
{
    //判断当前网络状态  没网情况下不刷新   无需关闭定时器
    if ([YXBTool isConnectionAvailable]) {
        [self httpDowloadWithListStyle];
    }
}

#pragma mark - QCBaseTableViewDelegate
//下拉刷新
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView{
    
    if (_dialogArray.count) {
        [_dialogArray removeAllObjects];
    }
    if (_dialogTextArray.count) {
        [_dialogTextArray removeAllObjects];
    }
    [self httpDowloadWithListStyle];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dialogArray.count;
}


//czg
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YXBLoanDialogue *model = nil;
    if (_dialogArray.count) {
        model = [_dialogArray objectAtIndex:indexPath.row];
    }
    //对话框类型 1文字语言对话框; 2图片; 3申请延期;5输入会话
    if([model.dialogueMode isEqualToString:@"1"]){//1文字语言对话框;
        
        MyLoanListTableViewOneCell *cell = [MyLoanListTableViewOneCell MyLoanListTableViewOneCellWithTableView:tableView];
        cell.model = model;
        return cell;
    }
    else if ([model.dialogueMode isEqualToString:@"2"]){//2图片
        MyLoanListTableViewTwoCell *cell = [MyLoanListTableViewTwoCell MyLoanListTableViewTwoCellWithTableView:tableView];
        cell.model = model;
        __weak MyLoanViewController *this = self;
        cell.updateVideoClicked = ^{
            if (this.loanInforDetailsModel.requestPersonIsLender == 1&&this.loanInforDetailsModel.loanState == 9) {
                [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:this.loanInforDetailsModel.videoReviewUrl params:nil] hasTopBar:YES titleName:@"审核视频" type:5];
            }else{
                [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:this.loanInforDetailsModel.videoReviewUrl params:nil] hasTopBar:YES titleName:@"播放视频" type:5];
            }
        };
        return cell;
        
    }
    else if ([model.dialogueMode isEqualToString:@"3"]){//3申请延期
        MyLoanListTableViewThreeCell *cell = [MyLoanListTableViewThreeCell MyLoanListTableViewThreeCellWithTableView:tableView];
        cell.model = model;
        return cell;

           }
    else if ([model.dialogueMode isEqualToString:@"6"]){//6申请部分还款
        MyLoanListTableViewFiveCell *cell = [MyLoanListTableViewFiveCell MyLoanListTableViewFiveCellWithTableView:tableView];
        cell.model = model;
        return cell;
        
    }
    else if ([model.dialogueMode isEqualToString:@"5"]){
        
        MyLoanListTableViewOneCell * cell = [MyLoanListTableViewOneCell MyLoanListTableViewOneCellWithTableView:tableView];
//        MyLoanListTableViewFiveCell *cell = [MyLoanListTableViewFiveCell MyLoanListTableViewFiveCellWithTableView:tableView];
        cell.model = model;
        return cell;
    }
    else{//利息协商
        MyLoanListTableViewFourCell *cell = [MyLoanListTableViewFourCell MyLoanListTableViewFourCellWithTableView:tableView];
        cell.model = model;
        return cell;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dialogArray.count) {
        YXBLoanDialogue *model = [_dialogArray objectAtIndex:indexPath.row];
        if ([model.dialogueMode integerValue]==1  || [model.dialogueMode integerValue] == 5) {//文字
            CGSize size = [YXBTool getFontSizeWithString:model.var1 font:[UIFont systemFontOfSize:11.1] constrainSize:CGSizeMake(133, 10000)];
            return size.height+45+25;
        }else if ([model.dialogueMode integerValue]==2){//图片
            return 168.0/2.0+10;
        }else if ([model.dialogueMode integerValue]==3 || [model.dialogueMode integerValue] == 6){//申请延期 部分还款
            return 190;
        }
        else{
            return 120;
        }
    }
    return 44.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_myTableView.contentOffset.y <= 0) {
        _checkMoreImgView.hidden = YES;
    }else{
        _checkMoreImgView.hidden = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
#pragma mark ------------- 数据请求  ----------------

#pragma mark - http---获取我的借条信息
- (void)httpDowloadWithListStyle{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak MyLoanViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
        
    } complete:^(LoanMoreInfo * r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation{
    LoanManagerV10 *manager = (LoanManagerV10 *)[httpOperation getAopInstance:[LoanManagerV10 class] returnValue:[YXBLoanInfoDetails class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {
        
        [manager getLoanInfoDetailsV2:userToken loanID:self.loanID];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
}
-(void)httpLoadComplete:(YXBLoanInfoDetails *)r{
    [self.myTableView reloadDeals];
    
    if (r.errCode==0) {
        //如果聊天数组未发生变化  则无需刷新
        if (r.iYXBLoanDialogue.count >= _dialogArray.count) {
            self.loanInforDetailsModel = r;
            [self refreshAllUIWith:r];
        }
    }else{
        [ProgressHUD showErrorWithStatus:r.errString];
    }
}
#pragma mark - http---发送
-(void)httpSendMesRequestWithChatType:(NSInteger)chatType Content:(NSString *)content{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak MyLoanViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpSendMesLOadParams:s httpOperation:assginHtttperator ChatType:chatType Content:content];
        
    } complete:^(TResultSet * r, int taskid) {
        [this httpSendMesLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
-(void)httpSendMesLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation ChatType:(NSInteger)chatType Content:(NSString *)content{
    LoanManagerV10 *_activityM = (LoanManagerV10 *)[httpOperation getAopInstance:[LoanManagerV10 class] returnValue:[TResultSet class]];
    
    [_activityM loanChatV2:[YXBTool getUserToken] loanID:self.loanID chatType:chatType andContent:content];
    
}
-(void)httpSendMesLoadComplete:(TResultSet *)r{
    [self.myTableView reloadDeals];
    if (r.errCode == 0) {
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        YXBLoanDialogue *model = [[YXBLoanDialogue alloc] init];
        model.dialogueMode = @"1";
        model.time = [YXBTool getCurrentTime];
        model.imgUrl = userModel.user.iconAddr;
        model.name = userModel.user.realname;
        model.displayMode = @"2";
        if (_bgView.chatType == 2) {
            model.dialogueMode = @"5";
        }
        model.var1 = _bgView.inputTextview.text;
        
        
        [_dialogArray addObject:model];
        
        [self.myTableView reloadData];
        if (self.myTableView.contentSize.height>_myTableView.height) {
            [self.myTableView setContentOffset:CGPointMake(0, _myTableView.contentSize.height-_myTableView.height)];
        }
        //
        if (_bgView.chatType == 2) {
            _bgView.inputTextview.text = @"";
        }
        else{
            _bgView.inputTextview.text = @"请选择不同模板语境";
        }
        [ProgressHUD showErrorWithStatus:r.errString];
    }else{
        [ProgressHUD showErrorWithStatus:r.errString];
    }
}

#pragma mark - http---点击底部按钮时的请求
-(void)httpClickedBottomBtnRequestWithBtnId:(NSInteger)btnId{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak MyLoanViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpClickedBottomBtnLOadParams:s httpOperation:assginHtttperator bottomBtnId:btnId];
    } complete:^(YXBLoanInfoDetails * r, int taskid) {
        [this httpClickedBottomBtnLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
    
}
-(void)httpClickedBottomBtnLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation bottomBtnId:(NSInteger)btnId{
    LoanManagerV10 *_activityM = (LoanManagerV10 *)[httpOperation getAopInstance:[LoanManagerV10 class] returnValue:[YXBLoanInfoDetails class]];
    [_activityM clickBottomButton:[YXBTool getUserToken] loanID:self.loanInforDetailsModel.loanID bottomButtonID:btnId];
}
-(void)httpClickedBottomBtnLoadComplete:(YXBLoanInfoDetails *)r{
    [self.myTableView reloadDeals];
    if (r.errCode == 0) {
        self.loanInforDetailsModel = r;
        [self refreshAllUIWith:r];
        [ProgressHUD showErrorWithStatus:r.errString];
    }else if(r.errCode == 807){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您已催款3次无应答，是否直接电话联系对方？" delegate:self cancelButtonTitle:@"再等等" otherButtonTitles:@"电话联系", nil];
        alert.tag =3003;
        [alert show];
    }else if(r.errCode == 808){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"现在催款太早啦，我们会在距离还款日7天时启动为您催款" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        alert.tag =3003;
        [alert show];
    }else{
        [ProgressHUD showErrorWithStatus:r.errString];
    }
}


#pragma mark - http---修改利息

-(void)httpConsultLixiRequest{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak MyLoanViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpConsultLixiLOadParams:s httpOperation:assginHtttperator];
        
    } complete:^(YXBLoanInfoDetails * r, int taskid) {
        [this httpConsultLixiLoadComplete:r];
    }];
    [self.iHttpOperator connect];
}

-(void)httpConsultLixiLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation{
    LoanManagerV10 *manager = (LoanManagerV10 *)[httpOperation getAopInstance:[LoanManagerV10 class] returnValue:[YXBLoanInfoDetails class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0){
        
        [manager applyModifyInterest:userToken loanId:self.loanInforDetailsModel.loanID newLixi:newlixi];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}
-(void)httpConsultLixiLoadComplete:(YXBLoanInfoDetails *)r{
    [_consultlixi removeFromSuperview];
    [self.myTableView reloadDeals];
    if (r.errCode==0) {
        
        self.loanInforDetailsModel = r;
        [self refreshAllUIWith:r];
    }else{
        [ProgressHUD showErrorWithStatus:r.errString];
    }
}


#pragma mark - http---申请延期
- (void)httpApplyYanqiRequest{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak MyLoanViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpApplyYanqiLOadParamss:s httpOperation:assginHtttperator];
        
    } complete:^(YXBLoanInfoDetails * r, int taskid) {
        [this httpApplyYanqiLoadCompletes:r];
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpApplyYanqiLOadParamss:(NSString *)s httpOperation:(HttpOperator *)httpOperation{
    LoanManagerV10 *manager = (LoanManagerV10 *)[httpOperation getAopInstance:[LoanManagerV10 class] returnValue:[YXBLoanInfoDetails class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0){
        
        [manager applyDelay:userToken loanID:self.loanInforDetailsModel.loanID compensationMoney:compensationMoney daleyTime:daleyTime];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
}
-(void)httpApplyYanqiLoadCompletes:(YXBLoanInfoDetails *)r{
    [self.myTableView reloadDeals];
    _yanqi.hidden=YES;
    [self starTimer];
    if(r.errCode == 0){
        self.loanInforDetailsModel = r;
        [self refreshAllUIWith:self.loanInforDetailsModel];
        [ProgressHUD showErrorWithStatus:r.errString];
    }else{
        [ProgressHUD showErrorWithStatus:r.errString];
    }
    NSLog(@"提交成功");
    
}
@end
