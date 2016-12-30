//
//  ConfirmationPaymentViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/2.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ConfirmationPaymentViewController.h"
#import "ConfirmationPaymentCell.h"
#import "ConfirmationPaymentDetailCell.h"
#import "QCLoginOneViewController.h"
#import "StudentCertifyController.h"
#import "UserState.h"
#import "StudentVerifyViewController.h"
@interface ConfirmationPaymentViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate> {
    UIButton *bottomBut;
    UILabel *_labelmoneyshi;
    MyOrderScheduleTopView * _topView;
}

@property (nonatomic,strong) QCBaseTableView *tableView;

@end

@implementation ConfirmationPaymentViewController
-(void)dealloc{
    NSLog(@"ConfirmationPaymentViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    self.title = @"确认付款";
    self.view.backgroundColor = rgb(244, 244, 244, 1);
    [self createView];
}


- (void)createView {
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-45) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [self createBottomView];
}
- (void)createBottomView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bottom-45-64, kDeviceWidth, 45)];
    view.backgroundColor = [YXBTool colorWithHexString:@"#f9f9f9"];
    [self.view addSubview:view];
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
    label.text = @"实付款:";
    label.textColor = [YXBTool colorWithHexString:@"#303030"];
    label.font = [UIFont boldSystemFontOfSize:16];
    [view addSubview:label];
    _labelmoneyshi = [[UILabel alloc] initWithFrame:CGRectMake(label.right, 10, 200, 30)];
    _labelmoneyshi.font = [UIFont boldSystemFontOfSize:16];
    _labelmoneyshi.textColor = [YXBTool colorWithHexString:@"#d91e3d"];
    [view addSubview:_labelmoneyshi];
    bottomBut = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-110,0, 110,45)];
    bottomBut.backgroundColor = [UIColor clearColor];
    [bottomBut setImage:[UIImage imageNamed:@"gofk-but"] forState:UIControlStateHighlighted];
    [bottomBut setImage:[UIImage imageNamed:@"gofk-but-on"] forState:UIControlStateNormal];
    [bottomBut addTarget:self action:@selector(bottomButAction) forControlEvents:UIControlEventTouchUpInside];
    
    //上边框
    CALayer *border = [CALayer layer];
    float height = -1.0f;
    float width = kDeviceWidth;
    border.frame = CGRectMake(0.0f, height, width, 1.0f);
    border.backgroundColor = [YXBTool colorWithHexString:@"#dcdcdc"].CGColor;
    [view.layer addSublayer:border];
    [view addSubview:bottomBut];
}

#pragma mark --- bottomAction
- (void)bottomButAction {
    NSLog(@"去付款!!!");
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有登录，请登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alterView.tag = 10010;
        [alterView show];
        return;
    }
    if ([UserState isLv4] == E_NO_OPERATE) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"分期商品前，请新完善您的身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alterView.tag = 10086;
        [alterView show];
        return;
    }else if ([UserState isLv4] == E_IN_REVIEW) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
        return;
    }else if ([UserState isLv4] == E_FAIL_UserStateRes) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"您的身份认证失败，请从新认证" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
        return;
    }
//    if (userModel.user.accountStatus == 1) {
//        //审核，可以借款
//        return;
//    }else if (userModel.user.accountStatus == 2) {
//        //通过
//    }else if (userModel.user.accountStatus == 4) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"身份认证需要一段时间审核，您可以逛逛其他功能，认证通过后，我们会通知您" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alterView show];
//        return;
//    }else if (userModel.user.accountStatus == 3) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"分期商品前，请新完善您的身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 10086;
//        [alterView show];
//        return;
//    }else if (userModel.user.accountStatus == 0) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"分期商品前，请新完善您的身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
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
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"分期商品前，请新完善您的(学生)身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 100861;
//        [alterView show];
//        return;
//    }else if (userModel.user.studentStatus == 0) {
//        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"分期商品前，请新完善您的(学生)身份信息" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alterView.tag = 100861;
//        [alterView show];
//        return;
//    }
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
            //学生认证
            StudentVerifyViewController *stuauthentic = [[StudentVerifyViewController alloc] init];
            [self.navigationController pushViewController:stuauthentic animated:YES];
            
        }
    }
    
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


#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self requestData];
}



#pragma mark --- tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *str = [NSString stringWithFormat:@"%@",self.model.adress];
      CGFloat higa = [YXBTool countLabelHeightWithText:str font:[UIFont systemFontOfSize:15] labelWidth:kDeviceWidth-10-85];
        return higa+40+10;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 140;
        }else if (indexPath.row == 1){
            return 140;
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UILabel *labeltit = [[UILabel alloc] init];
        labeltit.backgroundColor = [YXBTool colorWithHexString:@"#f4f4f4"];
        labeltit.text = @"  商品详情";
        labeltit.textColor = [YXBTool colorWithHexString:@"#303030"];
        labeltit.font = [UIFont boldSystemFontOfSize:15];
        
        //上边框
        CALayer *border = [CALayer layer];
        float height = -1.0f;
        float width = kDeviceWidth;
        border.frame = CGRectMake(0.0f, height, width, 1.0f);
        border.backgroundColor = [YXBTool colorWithHexString:@"#dcdcdc"].CGColor;
        [labeltit.layer addSublayer:border];
        
        //下边框
        CALayer *border1 = [CALayer layer];
        float height1 = 40.0f;
        float width1 = kDeviceWidth;
        border1.frame = CGRectMake(0.0f, height1, width1, 1.0f);
        border1.backgroundColor = [YXBTool colorWithHexString:@"#dcdcdc"].CGColor;
        [labeltit.layer addSublayer:border1];
        
        return labeltit;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        return 40;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{

    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }
    else{
        return 2;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString * cellID  =@"conCellId";
        ConfirmationPaymentCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == Nil) {
            cell = [[ConfirmationPaymentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        cell.model = self.model;
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            static NSString * cellID  =@"cell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == Nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.clipsToBounds = YES;
                _topView=[[MyOrderScheduleTopView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 140)];
                [cell.contentView addSubview:_topView];
            }
            _topView.model = self.model;
            return cell;
        }else if (indexPath.row == 1){
            static NSString * cellID  =@"conCellIdd";
            ConfirmationPaymentDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == Nil) {
                cell = [[ConfirmationPaymentDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                
            }
            cell.model = self.model;
            return cell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    
}


#pragma mark --- 数据请求
-(void)requestData
{

    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak ConfirmationPaymentViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {

        
    } error:^(int d, THttpOperatorErrorCode e) {
        [this httpLoadError:e];
        
    } param:^(NSString *s) {
        [this httpLOadParams:s httpOperation:assginHtttperator];
        
    } complete:^(OrderDownPayment *r, int taskid) {
        [this httpLoadComplete:r];
    }];
    
    [self.iHttpOperator connect];
    
    
}
//请求失败
-(void)httpLoadError:(THttpOperatorErrorCode)error{
    if (error == EHttp_Operator_Failed) {
        //服务器挂了
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        [self.tableView reloadDeals];
    }
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    CommerceManager* commerceManager = (CommerceManager *)  [httpOperation getAopInstance:[CommerceManager class] returnValue:[OrderDownPayment class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [commerceManager getOrderDownPayment:self.orderId userToken:userModel.user.yxbToken];
}
//请求完成
-(void)httpLoadComplete:(OrderDownPayment *)r{
    if (r.errCode == 0) {
        _labelmoneyshi.text = [NSString stringWithFormat:@"￥%@",r.disbursements];
        self.model = r;
        [_tableView reloadData];
        [_tableView reloadDeals];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
