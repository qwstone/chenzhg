//
//  AADetailsViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AADetailsViewController.h"
//#import "DetailsHeaderView.h"
#import "AADetailHeaderView.h"
#import "TActivityManager.h"
#import "NSSkyArray.h"
#import "JoinPeopleTableViewCell.h"
#import "TActivityMember.h"
#import "AADetailsSecondView.h"
#import "DetailsFooterView.h"
#import "AADiscussionViewController.h"
#import "ActivityStatusView.h"
#import "AAImageViewController.h"
#import "StatusHttp.h"
#import "AAStepViewController.h"
#import "QCFriendsViewController.h"
//#import "AAChatViewController.h"
#import "AAManager.h"
#import "AADetailTwoSectionTableViewCell.h"
#import "QCLocalLocation.h"
#import "AAInformView.h"
#import "YXBTool.h"
#import "UserState.h"
#import "AAShareView.h"
#import "QCSelectRefundViewController.h"
#import "ActivityMember.h"
//#import "RongLocationViewController.h"
#import "LoanCenterViewController.h"
#import "AAReceiptViewController.h"
#import "Payment_aaPay.h"
#import "CustomIOSAlertView.h"
#import "YXBProtocolView.h"
#import "FriendDetailViewController.h"
#import "FriendSelecteViewController.h"

#define kPartyTag 30000     //报名
#define kCheckingTag 30001  //签到
#define kCancleTag 30002    //取消活动
#define kNewPartyTag 30003  //发起新活动
#define kLodgeTag 30004     //投诉活动
#define kQuitTag 30005      //取消报名
#define kRejectTag 30006    //拒绝用户

#define AADetailsViewControllerAAPayUrl @"webView/user/aaPay.jsp"

@interface AADetailsViewController ()<DetailsFooterViewDelegate,ActivityStatusViewDelegate,QCBaseTableViewDelegate,StatusHttpDelegate,AADetailHeaderViewDelegate,AAShareViewDelegate,JoinPeopleTableViewCellDelegate,YXBProtocolViewtDelegate,QCFriendsViewControllerBackDelegate>
{
    ActivityStatusView * activityStatusView;
    StatusHttp * statusHttp;
    activityState _currentType;
    
    UIBarButtonItem *_lodgeItem;
    
    ActivityMember *_currentMember;  //被拒绝用户
    
    BOOL _firstHttp;    //首次请求
    StatusHttp * http;

    
    
}

//@property (nonatomic,strong) TActivity *activity;   //活动详情
@property (nonatomic,strong)QCBaseTableView * talbeView;
@property (nonatomic,strong)CustomIOSAlertView *partyAlert; //付费报名提示框
@property (nonatomic,assign)BOOL agreeSelected;    //付费报名协议

@end

@implementation AADetailsViewController

-(void)dealloc{
    NSLog(@"AADetailsViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"详情"];

    _firstHttp = YES;
    
    [self initView];
}

- (void)initView
{
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    
    //投诉
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, getScreenFitSize(21), 30);
    [btn addTarget:self action:@selector(lodgeAction:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setTitle:@"· · ·" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"dian-nav"] forState:UIControlStateNormal];
    _lodgeItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = _lodgeItem;
    
    self.view.backgroundColor = rgb(241, 240, 248, 1);
    
    _talbeView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.view.frame.size.height-50-64-20) style:UITableViewStylePlain refreshFooter:NO];
    _talbeView.delegate = self;
    _talbeView.dataSource = self;
    _talbeView.refreshDelegate = self;
    _talbeView.backgroundColor = [UIColor whiteColor];
    _talbeView.separatorColor = rgb(191, 191, 191, 1);
    [self.view addSubview:_talbeView];
    
//    _talbeView.layer.borderColor = rgb(191, 191, 191, 1).CGColor;
//    _talbeView.layer.borderWidth = 0.5;
    
    statusHttp = [[StatusHttp alloc]init];
    statusHttp.delegate = self;
//    [statusHttp finishTActivity:_activity];
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


