//
//  LoanConfirmViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanConfirmViewController.h"
#import "LoanConfirmTableViewCell.h"
#import "LoanFriendTypeViewController.h"
#import "YXBTool.h"
#import <QuartzCore/QuartzCore.h>
#import "YXBJieKuanController.h"
#import "JieKuanConfig.h"
#import "LoanManagerV10.h"
//@class YXBJieKuanController;
@interface LoanConfirmViewController ()<UITableViewDataSource,UITableViewDelegate,YXBJieKuanControllerDelegate>
@property(nonatomic,weak)UITableView *myTableView;
/**数据源*/
@property(nonatomic,strong)NSMutableArray *dataArray;

@property (strong, nonatomic) HttpOperator* iHttpOperator;

@end

@implementation LoanConfirmViewController
-(void)dealloc{
    NSLog(@"LoanConfirmViewController is dealloc");
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认借条信息";
    [self initUI];
    self.view.backgroundColor = kRGB(239, 239, 239);
    
}
-(void)initUI{
    [self setBackView];
    [self createTableView];

}
-(void)setBackView
{
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 30);
    [rightBtn setTitle:@"修改" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 13, kDeviceWidth-30, kDeviceHeight-64-13)];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource =self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [self createFooterView];
    self.myTableView = tableView;
    [self.view addSubview:self.myTableView];
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(0, _myTableView.bottom-13-20, kDeviceWidth-30, 13);
    [bottomBtn setImage:[UIImage imageNamed:@"safeguard"] forState:UIControlStateNormal];
    [_myTableView addSubview:bottomBtn];
}
-(UIView*)createFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth-30, 120)];
    
    UIButton *agreeProBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeProBtn.frame = CGRectMake(0, 0, 268, 27);
    agreeProBtn.center = CGPointMake((kDeviceWidth-30)/2.0, 25);
    [agreeProBtn setImage:[UIImage imageNamed:@"agree2"] forState:UIControlStateNormal];
    [agreeProBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:agreeProBtn];
    
    UIButton *selectFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectFriendBtn.frame = CGRectMake(0, agreeProBtn.bottom+13, kDeviceWidth-30, 42);
    [selectFriendBtn setImage:[UIImage imageNamed:@"selectFri"] forState:UIControlStateNormal];
    [selectFriendBtn addTarget:self action:@selector(selectedFriendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:selectFriendBtn];
    return footerView;
}
#pragma mark - Action
-(void)rightClick{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)leftClicked{
    
    [self.navigationController popViewControllerAnimated:YES];
}
//用户协议
-(void)agreeBtnClick:(UIButton *)btn{

    NSString *url = [NSString stringWithFormat:@"%@webView/helpcenter/agreement.jsp",YXB_IP_ADRESS];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"友借款服务协议"];
}
//选择好友
-(void)selectedFriendBtnClick{
    LoanFriendTypeViewController *selectFriVC = [[LoanFriendTypeViewController alloc] init];
    selectFriVC.friendType = LoanNewFriendTypeJieRu;//借入
    selectFriVC.yxbLoanModel=self.yxbLoanModel;
    selectFriVC.payType = AmorOrderPayTypeFukuan;
    selectFriVC.jiekuanDelegate = self;
    [self.navigationController pushViewController:selectFriVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"cellID%ld",(long)indexPath.row];
    LoanConfirmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LoanConfirmTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    if (self.yxbLoanModel) {
        cell.loanRateStr = self.loanRate;
        cell.model = self.yxbLoanModel;
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 借款请求
- (void)httpJiekuanRequest:(YXBLoan*)yxbLoanModel{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block typeof(self) this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        [this stopDefaultAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        if (error == EHttp_Operator_Failed) {
            [ProgressHUD showErrorWithStatus:@"加载失败,请检查手机网络"];
        }
        
    } param:^(NSString *s) {
        LoanManagerV10 *managerV3 = (LoanManagerV10*)[assginHtttperator getAopInstance:[LoanManagerV10 class] returnValue:[CreateLoanResponse class]];
        [managerV3 __yxb_service__createYXBLoan:yxbLoanModel];
        
    } complete:^(CreateLoanResponse *r, int taskid){
        [ProgressHUD showErrorWithStatus:r.errString];
        
        if (r.errCode == 0) {
            [this callWeChatWithLoanId:r.loanId];
            //发送成功
            //            LoanSentSuccessfully * loanViewControllers = [[LoanSentSuccessfully alloc]init];
            //            loanViewControllers.data = r;
            //            [[YXBTool getCurrentNav] pushViewController:loanViewControllers animated:YES];
            
            
        }else{
            //            [ProgressHUD showErrorWithStatus:r.errString];
        }
        
    }];
    [self.iHttpOperator connect];
}

-(void)callWeChatWithLoanId:(NSInteger)loanId
{
    //分享借款单
    //http://60.195.254.33:8083/webView/loan/shareLoan.jsp?t=l&loanId=借款单id
    NSString *url = [NSString stringWithFormat:@"%@webView/loan/shareLoan.jsp?t=l&loanId=%ld",YXB_IP_ADRESS,(long)loanId];
    [YXBTool shareToWeixinSessionContent:@"雪中送炭，真友情经得住考验；好借好还，无忧借条保你全程安心！" imgName:[UIImage imageNamed:@"shareImg"] url:url title:@"您有好友急需借钱，快去无忧借条帮帮TA吧！" callBackBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}

@end
