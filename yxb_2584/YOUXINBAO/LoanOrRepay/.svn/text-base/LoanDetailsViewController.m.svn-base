//
//  LoanDetailsViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanDetailsViewController.h"
#import "LoanDetaildSliderView.h"
#import "LoanDetailsInstallmentView.h"
#import "DetailsFooterView.h"
#import "LoanManagerV2.h"
#import "QCFriendsViewController.h"
#import "StatusHttp.h"
#import "AATimePickerView.h"
#import "PayViewController.h"
#import "QCBaseTableView.h"
#import "LoandetailsTableViewCell.h"
#import "DetailsAddUpDataView.h"
#import "PostponeView.h"
#import "UIAlertView+Block.h"
#import "StatusHttp.h"
#import "LoanOrRepayListViewController.h"
#import "YXBTool.h"
#import "UIAlertView+Block.h"
#import "UserState.h"
#import "LoanDetailInterestView.h"
#import "QCHomeDataManager.h"
#import "LoanCalculateUtil.h"
#import "LoanConfig.h"
#import "CustomIOSAlertView.h"
#import "YXBPayAction.h"
#import "LoanOrRepayFriendsViewController.h"
#import "LoanCenterViewController.h"
#import "ImagePickerViewController.h"
#import "LoanAddressBookViewController.h"
//#import "LoanTestWXViewController.h"
#import "QCDeviceManager.h"
#import "LoanFriendTypeViewController.h"
#import "FriendSelecteViewController.h"


#define Labelinterval  50
#define labelWidth 80
#define TextFieldWith 200
#define labelOrTextFieldHeight 20
#define TableViewHeightTopAlign 100
#define LoanDetailsViewControllerMaxInterest 0.25
#define LoanDetailsViewControllerMinLoadMoney 1
#define bottomTextLabelTopUp (kDeviceHeight - 64 - 50 - 50)
#define bottomTextLabelTopDown (kDeviceHeight - 64 - 50)
#define bottomTextLabelHeight 50
#define WXLoanNetNumber 2048



@interface LoanDetailsViewController ()<UIScrollViewDelegate,SliderViewDelegate,loanDetailsInstallmentViewDelegate,DetailsFooterViewDelegate,UITextFieldDelegate,StatusHttpDelegate,UIAlertViewDelegate,MJRefreshBaseViewDelegate,QCBaseTableViewDelegate,UITableViewDataSource,UITableViewDelegate,PostponeViewDelegate,HeaderViewDelegate,QCFriendsViewControllerBackDelegate>
{
    UITableView * _tableView;
    
    UITextField * moneyTextField;//钱
    UILabel *  timeLongLabel;//时长
    UILabel * AddupMoneyLabel;// 累计补偿金额;
    UITextField * interestTextField; //利息
    UILabel *danweiLabel;//金额单位
    UIButton *vedioCertification;//视频认证
    UILabel * fenqixianshiLabel;//分期付款显示
    UILabel * interestxianshiLabel;//利息显示
    UIButton * interestSwitch;//利息开关
    LoanDetailInterestView *interestView;//利息（三种、新版后加了个银行利息）
    UIButton * kouXiFangShiSwitch;//扣息方式开关
    UIButton * reimbursementSwitch;//还款方式开关
    UILabel * banklabel;
    UILabel *timeCountLabel;//倒计时label
    UILabel *moneyLendLabel;//打款计算 label
    UILabel *introLabel;//利息取整说明文字
    BOOL upFlag;//判断tableview的高度是否已变化
    
    LoanDetaildSliderView * sliderView;//滑竿
    
    DetailsFooterView * footerView;//底部按钮
    
    StatusHttp * statusHttp;//各种状态的联网
    
    AATimePickerView * _timePicker; // 事件选着
    
    LoanDetailsInstallmentView * installmentView;
    
    DetailsAddUpDataView * addUpView ;//累加页面
    NSArray * rowNameArray;
    BOOL isShowaddUPMoney;//是否显示累加页面
    BOOL ispostpone;//是否延期
    UIImageView *statusImageView;//显示已关闭等信息
    UILabel *bottomTextLabel;//借款协议
//    BOOL isShowVedioCertifict;//是否显示视频认证
    LoanNewFriendType _friendType;
}

@property (nonatomic,retain)    UITextField * timeTextField;//时间
@property (nonatomic,strong)    NSMutableArray *selectedArray;//选择的下方的分期按钮的model数组
@property (nonatomic,copy) NSString *selectedBtn;//选择的底部按钮

@end

@implementation LoanDetailsViewController


-(void)dealloc
{
    NSLog(@"LoanDetailsViewController is dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"借款详情"];
//    self.isShowVedioCertifict = NO;
    if (_bOrL == NEWLOAN) {
        [self setTitle:@"发起借款"];
    }
    
        
    upFlag = NO;
    self.selectedArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    rowNameArray = @[@"借款金额:",@"用款时间:",@"借款时长:",@"累计补偿金:",@"",@"利息:",@"扣息方式:",@"还款方式:"];
    [self initView];
    [self initViews];

    if (self.bOrL == COMPILE){
        [self setTitle:@"编辑"];
        
        
    } else if (self.bOrL == NEWLOAN) {
        _loan = [[Loan alloc]init];
        
        _loan.interestType = PRE_INTEREST;
        _loan.repayType = 0; //0---全额  1----分期
        _loan.expectBorrowDate = [AATimePickerView getCurrentTime];
        _loan.loanPeriod = LoanPeriod_WEEK_1;
        _loan.interestType = FREE;
        interestView.selectedIndex = 2;

        NSArray * array = nil;
        if (_fromFriendUser == nil) {
            array = [NSArray arrayWithObject:@"向好友借款"];

        }
        else
        {
            array = [NSArray arrayWithObject:[NSString stringWithFormat:@"向好友借款"] ];

        }
        
        
        footerView = [[DetailsFooterView alloc]initWithNameArr:array];
        footerView.delegate =self;        
//        _tableView.height = kDeviceHeight - 64 - 50 - _segmentHeight - bottomTextLabel.height;
//        bottomTextLabel.top = bottomTextLabelTopUp;
        [self adjustTableViewFrameWithSegment];
        if (_segmentHeight > 0) {
            footerView.frame = CGRectMake(footerView.left, footerView.top - _segmentHeight, footerView.width, footerView.height);
        }

        
        [self.view addSubview:footerView];
        
        installmentView.installmentStatus = DoNotChoose;

    }else if (self.bOrL == BorrowerORLendersQuickLend) {
        rowNameArray = @[@"借出金额:",@"用款时间:",@"借出时长:",@"累计补偿金:",@"",@"利息:",@"扣息方式:",@"还款方式:"];

        _loan = [[Loan alloc]init];
        
        _loan.interestType = PRE_INTEREST;
        _loan.repayType = 0; //0---全额  1----分期
        _loan.expectBorrowDate = [AATimePickerView getCurrentTime];
        _loan.loanPeriod = LoanPeriod_WEEK_1;
        _loan.interestType = FREE; //默认无息

        NSArray * array = nil;
        array = [NSArray arrayWithObject:@"选择好友"];
        if (_lendMyFriend != nil) {
            array = [NSArray arrayWithObject:[NSString stringWithFormat:@"支付"] ];
            
        }

            
        footerView = [[DetailsFooterView alloc]initWithNameArr:array];
        footerView.delegate =self;
        [self.view addSubview:footerView];
//        _tableView.height = kDeviceHeight - 64 - 50 - bottomTextLabel.height - _segmentHeight-footerView.height;
        [self makeTableViewHeight];
        bottomTextLabel.top = bottomTextLabelTopDown - _segmentHeight; //协议兰
        if (_segmentHeight > 0) {
            footerView.frame = CGRectMake(footerView.left, footerView.top - _segmentHeight, footerView.width, footerView.height);
//            _tableView.height = kDeviceHeight - 64 - 50 - _segmentHeight - bottomTextLabel.height;
            [self adjustTableViewFrameWithSegment];

        }

        
        installmentView.installmentStatus = DoNotChoose;
        
    }else{
        _tableView.hidden = YES;
//        [self getTLoanDetailWithLoanID:_loan.t_id];
        
        installmentView.installmentStatus = CanChoose;

    }
    
    bottomTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kDeviceHeight - 64 - 50 - 50 - _segmentHeight, kDeviceWidth-40, 50)];
    //    bottomTextLabel.frame = CGRectMake(0, 0, 300, 200);
//<<<<<<< .mine
//    bottomTextLabel.text = @"好友之间的借款，本站仅提供合法的电子借据和友情提示催款，如未使用无忧借条支付还款，本软件不负责债务纠纷。";
//=======
    bottomTextLabel.text = @"好友之间的借款，本站仅提供合法的电子借条和友情提示催款，如未使用无忧借条支付还款，本软件不负责债务纠纷。";
//>>>>>>> .r3020
    
    bottomTextLabel.font = [UIFont systemFontOfSize:12.0];
    bottomTextLabel.backgroundColor = [UIColor whiteColor];
    bottomTextLabel.numberOfLines = 0;
    bottomTextLabel.lineBreakMode = 0;
    [self.view addSubview:bottomTextLabel];
    [self makeTableViewHeight];
    

}

-(void)leftClicked
{
    if (_bOrL == NEWLOAN) {
        
        if ([moneyTextField.text isEqualToString:@""]) {
            [self.navigationController popViewControllerAnimated:YES];

        }
        else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否放弃已编辑选项?" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"放弃", nil];
        //    __weak typeof(self) this = self;
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                [super leftClicked];
            }
        }];
        }

    }
    else
    {
        [super leftClicked];
    }
}

- (void)initView
{
    
    if ((_bOrL !=NEWLOAN) && (_bOrL !=BorrowerORLendersQuickLend)) {
        QCBaseTableView * tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.view.frame.size.height-64-_segmentHeight)];
        [self makeTableViewHeight];
        tableView.refreshDelegate = self;
        _tableView = tableView;
        
    }else{
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.view.frame.size.height-64-_segmentHeight)];
    }
    [self makeTableViewHeight];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    
    
    //    if (_loan.status == QUICKLEND_NEEDCONFIRM) {
    //        timeCountLabel.hidden = NO;
    //    }
    //    else
    //    {
    //        timeCountLabel.hidden = YES;
    //    }
    
    
    if (_isShowTimer) {
        if (timeCountLabel == nil) {
            timeCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 80)];
            timeCountLabel.textAlignment = NSTextAlignmentCenter;
            timeCountLabel.textColor = [UIColor blackColor];
            timeCountLabel.numberOfLines = 2;
            timeCountLabel.lineBreakMode = 0;
            _tableView.tableHeaderView = timeCountLabel;
        }
    }
    
    
    UIImage * imageON = [UIImage imageNamed:@"youxi.png"];
    UIImage * imageOff = [UIImage imageNamed:@"wuxi.png"];
    interestSwitch = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-10-imageON.size.width, 10, imageON.size.width, imageON.size.height)];
    interestSwitch.selected = YES;
    [interestSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    interestSwitch.tag = 222;
    [interestSwitch setImage:imageON forState:UIControlStateSelected];
    [interestSwitch setImage:imageOff forState:UIControlStateNormal];
    interestSwitch.hidden = YES;
    
    //添加三种扣息方式 自定义利息、银行利息、无息
    CGFloat x = 100, y = 10, w = kDeviceWidth - 20 - x, h = imageON.size.height;
    interestView = [[LoanDetailInterestView alloc] initWithFrame:CGRectMake(x, y, w, h) WithArray:[NSArray arrayWithObjects:@"自定义息",@"银行息",@"无息", nil]];
    interestView.delegate = self;
    //    interestView.backgroundColor = [UIColor redColor];
    //    interestView.hidden = YES;
    
    installmentView = [[LoanDetailsInstallmentView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0)];
    installmentView.backgroundColor = [UIColor whiteColor];
    installmentView.delegate = self;
    _tableView.tableFooterView = installmentView;
    
}