//- (void)footerViewbuttonActionWithSender:(UIButton *)sender
//{
//    
//    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
//    if (!userModel.isLogin) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有登录，请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 10010;
//        [alterView show];
//        return;
//    }
//    if ([self.activity.avgCost floatValue] > 0) {//免费的情况下，不用实名认证
//        if ([UserState isLv2] == E_NO_OPERATE) {
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"参与（发起）付费的活动请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            alterView.tag = 10086;
//            [alterView show];
//            return;
//        }else if ([UserState isLv2] == E_IN_REVIEW) {
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alterView show];
//            return;
//        }else if ([UserState isLv2] == E_FAIL_UserStateRes) {
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"您的身份认证失败，请从新认证" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alterView show];
//            return;
//        }
////        if (userModel.user.accountStatus == 1) {
////            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息正在审核中..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
////            //        alterView.tag = 10086;
////            [alterView show];
////            return;
////        }else if (userModel.user.accountStatus == 4) {
////            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名信息已提交" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
////            [alterView show];
////            return;
////        }else if (userModel.user.accountStatus == 2) {
////            //通过
////        }else if (userModel.user.accountStatus == 3) {
////            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"实名认证信息，审核失败，请重新进行实名认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
////            alterView.tag = 10086;
////            [alterView show];
////            return;
////        }else if (userModel.user.accountStatus == 0) {
////            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"参与（发起）付费的活动请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
////            alterView.tag = 10086;
////            [alterView show];
////            return;
////        }
//    }
//    __weak AADetailsViewController *this = self;
//    
//    QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
//    ActivityOperate *op = [[ActivityOperate alloc] init];
//    op.activityID = _activity.t_id;
//    op.operaterToken = model.user.yxbToken;
//    QCLocalLocation *location = [QCLocalLocation shareInstance];
//    
//    op.reqLongitude = [NSString stringWithFormat:@"%f",location.longitude];
//    op.reqLatitude = [NSString stringWithFormat:@"%f",location.latitude];
//    
//    NSLog(@"syler = %ld",(long)sender.tag);
//    if ([sender.titleLabel.text isEqualToString:@"参与讨论"]) {//聊天入口
//        if ((_activity.chatId == nil) || [_activity.chatId length] < 2) {
//            [YXBTool showAlertViewWithString:@"聊天信息获取失败"];
//            return;
//        }
//
//        RongChat *chat  = [RongChat shareRongChat];
//        [chat connectRongServerWithRongToken:nil];
//
//        AAChatViewController * chatVC = [[AAChatViewController alloc]init];
//        
//        chatVC.portraitStyle = RCUserAvatarCycle;//圆头像
//        chatVC.currentTarget = _activity.chatId;
//        
//        chatVC.conversationType = ConversationType_GROUP;
//        chatVC.currentTargetName = _activity.chatName;
//        if ([ chatVC.currentTargetName isEqualToString:@""]) {
//            chatVC.currentTargetName = @"聊天";
//        }
//        chatVC.activity = _activity;
//        [self.navigationController pushViewController:chatVC animated:YES];
//
//    }else if ([sender.titleLabel.text isEqualToString:@"报名"]){
//        
//        if (self.activity.avgCost.floatValue > 0) {
////            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"该活动为预付费活动，一旦报名将不能取消，是否确定报名？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"付费报名", nil];
////            alter.tag = kPartyTag;
////            [alter show];
//            
//            /*
//             付费报名增加协议
//             */
//            this.partyAlert = [[CustomIOSAlertView alloc] init];
//            
//            // Add some custom content to the alert view
//            UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth-60, 100)];
//            contentView.backgroundColor = [UIColor whiteColor];
//            
//            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, contentView.width-30, 50)];
//            title.backgroundColor = [UIColor clearColor];
//            title.text = @"该活动为预付费活动，一旦报名将不能取消，是否确定报名？";
//            title.font = [UIFont boldSystemFontOfSize:17];
//            title.numberOfLines = 0;
//            title.textAlignment = NSTextAlignmentCenter;
//            [contentView addSubview:title];
//            
//            YXBProtocolView *agree = [[YXBProtocolView alloc] initWithType:TYPE_TO_AA_INTO Frame:CGRectMake(15, title.bottom+10, kDeviceWidth-30, 17) location:VIEWAlignmentLeft];
//            agree.tongyi.frame = CGRectMake(0, (agree.height-12.5)/2, 12.5, 12.5);
//            [agree.tongyi setBackgroundImage:[UIImage imageNamed:@"zc-check"] forState:UIControlStateNormal];
//            [agree.tongyi setBackgroundImage:[UIImage imageNamed:@"zc-checked"] forState:UIControlStateSelected];
//            [agree.tongyitiaokuan setTitleColor:rgb(52, 142, 250, 1) forState:UIControlStateNormal];
//            agree.delegate = self;
//            [contentView addSubview:agree];
//            
//            this.agreeSelected = YES;
//            
//            [this.partyAlert setContainerView:contentView];
//            
//            // Modify the parameters
//            [this.partyAlert setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"付费报名", nil]];
////            [alertView setDelegate:self];
//            
//            // You may use a Block, rather than a delegate.
//            [this.partyAlert setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
//                if (buttonIndex == 1) {
//                    if (this.agreeSelected) {
//                        Payment_aaPay *payModel = [[Payment_aaPay alloc] init];
//                        payModel.money = this.activity.avgCost;
//                        payModel.tActivityId = [NSString stringWithFormat:@"%ld",(long)this.activity.t_id] ;
//                        NSString *url = [YXBPaymentUtils getFullWebUrl:payModel];
//                        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];
//                        
//                    }else {
//                        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"请先勾选友信宝AA活动参与服务协议" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                        [alter show];
//                    }
//                }
//                [this.partyAlert close];
//            }];
//            
//            [this.partyAlert setUseMotionEffects:true];
//            [this.partyAlert show];
//        }else {
//            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"是否确认报名该活动？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            alter.tag = kPartyTag;
//            [alter show];
//            
//        }
//        
////        [statusHttp addTActivityParticipantwithModel:_activity];
//        
//    }else if ([sender.titleLabel.text isEqualToString:@"取消活动"]){
//       
//    }else if ([sender.titleLabel.text isEqualToString:@"结束活动"]){
////        [statusHttp finishTActivity:_activity];
//    }else if ([sender.titleLabel.text isEqualToString:@"编辑活动"]){
////        AAStepViewController * stepViewController = [[AAStepViewController alloc]init];
////        [stepViewController setActivity:_activity];
////        [self.navigationController pushViewController:stepViewController animated:YES];
//        QCIssueViewController *issue = [[QCIssueViewController alloc] init];
//        issue.activity = _activity;
//        if (_activity.status == A_REJECTED) {
//            issue.isFailed = YES;
//        }
//        [self.navigationController pushViewController:issue animated:YES];
//    }else if ([sender.titleLabel.text isEqualToString:@"取消报名"]){
////        [statusHttp quitTActivityParticipant:_activity];
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"取消报名会影响您的信用值是否确认取消报名？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//        alterView.tag = kQuitTag;
//        [alterView show];
//       
//    }else if ([sender.titleLabel.text isEqualToString:@"邀请好友"]){
////        QCFriendsViewController * friendsViewController = [[QCFriendsViewController alloc]init];
////        friendsViewController.activity = _activity;
////        friendsViewController.isFromInvite = YES;
////        [self.navigationController pushViewController:friendsViewController animated:YES];
//        FriendSelecteViewController *controller = [[FriendSelecteViewController alloc] init];
//        controller.friendType = LoanNewFriendTypeAAYaoQing;
//        
//        controller.delegate = self;
//        [self.navigationController pushViewController:controller animated:YES];
//
//        
//    }else if ([sender.titleLabel.text isEqualToString:@"微信分享"]){
//        //微信朋友圈
//        AAShareView *share = [[AAShareView alloc] initWithType:AAShareViewTypeFriend];
//        share.delegate = self;
//        [share show];
////        NSString *URLString = [NSString stringWithFormat:@"%@wap/aa/one.jsp?id=%ld",YXB_IP_ADRESS,(long)_activity.t_id];
////        NSString *timeAddress = [NSString stringWithFormat:@"%@ %@ %@  %@",[_activity.activityDate substringWithRange:NSMakeRange(5, 5)],[_activity.activityDate substringWithRange:NSMakeRange(11, 5)],[AADetailHeaderView getWeekdayWithNum:_activity.weekday],_activity.destName];
////        
////        [YXBTool shareToWeixinTimelineContent:timeAddress imgName:nil url:URLString title:_activity.topic callBackBlock:^{
////            
////        }];
//    }else if ([sender.titleLabel.text isEqualToString:@"发起新活动"]){
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"是否要再次发起此次活动？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
//        alterView.tag = kNewPartyTag;
//        [alterView show];
//
//    }else if ([sender.titleLabel.text isEqualToString:@"签到"]) {
//        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
//            //用户拒绝使用位置服务
//            //        if (KDeviceOSVersion >= 8.0) {
//            //
//            //        }else {
//            //
//            //        }
//            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"请先开启定位服务后，再来签到。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alterView show];
//        }else {
//            if (_activity.distance.floatValue > 500) {
//                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您还未到活动地点，请到达活动地点后在进行签到。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alterView show];
//                return;
//            }
//            
//            if (self.activity.status == A_PASSED && _activity.type == M_REGISTERED) {
//                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"活动开始后再来签到吧。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alterView show];
//            }else if (self.activity.status == A_STARTED && _activity.type == M_LODGE) {
//                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您已投诉该活动，暂不能签到。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alterView show];
//            }else if (self.activity.status == A_STARTED && _activity.type == M_REGISTERED) {
//                if (self.activity.avgCost.floatValue == 0) {
//                    op.OperateState = OPERATE_CHECKIN_ACTIVITY;
//                    [statusHttp __yxb_service__userActivityOperate:op complete:^(AAActivity *activity) {
//                        [this reloadTableView:activity];
//                    }];
//                }else {
//                    
//                    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"是否确定签到？签到后，预付款将自动打到发起人账户。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"签到", nil];
//                    alterView.tag = kCheckingTag;
//                    [alterView show];
//                }
//                
//            }else if (self.activity.status == A_FINISHED) {
//                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"活动已结束，暂停签到。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alterView show];
//            }
//            
//        }
//    }else if ([sender.titleLabel.text isEqualToString:@"借条管理"]) {
//        LoanCenterViewController *loanCenter= [[LoanCenterViewController alloc] init];
//        loanCenter.selectedIndex = 3;
//        [self.navigationController pushViewController:loanCenter animated:YES];
//        
//    }else if ([sender.titleLabel.text isEqualToString:@"借条(已还款)"] || [sender.titleLabel.text isEqualToString:@"借条(未还款)"]) {
//        AAReceiptViewController *receipt = [[AAReceiptViewController alloc] init];
//        receipt.loanId = _activity.jumpId;
//        
//        [self.navigationController pushViewController:receipt animated:YES];
//        
//    }
//   
//}


