//
//  DebtDetailNewViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/20.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DebtDetailNewViewController.h"
#import "DebtDetailCell.h"
#import "DebtDetailHeaderView.h"
#import "DebtDetailFooterView.h"
#import "YXBTool.h"
#import "DebtdetailAlertContentView.h"
#import "CustomIOSAlertView.h"
#import "HttpOperator.h"
#import "AppBlankNoteManager.h"
#import "DebtScheduleViewController.h"
#import "QCBaseTableView.h"
#import "QCLoginOneViewController.h"
#import "StudentCertifyController.h"
#import "UserState.h"
#import "UIAlertView+Block.h"
#import "WhiteCollarViewController.h"
#import "SetViewController.h"
#import "StudentVerifyViewController.h"

#define DebtDetailNewViewControllerNumberOfItems 5

@interface DebtDetailNewViewController ()<UITableViewDataSource,UITableViewDelegate,DebtDetailFooterViewDelegate,QCBaseTableViewDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)QCBaseTableView *tableView;
@property(nonatomic,strong)DebtDetailHeaderView *headerView;
@property(nonatomic,strong)DebtDetailFooterView *footerView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)HttpOperator   *iHttpOperator;



@end

@implementation DebtDetailNewViewController
-(void)dealloc{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    [self setTitle:[NSString stringWithFormat:@"%@的白条",_model.nickName]];

    [self loadCustomViews];
//    [self loadViewWithModel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadCustomViews
{
    CGFloat x = 0, y = 0, w = kDeviceWidth,h = 94;
    
    self.headerView = [[DebtDetailHeaderView alloc] initWithFrame:CGRectMake(x,y, w, h)];
    _headerView.backgroundColor = [UIColor whiteColor];
    self.footerView = [[DebtDetailFooterView alloc] initWithFrame:CGRectMake(0, 0, w, h + 40)];
//    _footerView.backgroundColor = [UIColor greenColor];
    _footerView.delegate = self;
    
    x = 0, y = 0, w = kDeviceWidth,h = kDeviceHeight - 64;
    self.tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(x, y, w, h) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = _footerView;
    [self.view addSubview:_tableView];
}

//网络请求
-(void)requestData
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak DebtDetailNewViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
        
    } error:^(int d, THttpOperatorErrorCode e) {
        if (e == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            [this.tableView reloadDeals];
        }

        
    } param:^(NSString *s) {

        [this httpLOadParams:s httpOperation:assginHtttperator];
        
    } complete:^(id r, int taskid) {

    
        [this httpLoadComplete:r];
    }];
    
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    AppBlankNoteManager* blankNote = (AppBlankNoteManager *)  [httpOperation getAopInstance:[AppBlankNoteManager class] returnValue:[BlankNoteData class]];
    NSString *token = @"";
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    token = userModel.user.yxbToken;
    if (token == nil) {
        token = @"";
    }
    [blankNote getNoteSetting:token blankNoteDataID:self.model.blankNoteID];
}
//请求完成
-(void)httpLoadComplete:(id)r{
    NSLog(@"r=  %@",r);
    
    [self.tableView reloadDeals];
    
    BlankNoteData *set = r;
    if (set.errCode == 0)
    {
        //            [alerView close];
        
        
        self.model = set;
        [self loadViewWithModel];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求数据失败" message:set.errString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"请求数据失败：---%@",set.errString);
    }
    
    

}


//views 赋值
-(void)loadViewWithModel
{
    if (_model != nil) {
        [self divideModelsWithModelProperty];
        _headerView.model = _model;
        [_tableView reloadData];
    }
}

