//
//  realModeViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/6/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "realModeViewController.h"
#import "HttpOperator.h"
#import "LoginCell.h"
#import "RealnameAuthenticationManager.h"
#import "RealnameAuthentication.h"
#import "AuthenticationViewController.h"
#import "YXBTool.h"
#import "HomePopView.h"
typedef enum{
    RealModeTypeRealName,
    RealModeTypeId,
}RealModeType;

@interface realModeViewController ()<UITableViewDelegate,UITableViewDataSource,QCBaseTableViewDelegate,HomePopViewDelegate>

@property (nonatomic,strong)QCBaseTableView *tableView;
@property(nonatomic,strong)HttpOperator   *iHttpOperator;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)RealnameAuthentication *myAuthModel;
@property(nonatomic,strong)UIButton *sureBtn;

@end

@implementation realModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"实名认证"];
    
    [self initViews];
    
    self.dataArray = [NSMutableArray array];
}

- (void)initViews {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 60)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = rgb(137, 137, 137, 1.0);
    label.font = [UIFont systemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"为了保障您的利益，请认真填写身份信息!";
    label.userInteractionEnabled = YES;
    [self.view addSubview:label];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [label addGestureRecognizer:tap];
    
    
    
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, label.origin.y + label.height, kDeviceWidth, kDeviceHeight-64-label.height) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.backgroundColor = rgb(50, 142, 250, 1.0);
    _sureBtn.frame = CGRectMake(20, LoginCellContentHeight*2+50, kDeviceWidth - 40, 50);
    [_sureBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(overleapAction:) forControlEvents:UIControlEventTouchUpInside];
    _sureBtn.layer.cornerRadius = 5.0;
    
    [_tableView addSubview:_sureBtn];

}

-(void)viewWillAppear:(BOOL)animated
{

    
    [self requestData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.iHttpOperator cancel];
}

-(void)endEdit
{
    [self.view endEditing:YES];
//    [self.view endEditing:NO];
}

-(void)loadData
{
    if (_dataArray != nil && [_dataArray count] > 0) {
        [_dataArray removeAllObjects];
    }
    
    NSMutableArray *title1Array = [NSMutableArray arrayWithObjects:
                                   (_myAuthModel.realname == nil)?@"":_myAuthModel.realname,
                                   (_myAuthModel.idCardNo == nil)?@"":_myAuthModel.idCardNo,
                                   nil];

        NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"真实姓名:",@"身份证号:",nil];
    
    for (int i = 0; i < [title1Array count]; i ++) {
        LoginModel *model = [[LoginModel alloc] init];
        model.titleName = titleArray[i];
        model.text = title1Array[i];
        [_dataArray addObject:model];
    }
    
    //设置是否可编辑
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (userModel.user.accountStatus == IdentityCheckStatusRegisted) {
        //审核通过 2 审核中1 不可编辑
        _sureBtn.hidden = NO;
    }
    else
    {
        _sureBtn.hidden = YES;
        
    }
}



#pragma mark- UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LoginCellContentHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellID";
    LoginCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == Nil) {
        
        cell = [[LoginCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID width:_tableView.width height:LoginCellContentHeight];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    __weak  realModeViewController *this = self;
    
    [cell setMyTextfieldBeginBlock:^{
        
        
    } EndBlock:^(NSString *text) {
        
        if (indexPath.row == 0) {
            this.myAuthModel.realname = text;
        }
        if (indexPath.row == 1) {
            this.myAuthModel.idCardNo = text;
        }
        
        
    }];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    //设置是否可编辑
    if (userModel.user.accountStatus == IdentityCheckStatusRegisted) {
        //审核通过 2 审核中1 不可编辑
        [cell editEnable:YES];
    }
    else
    {
        [cell editEnable:NO];
        
    }
    
    if (indexPath.row < [_dataArray count]) {
        LoginModel* model = _dataArray[indexPath.row];
        
        cell.model = model;
        
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self endEdit];
    
}

#pragma mark - QCBaseTabelView delegate
-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    [self requestData];
}

#pragma mark - HTTP 
-(void)requestData
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak realModeViewController *this = self;
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
    
        [this httpLoadParamsTwo:assginHtttperator];
        
    } complete:^(RealnameAuthentication *r, int taskid) {
        [this httpLoadCompleteTwo:r];
    }];
    
    [self.iHttpOperator connect];
    
    
}
- (void)httpLoadParamsTwo:(HttpOperator *)assginHtttperator{

    RealnameAuthenticationManager *manager = (RealnameAuthenticationManager *)[assginHtttperator getAopInstance:[RealnameAuthenticationManager class] returnValue:[RealnameAuthentication class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [manager getInfo:userModel.user.yxbToken];
}
- (void)httpLoadCompleteTwo:(RealnameAuthentication *)r{

    NSLog(@"r=  %@",r);

    [self.tableView reloadDeals];
    if (r.errCode == 0 || r.errCode == 7) {
        
        self.myAuthModel = r;
        
        [self loadData];
        [_tableView reloadData];
        
    }
    else
    {
        NSLog(@"请求错误---");
    }

}
//身份认证
-(void)authenInfoWithType:(RealModeType)type
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak realModeViewController *this = self;
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
        [this httpLoadParams:assginHtttperator];
    } complete:^(TResultSet *r, int taskid) {
        [this httpLoadComplete:r];
        
    }];
    
    [self.iHttpOperator connect];
    
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    RealnameAuthenticationManager *manager = (RealnameAuthenticationManager *)[assginHtttperator getAopInstance:[RealnameAuthenticationManager class] returnValue:[TResultSet class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance]getLoginUser];
    self.myAuthModel.userToken = userModel.user.yxbToken;
    self.myAuthModel.userId = userModel.user.t_id;
    [manager __yxb_service__updateRealnameInfo:self.myAuthModel];
    NSLog(@"%@",self.myAuthModel.idCardNo);
    NSLog(@"%@",self.myAuthModel.realname);

}
- (void)httpLoadComplete:(TResultSet *)r{
    if (r.errCode == 0 || r.errCode == 7) {
        
        //实名认证信息(身份证号)验证成功  更新认证状态到本地
        QCUserModel * userModel = [[QCUserManager sharedInstance] getLoginUser];
        userModel.user.idCardNo = self.myAuthModel.idCardNo;
        userModel.user.realname = self.myAuthModel.realname;
        userModel.user.accountStatus = 4;
        [[QCUserManager sharedInstance] setLoginUser:userModel];
        
        if (r.errCode == 0) {
                [self endEdit];
            HomePopView *homeview = [[HomePopView alloc] init];
            homeview.delegte = self;
            [homeview showCongratulations];
        }
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"认证成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
        [self requestData];
        
        //            [this.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        //            NSLog(@"请求错误---");
    }



}

#pragma mark 任务体系 HomePopView - delegete
- (void)LookNniversalRoll:(NSString *)urlStr {

    [YXBTool jumpInnerSafaryWithUrl:urlStr hasTopBar:NO titleName:@"优惠券"];
}

#pragma mark - Button Action
- (void)overleapAction:(UIButton *)button {
    [self authenInfoWithType:RealModeTypeRealName];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