- (void)httpCompleteWithResultSet:(TResultSet *)set
{
    if (set.errCode == 0) {
        [self httpDowload];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:set.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

        return getScreenFitSize(170);
    }else if (indexPath.section == 1){
        return [AADetailsSecondView getHeightFromText:self.activity.detail]+45-180+[self getImgHight];
    }else if (indexPath.section == 2){
        return 65;
    }else{
        return 0;
    }
}

- (CGFloat)getImgHight{
    NSString *imageJson = self.activity.postWallPics;
    if (imageJson != nil) {
        
        NSError *error;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        NSArray *images = [NSJSONSerialization JSONObjectWithData:[imageJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        NSMutableArray *container = [NSMutableArray new];
        for (NSDictionary *dic in images) {
            AAFlowImageModel *model = [[AAFlowImageModel alloc] initWithDic:dic];
            [container addObject:model];
        }
        if (container.count > 0) {
            if (container.count == 1) {
                return kDeviceWidth/320*150;
            }else if (container.count == 2){
                return kDeviceWidth/320*111;
            }else if (container.count >= 3){
                return kDeviceWidth/320*75;
            }
        }
//        if (container.count > 0) {
//            if (container.count == 1) {
//                AAFlowImageModel *model = container[0];
//                return kDeviceWidth/320*225/model.width*model.height;
//            }else if (container.count == 2){
//                AAFlowImageModel *model = container[0];
//                AAFlowImageModel *model1 = container[1];
//                if (((kDeviceWidth - 20)/2/model.width*model.height) >= ((kDeviceWidth - 20)/2/model1.width*model1.height)) {
//                    return (kDeviceWidth - 20)/2/model.width*model.height;
//                }
//                return (kDeviceWidth - 20)/2/model1.width*model1.height;
//            }else if (container.count >= 3){
//                AAFlowImageModel *model = container[0];
//                AAFlowImageModel *model1 = container[1];
//                AAFlowImageModel *model2 = container[2];
//                NSInteger a = (kDeviceWidth - 20)/3/model.width*model.height;
//                NSInteger b = (kDeviceWidth - 20)/3/model1.width*model1.height;
//                NSInteger z = (kDeviceWidth - 20)/3/model2.width*model2.height;
//                if (a >= b) {
//                    if (a >= z) {
//                        return a;
//                    }else {
//                        return z;
//                    }
//                }else {
//                    if (b >= z) {
//                        return b;
//                    }else {
//                        return z;
//                    }
//                }
//            }
//        }
    }
    return kDeviceWidth/320*150;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return _activity.participants.count-1;
            break;
        default:
            return 0;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 2) {
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 35)];
        bgView.backgroundColor = [UIColor whiteColor];
        
        UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 10)];
        grayView.backgroundColor = rgb(241, 240, 248, 1);
        [bgView addSubview:grayView];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0.5)];
        line1.backgroundColor = rgb(191, 191, 191, 1);
        [grayView addSubview:line1];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, kDeviceWidth, 0.5)];
        line2.backgroundColor = rgb(191, 191, 191, 1);
        [grayView addSubview:line2];
        
        UILabel *partyLabel = [[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth-180)/2, 15, 180, 15)];
        //            partyLabel.center = bgView.center;
        partyLabel.text = @"参与名单(不显示发起者)";
        partyLabel.textAlignment = NSTextAlignmentCenter;
        partyLabel.textColor = rgb(150, 150, 150, 1);
        partyLabel.backgroundColor = [UIColor clearColor];
        partyLabel.font = [UIFont systemFontOfSize:15];
        [bgView addSubview:partyLabel];
        
        UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(20,22, (kDeviceWidth-180-40)/2, 1)];
        leftLine.backgroundColor = rgb(191, 191, 191, 1);
        [bgView addSubview:leftLine];
        
        UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(partyLabel.right, 22, (kDeviceWidth-180-40)/2, 1)];
        rightLine.backgroundColor = rgb(191, 191, 191, 1);
        [bgView addSubview:rightLine];
        return bgView;