#pragma -mark 将model拆分成tableView的数据源
-(void)divideModelsWithModelProperty
{
    NSInteger numberOfItems = DebtDetailNewViewControllerNumberOfItems;
    NSMutableArray *keysArray = [NSMutableArray array];
    [keysArray addObject:@"借款金额"];
    [keysArray addObject:@"还款方式"];
    [keysArray addObject:@"还款周期"];
    [keysArray addObject:@"年 利 率"];
    [keysArray addObject:@"利    息"];
    
    NSMutableArray *valuesArray = [NSMutableArray array];
    [valuesArray addObject:[NSString stringWithFormat:@"%@",_model.money==nil?@"":_model.money]];
    [valuesArray addObject:[NSString stringWithFormat:@"%@",_model.repaymentStringWithType==nil?@"":_model.repaymentStringWithType]];
    [valuesArray addObject:[NSString stringWithFormat:@"%ld",_model.repaymentMonth<=0?0:((long)_model.repaymentMonth)]];
    [valuesArray addObject:[NSString stringWithFormat:@"%@",_model.yearRate==nil?@"":_model.yearRate]];
    [valuesArray addObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@元",[YXBTool setMoney:_model.money yearRate:self.model.yearRate repaymentMonth:self.model.repaymentMonth]]]];

    self.dataArray = [NSMutableArray array];
    [_dataArray removeAllObjects];
    for (int i = 0; i < numberOfItems; i ++) {
        DebtItemModel *itemModel = [[DebtItemModel alloc] init];
        itemModel.debtName = keysArray[i];
        itemModel.debtValue = valuesArray[i];
        [_dataArray addObject:itemModel];
    }
}

#pragma -mark UITableViewDataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellID";
    DebtDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[DebtDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.width = _tableView.width;
    cell.height = DebtDetailCellHeight;
    [cell reSetFrameIfNeed];
    if (indexPath.row < [_dataArray count]) {
        DebtItemModel * debtModel = _dataArray[indexPath.row];
        cell.model = debtModel;
        if (indexPath.row == [_dataArray count] - 1) {
            [cell isFirstMianxi:YES];
        }
        else
        {
            [cell isFirstMianxi:NO];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DebtDetailCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section   // custom view for header. will be adjusted to default or specified header height
{
    UIView *sHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.width, 20)];
    sHeader.backgroundColor = [UIColor clearColor];
    return sHeader;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

//下拉刷新
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    [self requestData];
}




#pragma mark ----alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10010){
        if (buttonIndex == 1) {
            
            [self toLogin];
        }
    } else if (alertView.tag == 10086){
        if (buttonIndex == 1) {
            [self toAuthentication];
        }
    } else if (alertView.tag == 100861){
        if (buttonIndex == 1) {
            [self toSetViewCtr];
        }
    }
    
}

- (void)toSetViewCtr {
    SetViewController *authentic = [[SetViewController alloc] init];
    [self.navigationController pushViewController:authentic animated:YES];
}

//白领认证
- (void)towhitecollartication {
    WhiteCollarViewController *white=[[WhiteCollarViewController alloc]init];
    [self.navigationController pushViewController:white animated:YES];
    
}

- (void)tostuauthentic{
    //学生认证
    StudentVerifyViewController *stuauthentic = [[StudentVerifyViewController alloc] init];
    [self.navigationController pushViewController:stuauthentic animated:YES];
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

-(void)findToLoan//找他借款点击事件
{
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有登录，请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alterView.tag = 10010;
        [alterView show];
        return;
    }
    
    if ([UserState isLv3] == E_NO_OPERATE) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"向土豪借款，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alterView.tag = 10086;
        [alterView show];
        return;
    }else if ([UserState isLv3] == E_IN_REVIEW) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
        return;
    }else if ([UserState isLv3] == E_FAIL_UserStateRes) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"您的身份认证失败，请从新认证" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
        return;
    }
    //    if ([UserState isLv4] == E_NO_OPERATE) {
    //        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"向土豪借款，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //        alterView.tag = 100861;
    //        [alterView show];
    //        return;
    //    }else if ([UserState isLv4] == E_IN_REVIEW) {
    //        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    //        [alterView show];
    //        return;
    //    }else if ([UserState isLv4] == E_FAIL_UserStateRes) {
    //        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"您的身份认证失败，请从新认证" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    //        [alterView show];
    //        return;
    //    }
    
    if (userModel.user.studentStatus == 2 || userModel.user.whiteCollarStatus == 2) {
        
    }else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请先进行身份认证" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"学生认证" otherButtonTitles:@"白领认证", nil];
        [actionSheet showInView:self.view];
        return;
    }


    
//    if (userModel.user.accountStatus == 1) {
//        //审核，可以借款
//        return;
//    }else if (userModel.user.accountStatus == 2) {
//        //通过
//    }else if (userModel.user.accountStatus == 3) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"向土豪借款，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 10086;
//        [alterView show];
//        return;
//    }else if (userModel.user.accountStatus == 4) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alterView show];
//        return;
//    }else if (userModel.user.accountStatus == 0) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"向土豪借款，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 10086;
//        [alterView show];
//        return;
//    }
//    
//    if (userModel.user.studentStatus == 1) {
//        //审核，可以借款
//        return;
//    }else if (userModel.user.studentStatus == 2) {
//        //通过
//    }else if (userModel.user.studentStatus == 3) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"向土豪借款，请先完善身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 100861;
//        [alterView show];
//        return;
//    }else if (userModel.user.studentStatus == 0) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"申请借款，请完成学生认证" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 100861;
//        [alterView show];
//        return;
//    }
    /*
    DebtdetailAlertContentView *contentView = [self setAlertContentView];
    
    contentView.model = _model;
    
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:contentView];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"确认", nil]];
    //    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        if (buttonIndex == 1) {
            [self requestPay:alertView];
            
        }
        else
        {
            [alertView close];
            
        }
    }];
    
    [alertView setUseMotionEffects:true];
    // And launch the dialog
    [alertView show];
    
    */
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"是否确认借入\"%@\"的白条",_model.nickName] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            [self requestPay:nil];

        }
    }];
    
}