-(void)initViews
{

    //视频认证
    vedioCertification = [UIButton buttonWithType:UIButtonTypeCustom];
    vedioCertification.frame = CGRectMake(kDeviceWidth-48-24.5, 8.5, 48, 27);
    [vedioCertification setImage:[UIImage imageNamed:@"video-icon"] forState:UIControlStateNormal];
    [vedioCertification addTarget:self action:@selector(vedioCertificationClick) forControlEvents:UIControlEventTouchUpInside];

    
    //钱输入框
    moneyTextField = [[UITextField alloc]initWithFrame:CGRectMake(kDeviceWidth-200, 0, 180, 48)];
    moneyTextField.textAlignment = NSTextAlignmentRight;
    moneyTextField.delegate = self;
    moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    moneyTextField.placeholder = [NSString stringWithFormat:@"限1-%d元",LoanDetailsViewControllerMaxLoadMoney];

    //时间输入框
    _timeTextField = [[UITextField alloc]initWithFrame:moneyTextField.frame];
    _timeTextField.textColor = rgb(69, 69, 69, 1.0);
    _timeTextField.textAlignment = NSTextAlignmentRight;
    _timeTextField.delegate = self;
    //    timeTextField.backgroundColor = [UIColor redColor];
    _timeTextField.text = [AATimePickerView getCurrentTime];

    //时长输入
    timeLongLabel = [[UILabel alloc]initWithFrame:moneyTextField.frame];
    timeLongLabel.text = @"一周";
    timeLongLabel.textAlignment = NSTextAlignmentRight;
    timeLongLabel.font = [UIFont systemFontOfSize:14];
    
    //时长滑轮
    sliderView = [[LoanDetaildSliderView alloc]initWithFrame:CGRectMake(0, 50, kDeviceWidth, Labelinterval)];
    sliderView.delegate  = self;
    sliderView.slider.value = 7.0;

    //展开延期数据
    AddupMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth-120, 15, 100, 20)];
    AddupMoneyLabel.text = @"800 元";
    
    //展开
    addUpView = [[DetailsAddUpDataView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
    addUpView.hidden = YES;
    
    //输入利息值
    interestTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, (kDeviceWidth-40)/2.0, 40)];
    interestTextField.backgroundColor = [UIColor whiteColor];
    interestTextField.placeholder = @"请输入利息";
    interestTextField.textAlignment = NSTextAlignmentCenter;
    interestTextField.delegate =self;
    interestTextField.keyboardType =UIKeyboardTypeNumberPad;
    interestTextField.layer.cornerRadius = 3.0;

    //金额单位
    danweiLabel = [[UILabel alloc] initWithFrame:CGRectMake(interestTextField.right+5, interestTextField.top, 20, interestTextField.height)];
    danweiLabel.textColor = [UIColor redColor];
    danweiLabel.text = @"元";
    danweiLabel.font = [UIFont systemFontOfSize:16];
    
    
    //银行基准利率
    banklabel = [[UILabel alloc]initWithFrame:CGRectMake(danweiLabel.right + 5,interestTextField.top, (interestTextField.width - 10)/2.0+5, interestTextField.height)];
    banklabel.textColor = rgb(74, 74, 74, 1);
    banklabel.textAlignment = NSTextAlignmentRight;
    banklabel.font = [UIFont systemFontOfSize:16];
    banklabel.text = @"年化利率:";
    
    //利率显示
    interestxianshiLabel =[[UILabel alloc]initWithFrame:CGRectMake(banklabel.right, banklabel.top, banklabel.width-15, banklabel.height)];
//    interestxianshiLabel.textColor = rgb(221, 101, 115, 1.0);
    interestxianshiLabel.textColor = [UIColor grayColor];


    
    //            interestxianshiLabel.text = @"年化利率:0%";
    interestxianshiLabel.textAlignment = NSTextAlignmentLeft;
//    interestxianshiLabel.backgroundColor = [UIColor redColor];
    interestxianshiLabel.font = [UIFont systemFontOfSize:16];
    interestxianshiLabel.adjustsFontSizeToFitWidth = YES;
    interestxianshiLabel.minimumScaleFactor =8.0/interestxianshiLabel.font.pointSize;


    //添加银行利息  利息取整说明文字
    
    introLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, interestTextField.bottom+10, kDeviceWidth-40, 12)];
//    introLabel.textColor = rgb(221, 101, 115, 1.0);
    introLabel.textColor = [UIColor grayColor];
    introLabel.textAlignment = NSTextAlignmentCenter;
    introLabel.font = [UIFont systemFontOfSize:16];
    introLabel.text = @"利息取整,只进不舍。例:应付1.01元,实付2元。";
    introLabel.adjustsFontSizeToFitWidth = YES;
    introLabel.minimumScaleFactor = 8.0/introLabel.font.pointSize;
    //先息后息 设置
    UIImage * imageON = [UIImage imageNamed:@"xianxi.png"];
    UIImage * imageOff = [UIImage imageNamed:@"houxi.png"];
    kouXiFangShiSwitch = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-10-imageON.size.width, introLabel.bottom + 10, imageON.size.width, imageON.size.height)];
    [kouXiFangShiSwitch setImage:imageON forState:UIControlStateSelected];
    [kouXiFangShiSwitch setImage:imageOff forState:UIControlStateNormal];
    kouXiFangShiSwitch.selected = NO;
    [kouXiFangShiSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    kouXiFangShiSwitch.tag = 223;

    //全额  分期选择
    UIImage * imageON1 = [UIImage imageNamed:@"fenqi.png"];
    UIImage * imageOff1 = [UIImage imageNamed:@"quane.png"];
    reimbursementSwitch = [[UIButton alloc]initWithFrame:interestSwitch.frame];
    //            reimbursementSwitch.selected = NO;
    [reimbursementSwitch setImage:imageON1 forState:UIControlStateSelected];
    [reimbursementSwitch setImage:imageOff1 forState:UIControlStateNormal];
    //            reimbursementSwitch.userInteractionEnabled = NO;
    
    [reimbursementSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    reimbursementSwitch.tag = 224;

}

- (void)setNavigationBarItmeWithTitle:(NSString *)title
{
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightNavigationBarItmeAciton:)];
   
    item.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = item;
}


- (void)rightNavigationBarItmeAciton:(UINavigationItem *)item
{
    statusHttp = [[StatusHttp alloc]init];
    statusHttp.delegate = self;

    if ([item.title isEqualToString:@"编辑"]) {
        LoanDetailsViewController * compileViewController = [[LoanDetailsViewController alloc]init];
        
        [self.navigationController pushViewController:compileViewController animated:YES];
        compileViewController.bOrL = COMPILE;
        compileViewController.loan = _loan;

    }else if ([item.title isEqualToString:@"继续发送"])
    {
//        [self loanFromWXReSend:YES];
        [self callWeChatWithLoanId:_loan.t_id];
    }
    else{
        //延期
//        PostponeView * postpone = [[PostponeView alloc]initWithbtnTitleArray:@[@"取消",@"确定"]];
//        postpone.delegate =self;
//        [postpone show];
        QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];

        if ((userModel.user.t_id == _loan.borrowerId) &&
            (_loan.status == MODIFY_AFTERLEND_NEEDCONFIRM_BYLENDER))
        {
        
//            [ProgressHUD showSuccessWithStatus:@"正在等待对方确认延期"];
        }
        else
        {
            /*
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否为该借款单延期一个月？" message:@"请联系借款人在7天内处理,过期自动取消。\n给予补偿金成功率会更高哦" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            alert.tag = LoanDetailsViewControllerPostPoneAlertViewTag;
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            UITextField *tf=[alert textFieldAtIndex:0];
            tf.placeholder = @"请输入补偿金 默认0元";
            tf.keyboardType = UIKeyboardTypeNumberPad;
            [alert show];
            */
            
            [self postPoneAction];

            


            
        }
        
    }
}
-(void)vedioCertificationClick{
    NSLog(@"认证视频");
    
//    [YXBTool jumpInnerSafaryWithUrl:self.loan.jumpToCheckUrl hasTopBar:YES titleName:@"认证视频"];
    [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:self.loan.jumpToCheckUrl params:nil] hasTopBar:YES titleName:@"视频播放"];

}
-(void)postPoneAction
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth - 40, 100)];
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15,view.width, 18)];
    firstLabel.text = @"是否为该借款单延期一个月？";
    firstLabel.font = [UIFont systemFontOfSize:18.0];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:firstLabel];
    
    UILabel *secLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, firstLabel.bottom + 15,2 * (view.width-40)/3.0, 13)];
    secLabel.text = @"给予补偿金成功率会更高哦!";
    secLabel.font = [UIFont systemFontOfSize:13.0];
    secLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:secLabel];
    
    UITextField *moneyTf = [[UITextField alloc] initWithFrame:CGRectMake(secLabel.right, secLabel.top, (view.width-40)/3.0, secLabel.height)];
    
    [moneyTf becomeFirstResponder];
    moneyTf.textAlignment = NSTextAlignmentCenter;
    moneyTf.placeholder = @"请输入补偿金";
    NSString *str = @"请输入补偿金";
    
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:str];
    [aStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, str.length)];
    //            moneyTf.attributedPlaceholder = aStr;
    moneyTf.keyboardType = UIKeyboardTypeNumberPad;
    moneyTf.textColor = [UIColor redColor];
    moneyTf.font = [UIFont systemFontOfSize:13.0];
    [view addSubview:moneyTf];
    
    UILabel *thiLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, secLabel.bottom + 10,(view.width-40), 13)];
    thiLabel.text = @"请联系借款人在7天内处理,过期自动取消。";
    thiLabel.font = [UIFont systemFontOfSize:13.0];
    thiLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:thiLabel];
    
    
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:view];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"确认", nil]];
    //    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        if ([moneyTf.text integerValue] < 0) {
            [ProgressHUD showErrorWithStatus:@"输入补偿金金额有误，请重新输入"];
            return ;
        }
        if (buttonIndex == 1) {
            
            if (moneyTf.text == nil || [moneyTf.text isEqualToString:@""]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您尚未输入补偿金，系统默认0元," delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                    if (buttonIndex == 1) {
                        [self.view endEditing:YES];
                        moneyTf.text = @"0";
                        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
                        self.loan.yxbToken = userModel.user.yxbToken;
                        self.loan.currentCompensation = moneyTf.text;
                        self.loan.operationType = POSTPONE_AFTERPAY;
                        statusHttp.delegate = self;
                        statusHttp.netNumber = LoanDetailsViewControllerPostPoneAlertViewTag;
                        [statusHttp __yxb_service__createAndModifyTLoan:self.loan];
                        
                    }
                }];
            }
            else
            {
                [self.view endEditing:YES];
                QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
                self.loan.yxbToken = userModel.user.yxbToken;
                self.loan.currentCompensation = moneyTf.text;
                self.loan.operationType = POSTPONE_AFTERPAY;
                statusHttp.delegate = self;
                statusHttp.netNumber = LoanDetailsViewControllerPostPoneAlertViewTag;
                [statusHttp __yxb_service__createAndModifyTLoan:self.loan];
                
            }
            
        }
    }];
    
    [alertView setUseMotionEffects:true];
    // And launch the dialog
    [alertView show];

}

#pragma mark   延期Aciton
-(void)postponetView:(PostponeView *)postponeView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [postponeView remove];
    }else if (buttonIndex == 2){
        self.loan.currentCompensation = postponeView.textField.text;
        [statusHttp __yxb_service__createAndModifyTLoan:self.loan];

    }
}

