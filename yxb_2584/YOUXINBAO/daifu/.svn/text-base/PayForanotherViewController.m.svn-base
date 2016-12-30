//
//  PayForanotherViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/9/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "PayForanotherViewController.h"
#import "YXBTool.h"
#import "GuaranteeManager.h"
#import "HelpPayment.h"
#import "Payment_producutOtherPay.h"
#import "User.h"
#import "FriendDetailViewController.h"
#import "UIAlertView+Block.h"

@interface PayForanotherViewController ()<PayForanotherTableViewCellDelegate>
@property(nonatomic,strong)HelpPayment  *model;
@end
#define deufbottomHight     49
@implementation PayForanotherViewController
-(void)dealloc{
    NSLog(@"PayForanotherViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"代付详情"];
    [self setBackView];
    [self createView];
    [self createBottomView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self httpDowloadWithListStyle:1];
}
- (void)createView {
    self.view.backgroundColor = rgb(244, 244, 244, 1);
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0 , kDeviceWidth,kDeviceHeight-64-deufbottomHight) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = rgb(244, 244, 244, 1);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];

}

- (void)createBottomView {
    NSArray *array = @[@"拒绝代付",@"付款"];
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-deufbottomHight-64, kDeviceWidth, deufbottomHight)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0.5)];
    view3.backgroundColor = [YXBTool colorWithHexString:@"#d6d6d6"];
    [self.bottomView addSubview:view3];
    for (int i = 0; i < 2; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2*i, 0, kDeviceWidth/2, self.bottomView.height)];
        [button setTitleColor:[YXBTool colorWithHexString:@"#2C91EC"] forState:UIControlStateNormal];
        button.tag = i;
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(bottombuttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:button];
    }
    self.bottomView.hidden = YES;
}

- (void)bottombuttonAction:(UIButton *)sender {
    if (sender.tag == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否拒绝代付" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                //拒绝代付
                [self httpDowloadWithListStyle:2];

            }
        }];
    }else if (sender.tag == 1){
        //同意
        //支付
        Payment_producutOtherPay *payModel = [[Payment_producutOtherPay alloc] init];
        payModel.money = self.model.helpPayMoney;
        payModel.otherId = [NSString stringWithFormat:@"%ld",(long)self.model.helpPaymentId] ;
        NSString *url = [YXBPaymentUtils getFullWebUrl:payModel];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];
    }

}




#pragma mark --- tableview delegate
//下拉刷新
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self httpDowloadWithListStyle:1];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *informationIdentifier = @"PayForanotherTableViewCell";
    PayForanotherTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:informationIdentifier];
    if (cell == nil) {
        cell = [[PayForanotherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:informationIdentifier];
         cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.layer.borderColor = [YXBTool colorWithHexString:@"#d6d6d6"].CGColor;
        cell.layer.borderWidth = 0.5f;
    }
    cell.delegate = self;
    cell.model = self.model;
    return cell;
}
//计算高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 310+[YXBTool getFontSizeWithString:self.model.helpPayDeclare font:[UIFont systemFontOfSize:16] constrainSize:CGSizeMake(kDeviceWidth-120, CGFLOAT_MAX)].height+2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(void)toMyFriend
{
    NSInteger userId = self.model.helpPayUserId;
    User *user = [[User alloc] init];
    user.t_id = userId;
    
    FriendDetailViewController *controller = [[FriendDetailViewController alloc] init];
    controller.user = user;
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpDowloadWithListStyle:(NSInteger)type//1 初始请求  2  点击拒绝请求
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = self.iHttpOperator;
    __weak PayForanotherViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            [this.tableView reloadDeals];
            [ProgressHUD dismiss];
            
        }
        
    } param:^(NSString *s) {

        [this httpLOadParams:s httpOperation:assginHtttperator WithListStyle:type];
    } complete:^(HelpPayment *r, int taskid) {
        
        [this httpLoadComplete:r];
        
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation WithListStyle:(NSInteger)type
{
    GuaranteeManager  * manager = (GuaranteeManager *)  [httpOperation getAopInstance:[GuaranteeManager class] returnValue:[HelpPayment class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *userToken = userModel.user.yxbToken;
    if (type == 1) {
        [manager getHelpPayment:userToken helpPayID:self.helpID];
    }else if (type == 2){
        [manager refuseHelpPayment:userToken helpPayID:self.helpID];
    }
}
//请求完成
-(void)httpLoadComplete:(HelpPayment *)r{
    if (r.errCode == 0) {
        self.model = r;
    }else {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"请求出错" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }
    [_tableView reloadData];
    [_tableView reloadDeals];
    [self reloadBottomView];
}

- (void)reloadBottomView {
    if (self.model.helpPaymentStatus == 100) {
        self.bottomView.hidden = NO;
        _tableView.height = kDeviceHeight-64-deufbottomHight;
    }else {
        self.bottomView.hidden = YES;
        _tableView.height = kDeviceHeight-64;
    }
}
@end
