//
//  GuaranteeDaifuDetailViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/9/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "GuaranteeDaifuDetailViewController.h"
#import "YXBTool.h"
#import "GuaranteeDaifuDetailCell.h"
#import "PayScrollView.h"
#import "GuaranteeStages.h"
#import "PayForanotherViewController.h"
#import "GuaranteeManager.h"
#import "HelpPayment.h"
#import "GuaranteeData.h"
#import "Payment_producutAssurePay.h"
#import "UIAlertView+Block.h"
@interface GuaranteeDaifuDetailViewController ()
@property (nonatomic,strong)PayScrollView *payScrollView;
@property(nonatomic,strong)GuaranteeData  *model;
@property(nonatomic,strong)UIButton  *phoneBut;
@end
#define deufbottomHight     49
@implementation GuaranteeDaifuDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    [self setTitle:@"详情"];
//    [self setNavbar];
    [self createView];
    [self createBottomView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self httpDowloadWithListStyle:1];
}

- (void)setNavbar {
    [self setNavigationButtonItrmWithiamge:@"index-notice-icon.png" withRightOrleft:@"right" withtargrt:self withAction:@selector(rightNavigationItemAction)];
}

- (void)rightNavigationItemAction {
    NSString *url = [YXBTool getURL:@"webView/explain/assureExplain.jsp" params:nil];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"分期担保说明"];
}
- (void)createBottomView {
    NSArray *array = @[@"拒绝担保",@"支付担保金"];
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-deufbottomHight-64, kDeviceWidth, deufbottomHight)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0.5)];
    view3.backgroundColor = [YXBTool colorWithHexString:@"#d6d6d6"];
    [self.bottomView addSubview:view3];
    for (int i = 0; i < 2; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/2*i, 0, kDeviceWidth/2, self.bottomView.height)];
        button.tag = i;
        [button setTitleColor:[YXBTool colorWithHexString:@"#2C91EC"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(bottombuttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:button];
    }
    self.phoneBut = [[UIButton alloc] initWithFrame:self.bottomView.bounds];
    [self.phoneBut setTitleColor:[YXBTool colorWithHexString:@"#2C91EC"] forState:UIControlStateNormal];
    self.phoneBut.backgroundColor = [UIColor whiteColor];
    [self.phoneBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self.phoneBut setTitle:@"电话沟通" forState:UIControlStateNormal];
    [self.phoneBut addTarget:self action:@selector(bottombuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.phoneBut.tag = 3;
    [self.bottomView addSubview:self.phoneBut];
    self.bottomView.hidden = YES;
}
- (void)bottombuttonAction:(UIButton *)sender {
    if (sender.tag == 0) {
        //拒绝担保
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否拒绝担保" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                [self httpDowloadWithListStyle:2];

            }
        }];

        
    }else if (sender.tag == 1){
        //支付
        Payment_producutAssurePay *payModel = [[Payment_producutAssurePay alloc] init];
        payModel.money = self.model.guaranteeMoney;
        payModel.assureId = [NSString stringWithFormat:@"%ld",(long)self.model.guaranteeID] ;
        NSString *url = [YXBPaymentUtils getFullWebUrl:payModel];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];
//        [YXBTool jumpSafariWithUrl:url];
    }else if (sender.tag == 3){
        //电话
        [YXBTool callTelphoneWithNum:self.model.proposerPhoneNumber];
    }
    
}

- (void)createView {
    self.view.backgroundColor = rgb(244, 244, 244, 1);
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0 , kDeviceWidth,kDeviceHeight-64-deufbottomHight) style:UITableViewStylePlain refreshFooter:NO];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    _tableView.backgroundColor = rgb(244, 244, 244, 1);
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
    [_tableView reloadDeals];
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
    static NSString *informationIdentifier = @"GuaranteeDaifucell";
    GuaranteeDaifuDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:informationIdentifier];
    if (cell == nil) {
        cell = [[GuaranteeDaifuDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:informationIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.layer.borderColor = rgb(235, 235, 235, 1).CGColor;
        cell.layer.borderWidth = 0.5f;
    }

    cell.model = self.model;
    return cell;
}
//计算高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat tintHeight = [GuaranteeDaifuDetailCell getTintHeight] + 10;
    return 550 + tintHeight;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    PayForanotherViewController *ctr = [[PayForanotherViewController alloc] init];
//    [self.navigationController pushViewController:ctr animated:YES];
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
    __weak GuaranteeDaifuDetailViewController *this = self;
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
        
    } complete:^(GuaranteeData *r, int taskid) {
        
        [self httpLoadComplete:r];
        
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation WithListStyle:(NSInteger)type
{
    GuaranteeManager  * manager = (GuaranteeManager *)  [httpOperation getAopInstance:[GuaranteeManager class] returnValue:[GuaranteeData class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *userToken = userModel.user.yxbToken;
    if (type == 1) {
        [manager getGuaranteeDetails:userToken guaranteeID:self.guaranteeID];
    }else if (type == 2){
        [manager refuseGuarantee:userToken guaranteeID:self.guaranteeID];
    }
}
//请求完成
-(void)httpLoadComplete:(GuaranteeData *)r{
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
    _tableView.height = kDeviceHeight-64-deufbottomHight;
    if (self.model.guaranteeState == 100) {
        self.bottomView.hidden = NO;
        self.phoneBut.hidden = YES;
    }else if(self.model.guaranteeState == 200){
        self.bottomView.hidden = NO;
        self.phoneBut.hidden = NO;
    }else {
        self.bottomView.hidden = YES;
        _tableView.height = kDeviceHeight-64;
    }
}
@end