#pragma mark - UITableViewDataSourceDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_isShowVedioCertifict) {
        return 2;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isShowVedioCertifict&&section == 0) {

        return 1;
    }
    return rowNameArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 0&&_isShowVedioCertifict) {
        return 15;
    }else{
        return 0.0000001;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    NSInteger height = 0;
    if (indexPath.section == 0&&_isShowVedioCertifict) {
        return 45;
    }
    switch (indexPath.row) {
        case 0:
        {
            height = 50;
        }
            break;
        case 1:
        {
            if (_bOrL == BorrowerORLendersQuickLend) {
                //高级快速放款借出时不显示时间选择项
                height = 0;
            }
            else
            {
                height = 50;
            }
        }
            break;
        case 2:
        {
            height = 110;
            break;

        }
        case 3:
        {
            /*
            if (ispostpone) {
                height = 50;
            }else{
                height = 0;
                
            }
            */
            height = 0;
//            if(_loan.status == MODIFY_AFTERLEND_NEEDCONFIRM_BYLENDER)
            if(ispostpone)
            {
                height = 50;
            }

            break;

        }
        case 4:
        {
            if (isShowaddUPMoney) {
                height = DetailsAddUpDataViewHeight * [_loan.compensationNoteList count];
                
            }else{
                height = 0;
            }
            break;

        }
        case 5:
        {
            height = 50;
            break;

        }
        case 6:
        {
            if (_loan.interestType != FREE) {
                if (moneyLendLabel.hidden == YES) {
                    height = 130;
                    
                }
                height = 160;
                
                
            }else{
                
                height = 0;
            }
            
            break;

        }
        case 7:
        {
            height = 50;
            break;

        }
        default:
        {
            height = 0;
            
            break;

        }
    }
    
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isShowVedioCertifict&&indexPath.section == 0&&indexPath.row==0) {
        [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:self.loan.jumpToCheckUrl params:nil] hasTopBar:YES titleName:@"视频播放"];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (_isShowVedioCertifict) {
        static NSString *cellID0 = @"session0";
        LoandetailsTableViewCell * cell0 = [tableView dequeueReusableCellWithIdentifier:cellID0];
        
        if (cell0 == nil) {
            
            cell0 = [[LoandetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID0];
            [cell0 setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        if (indexPath.row == 0&&indexPath.section == 0) {
            [cell0.contentView addSubview:vedioCertification];
            cell0.titleLabel.text = @"认证视频:";
            cell0.clipsToBounds = YES;
            return cell0;
        }
        
    }
    NSString * cellID = [NSString stringWithFormat:@"row%ld",(long)(indexPath.row)];

    LoandetailsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[LoandetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        {
            if (indexPath.row == 0) {
                //输入借款金额 行
                [cell.contentView addSubview:moneyTextField];
                
            }else if (indexPath.row == 1){
                //输入借款日期 行
                [cell.contentView addSubview:_timeTextField];
                
            }else if (indexPath.row == 2){
                //输入借款时长   借款滑动条  2行
                [cell.contentView addSubview:timeLongLabel];
                
                [cell.contentView addSubview:sliderView];
                
            }else if (indexPath.row == 3){
                //输入延期相关
                
                [cell.contentView addSubview:AddupMoneyLabel];
                UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth- 60, 0, 60, 50)];
                [btn setImage:[UIImage imageNamed:@"drop-down.png"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateSelected];
                [btn addTarget:self action:@selector(addupBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btn];
                
                //            }
                
            }else if (indexPath.row == 4){
                //多条延期记录的view
                cell.backgroundColor = rgb(238, 236, 246, 1);
                
                [cell.contentView addSubview:addUpView];
            }
            else if (indexPath.row == 5){
                //利息开关
                [cell.contentView addSubview:interestSwitch];//interestSwitch已废弃
                [cell.contentView addSubview:interestView]; //0707新的 自定义息 银行息 无息
                
                if (_loan.useBankRate == 1) {
                    interestView.selectedIndex = 1;
                }
                else if (_loan.interestType == FREE)
                {
                    interestView.selectedIndex = 2;
                }
                else{
                    interestView.selectedIndex = 0;
                }
                
            }else if (indexPath.row == 6){
                
                //利息相关四行
     
                // 1 利息输入框  年化利率
                // 2 取整说明
                // 3 扣息方式
                // 4 收到打款说明

                cell.backgroundColor = rgb(238, 236, 246, 1);
                [cell.contentView addSubview:interestTextField];
                
                [cell.contentView addSubview:interestxianshiLabel];
                [cell.contentView addSubview:danweiLabel];
                [cell.contentView addSubview:banklabel];
                [cell.contentView addSubview:introLabel];
                [cell.contentView addSubview:kouXiFangShiSwitch];
                
                cell.titleLabel.frame = CGRectMake(cell.titleLabel.origin.x, kouXiFangShiSwitch.top, cell.titleLabel.size.width, 40);
                
                
                if (moneyLendLabel == nil) {
                    UILabel *tintLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kouXiFangShiSwitch.bottom, kDeviceWidth-40, 30)];
                    tintLabel.hidden = YES;
                    tintLabel.font = [UIFont systemFontOfSize:14.0];
                    tintLabel.textAlignment = NSTextAlignmentRight;
                    moneyLendLabel = tintLabel;
                    
                    
                }
                [self isShownDakuanLabel];
                [cell.contentView addSubview:moneyLendLabel];
                
            }else if (indexPath.row == 7){
                
                
                [cell.contentView addSubview:reimbursementSwitch];
            }
        }
        
    }
    

    cell.titleLabel.text = rowNameArray[indexPath.row];
    cell.clipsToBounds = YES;
    
    
    //延期相关判断 开始
    if (indexPath.row == 5 && !interestSwitch.selected)
    {
        
    }else if (indexPath.row == 3)
    {
        if (ispostpone) {
            cell.contentView.hidden = NO;
            
        }else{
            cell.contentView.hidden = YES;
        }
    }else if (indexPath.row == 6 && !interestSwitch.selected)
    {
        cell.titleLabel.text =@"";
    }
    //延期相关判断 结束
    
    //用loan更新UI
    [self showInfoWithLoan];
    
    return cell;
    
}

//更新数据
-(void)showInfoWithLoan
{
    moneyTextField.text = _loan.money;
    _timeTextField.text = _loan.expectBorrowDate;
    timeLongLabel.text = [Loan getLoanPeriodWith:_loan.loanPeriod];
    if (_loan.postponePeriod !=0) {
        NSString * string = [NSString stringWithFormat:@"%@+%ld个月(延)",timeLongLabel.text,(long)_loan.postponePeriod];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange range = NSMakeRange(timeLongLabel.text.length, string.length-timeLongLabel.text.length);
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
        timeLongLabel.attributedText = str;
        
    }
    NSString * string = [NSString stringWithFormat:@"%@元",_loan.sumCompensation];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = NSMakeRange(0, string.length-1);
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
    AddupMoneyLabel.attributedText = str;
    //    AddupMoneyLabel.text = _loan.sumCompensation;
    
    sliderView.slider.value = _loan.loanPeriod;
    sliderView.loanPeriod = _loan.loanPeriod;
    interestTextField.text = _loan.interest;

    if ([self isEditState]) {
        if ([_loan.interest integerValue] == 0) {
            interestTextField.text = @"";

        }
    }
    
    if (interestView.selectedIndex != 1) {
        interestxianshiLabel.text = [NSString stringWithFormat:@"%0.2f%%",[_loan interestRateWithLoanPeriod:_loan.loanPeriod money:[self getMoneyWithOthers] interest:[_loan.interest floatValue]]*100];
        
    }
    
    
    if (_loan.interestType == FREE) {
        interestSwitch.selected = NO;
        [self interesthidden:NO];
        
    }else if (_loan.interestType == PRE_INTEREST) {
        interestSwitch.selected = YES;
        [self interesthidden:YES];
        
        kouXiFangShiSwitch.selected =NO;
    }else if(_loan.interestType == POST_INTEREST){
        interestSwitch.selected = YES;
        [self interesthidden:YES];
        
        kouXiFangShiSwitch.selected =YES;
    }
    if (_loan.repayType==1) {
        reimbursementSwitch.selected = YES;
    }else if(_loan.repayType == 0){
        reimbursementSwitch.selected = NO;
    }
    addUpView.height = DetailsAddUpDataViewHeight * [_loan.compensationNoteList count];
    [addUpView reloadDataWithArray:_loan.compensationNoteList];
    
    
    installmentView.array = _loan.installmentList;
    
    if (sliderView != nil) {
        installmentView.model = self.loan;
        [installmentView refreshWith:sliderView.loanPeriod];
        
    }
    
    
    if (interestView.selectedIndex == 1) {
        if (_bOrL == NEWLOAN || _bOrL == BorrowerORLendersQuickLend) {
            [self showInterestFieldInfo];
            if (_loan.repayType == 0) {
                _loan.installmentList = [LoanDetailsInstallmentView installmentArrayWithMoney:moneyTextField.text withInterest:interestTextField.text withUserTime:_timeTextField.text withTimeLong:sliderView.loanPeriod repayType:0 kouxifangshi:_loan.interestType];
            }
            else
            {
                _loan.installmentList =[LoanDetailsInstallmentView installmentArrayWithMoney:moneyTextField.text withInterest:interestTextField.text withUserTime:_timeTextField.text withTimeLong:sliderView.loanPeriod kouxifangshi:_loan.interestType];
                
            }
            installmentView.array = _loan.installmentList;

        }

        
    }
    
    
    [self isShownDakuanLabel];
    NSLog(@"moneyTextField.text-%@--%@",moneyTextField,moneyTextField.text);
    if ([moneyTextField.text isEqualToString:@""]) {
        installmentView.hidden = YES;
    }
    else
    {
        installmentView.hidden = NO;
    }

    _tableView.contentSize = CGSizeMake(kDeviceWidth, installmentView.origin.y+installmentView.size.height);


}

#pragma -mark installmentViewDelegate

- (void)InstallmentViewButtonAction:(UIButton *)sender
{
    
}

- (void)selectedArrayInstallmentView:(NSMutableArray *)selectedArray//选中的数组
{
    [self.selectedArray removeAllObjects];
    [self.selectedArray addObjectsFromArray:selectedArray];
    
}

#pragma mark  滑竿delegateAction
- (void)changesValue:(LoanPeriod)loanPeriod
{//滑动时
    timeLongLabel.text =  [Loan getLoanPeriodWith:loanPeriod];
    
    //取消滑竿时 闪动
    /*
    if (loanPeriod>=LoanPeriod_MONTH_2) {
        reimbursementSwitch.userInteractionEnabled = YES;
        reimbursementSwitch.selected = YES;
    }else{
        reimbursementSwitch.userInteractionEnabled = NO;
        reimbursementSwitch.selected = NO;
    }
    
    */

    if (interestView.selectedIndex != 1) {
        interestxianshiLabel.text = [NSString stringWithFormat:@"应付年利率:%0.2f%%",[_loan interestRateWithLoanPeriod:_loan.loanPeriod money:[self getMoneyWithOthers] interest:[_loan.interest floatValue]]*100];

    }
    
/*
    CGFloat interest = [self interestPerYearWithInterest:[interestTextField.text floatValue] money:[moneyTextField.text floatValue] month:[timeLongLabel.text integerValue] isPostInterest:!kouXiFangShiSwitch.selected];
    if (interest >= 0) {
        interestxianshiLabel.text = [NSString stringWithFormat:@"所付利息年化利率:%0.2f%%",interest*100];
        
    }
    else
    {
        interestxianshiLabel.text = [NSString stringWithFormat:@"所付利息年化利率:=="];
        
    }
*/

}

- (void)sliderFinsh:(LoanPeriod)loanPeriod
{//滑动结束
    
    if (loanPeriod < LoanPeriod_MONTH_2)
    {
        _loan.repayType = 0;
    }
    
    _loan.loanPeriod = loanPeriod;
    

    
    _loan.interest = interestTextField.text;

    if (_loan.repayType == 0) {
        _loan.installmentList = [LoanDetailsInstallmentView installmentArrayWithMoney:moneyTextField.text withInterest:interestTextField.text withUserTime:_timeTextField.text withTimeLong:sliderView.loanPeriod repayType:0 kouxifangshi:_loan.interestType];
    }
    else
    {
        _loan.installmentList =[LoanDetailsInstallmentView installmentArrayWithMoney:moneyTextField.text withInterest:interestTextField.text withUserTime:_timeTextField.text withTimeLong:sliderView.loanPeriod kouxifangshi:_loan.interestType];

    }
    installmentView.array = _loan.installmentList;
    [self refreshSubViews];

//    [_tableView reloadData];
}