//        UIImageView *cymd = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 16)];
//        cymd.image = [UIImage imageNamed:@"AA_cymd"];
//        return cymd;
    }
    return Nil;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section == 2) {
        return 35;
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString * onecellID = @"ONESECTION";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:onecellID];
        if (cell==Nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellID];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
//        
        AADetailHeaderView * headerView = [[AADetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, getScreenFitSize(170))];
        [headerView setActivityModel:_activity];
        headerView.delegate = self;
        [cell.contentView addSubview:headerView];
        
//        //是否显示图片墙
//        if (_activity.status == A_PASSED || _activity.status == A_STARTED || _activity.status == A_FINISHED) {
//            [headerView setImageButtonHidden:NO];
//        }else {
//            [headerView setImageButtonHidden:YES];
//        }

        return cell;
    }else if (indexPath.section == 1){
        NSString * twoCellID = @"TWOSECTION";
        AADetailTwoSectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:twoCellID];
        if (cell==Nil) {
            cell = [[AADetailTwoSectionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:twoCellID];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.vc = self;
        }
        cell.activityModel = self.activity;
        return cell;

    }else{
        NSString * threeCellID = @"THREESECTION";
        JoinPeopleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:threeCellID];
        if (cell==Nil) {
            cell = [[JoinPeopleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:threeCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
//        TActivityMember * member = _activity.participants[indexPath.row];
        cell.row = indexPath.row+1;

        [cell setTacivity:_activity];
//        [cell setMomber:member];
        return cell;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.iHttpOperator != nil) {
        [self.iHttpOperator cancel];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self httpDowload];
    _firstHttp = NO;
}

#pragma mark - ProtocolView delegate
- (void)checkButton:(UIButton *)sender {
    
    if (!sender.selected) {
        _agreeSelected = NO;
        
    }else{
        _agreeSelected = YES;
    }
}

- (void)protocolButton:(UIButton *)sender {
    [_partyAlert close];
}

#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpDowload
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AADetailsViewController *this = self;
    
    [self.iHttpOperator connetStart:^(int d) {
        [this stopDefaultAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        [this httpLoadError:error];
    } param:^(NSString *s) {
        
        /*
        TActivityManager* _activityM = (TActivityManager*)  [assginHtttperator getAopInstance:[TActivityManager class] returnValue:[TActivity class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        [_activityM getTActivityById:userModel.user.t_id activityId:this.brief.t_id tagType:this.tagType];
         */
        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(AAActivity* r, int taskid) {

        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//请求出错
-(void)httpLoadError:(THttpOperatorErrorCode)error{
    if (error == EHttp_Operator_Failed) {
        //服务器挂了
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        [self.talbeView reloadDeals];
    }
}
//上传参数
- (void)httpLOadParams:(NSString *)s  httpOperation:(HttpOperator *)httpOperation{
    AAManager* _activityM = (AAManager*)  [httpOperation getAopInstance:[AAManager class] returnValue:[AAActivity class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    [_activityM getAAActivityDetail:userModel.user.yxbToken AAActivityID:self.activityId];
}

//
- (void)httpLoadComplete:(AAActivity *)r
{
    if (r.errCode == 0) {
        self.activity = r;
        //            [this setTitle:r.topic];
        [self createFooterView];
        if (r.status == A_STARTED && r.type == M_REGISTERED) {
            UIAlertView * arlview = [[UIAlertView alloc]initWithTitle:@"" message:@"活动已开始,可以签到了" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [arlview show];
        }
        
        if (r.status == A_CANCELED && r.type == M_REGISTERED) {
            UIAlertView * arlview = [[UIAlertView alloc]initWithTitle:@"" message:@"很抱歉，活动发起者取消了本次活动，看看周边其它活动吧~(您的预付费已退回账户，请注意查收。)" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [arlview show];
        }
    }else {
        
    }
    [self.talbeView reloadData];
    [self.talbeView reloadDeals];

}



- (void)createFooterView
{
    if (activityStatusView != nil) {
        [activityStatusView removeFromSuperview];
    }

    //是否盖章
    BOOL changeZhuang;
    if (_currentType == self.activity.type) {
        changeZhuang = NO;
    }else {
        changeZhuang = YES;
    }
    
    NSArray * nameArray;
    //活动审核中
//    NSLog(@"sss = %d fff =%ld",_activity.status,_activity.type);
    if (_activity.status == A_CHECKING &&_activity.type == M_CREATED) {
        activityStatusView = [[ActivityStatusView alloc]initWithFrame:CGRectMake(0, -150, 200, 80)];
//        [activityStatusView.zhuangBtn setTitle:@"活动审核中" forState:UIControlStateNormal];
        [activityStatusView.zhuangBtn setImage:[UIImage imageNamed:@"AA_auditingseal"] forState:UIControlStateNormal];
        [_talbeView addSubview:activityStatusView];
//        [activityStatusView startAnimationWithPoint:self.view.center];
        if (changeZhuang) {
            [activityStatusView startAnimationWithPoint:CGPointMake(_talbeView.center.x, 100)];
            
        }else {
            [activityStatusView setFrameWithPoint:CGPointMake(_talbeView.center.x, 100)];
        }
        nameArray = @[@"编辑活动"];
    //活动未通过
    }else if (_activity.status == A_REJECTED &&_activity.type== M_CREATED){
        activityStatusView = [[ActivityStatusView alloc]initWithFrame:CGRectMake(0, -150, 200, 80)];
//        [activityStatusView.zhuangBtn setTitle:@"活动未通过" forState:UIControlStateNormal];
        [activityStatusView.zhuangBtn setImage:[UIImage imageNamed:@"AA_auditedseal"] forState:UIControlStateNormal];

        [_talbeView addSubview:activityStatusView];
        //        [activityStatusView startAnimationWithPoint:self.view.center];
        if (changeZhuang) {
            [activityStatusView startAnimationWithPoint:CGPointMake(_talbeView.center.x, 100)];
            
        }else {
            [activityStatusView setFrameWithPoint:CGPointMake(_talbeView.center.x, 100)];
        }
        nameArray = @[@"编辑活动"];
    //活动已通过
    }else if (_activity.status == A_PASSED && _activity.type == M_CREATED){
        nameArray = @[@"参与讨论",@"微信分享",@"邀请好友"];
    }else if (_activity.status == A_PASSED && _activity.type == M_Vistor){
        nameArray = @[@"报名"];
    }else if (_activity.status == A_PASSED && _activity.type == M_BEINVITED){
        nameArray = @[@"报名"];
    }else if (_activity.status == A_PASSED && _activity.type == M_REGISTERED){
        if (_activity.avgCost.doubleValue > 0) {
            nameArray = @[@"签到",@"参与讨论"];
        }else {
            nameArray = @[@"取消报名",@"签到",@"参与讨论"];
            
        }
    }else if (_activity.status == A_PASSED && _activity.type == M_CHECKIN){
        if (_activity.avgCost.doubleValue > 0) {
            nameArray = @[@"参与讨论"];
        }else {
            nameArray = @[@"取消报名",@"参与讨论"];
            
        }
    }else if (_activity.status == A_PASSED && _activity.type == M_QUIT){
        nameArray = @[@"报名"];
    }else if (_activity.status == A_PASSED && _activity.type == M_REJECTED){
        nameArray = @[@"报名"];
    //活动开始
    }else if (_activity.status == A_STARTED){
        activityStatusView = [[ActivityStatusView alloc]initWithFrame:CGRectMake(0, -150, 200, 80)];
        activityStatusView.delegate =self;
//        [activityStatusView.zhuangBtn setTitle:@"活动结束" forState:UIControlStateNormal];
        [activityStatusView.zhuangBtn setImage:[UIImage imageNamed:@"AA_sealing"] forState:UIControlStateNormal];
        [_talbeView addSubview:activityStatusView];
        //        [activityStatusView startAnimationWithPoint:self.view.center];
        if (changeZhuang) {
            [activityStatusView startAnimationWithPoint:CGPointMake(_talbeView.center.x, 100)];
            
        }else {
            [activityStatusView setFrameWithPoint:CGPointMake(_talbeView.center.x, 100)];
        }
        if (_activity.type == M_CREATED ||_activity.type == M_CHECKIN) {
            nameArray = @[@"参与讨论"];
        }else if (_activity.type == M_QUIT ||_activity.type == M_REJECTED){
//            nameArray = @[@"参与讨论"];
        }else if (_activity.type == M_REGISTERED || _activity.type == M_LODGE) {
            nameArray = @[@"签到",@"参与讨论"];
        }else if (_activity.type == M_Vistor) {
            nameArray = @[@"报名"];
        }
    //活动取消
    }else if (_activity.status == A_CANCELED){
        activityStatusView = [[ActivityStatusView alloc]initWithFrame:CGRectMake(0, -150, 200, 80)];
        //        [activityStatusView.zhuangBtn setTitle:@"活动未通过" forState:UIControlStateNormal];
        [activityStatusView.zhuangBtn setImage:[UIImage imageNamed:@"AA_cancle"] forState:UIControlStateNormal];
        
        [_talbeView addSubview:activityStatusView];
        //        [activityStatusView startAnimationWithPoint:self.view.center];
        if (changeZhuang) {
            [activityStatusView startAnimationWithPoint:CGPointMake(_talbeView.center.x, 100)];
            
        }else {
            [activityStatusView setFrameWithPoint:CGPointMake(_talbeView.center.x, 100)];
        }
        if (_activity.type == M_CREATED) {
            nameArray = @[@"发起新活动",@"参与讨论"];

        }else if (_activity.type == M_REGISTERED || _activity.type == M_CHECKIN){
            nameArray = @[@"参与讨论"];
//            nameArray = @[@"参与讨论"];

        }
    }else if (_activity.status == A_FINISHED){
    
        activityStatusView = [[ActivityStatusView alloc]initWithFrame:CGRectMake(0, -150, 200, 80)];
        activityStatusView.delegate =self;
//        [activityStatusView.zhuangBtn setTitle:@"活动结束" forState:UIControlStateNormal];
        [activityStatusView.zhuangBtn setImage:[UIImage imageNamed:@"AA_overseal"] forState:UIControlStateNormal];
        [_talbeView addSubview:activityStatusView];
        //        [activityStatusView startAnimationWithPoint:self.view.center];
        if (changeZhuang) {
            [activityStatusView startAnimationWithPoint:CGPointMake(_talbeView.center.x, 100)];
            
        }else {
            [activityStatusView setFrameWithPoint:CGPointMake(_talbeView.center.x, 100)];
        }
        //        if (_activity.type == M_CREATED || _activity.type == M_REGISTERED || _activity.type == M_CHECKIN) {
//            nameArray = @[@"参与讨论",@"相片墙"];
//        }else if (_activity.type == M_QUIT ||_activity.type == M_REJECTED){
        if (_activity.type == M_REGISTERED || _activity.type == M_CHECKIN) {
            nameArray = @[@"参与讨论"];
        }else if (_activity.type == M_CREATED) {
            //发起者
            nameArray = @[@"发起新活动",@"参与讨论"];
        }
//        }
    }

//    activityStatusView.layer.borderColor = [UIColor redColor].CGColor;
//    activityStatusView.layer.borderWidth = 0.5;
    if (self.activity.payType == 3 && self.activity.type == M_CREATED) {
        NSMutableArray *newArr = [NSMutableArray arrayWithObject:@"借条管理"];
        [newArr addObjectsFromArray:nameArray];
        nameArray = newArr;
        
    }
    
    if (self.activity.memberPayType == 3 && (self.activity.type == M_REGISTERED || self.activity.type == M_CHECKIN || self.activity.type == M_LODGE)) {
        NSString *name;
        if (self.activity.loanStatus == 1 || self.activity.loanStatus == 5) {
            name = @"借条(已还款)";
        }else if (self.activity.loanStatus == 2) {
            name = @"借条(未还款)";
        }
        if (name != nil && name.length != 0) {
            NSMutableArray *newArr = [NSMutableArray arrayWithObject:name];
            [newArr addObjectsFromArray:nameArray];
            nameArray = newArr;
            
        }
    }
    
    _currentType = (activityState)self.activity.type;
    DetailsFooterView * detailsFooterView = [[DetailsFooterView alloc]initWithNameArr:nameArray];
    detailsFooterView.delegate = self;
    [self.view addSubview:detailsFooterView];

}

- (void)activituStatusViewBtn:(UIButton *)sender
{
//    AAImageViewController * imageViewController = [[AAImageViewController alloc]init];
//    imageViewController.activity = _activity;
//    [self.navigationController pushViewController:imageViewController animated:YES];
}

- (void)reloadTableView:(AAActivity *)activity {
    if (activity.errCode == 0) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:activity.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        self.activity = activity;
        [self.talbeView reloadData];
        [self createFooterView];
    }else {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:activity.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex  {
    __weak AADetailsViewController *this = self;
    
    QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
    ActivityOperate *op = [[ActivityOperate alloc] init];
    op.activityID = _activity.t_id;
    op.operaterToken = model.user.yxbToken;
    QCLocalLocation *location = [QCLocalLocation shareInstance];
    
    op.reqLongitude = [NSString stringWithFormat:@"%f",location.longitude];
    op.reqLatitude = [NSString stringWithFormat:@"%f",location.latitude];
    if (alertView.tag == kPartyTag) {
        if (buttonIndex == 1) {
            if (self.activity.avgCost.floatValue == 0) {
                op.OperateState = OPERATE_PARTICIPANT_ACTIVITY;
                [statusHttp __yxb_service__userActivityOperate:op complete:^(AAActivity *activity) {
                    [this reloadTableView:activity];
                }];
            }else {
//                if (self.iPayJsonTools == nil) {
//                    self.iPayJsonTools = [[PayJsonTools alloc] init];
//                }
//                op.OperateState = OPERATE_PARTICIPANT_ACTIVITY;
//                AAManager* mgr = [self.iPayJsonTools getAopInstance:[AAManager class]];
//                
//                __weak typeof(self) this = self;
//                self.iPayJsonTools.iOnJsonStr = ^(NSString* s) {
//                    NSLog(@"log = %@", s);
//                    if ([s length] > 0) {
//                        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                        [dic setObject:this.activity.avgCost  forKey:@"money"];
//                        [dic setValue:[NSNumber numberWithInteger:this.activity.t_id] forKey:@"ActivityId"];
////                        [dic setObject:s forKey:@"json"];
//                        NSString *urlstrs = [YXBTool getURL:AADetailsViewControllerAAPayUrl params:[YXBTool jsonEqualWithDic:dic]];
//                        NSLog(@"%@",urlstrs);
//                        [YXBTool jumpInnerSafaryWithUrl:urlstrs hasTopBar:NO titleName:@"支付"];
//                        
//                        
//                        
//                    }
//                    else
//                    {
//                        [YXBTool showAlertViewWithString:@"AA请求支付信息错误"];
//                    }
//                    
//                    
//                };
//                [mgr __yxb_service__userActivityOperate:op];
//                Payment_aaPay *payModel = [[Payment_aaPay alloc] init];
//                payModel.money = this.activity.avgCost;
//                payModel.tActivityId = [NSString stringWithFormat:@"%ld",(long)this.activity.t_id] ;
//                NSString *url = [YXBPaymentUtils getFullWebUrl:payModel];
//                [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];
                
            }
            //修改付费
//            op.OperateState = OPERATE_PARTICIPANT_ACTIVITY;
//            [statusHttp __yxb_service__userActivityOperate:op complete:^(AAActivity *activity) {
//                [this reloadTableView:activity];
//            }];
        }
    }else if (alertView.tag == kCheckingTag) {
        if (buttonIndex == 1) {
            op.OperateState = OPERATE_CHECKIN_ACTIVITY;
            [statusHttp __yxb_service__userActivityOperate:op complete:^(AAActivity *activity) {
                [this reloadTableView:activity];
            }];
            
        }

    }else if (alertView.tag == kCancleTag) {
        if (buttonIndex == 1) {
            op.OperateState = OPERATE_CANCEL_ACTIVITY;
            [statusHttp __yxb_service__userActivityOperate:op complete:^(AAActivity *activity) {
                if (activity.errCode == 0) {
                    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"取消成功" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alter show];
//                    for (UIViewController *vc in self.navigationController.childViewControllers) {
//                        if ([vc isKindOfClass:[AAActivitiesListViewController class]]) {
//                            AAActivitiesListViewController *list = (AAActivitiesListViewController *)vc;
//                            list.listStyle = L_myList;
//                            
//                            [self.navigationController popToViewController:list animated:YES];
//                        }
//                    }
                    [this.navigationController popViewControllerAnimated:YES];
                }else {
                    [this reloadTableView:activity];
                    
                }
            }];
        }
    } else if (alertView.tag == 10010){
        if (buttonIndex == 1) {
            
            [self toLogin];
        }
    } else if (alertView.tag == 10086){
        if (buttonIndex == 1) {
            
            [self toAuthentication];
        }
    }else if (alertView.tag == kNewPartyTag) {
        if (buttonIndex == 1) {
            QCIssueViewController *issue = [[QCIssueViewController alloc] init];
            issue.activity = _activity;
//            issue.isAfresh = YES;
            [self.navigationController pushViewController:issue animated:YES];
            
        }
    }else if (alertView.tag == kLodgeTag) {
        if (buttonIndex == 1) {
            
            op.OperateState = OPERATE_CT_ACTIVITY;
            [statusHttp __yxb_service__userActivityOperate:op complete:^(AAActivity *activity) {
                [this reloadTableView:activity];
            }];
            
        }
    }else if (alertView.tag == kQuitTag) {
        if (buttonIndex == 1) {
            
            op.OperateState = OPERATE_QUIT_ACTIVITY;
            [statusHttp __yxb_service__userActivityOperate:op complete:^(AAActivity *activity) {
                if (activity.errCode == 0) {
                    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"取消成功" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alter show];
//                    for (UIViewController *vc in self.navigationController.childViewControllers) {
//                        if ([vc isKindOfClass:[AAActivitiesListViewController class]]) {
//                            AAActivitiesListViewController *list = (AAActivitiesListViewController *)vc;
//                            list.listStyle = L_myList;
//                            
//                            [self.navigationController popToViewController:list animated:YES];
//                        }
//                    }
                    [this.navigationController popViewControllerAnimated:YES];
                }else {
                    [this reloadTableView:activity];
                    
                }
            }];
            
        }
    }else if (alertView.tag == kRejectTag) {
        if (buttonIndex == 1) {
            op.OperateState = OPERATE_REJECT_ACTIVITY;
            op.rejectUserToken = _currentMember.yxbToken;
            [statusHttp __yxb_service__userActivityOperate:op complete:^(AAActivity *activity) {
                [this reloadTableView:activity];
            }];
        }
        
    }
}

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    if (!_firstHttp) {
        [self httpDowload];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)httpCompleteWithResultSet:(TResultSet *)set withHttpTag:(NSInteger)tag {
    
}

- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)lodgeAction:(UIButton *)button {
    if (_activity != nil) {
        AAShareView *share = [[AAShareView alloc] init];
        share.delegate = self;
        //是否显示投诉按钮
        if ((_activity.type != M_CREATED && _activity.type != M_LODGE) && (_activity.status == A_STARTED || _activity.status == A_FINISHED)) {
            [share setLodgeButtonHidden:NO];
        }else {
            [share setLodgeButtonHidden:YES];
        }
        [share show];
        
    }
    
//    //投诉
//    
//    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"投诉仅针对活动发起者未举行活动，其他问题暂不受理。若有虚假投诉，友信宝一经核实将限制参与活动权限。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"投诉", nil];
//    alter.tag = kLodgeTag;
//    [alter show];
    
}

#pragma mark - AAShareView delegate
- (void)AAShareViewWeixinSessionButtonDidClicked:(AAShareView *)view {
    //微信好友
    NSString *URLString = [NSString stringWithFormat:@"%@wap/aa/one.jsp?id=%ld",YXB_IP_ADRESS,(long)_activity.t_id];
    NSString *timeAddress = [NSString stringWithFormat:@"%@ %@ %@  %@",[_activity.activityDate substringWithRange:NSMakeRange(5, 5)],[_activity.activityDate substringWithRange:NSMakeRange(11, 5)],[AADetailHeaderView getWeekdayWithNum:_activity.weekday],_activity.destName];
    
    [YXBTool shareToWeixinSessionContent:timeAddress imgName:nil url:URLString title:_activity.topic callBackBlock:^{
        
    }];
}

- (void)AAShareViewWeixinTimelineContentButtonDidClicked:(AAShareView *)view {
    //微信朋友圈
    NSString *URLString = [NSString stringWithFormat:@"%@wap/aa/one.jsp?id=%ld",YXB_IP_ADRESS,(long)_activity.t_id];
    NSString *timeAddress = [NSString stringWithFormat:@"%@ %@ %@  %@",[_activity.activityDate substringWithRange:NSMakeRange(5, 5)],[_activity.activityDate substringWithRange:NSMakeRange(11, 5)],[AADetailHeaderView getWeekdayWithNum:_activity.weekday],_activity.destName];
    
    [YXBTool shareToWeixinTimelineContent:timeAddress imgName:nil url:URLString title:_activity.topic callBackBlock:^{
        
    }];
}

- (void)AAShareViewLodgeButtonDidClicked:(AAShareView *)view {
    //投诉
    if (_activity.status == A_FINISHED) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"活动已结束，不能投诉。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    
    if (_activity.type == M_CHECKIN) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"您已签到，不能投诉。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    
    if (_activity.status == A_PASSED) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"请在活动进行中使用此功能。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }

    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"投诉仅针对活动发起者未举行活动，其他问题暂不受理。若有虚假投诉，友信宝一经核实将限制参与活动权限。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"投诉", nil];
    alter.tag = kLodgeTag;
    [alter show];
}

- (void)AAShareViewGatheringButtonDidClicked:(AAShareView *)view {
    //AA收款
    if (_activity.type != M_CREATED) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"对不起，只有发起者才能发起AA收款。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    if (_activity.status != A_FINISHED && _activity.status != A_STARTED) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"请在活动开始后使用此功能。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    
    QCSelectRefundViewController *refund = [[QCSelectRefundViewController alloc] init];
    refund.activityId = self.activityId;
    refund.activity = _activity;
    refund.participants = _activity.participants;
    refund.title = _activity.topic;
    refund.titltext = _activity.topic;
    refund.state = @"收款";
    [self.navigationController pushViewController:refund animated:YES];
}

- (void)AAShareViewRefundingButtonDidClicked:(AAShareView *)view {
    //AA退款
    if (_activity.type != M_CREATED) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"对不起，只有发起者才能发起AA退款。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    
    if (_activity.status != A_FINISHED && _activity.status != A_STARTED) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"请在活动开始后使用此功能。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    
    QCSelectRefundViewController *refund = [[QCSelectRefundViewController alloc] init];
    refund.activity = _activity;
    refund.participants = _activity.participants;
    refund.title = _activity.topic;
    refund.state = @"退款";
    refund.activityId = self.activityId;
    refund.titltext = _activity.topic;
    [self.navigationController pushViewController:refund animated:YES];
}

#pragma mark - JoinPeopleTableViewCell delegate
- (void)JoinPeopleTableViewCellRejectButtonDidClicked:(JoinPeopleTableViewCell *)cell {
    NSIndexPath *indexPath = [_talbeView indexPathForCell:cell];
    
    _currentMember = [_activity.participants objectAtIndex:indexPath.row+1];
    
    NSString *mes;
    if (_activity.avgCost.floatValue == 0) {
        mes = [NSString stringWithFormat:@"是否拒绝%@参与活动聚会？",_currentMember.nickname];
    }else {
        mes = [NSString stringWithFormat:@"是否拒绝%@参与活动聚会？拒绝ta后，预付费同时返还到他的账户。",_currentMember.nickname];
    }
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:mes delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alter.tag = kRejectTag;
    [alter show];
}

#pragma mark - DetailHeaderView delegate
- (void)lodgeButtonActionWithStyle:(AADetailHeaderViewButtonStyle)style {
    if (style == AADetailHeaderViewButtonStyleLodge) {
        if (self.activity == nil) {
            return;
        }
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        AAInformView *inform = [[AAInformView alloc] initWithFrame:keyWindow.bounds];
        inform.dataArray = self.activity.complaints;
        [keyWindow addSubview:inform];
    }else if (style == AADetailHeaderViewButtonStyleCancle) {
        if ([YXBTool intervalSinceNow:_activity.activityDate]/3600 >= 1) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"是否确认取消活动聚会？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            alter.tag = kCancleTag;
            [alter show];
            
        }else if ([YXBTool intervalSinceNow:_activity.activityDate]/3600 > 0 && [YXBTool intervalSinceNow:_activity.activityDate]/3600 < 1){
            [YXBTool showAlertViewWithString:@"活动开始前1小时不能取消活动。"];
        }
        //        [statusHttp cancelTActivity:_activity];
        
        
    }
}
//- (void)mapButtonAction {
//    if (_activity != nil) {
//        CLLocationCoordinate2D location = CLLocationCoordinate2DMake(_activity.destLatitude.floatValue, _activity.destLongitude.floatValue);
//        
//        RongLocationViewController *locationViewController = [[RongLocationViewController alloc] initWithLocation:location locationName:_activity.destName];
//        [self.navigationController pushViewController:locationViewController animated:YES];
//    }
//}


-(void)userImageClickedWithUserId:(NSInteger)uId
{
    User *user = [[User alloc] init];
    user.t_id = uId;
    
    FriendDetailViewController *controller = [[FriendDetailViewController alloc] init];
    controller.user = user;
    [self.navigationController pushViewController:controller animated:YES];
    
}
//选择好友之后的回调
- (void)createAACollectMoneyRequestWithNames:(NSString *)names
{
    http = [[StatusHttp alloc]init];

    [http addTActivityInviteeListActivityId:self.activity.t_id userIdStr:names complete:^(TResultSet *resultSet) {
        if (resultSet.errCode == 0) {
//            UIAlertView *altert = [[UIAlertView alloc] initWithTitle:nil message:@"邀请成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [altert show];
            [ProgressHUD showSuccessWithStatus:resultSet.errString];
            [[YXBTool getCurrentNav] popViewControllerAnimated:YES];
        }else {
            UIAlertView *altert = [[UIAlertView alloc] initWithTitle:nil message:resultSet.errString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [altert show];
            
        }
    }];

}


//- (void)imageButtonActionWithSender:(UIButton *)sender {
//    AAImageViewController * imageViewController = [[AAImageViewController alloc]init];
//    imageViewController.activity = _activity;
//    [self.navigationController pushViewController:imageViewController animated:YES];
//
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