-(DebtdetailAlertContentView *)setAlertContentView
{
    DebtdetailAlertContentView *contentView = [[DebtdetailAlertContentView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth-20, 200)];
    contentView.backgroundColor = [UIColor whiteColor];
    //    [self setAlertContent:contentView];
    //    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    //    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //    maskLayer.frame = contentView.bounds;
    //    maskLayer.path = maskPath.CGPath;
    //    contentView.layer.mask = maskLayer;
    return contentView;
}

/**
 *  @author chenglibin
 *
 *  找他借款网络请求
 */
-(void)requestPay:(CustomIOSAlertView *)alerView
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak DebtDetailNewViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
        
    } error:^(int d, THttpOperatorErrorCode e) {
        
        
    } param:^(NSString *s) {

        [this httpLOad_RequestPayParams:s httpOperation:assginHtttperator];
        
    } complete:^(id r, int taskid) {
        
        [this httpLoad_RequestPayComplete:r];
    }];
    
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOad_RequestPayParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    AppBlankNoteManager* blankNote = (AppBlankNoteManager *)  [httpOperation getAopInstance:[AppBlankNoteManager class] returnValue:[TResultSet class]];
    NSString *token = @"";
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    token = userModel.user.yxbToken;
    if (token == nil) {
        token = @"";
    }
    [blankNote claimNote:token noteID:_model.blankNoteID];
}
//请求完成
-(void)httpLoad_RequestPayComplete:(id)r{
    NSLog(@"r=  %@",r);
    
    TResultSet *set = r;
    if (set.errCode == 0)
    {
        //            [alerView close];
        
        NSInteger blankNoteId = set.resInteger;
        if (blankNoteId >= 0) {
            [self successToScheduleWithNoteId:blankNoteId];
            
        }
        else
        {
            NSLog(@"白条id错误");
        }
        [ProgressHUD showErrorWithStatus:set.errString];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"白条借入失败" message:set.errString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"白条借入失败：---%@",set.errString);
    }

}
-(void)successToScheduleWithNoteId:(NSInteger)noteId
{
    
    /*
     UIAlertView *subAlert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的借款已申请成功,工作人员将在2小时内进行电话确认。" delegate:nil cancelButtonTitle:@"查看进度" otherButtonTitles: nil];
     [subAlert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
     
     DebtScheduleViewController *controller = [[DebtScheduleViewController alloc] init];
     controller.model = _model;
     [self.navigationController pushViewController:controller animated:YES];
     }];
     */
    
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    UILabel *titleLabel = [self labelWithFrame:CGRectMake(0, 0, kDeviceWidth - 20, 80)];
    [titleLabel setNumberOfLines:0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = @"您的借款已申请成功,工作人员将在2小时内进行电话确认。";
    //    [self setAlertContent:titleLabel];
    // Add some custom content to the alert view
    [alertView setContainerView:titleLabel];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"查看进度", nil]];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        if (buttonIndex == 0) {
            DebtScheduleViewController *controller = [[DebtScheduleViewController alloc] init];
            NoteSummary *noteSummary = [[NoteSummary alloc] init];
            noteSummary.repaymentNoteID = noteId;
            noteSummary.debtorName = _model.nickName;
            
            controller.noteSummary = noteSummary;
            [self.navigationController pushViewController:controller animated:YES];
            
        }
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    // And launch the dialog
    [alertView show];
    
    
}

#pragma mark - UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self tostuauthentic];
    }else if (buttonIndex == 1){
        [self towhitecollartication];
    }else if (buttonIndex == 2){
        NSLog(@"取消");
    }
}


- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

-(UILabel *)labelWithFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
//    label.backgroundColor = [self generateRandomColor];
    label.font = [UIFont systemFontOfSize:14];
    return label;
}


@end