#pragma mark  开关按钮Aciton
- (void)switchAction:(UIButton *)sender
{
    sender.selected = !sender.selected;

    if ([sender isEqual:reimbursementSwitch]) {

        if (sliderView.loanPeriod < LoanPeriod_MONTH_2) {
            [YXBTool showAlertViewWithString:@"小于2个月,暂不支持分期"];
            sender.selected = NO;
        }
        _loan.repayType = sender.selected;

//        installmentView.hidden = !reimbursementSwitch.selected;
//        installmentView.hidden = NO;
        [self sliderFinsh:sliderView.loanPeriod];
    }else if ([sender isEqual:interestSwitch]){
        if (!interestSwitch.selected) {
            [self interesthidden:YES];
            _loan.interestType = FREE;
            _loan.interest = @"0";
        }else{
            [self interesthidden:NO];
            if (kouXiFangShiSwitch.selected) {
                _loan.interestType = POST_INTEREST;
            }else{
                _loan.interestType = PRE_INTEREST;
            }
            [self kouxifangshiAction];
        }
        
    }else if ([sender isEqual:kouXiFangShiSwitch]){
        if (kouXiFangShiSwitch.selected == YES) {
            _loan.interestType = POST_INTEREST;
//            _loan.interestType = PRE_INTEREST;
            if ([interestTextField.text integerValue] >= [moneyTextField.text integerValue]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"先息方式利息不能大于本金" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                    
                    interestTextField.text = @"";
                    _loan.interest = @"0";
                }];
            }
        }else{
            _loan.interestType = PRE_INTEREST;
//            _loan.interestType = POST_INTEREST;
        }
        
        [self sliderFinsh:sliderView.loanPeriod];
    }
//    [_tableView reloadData];
    [self isShownDakuanLabel];
    
//    [self refreshSubViews];
    [self sliderFinsh:sliderView.loanPeriod];


    _tableView.contentSize = CGSizeMake(kDeviceWidth, installmentView.origin.y+installmentView.size.height);

}
#pragma mark 累加显示按钮
- (void)addupBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    isShowaddUPMoney = sender.selected;
    addUpView.hidden = !sender.selected;
//    QCBaseTableView * table = (QCBaseTableView *)_tableView;

//    [_tableView reloadData];
    [self refreshSubViews];
}

#pragma mark ---- HTTP 获取详情页面
- (void)getTLoanDetailWithLoanID:(NSInteger)loanId
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak LoanDetailsViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        [this stopDefaultAnimation];
    } cancel:^(int d) {
//        [ProgressHUD showErrorWithStatus:@"操作失败！"];
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            QCBaseTableView * table = (QCBaseTableView *)_tableView;
            [table reloadDeals];

        }
        
    } param:^(NSString *s) {
        

        [this httpLOadParams:s httpOperation:assginHtttperator WithLoanID:loanId];
        
    } complete:^(Loan* r, int taskid) {
        
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation WithLoanID:(NSInteger)loanId
{
    LoanManagerV2* _Loanmanger = (LoanManagerV2*)  [httpOperation getAopInstance:[LoanManagerV2 class] returnValue:[Loan class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    //        if (loanId != 0) {
    //            [_Loanmanger getTLoanDetail:userModel.user.t_id loanId:loanId];
    //
    //        }
    [_Loanmanger getTLoanDetailNew:userModel.user.t_id loanId:loanId loanFriendType:self.loan.loanFriendType];
}
//请求完成
-(void)httpLoadComplete:(Loan *)r{
    if (r.errCode == 0) {
        self.loan = r;
//        self.loan.status = APPLYING_NEEDRECORD;
        //            r.postponePeriod = 3;//测试延期
        if (r.postponePeriod!=0) {
            ispostpone = YES;
        }
        if (self.loan.verifyVideoUrl.length>0) {
            self.isShowVedioCertifict = YES;
        }else{
            self.isShowVedioCertifict = NO;
        }
        //显示倒计时
        if (_loan.status == QUICKLEND_NEEDCONFIRM) {
            //                timeCountLabel.hidden = NO;
            if (timeCountLabel == nil) {
                timeCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 80)];
                timeCountLabel.textAlignment = NSTextAlignmentCenter;
                timeCountLabel.textColor = [UIColor blackColor];
                timeCountLabel.numberOfLines = 2;
                timeCountLabel.lineBreakMode = 0;
                _tableView.tableHeaderView = timeCountLabel;
            }
            
        }
        else
        {
            //                timeCountLabel.hidden = YES;
            [timeCountLabel removeFromSuperview];
            _tableView.tableHeaderView = nil;
        }
        
        
        if (timeCountLabel != nil) {
            QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
            NSString *tintText;
            NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] init];
            
            if (userModel.user.t_id == _loan.lenderId) {
                tintText = [NSString stringWithFormat:@"若对方在%@前未操作,\n放款全额将自动退回到您的账号",self.loan.closeDate];
                aString = [[NSMutableAttributedString alloc] initWithString:tintText];
                [aString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, 19)];
            }
            else
            {
                tintText = [NSString stringWithFormat:@"请于%@前操作,\n若超时未操作,交易将自动关闭",self.loan.closeDate];
                aString = [[NSMutableAttributedString alloc] initWithString:tintText];
                [aString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 19)];
                
                
                
            }
            timeCountLabel.attributedText = aString;
        }
        if (r.messageFlag) {
            UIImage * image = [UIImage imageNamed:@"postpone.png"];
            UIImageView * postponeImage = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth-100, 200, image.size.width, image.size.height)];
            postponeImage.image = image;
            postponeImage.center = CGPointMake(self.view.center.x, 150);
            [_tableView addSubview:postponeImage];
            NSString * message;
            if (self.bOrL == BORROWER) {
                message = r.borrowerMessage;
            }else{
                message = r.lenderMessage;
            }
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"去看看",@"忽略", nil];
            [alert show];
            
        }
        [self createFooterViewWith:r];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        //放款人操作
        if (userModel.user.t_id == _loan.lenderId) {
            installmentView.installmentStatus = DoNotChoose;
            
        }
        else
        {
            installmentView.installmentStatus = CanChoose;
        }
        [UIView animateWithDuration:0.3 animations:^{
            _tableView.hidden = NO;
        }];
        //            [self sliderFinsh:r.loanPeriod];
        
        
    }else{
        NSLog(@"%@",r.errString);
    }
    if ([_tableView isKindOfClass:[QCBaseTableView class]]) {
        QCBaseTableView * table = (QCBaseTableView *)_tableView;
        [table reloadDeals];
        
    }else {
        
    }
    //        [_tableView reloadData];
    
    if (_loan.useBankRate == 1) {
        interestView.selectedIndex = 1;
    }
    else if (_loan.interestType == FREE)
    {
        interestView.selectedIndex = 2;
    }
    else{
        interestView.selectedIndex = 0;
    }

    [self refreshSubViews];
    if (self.bOrL == COMPILE) {
        [self userInteractionEnabled:YES];
        
    }
    else
    {
        [self userInteractionEnabled:NO];
        
    }
    
    //添加状态标
    if (self.loan.status == REPAYED ||
        self.loan.status == BORROWERCANCELLED ||
        self.loan.status == DECLINED ||
        self.loan.status == CLOSED ||
        self.loan.status == QUICKLEND_DECLINED ||
        self.loan.status == QUICKLEND_CLOSED)
    {
        if (statusImageView != nil && statusImageView.superview) {
            [statusImageView removeFromSuperview];
        }
        statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth - 259)/2.0, 150, 259, 103)];
        statusImageView.image = [UIImage imageNamed:[self stateImageNameWithStateCode:_loan.status]];
        //            statusImageView.contentMode = UIViewContentModeCenter;
        [_tableView addSubview:statusImageView];
        
        installmentView.userInteractionEnabled = NO;
    }
    else
    {
        statusImageView.image = nil;
        statusImageView = nil;
        //            _tableView.tableHeaderView = nil;
    }

}
-(NSString *)stateImageNameWithStateCode:(L_LoanStatus)status
{
    NSString *imageName = @"";
    if(status == REPAYED)
    {
        imageName = @"loan_completed.png";
    }else if (status == BORROWERCANCELLED)
    {
        imageName = @"loan_cancel.png";
    }else if (status == DECLINED || status == QUICKLEND_DECLINED)
    {
        imageName = @"loan_rejected.png";
    }
    else if (status == CLOSED || status == QUICKLEND_CLOSED)
    {
        imageName = @"loan_closed.png";
    }
    
    return imageName;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self refreshData];

    if (alertView.tag == 31) {
        return;
    }else if(alertView.tag == 30){
//        [self refreshData];

//        [self.navigationController popViewControllerAnimated:YES];
    }else if (alertView.tag == 666){
        if (_bOrL == COMPILE) {
            [self.navigationController popViewControllerAnimated:YES];

        }
        [self refreshData];
    }else if (alertView.tag == 665){
        return;
    } else if (alertView.tag == 10010){
        if (buttonIndex == 1) {
            
            [self toLogin];
        }
    } else if (alertView.tag == 10086){
        if (buttonIndex == 1) {
            
            [self toAuthentication];
        }
    }else if (alertView.tag == LoanDetailsViewControllerPostPoneAlertViewTag)
    {
        if (buttonIndex == 1) {
            UITextField *tf=[alertView textFieldAtIndex:0];
            
            QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
            self.loan.yxbToken = userModel.user.yxbToken;
            self.loan.currentCompensation = tf.text;
            self.loan.operationType = POSTPONE_AFTERPAY;
            statusHttp.delegate = self;
            statusHttp.netNumber = LoanDetailsViewControllerPostPoneAlertViewTag;
            [statusHttp __yxb_service__createAndModifyTLoan:self.loan];
            
        }

    }else if (alertView.tag == 8888){
        if (buttonIndex == 1) {
            AuthenticationViewController *authentic = [[AuthenticationViewController alloc] init];
            [self.navigationController pushViewController:authentic animated:YES];
        }
    }
    
}

#pragma mark  创建底部按钮
- (void)createFooterViewWith:(Loan *)loan
{
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];

    NSArray * array;
    if (self.bOrL != COMPILE) {
        /*
        if (loan.status == APPLYING_NEEDCONFIRM ||loan.status == APPLYING_NEEDCONFIRM_NEEDAGREE_BYBORROWER) {
            if(loan.borrowerId == userModel.user.t_id)
            {
                //只有借款人可以编辑
                [self setNavigationBarItmeWithTitle:@"编辑"];
                if (loan.loanFriendType == YXBPayDesWeChat) {
                    [self setNavigationBarItmeWithTitle:@"继续发送"];
                }

            }
        }
        if ((userModel.user.t_id == loan.borrowerId) &&
            (loan.status == NEEDREPAY) &&
            loan.repayType == 0)
        {
            [self setNavigationBarItmeWithTitle:@"延期"];

        }
        if ((userModel.user.t_id == loan.borrowerId) &&
            (loan.status == MODIFY_AFTERLEND_NEEDCONFIRM_BYLENDER))
        {
            NSString * firstDate = _loan.lastModifyDate;
            NSString * endDate = [YXBTool getCurrentTime];
            NSInteger day = [YXBTool numberOfDaysBetween:firstDate and:endDate];
            if (day >= 0 && day <= 7) {
                NSString *tintStr = [NSString stringWithFormat:@"剩余%ld天",(long)(7-day)];
//                [ProgressHUD showSuccessWithStatus:tintStr];
                [self setNavigationBarItmeWithTitle:tintStr];

            }
            
        }
        
        */
        
        if ((userModel.user.t_id == loan.borrowerId))
        {
            if (loan.status == APPLYING_NEEDCONFIRM ||loan.status == APPLYING_NEEDCONFIRM_NEEDAGREE_BYBORROWER)
            {
                
                //只有借款人可以编辑
                [self setNavigationBarItmeWithTitle:@"编辑"];
                if (loan.loanFriendType == YXBPayDesWeChat) {
                    [self setNavigationBarItmeWithTitle:@"继续发送"];
                }

            }
            else if ((loan.status == NEEDREPAY) && loan.repayType == 0)
            {
                [self setNavigationBarItmeWithTitle:@"延期"];

            }else if (loan.status == MODIFY_AFTERLEND_NEEDCONFIRM_BYLENDER)
            {
                NSString * firstDate = _loan.lastModifyDate;
                NSString * endDate = [YXBTool getCurrentTime];
                NSInteger day = [YXBTool numberOfDaysBetween:firstDate and:endDate];
                if (day >= 0 && day <= 7) {
                    NSString *tintStr = [NSString stringWithFormat:@"剩余%ld天",(long)(7-day)];
                    //                [ProgressHUD showSuccessWithStatus:tintStr];
                    [self setNavigationBarItmeWithTitle:tintStr];
                    
                }

            }
            else
            {
                [self setNavigationBarItmeWithTitle:nil];

            }
        }
        else
        {
            if (loan.status == APPLYING_NEEDCONFIRM ||loan.status == APPLYING_NEEDCONFIRM_NEEDAGREE_BYBORROWER)
            {
                
                //只有借款人可以编辑
                [self setNavigationBarItmeWithTitle:@"编辑"];
                
            }
            else
            {
                [self setNavigationBarItmeWithTitle:nil];
                
            }

                

        }
        
        

    }
        if (_bOrL == BORROWER ) {
        switch (loan.status) {
                
            case APPLYING_NEEDRECORD://【  申请中   】	310-> 借款中-已打款-待录制视频
                array = @[@"去录制视频"];
                break;
            case APPLYING_NEEDCONFIRMRECORD://【  申请中   】	320-> 借款中-已打款-待确认视频
                array = @[@"提醒对方审核"];
                break;

            case APPLYING_NEEDCONFIRM://【  申请中   】	100-> 借款中-待放款人同意
                array = @[@"取消借款"];
                break;
            case APPLYING_NEEDCONFIRM_NEEDAGREE_BYBORROWER://【  申请中   】	200-> 借款中-待借款人确认
                array = @[@"取消借款",@"同意修改并借款",];
                break;
            case APPLYING_NEEDPAY://【  申请中   】	300-> 借款中-待打款
                array = @[@"取消借款"];
                break;
            case OFFLINE_LENDMONEY_CONFIRM://【  申请中   】	350-> 线下打款确认
                array = @[@"未收到打款",@"已收到打款"];
                break;
            case NEEDREPAY://【  还款中   】	400-> 待还款
                array = @[@"去还款"];
                break;
            case MODIFY_AFTERLEND_NEEDCONFIRM_BYLENDER://【  还款中   】	500-> 申请修改-放款方确认
                array = @[@"取消延期"];
                break;
            case NEEDRECEIVE://【  还款中   】	600-> 线下还款确认(全额)
                array = @[@"电话通知"];
                break;
            case REPAYED://【历史记录】	700-> 还款成功
                array = nil;
                break;
            case BORROWERCANCELLED://【历史记录】	800-> 已取消
                array = @[@"发送给其他好友试试"];
                break;
            case DECLINED://【历史记录】	810-> 已拒绝
                array = @[@"发送给其他好友试试"];
                break;
            case CLOSED://【历史记录】	820-> 已关闭
                array = @[@"发送给其他好友试试"];
                break;
            case QUICKLEND_NEEDCONFIRM://【  申请中   】	100-> 借款中-待放款人同意
                array = @[@"同意借款",@"拒绝借款"];
                break;

            default:
                array = Nil;
                break;
        }
    }else if (_bOrL == LENDERS){
        switch (loan.status) {
            case APPLYING_NEEDRECORD://【  申请中   】	310-> 借款中-已打款-待录制视频
                array = @[@"提醒对方录制视频"];
                break;
            case APPLYING_NEEDCONFIRMRECORD://【  申请中   】	320-> 借款中-已打款-待确认视频
                array = @[@"去审核"];
                break;
                
                
            case APPLYING_NEEDCONFIRM://【  申请中   】	100-> 借款中-待放款人同意
                array = @[@"拒绝借款",@"同意借款"];
                break;
            case APPLYING_NEEDCONFIRM_NEEDAGREE_BYBORROWER://【  申请中   】	200-> 借款中-待借款人确认
                array = @[@"拒绝借款"];
                break;
            case  APPLYING_NEEDPAY://【  申请中   】	300-> 借款中-待打款
                array = @[@"去打款"];
                break;
            case OFFLINE_LENDMONEY_CONFIRM://【  申请中   】	350-> 线下打款确认
                array = nil;
                break;
            case NEEDREPAY://【  还款中   】	400-> 待还款:
                array = nil;
                break;
            case MODIFY_AFTERLEND_NEEDCONFIRM_BYLENDER://【  还款中   】	500-> 申请修改-放款方确认
                array = @[@"拒绝延期",@"同意延期"];
                break;
            case NEEDRECEIVE://【  还款中   】	600-> 线下还款确认(全额)
                array = @[@"未收到还款",@"确认已收到还款"];
                break;
//            case REPAYED://【历史记录】	700-> 还款成功
//                array = nil;
//                break;
//            case BORROWERCANCELLED://【历史记录】	800-> 已取消
//                array = @[@"查看新单据"];
//                break;
//            case DECLINED://【历史记录】	810-> 已拒绝
//                array = @[@"查看新单据"];
//                break;
//            case CLOSED://【历史记录】	820-> 已关闭
//                array = @[@"拒绝延期",@"同意延期"];
//                break;
            default:
                array = nil;
                break;
        }
    }else if (self.bOrL == COMPILE){
        array = @[@"取消修改",@"确定修改"];
    }
    if (array) {
        
        footerView = [[DetailsFooterView alloc]initWithNameArr:array];
//        _tableView.height = kDeviceHeight - 64 - 50 - _segmentHeight - bottomTextLabel.height;
        [self adjustTableViewFrameWithSegment];
        
        if (_segmentHeight > 0) {
            footerView.frame = CGRectMake(footerView.left, footerView.top - _segmentHeight, footerView.width, footerView.height);
        }
        footerView.delegate =self;
        [self.view addSubview:footerView];
        
        
    }


    NSLog(@"bottomTextLabel--%@---%@",bottomTextLabel,bottomTextLabel.superview);

}



- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
}

- (void)toAuthentication {
    AuthenticationViewController *authentic = [[AuthenticationViewController alloc] init];
    [self.navigationController pushViewController:authentic animated:YES];
}
#pragma mark  底部按钮回调
- (void)footerViewbuttonActionWithSender:(UIButton *)sender
{
    
    NSInteger temp = [[moneyTextField text] integerValue] - [[interestTextField text] integerValue];
    if (kouXiFangShiSwitch.selected && temp <= 0) {
        [YXBTool showAlertViewWithString:@"先息方式利息不能大于本金"];
        return;
    }

    if (interestSwitch.selected && ([[interestTextField text] isEqualToString:@""])) {
        interestTextField.text = @"1";
        _loan.interest = interestTextField.text;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您输入的利息为空，系统默认利息1元" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                [self footerSureAction:sender];
            }
        }];
        
    }
    else
    {
        [self footerSureAction:sender];

    }
    

}

-(void)footerSureAction:(UIButton *)sender
{
    
    statusHttp = [[StatusHttp alloc]init];
    statusHttp.delegate = self;
    self.loan.loanFriendType = _loan.loanFriendType;
    if ([moneyTextField.text isEqualToString:@""]) {
            moneyTextField.layer.borderWidth= 0.5;
            moneyTextField.layer.borderColor = [UIColor redColor].CGColor;
            [YXBTool showAlertViewWithString:@"请输入金额"];
        return;

    }
    
    [self footActionWithSender:sender];
    
    
}

//根据不同状态分别提示
-(void)footActionWithSender:(UIButton *)sender
{
    self.selectedBtn = sender.titleLabel.text;
    
    if([sender.titleLabel.text isEqualToString:@"去录制视频"]){
        ImagePickerViewController *imagePVC = [[ImagePickerViewController alloc] init];
        imagePVC.loanId = self.loan.t_id;
        imagePVC.verifyText=self.loan.verifyText;
        [self.navigationController pushViewController:imagePVC animated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"去审核"]){//
        
        [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:self.loan.jumpToCheckUrl params:nil] hasTopBar:YES titleName:@"审核视频"];
    }else if([sender.titleLabel.text isEqualToString:@"提醒对方录制视频"]){
        
            NSString *tintMsg = [NSString stringWithFormat:@"您确定%@",sender.titleLabel.text];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                
                if (buttonIndex == 1) {
                        [statusHttp __yxb_service__operateTLoan:REMIND_NEED_UPLOAD_VIDEO withTloan:_loan];
                }
            }];

    }else if([sender.titleLabel.text isEqualToString:@"提醒对方审核"]){
        
        NSString *tintMsg = [NSString stringWithFormat:@"您确定%@",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                [statusHttp __yxb_service__operateTLoan:REMIND_CHECK_UPLOAD_VIDEO withTloan:_loan];
            }
        }];
        
    }

    
    
    
    
    //向好友借款
    if ([sender.titleLabel.text isEqualToString:@"发送给其他好友试试"]||[sender.titleLabel.text isEqualToString:@"向好友借款"]) {
        
        
        
        if ([moneyTextField.text isEqualToString:@""]) {
            
            // [YXBTool showAlertViewWithString:@"请输入金额"];
            if (interestSwitch.selected == YES && [interestTextField.text length] <= 0) {
                [YXBTool showAlertViewWithString:@"利息不能为空!"];
                return;
                
            }
            //  moneyTextField.layer.borderWidth= 0.5;
            //  moneyTextField.layer.borderColor = [UIColor redColor].CGColor;
            
            interestTextField.layer.borderWidth = 0.5;
            interestTextField.layer.borderColor = [UIColor redColor].CGColor;
        }else{ //正常流程直接选择好友借款
            if (_fromFriendUser == nil) {
                /*
                 QCFriendsViewController * friendsViewController = [[QCFriendsViewController alloc]init];
                 [self BorrowWithoperationType:APPLY];
                 friendsViewController.loanModel = self.loan;
                 friendsViewController.isFromBorrow = YES;
                 [[YXBTool getCurrentNav] pushViewController:friendsViewController animated:YES];
                 */
                /*
                 有借有还好友修改
                 */
                [self loanFromWXReSend:NO];
                
                /*
                 [self BorrowWithoperationType:APPLY];
                 
                 [self loanFromWX];
                 */
            }
            else //快速流程 从好友跳过来借款
            {
                QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
                
                statusHttp = [[StatusHttp alloc]init];
                statusHttp.delegate = self;
                self.loan.operationType = LOAN_APPLY;
                self.loan.borrowerId = userModel.user.t_id;
                self.loan.lenderId  = _fromFriendUser.t_id;
                self.loan.yxbToken = userModel.user.yxbToken;
                self.loan.loanFriendType = YXBPayDesFriend;
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定向好友借款？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                //                [alert showal]
                [statusHttp __yxb_service__createAndModifyTLoan:_loan];
                
            }
        }
        
    }else if ([sender.titleLabel.text isEqualToString:@"选择好友"] ||
              [sender.titleLabel.text isEqualToString:@"支付"])
    {
        //快速放款
        if ([moneyTextField.text isEqualToString:@""]) {
            //                    moneyTextField.layer.borderWidth= 0.5;
            //                    moneyTextField.layer.borderColor = [UIColor redColor].CGColor;
            //                    [YXBTool showAlertViewWithString:@"请输入金额"];
            
            interestTextField.layer.borderWidth = 0.5;
            interestTextField.layer.borderColor = [UIColor redColor].CGColor;
        }else{ //正常流程直接选择好友放款
            if (_lendMyFriend == nil) {
                //                        QCFriendsViewController * friendsViewController = [[QCFriendsViewController alloc]init];
                //                        [self BorrowWithoperationType:APPLY];
                //                        friendsViewController.loanModel = self.loan;
                //                        friendsViewController.isFromBorrow = YES;
                //                        [[YXBTool getCurrentNav] pushViewController:friendsViewController animated:YES];
                /*
                 有借有还好友修改
                 */
                
                /*
                LoanOrRepayFriendsViewController * friendsViewController = [[LoanOrRepayFriendsViewController alloc]init];
                [self lendWithOperationType:LOAN_QUICK_SEND_QUICK_LEND];
                self.loan.loanType = LoanQuickTypeNormal;
                self.loan.loanFriendType = YXBPayDesFriend;
                friendsViewController.loanModel = self.loan;
                friendsViewController.isFromLender = YES;
                [[YXBTool getCurrentNav] pushViewController:friendsViewController animated:YES];
                */
//                LoanFriendTypeViewController *controller = [[LoanFriendTypeViewController alloc] init];
//                [self BorrowWithoperationType:APPLY];
//                controller.friendType = LoanNewFriendTypeJieChu;
//                controller.loanModel = self.loan;
//                [[YXBTool getCurrentNav] pushViewController:controller animated:YES];
                
                FriendSelecteViewController *friendController = [[FriendSelecteViewController alloc] init];
                QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
//                [self BorrowWithoperationType:APPLY];
                self.loan.loanFriendType = 1;
                self.loan.lenderId = userModel.user.t_id;
                self.loan.operationType = LOAN_QUICK_SEND_QUICK_LEND;
                self.loan.yxbToken = userModel.user.yxbToken;
                friendController.friendType = LoanNewFriendTypeJieChu;
                friendController.loanModel = self.loan;
                [[YXBTool getCurrentNav] pushViewController:friendController animated:YES];


                
                
                
                
            }
            else //快速流程 从好友跳过来借款
            {
                QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
                
                statusHttp = [[StatusHttp alloc]init];
                statusHttp.delegate = self;
                //                self.loan.operationType = LOAN_APPLY;
                [self lendWithOperationType:LOAN_QUICK_SEND_QUICK_LEND];
                
                self.loan.borrowerId = _lendMyFriend.t_id ;
                self.loan.lenderId = userModel.user.t_id;
                self.loan.yxbToken = userModel.user.yxbToken;
                self.loan.loanType = LoanQuickTypeNormal;//
                self.loan.loanFriendType = YXBPayDesFriend;
                /*
                 PayViewController * payViewcontroller = [[PayViewController alloc]init];
                 payViewcontroller.payWay = YXBPayWayFukuan;
                 payViewcontroller.loan = self.loan;
                 payViewcontroller.isQuickLend = YES;
                 [self.navigationController pushViewController:payViewcontroller animated:YES];
                 
                 */
                
                YXBPayAction *pay = [[YXBPayAction alloc] init];
                pay.payWay = YXBPayWayFukuan;
                pay.isQuickLend = YES;
                pay.loan = self.loan;
                [pay payAction];
                
                
                //                [statusHttp __yxb_service__createAndModifyTLoan:_loan];
                
            }
        }
        
    }else if (self.bOrL == BORROWER && [sender.titleLabel.text isEqualToString:@"拒绝借款"]){
        
        //极速借出---》借款人拒绝借款
        NSString *tintMsg = [NSString stringWithFormat:@"您确定%@",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                [statusHttp __yxb_service__operateTLoan:DECLINE_QUICK_LEND withTloan:_loan];

            }
        }];
        
        
    }else if (self.bOrL == LENDERS && [sender.titleLabel.text isEqualToString:@"拒绝借款"]){
        //        [statusHttp declineTLoan:userModel.user.t_id loanId:_loan.t_id];
        NSString *tintMsg = [NSString stringWithFormat:@"您确定%@",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {

        [statusHttp __yxb_service__operateTLoan:LOAN_DECLINE withTloan:_loan];
            }
        }];

        
    }else if (self.bOrL == BORROWER && [sender.titleLabel.text isEqualToString:@"同意借款"]){
        //快速放款 ---》借款人同意
        //        [statusHttp comfirmTLoan:userModel.user.t_id loanId:_loan.t_id];
        [statusHttp __yxb_service__operateTLoan:CONFIRM_QUICK_LEND withTloan:_loan];
        
    }else if (self.bOrL == BORROWER && [sender.titleLabel.text isEqualToString:@"同意修改并借款"]){
        NSString *tintMsg = [NSString stringWithFormat:@"%@?",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                [statusHttp __yxb_service__operateTLoan:LOAN_CONFIRM_MODIFY withTloan:_loan];
            }
        }];

        
    }
    else if (self.bOrL == LENDERS && [sender.titleLabel.text isEqualToString:@"同意借款"]){
        //        普通借款，放款人同意
        //        [statusHttp comfirmTLoan:userModel.user.t_id loanId:_loan.t_id];
        
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        if (!userModel.isLogin) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有登录，请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alterView.tag = 10010;
            [alterView show];
            return;
        }
        
        if ([UserState isLv2] == E_NO_OPERATE) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"为保障您的资金安全，放款前请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alterView.tag = 10086;
            [alterView show];
            return;
        }else if ([UserState isLv2] == E_IN_REVIEW) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alterView show];
            return;
        }else if ([UserState isLv2] == E_FAIL_UserStateRes) {
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"您的身份认证失败，请从新认证" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alterView show];
            return;
        }
        //                if (userModel.user.accountStatus == 1) {
        //                    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息正在审核中..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        //                    //        alterView.tag = 10086;
        //                    [alterView show];
        //                    return;
        //                }else if (userModel.user.accountStatus == 4) {
        //                    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名信息已提交" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        //                    [alterView show];
        //                    return;
        //                }else if (userModel.user.accountStatus == 2) {
        //                    //通过
        //                }else if (userModel.user.accountStatus == 3) {
        //                    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息，审核失败，请重新进行实名认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //                    alterView.tag = 10086;
        //                    [alterView show];
        //                    return;
        //                }else if (userModel.user.accountStatus == 0) {
        //                    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"为了更快的借入（借出）款项，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        //                    alterView.tag = 10086;
        //                    [alterView show];
        //                    return;
        //                }
        
        [statusHttp __yxb_service__operateTLoan:LOAN_CONFIRM withTloan:_loan];
        
    }else if ([sender.titleLabel.text isEqualToString:@"取消借款"]){
        
        NSString *tintMsg = [NSString stringWithFormat:@"您确定%@?",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                [statusHttp __yxb_service__operateTLoan:LOAN_BORROWERCANCEL withTloan:_loan];
            }
        }];

        
    }else if ([sender.titleLabel.text isEqualToString:@"申请延期"]){
        
    }else if ([sender.titleLabel.text isEqualToString:@"取消修改"]){
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([sender.titleLabel.text isEqualToString:@"确定修改"]){
        NSString *tintMsg = [NSString stringWithFormat:@"您%@?",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                [self BorrowWithoperationType:MODIFY];
                [statusHttp __yxb_service__createAndModifyTLoan:self.loan];
            }
        }];

        
    }else if ([sender.titleLabel.text isEqualToString:@"同意延期"]){
        
        NSString *tintMsg = [NSString stringWithFormat:@"您确定%@?",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                [statusHttp __yxb_service__operateTLoan:LOAN_CONFIRM_MODIFY_AFTERPAY withTloan:_loan];
            }
        }];

        
    }else if ([sender.titleLabel.text isEqualToString:@"未收到打款"]){
        //        [statusHttp __yxb_service__operateTLoan:LOAN_PAY_NOTYXB_NOT_BE_PAID withTloan:_loan];
        
        NSString *tintMsg = [NSString stringWithFormat:@"您确定%@?",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
                CgLoan * cgloan = [[CgLoan alloc]init];
                cgloan.yxbToken = userModel.user.yxbToken;
                cgloan.userId = userModel.user.t_id;
                cgloan.mainId = _loan.t_id;
                cgloan.operationType = LOAN_PAY_NOTYXB_NOT_BE_PAID;
                cgloan.totalMoney = _loan.money;
                
                [statusHttp __yxb__chargeTLoanwithTloan:cgloan];
            }
        }];

        
        
    }else if ([sender.titleLabel.text isEqualToString:@"已收到打款"]){
        //        [statusHttp __yxb_service__operateTLoan:LOAN_PAY_NOTYXB_BE_PAID withTloan:_loan];
        NSString *tintMsg = [NSString stringWithFormat:@"您确定%@?",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
                CgLoan * cgloan = [[CgLoan alloc]init];
                cgloan.yxbToken = userModel.user.yxbToken;
                cgloan.userId = userModel.user.t_id;
                cgloan.mainId = _loan.t_id;
                cgloan.operationType = LOAN_PAY_NOTYXB_BE_PAID;
                cgloan.totalMoney = _loan.money;
                
                [statusHttp __yxb__chargeTLoanwithTloan:cgloan];
            }
        }];

        
        
        
    }else if ([sender.titleLabel.text isEqualToString:@"未收到对方还款"]){
        
        NSString *tintMsg = [NSString stringWithFormat:@"您确定%@?",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                [statusHttp __yxb_service__operateTLoan:LOAN_REPAY_NOTYXB_NOT_BE_PAID withTloan:_loan];
            }
        }];

        
    }else if ([sender.titleLabel.text isEqualToString:@"确认已收到对方还款"]){
        NSString *tintMsg = [NSString stringWithFormat:@"您确定%@?",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                [statusHttp __yxb_service__operateTLoan:LOAN_REPAY_NOTYXB_BE_PAID withTloan:_loan];
            }
        }];

    }else if ([sender.titleLabel.text isEqualToString:@"取消延期"]){
        NSString *tintMsg = [NSString stringWithFormat:@"您确定%@?",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                [statusHttp __yxb_service__operateTLoan:CANCEL_POSTPONE_AFTERPAY withTloan:_loan];
            }
        }];

        
    }else if ([sender.titleLabel.text isEqualToString:@"拒绝延期"]){
        NSString *tintMsg = [NSString stringWithFormat:@"您确定%@?",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                [statusHttp __yxb_service__operateTLoan:LOAN_DECLINE_MODIFY_AFTERPAY withTloan:_loan];
            }
        }];

        
    }else if ([sender.titleLabel.text isEqualToString:@"同意延期"]){
        NSString *tintMsg = [NSString stringWithFormat:@"您确定%@?",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                [statusHttp __yxb_service__operateTLoan:LOAN_CONFIRM_MODIFY_AFTERPAY withTloan:_loan];
            }
        }];

        
    }else if ([sender.titleLabel.text isEqualToString:@"去还款"] || [sender.titleLabel.text isEqualToString:@"去打款"]){
        
        if ([sender.titleLabel.text isEqualToString:@"去还款"]) {
            if (([self.loan.installmentList count] > 1) &&
                (_selectedArray == nil || [_selectedArray count] == 0))
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"还款提示" message:@"您尚未选择分期还款的期次" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                return;
            }
            
        }
        
        /*
         PayViewController * payViewcontroller = [[PayViewController alloc]init];
         if ([sender.titleLabel.text isEqualToString:@"去打款"]) {
         payViewcontroller.payWay = YXBPayWayFukuan;
         }
         else
         {
         payViewcontroller.payWay = YXBPayWayHuankuan;
         
         }
         
         if (([self.loan.installmentList count] == 1) &&((_selectedArray == nil) || ([_selectedArray count] == 0)))
         {
         [self.selectedArray addObjectsFromArray:self.loan.installmentList];
         }
         payViewcontroller.selectedArray = self.selectedArray;
         payViewcontroller.loan = self.loan;
         [self.navigationController pushViewController:payViewcontroller animated:YES];
         
         */
        
        YXBPayAction *pay = [[YXBPayAction alloc] init];
        if ([sender.titleLabel.text isEqualToString:@"去打款"]) {
            pay.payWay = YXBPayWayFukuan;
        }
        else
        {
            pay.payWay = YXBPayWayHuankuan;
            
        }
        
        if (([self.loan.installmentList count] == 1) &&((_selectedArray == nil) || ([_selectedArray count] == 0)))
        {
            [self.selectedArray addObjectsFromArray:self.loan.installmentList];
        }
        
        pay.selectedArray = self.selectedArray;
        //                pay.isQuickLend = YES;
        pay.loan = self.loan;
        [pay payAction];
        
    }else if ([sender.titleLabel.text isEqualToString:@"电话通知"]){
        [self tellWithTellNumber:_loan.friendUsername];
    }else if ([sender.titleLabel.text isEqualToString:@"未收到还款"]){
        
        NSString *tintMsg = [NSString stringWithFormat:@"您确定%@?",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
                CgLoan * cgloan = [[CgLoan alloc]init];
                cgloan.yxbToken = userModel.user.yxbToken;
                cgloan.userId = userModel.user.t_id;
                cgloan.mainId = _loan.t_id;
                cgloan.operationType = LOAN_REPAY_NOTYXB_NOT_BE_PAID;
                cgloan.totalMoney = _loan.money;
                
                [statusHttp __yxb__chargeTLoanwithTloan:cgloan];
            }
        }];

    }else if ([sender.titleLabel.text isEqualToString:@"确认已收到还款"]){
        //        [statusHttp __yxb_service__operateTLoan:LOAN_REPAY_NOTYXB_BE_PAID withTloan:_loan];
        
        NSString *tintMsg = [NSString stringWithFormat:@"您确定%@?",sender.titleLabel.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:tintMsg delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
                CgLoan * cgloan = [[CgLoan alloc]init];
                cgloan.yxbToken = userModel.user.yxbToken;
                cgloan.userId = userModel.user.t_id;
                cgloan.mainId = _loan.t_id;
                cgloan.operationType = LOAN_REPAY_NOTYXB_BE_PAID;
                cgloan.totalMoney = _loan.money;
                
                [statusHttp __yxb__chargeTLoanwithTloan:cgloan];
            }
        }];

    }
    
}


// 打电话给好友
- (void)tellWithTellNumber:(NSString *)number
{
    NSString * telstring = [NSString stringWithFormat:@"tel:%@",number];
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telstring]];
    UIWebView*callWebview =[[UIWebView alloc] init];
    
    NSURL *telURL =[NSURL URLWithString:telstring];
    
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    
    
    [self.view addSubview:callWebview];
    
}


// 给loan 赋值
- (void)BorrowWithoperationType:(int)type
{
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    //编辑不能够修改borrowId
    if(_bOrL != MODIFY)
    {
        self.loan.borrowerId = userModel.user.t_id;

    }
    self.loan.operationType = type;
    self.loan.yxbToken = userModel.user.yxbToken;
    
}

-(void)lendWithOperationType:(int)type
{
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    self.loan.lenderId = userModel.user.t_id;
    
    self.loan.operationType = type;
    self.loan.yxbToken = userModel.user.yxbToken;

}




#pragma StatusHttp类 联网结束回调
- (void)httpCompleteWithResultSet:(TResultSet *)set withHttpTag:(NSInteger)tag
{
    if (set.errCode == [Authentication integerValue]) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:set.errString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"认证", nil];
        alterView.tag = 8888;
        [alterView show];
        return;
    }
    if (set.errCode == 0) {
        if (statusHttp.netNumber == WXLoanNetNumber) {
            [ProgressHUD showSuccessWithStatus:@"调用微信客户端"];
            if (set.errCode == 0) {
                [self callWeChatWithLoanId:set.resInteger];
                
            }
            else
            {
                [ProgressHUD showSuccessWithStatus:set.errString];
                
            }
            return;
        }
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:set.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        if (tag == 1) {
            alert.tag = tag;
            [self.navigationController popViewControllerAnimated:YES];
        }else if (tag == 666){
            if (set.errCode == 0) {
                alert.tag = tag;
            }else{
                alert.tag = tag-1;
            }
            
        }else if (tag == LoanDetailsViewControllerPostPoneAlertViewTag)
        {
            [self setNavigationBarItmeWithTitle:@"剩下7天"];
            
        }
        else{
            if (set.errCode == 0) {
                alert.tag = 30;
            }else{
                alert.tag = 31;
            }
        }
        if (tag==1) {
            return;
        }
        else{
            //        [alert show];
            [ProgressHUD showSuccessWithStatus:set.errString];
        };
        
        if (tag == 888)
        { //同意借款
            if (self.loan.loanFriendType == YXBPayDesWeChat || self.loan.loanFriendType == YXBPayDesContact) {
                for (UIViewController *vc in [self.navigationController viewControllers]) {
                    if ([vc isKindOfClass:[LoanCenterViewController class]]) {
                        [ProgressHUD showSuccessWithStatus:set.errString];
                        [self.navigationController popToViewController:vc animated:YES];
                        
                        return;
                    }
                }
                [self.navigationController popToRootViewControllerAnimated:YES];
                [YXBTool showAlertViewWithString:set.errString];
                
            }
            //        UIViewController *vc = [self.navigationController viewControllers];
            
            else
            {
                //同意之后 如果是放款人 直接去支付
                //同意借款和去打款合并
                
                if (set.errCode == 0) {
                    if (_bOrL == LENDERS && self.loan.status == APPLYING_NEEDCONFIRM && [self.selectedBtn isEqualToString:@"同意借款"])
                    {
                        UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
                        [sender setTitle:@"去打款" forState:UIControlStateNormal];
                        [self footerSureAction:sender];
                    }
                    
                }
                [self QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)_tableView];
                
                
            }
        }
        else
        {
            [self QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)_tableView];
            
        }
        
        if (_fromFriendUser != nil) {
            _fromFriendUser = nil;
            //        LoanOrRepayListViewController * list = [[LoanOrRepayListViewController alloc]init];
            //        list.type = LoanOrRepayListBorrow;
            //        [self.navigationController pushViewController:list animated:YES];
        }

    }
    else
    {
        [ProgressHUD showErrorWithStatus:set.errString];
    }
}


#pragma mark  uitextFiled delegate


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];

    [str replaceCharactersInRange:range withString:string];
    
    if(textField == moneyTextField)
    {
        
        if ([str integerValue] > LoanDetailsViewControllerMaxLoadMoney)
        {
            [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"借款金额最高%d",LoanDetailsViewControllerMaxLoadMoney]];
            moneyTextField.text = [NSString stringWithFormat:@"%d",LoanDetailsViewControllerMaxLoadMoney];
            return NO;
            
        }
//        if ([str integerValue] < LoanDetailsViewControllerMinLoadMoney)
//        {
//            [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"借款金额最少 %d 元",LoanDetailsViewControllerMinLoadMoney]];
//            moneyTextField.text = [NSString stringWithFormat:@"%d",LoanDetailsViewControllerMinLoadMoney];
//            return NO;
//            
//        }

        if ([str integerValue] == 0 && string.integerValue == 0 &&[textField.text integerValue] == 0) {
            return NO;
        }
        
    }else if (textField == interestTextField){
    
        if ([str integerValue] > [_loan.money integerValue])
        {
            [YXBTool showAlertViewWithString:@"利息金额不能大于借款金额"];
            interestTextField.text = moneyTextField.text;
            return NO;
            
        }

    }

    return YES;

}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{

/*
    if ((upFlag == NO) && [textField isEqual:interestTextField]) {
        _tableView.height = _tableView.height - TableViewHeightTopAlign;
        upFlag = YES;
        
    }
    
    */
    textField.layer.borderColor = [[UIColor clearColor]CGColor];

    if ([textField isEqual:moneyTextField]||[textField isEqual:interestTextField]) {
        UIImageView * sendBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(-1, 0, kDeviceWidth+2, 50)];
        sendBackImage.backgroundColor = [UIColor whiteColor];
        CALayer * lineup = [CALayer layer];
        lineup.backgroundColor = [rgb(255, 156, 146, 1) CGColor];
        lineup.frame = CGRectMake(0, 0, sendBackImage.width, 1);
        [sendBackImage.layer addSublayer:lineup];
        
        CALayer * linedown = [CALayer layer];
        linedown.backgroundColor = [rgb(255, 156, 146, 1) CGColor];
        linedown.frame = CGRectMake(0, sendBackImage.height-1, sendBackImage.width, 1);
        [sendBackImage.layer addSublayer:linedown];
        sendBackImage.userInteractionEnabled = YES;
        [self createButtonWithframe:CGRectMake(10, 5, kDeviceWidth-20, 40) withImage:@"register_sure.png" withView:sendBackImage withTarget:self withAcation:@selector(keyBtnAction:) withTag:111];
        textField.inputAccessoryView = sendBackImage;
    }else if ([textField isEqual:_timeTextField]){

    }

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if ([textField isEqual:interestTextField]) {
        //点击利息是  利息输入框上移出键盘
        [_tableView setContentOffset:CGPointMake(0, 100) animated:YES];
        if (kDeviceHeight < 500) {
            [_tableView setContentOffset:CGPointMake(0, 200) animated:YES];

        }
    }
    
    if ([textField isEqual:_timeTextField]) {
        
        if (_timePicker == nil) {
            _timePicker = [[AATimePickerView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-64, _tableView.width, kTimeCustomHeight)withHour:NO];

            [self.view addSubview:_timePicker];
        }
        __weak LoanDetailsViewController * this = self;
        __weak LoanDetaildSliderView *bSlide = sliderView;
        __weak LoanDetailsInstallmentView *bInstallment = installmentView;
        _timePicker.selectedBlock= ^ (NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minIndex, AATimePickerView *timePickerView) {
            
          
            NSString *date = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)year,(long)month,(long)day];
            this.timeTextField.text = date;
            this.loan.expectBorrowDate = date;
            [this sliderFinsh:bSlide.loanPeriod];
            [bInstallment refreshWith:this.loan.loanPeriod];
            [this refreshSubViews];
        };
        [self keyBtnAction:nil];

        [_timePicker showPickerView];

        return NO;
    }    else{
        if (_timePicker && _timePicker.isShow) {
            [_timePicker showPickerView];
        }
        return YES;
    }
    
//    return YES;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [self isShownDakuanLabel];
    if ([textField isEqual:moneyTextField]) {
        _loan.money = moneyTextField.text;
        if ([moneyTextField.text isEqualToString:@""]) {
            installmentView.hidden = YES;
        }
        else
        {
            installmentView.hidden = NO;
        }
    }else if ([textField isEqual:interestTextField]){
        //利率
//        NSInteger hMoney = kouXiFangShiSwitch.selected?([moneyTextField.text integerValue] - [interestTextField.text integerValue]):[moneyTextField.text integerValue];
//        hMoney = [moneyTextField.text integerValue];
        CGFloat p = [_loan interestRateWithLoanPeriod:_loan.loanPeriod money:[self getMoneyWithOthers] interest:[interestTextField.text integerValue]];
        if (interestView.selectedIndex != 1) {
            interestxianshiLabel.text = [NSString stringWithFormat:@"应付年利率:%0.2f%%",p*100];

        }
        
        
//        CGFloat p = [self interestPerYearWithInterest:[interestTextField.text floatValue] money:[moneyTextField.text floatValue] month:[timeLongLabel.text integerValue] isPostInterest:!kouXiFangShiSwitch.selected];
        if (p >= LoanDetailsViewControllerMaxInterest) {
            
            [YXBTool showAlertViewWithString:@"您的利息已超过法律规定四倍，利息金额不受法律保护"];
        }else if (p <= 0)
        {

            if (moneyTextField.text == nil || [moneyTextField.text length] <= 0) {
                [YXBTool showAlertViewWithString:@"借款金额输入有误！"];
            }
            /*
            else
            {
                [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"先息方式，利息不能大于借款金额(%@元)，请修改借款金额或利息",moneyTextField.text]];
                interestTextField.text = moneyTextField.text;


            }
            */
            if([interestTextField.text integerValue] >= [_loan.money integerValue])
            {
                if (kouXiFangShiSwitch.selected == YES) {
                    [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"先息方式，利息不能大于借款金额(%@元)，请修改借款金额或利息",moneyTextField.text]];
                    interestTextField.text = @"";
                    _loan.interest = @"0";
                    
                }

            }


//            interestTextField.text = [NSString stringWithFormat:@"%ld",[moneyTextField.text integerValue] - 1];
        }

        _loan.interest = interestTextField.text;
        
        /*
        if (upFlag == YES) {
            upFlag = NO;
            _tableView.height = _tableView.height + TableViewHeightTopAlign;

        }
        */
    }
    if (![textField.text isEqualToString:@""]) {
        NSString * money;
        NSString * interest;
        if ([moneyTextField.text isEqualToString:@""]) {
            money = 0;
        }else{
            money = moneyTextField.text;
        }
        
        if ([interestTextField.text isEqualToString:@""]) {
            interest = 0;
        }else{
            interest = interestTextField.text;
        }
//
//        interestxianshiLabel.text = [NSString stringWithFormat:@"所付利息年化利率:%0.2f%%",[_loan interestRateWithLoanPeriod:(LoanPeriod)sliderView.slider.value money:[money integerValue] interest:[interest floatValue]]*100];
        if (reimbursementSwitch.selected) {
            
//            if (_bOrL == NEWLOAN) {
//                
            _loan.installmentList =[LoanDetailsInstallmentView installmentArrayWithMoney:moneyTextField.text withInterest:interestTextField.text withUserTime:_timeTextField.text withTimeLong:sliderView.loanPeriod kouxifangshi:_loan.interestType];
            
        }
        else
        {
            _loan.installmentList =[LoanDetailsInstallmentView installmentArrayWithMoney:moneyTextField.text withInterest:interestTextField.text withUserTime:_timeTextField.text withTimeLong:sliderView.loanPeriod repayType:0 kouxifangshi:_loan.interestType];

        }

    }
    installmentView.array = _loan.installmentList;

//    [_tableView reloadData];
    [self refreshSubViews];
}


-(void)showAlertWhenBiggerThanMax
{
    
}


/**
 *  @author chenglibin
 *
 *  年利率计算
 *
 *  @param interest 利息值
 *  @param money    借款金额
 *  @param month    月数
 *
 *  @return 利息
 */
-(CGFloat)interestPerYearWithInterest:(CGFloat)interest money:(CGFloat)money month:(NSInteger)month isPostInterest:(BOOL)isPostInterest
{
    CGFloat p = 0;
    if (month <= 0) {
        month = 1;
    }
    //先息方式
    if (!isPostInterest) {
        money = money - interest;

    }

    //先息方式
    if (money <= 0) {
        p = -1;
    }
    else
    {
        p = 12 * interest/(money * month);

    }
    
    return p;
    
}


- (void)keyBtnAction:(UIButton *)btn
{
    [moneyTextField resignFirstResponder];
    [interestTextField resignFirstResponder];
}




//刷新数据
- (void)refreshData {

//    [_tableView reloadData];
    //移除footview
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[DetailsFooterView class]]) {
            [view removeFromSuperview];
        }
    }

    

    [self makeTableViewHeight];
    NSLog(@"height---%ld====%ld",(long)kDeviceHeight,(long)bottomTextLabelTopDown);
    bottomTextLabel.top = bottomTextLabelTopDown - _segmentHeight;//协议兰
    [self getTLoanDetailWithLoanID:_loan.t_id];
        

}

- (void)userInteractionEnabled:(BOOL)enabled
{
    moneyTextField.userInteractionEnabled = enabled;
    interestTextField.userInteractionEnabled = enabled;
    _timeTextField.userInteractionEnabled = enabled;
    interestSwitch.userInteractionEnabled = enabled;
    sliderView.userInteractionEnabled = enabled;
    kouXiFangShiSwitch.userInteractionEnabled = enabled;
    reimbursementSwitch.userInteractionEnabled = enabled;
    interestView.userInteractionEnabled = enabled;
}

- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
//    self.bOrL == COMPILE
//    if (self.bOrL != COMPILE) {
//        [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//
//
//    }
//    else
//    {
        [self refreshData];

//    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.bOrL == COMPILE) {
        [self userInteractionEnabled:YES];
    }
//    else
//    {
//        moneyLendLabel.text = [NSString stringWithFormat:@"您已收到对方打款 %ld 元",[self moneyToLend]] ;
//
//    }
    _tableView.contentSize = CGSizeMake(kDeviceWidth, installmentView.origin.y+installmentView.size.height);
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (_bOrL == NEWLOAN || _loan.borrowerId == userModel.user.t_id) {

        [self isShownDakuanLabel];
    }
    else{
        if (_loan.lenderId == userModel.user.t_id) {
            NSInteger money = [self moneyToLend];
            if (money == 0) {
                moneyLendLabel.hidden = YES;
            }
            else
            {
                moneyLendLabel.text = [NSString stringWithFormat:@"您打款给对方 %ld 元",(long)[self moneyToLend]] ;
                moneyLendLabel.hidden = NO;

            }

        }
        else
        {
            moneyLendLabel.hidden = YES;

        }
    }
    
    //无息隐藏 moneyLendLabel
    
    if (interestSwitch.selected == NO) {
        moneyLendLabel.hidden = YES;
    }
    
    


}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.bOrL == BORROWER || self.bOrL == LENDERS) {
        //        [self getTLoanDetailWithLoanID:_loan.t_id];
        [self QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)_tableView];
        
    }

    
    if (_selectedArray != nil && [_selectedArray count] > 0) {
        [_selectedArray removeAllObjects];
    }
    
    
}

// 利息选项的现实和隐藏
- (void)interesthidden:(InterestType)type
{
    if (type == FREE) {
        interestTextField.hidden = YES;
        kouXiFangShiSwitch.hidden = YES;
        banklabel.hidden = YES;
        interestxianshiLabel.hidden = YES;
    }else{
        interestTextField.hidden = NO;
        kouXiFangShiSwitch.hidden = NO;
        banklabel.hidden = NO;
        interestxianshiLabel.hidden = NO;
    }

}

-(NSInteger)getMoneyWithOthers
{
    NSInteger money = 0;

    money = kouXiFangShiSwitch.selected?([moneyTextField.text integerValue] - [interestTextField.text integerValue]):[moneyTextField.text integerValue];
    return money;
}


-(void)refreshSubViews
{
    
//    [self sliderFinsh:sliderView.loanPeriod];
//    installmentView.hidden = !reimbursementSwitch.selected;
//    installmentView.array = _loan.installmentList;
//    installmentView.hidden = NO;
    [installmentView refreshWith:sliderView.loanPeriod];

    [_tableView reloadData];


}

//去打款 放款钱数 用于提示
-(NSInteger)moneyToLend
{
    NSInteger money = 0;
//    if (([[moneyTextField text] integerValue] <= 0) || ([[interestTextField text] integerValue] <= 0)) {
//        return money;
//    }

    
    if (kouXiFangShiSwitch.selected) {
        money = [moneyTextField.text integerValue] - [interestTextField.text integerValue];
    }
    else
    {
        money = [moneyTextField.text integerValue];
    }
    
    if (money <= 0) {
        money = 0;
    }
    return money;
}

-(void)kouxifangshiAction
{
    if (_loan.interestType == POST_INTEREST) {
        //先息
        NSInteger temp = [[moneyTextField text] integerValue] - [[interestTextField text] integerValue];
        if (temp <= 0) {
            [YXBTool showAlertViewWithString:@"先息方式利息不能大于本金"];
            interestTextField.text = @"";
            _loan.interest = @"0";
        }
        
    }
}

//是否显示您将收到打款label
-(void)isShownDakuanLabel
{
    NSInteger money = [self moneyToLend];
    if (money == 0 || !interestSwitch.selected) {
        moneyLendLabel.hidden = YES;
    }
    else
    {
        moneyLendLabel.text = [NSString stringWithFormat:@"将收到打款 %ld 元",(long)money];
        moneyLendLabel.hidden = NO;
        
    }

}

#pragma -mark 利息按钮回调
-(void)headerViewSelectedIndex:(NSInteger)index
{
    if (_loan.t_id > 0 && _bOrL != COMPILE) {
        //判断是已经存在的借款单，并且不是在编辑状态，点击利息按钮，只改变利息颜色，不计算值
        return;
    }
    _loan.useBankRate = 0;
    interestTextField.enabled = YES;
    if (_loan.t_id > 0) {
        interestTextField.text = _loan.interest;

    }
    else
    {
        interestTextField.text = @"0";

    }
    _loan.interest = interestTextField.text;
    interestTextField.placeholder = @"请输入利息";
    if (index == 2) {
//        2 为无息
        [self interesthidden:YES];
        _loan.interestType = FREE;
        _loan.interest = @"0";
        interestTextField.text = @"0";
    }else{
        [self interesthidden:NO];
        if (kouXiFangShiSwitch.selected) {
            _loan.interestType = POST_INTEREST;
        }else{
            _loan.interestType = PRE_INTEREST;
        }
        [self kouxifangshiAction];
        if (interestView.selectedIndex == 1) {
            _loan.useBankRate = 1;
            interestTextField.placeholder = @"自动计算利息";
            [self showInterestFieldInfo];
        }
    }
//    [self refreshSubViews];
    [self sliderFinsh:_loan.loanPeriod];
}

-(void)showInterestFieldInfo
{
    interestTextField.enabled = NO;
    interestxianshiLabel.text = [NSString stringWithFormat:@"%@ %%",[QCHomeDataManager sharedInstance].annualPercentageRate];
//    NSInteger interest = [LoanCalculateUtil interestWithMoney:[moneyTextField.text integerValue] timelong:_loan.loanPeriod rate:[interestxianshiLabel.text floatValue]/100 interestType:_loan.interestType];
    
    NSInteger interest = [LoanCalculateUtil interestWithMoney:[moneyTextField.text integerValue] timelong:_loan.loanPeriod rate:[interestxianshiLabel.text floatValue]/100];

    
    interestTextField.text = _loan.interest;

    if ([self isEditState])
    {
        interestTextField.text = [NSString stringWithFormat:@"%ld",(long)interest];
        _loan.interest = interestTextField.text;
        if ([_loan.interest integerValue] == 0) {
            interestTextField.text = @"";
        }
        
        
        

    }

    if ([[QCHomeDataManager sharedInstance].annualPercentageRate integerValue] == 0) {
        interestxianshiLabel.text = @"暂无数据";
//        interestTextField.text = @"";
//        _loan.interest = @"0";
        interestTextField.text = _loan.interest;
        
        
    }

}

//判断是否是创建编辑状态
-(BOOL)isEditState
{
    if (_bOrL == NEWLOAN || _bOrL == COMPILE || _bOrL == BorrowerORLendersQuickLend) {
        return YES;
    }
    return NO;
}

//调整tableview的frame
-(void)adjustTableViewFrameWithSegment
{
//    _tableView.height = kDeviceHeight - 64 - 50 - _segmentHeight - bottomTextLabel.height - footerView.height;
    [self makeTableViewHeight];
    bottomTextLabel.top = bottomTextLabelTopUp - _segmentHeight;//协议兰
//    bottomTextLabel.top = bottomTextLabel.top - _segmentHeight;

}

-(void)makeTableViewHeight
{
    _tableView.height = kDeviceHeight - 64 - bottomTextLabel.height - footerView.height - _segmentHeight;
}


-(void)createLoanDetailWithLoan:(Loan *)loan
{

    statusHttp.delegate =self;
    statusHttp.netNumber = WXLoanNetNumber;
    
    [statusHttp __yxb_service__createAndModifyTLoan:loan];
    [ProgressHUD showWithStatus:@"正在加载..." maskType:ProgressHUDMaskTypeBlack tipsType:ProgressHUDTipsTypeLongBottom networkIndicator:YES];


}

-(void)callWeChatWithLoanId:(NSInteger)loanId
{
    //分享借款单
//http://60.195.254.33:8083/webView/loan/shareLoan.jsp?t=l&loanId=借款单id
    NSString *url = [NSString stringWithFormat:@"%@webView/loan/shareLoan.jsp?t=l&loanId=%ld",YXB_IP_ADRESS,(long)loanId];
    [YXBTool shareToWeixinSessionContent:@"雪中送炭，真友情经得住考验，无忧借条帮你记录电子借条，好借好还好感情！" imgName:[UIImage imageNamed:@"shareImg"] url:url title:@"江湖求援，您的诚信好友急需借钱，快去无忧借条帮帮忙！" callBackBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}


-(void)loanFromWXReSend:(BOOL)reSend
{
    
    
//    LoanOrRepayFriendsViewController* friendsViewController = [[LoanOrRepayFriendsViewController alloc]init];
//    [self BorrowWithoperationType:APPLY];
//    friendsViewController.delegate = self;
//    friendsViewController.loanModel = self.loan;
//    friendsViewController.isFromBorrow = YES;
//    friendsViewController.isFromSend = reSend;
//    [[YXBTool getCurrentNav] pushViewController:friendsViewController animated:YES];
    
    
//    LoanAddressBookViewController *controller = [[LoanAddressBookViewController alloc] init];
//    [self BorrowWithoperationType:APPLY];
//    controller.loanModel = self.loan;
//    
//    [[YXBTool getCurrentNav] pushViewController:controller animated:YES];
    
    
    LoanFriendTypeViewController *controller = [[LoanFriendTypeViewController alloc] init];
    [self BorrowWithoperationType:APPLY];
    controller.friendType = LoanNewFriendTypeJieRu;
    controller.loanModel = self.loan;
    controller.delegate = self;
    [[YXBTool getCurrentNav] pushViewController:controller animated:YES];



}




@end
