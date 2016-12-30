//
//  AmortizationProduceDetailViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/5/26.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AmortizationProduceDetailViewController.h"
#import "QCBaseTableView.h"
#import "AmortizationDetailView.h"
#import "CommerceManager.h"
#import "AACreatePickerView.h"
#import "CommerceDetail.h"
#import "StagesInterest.h"

@interface AmortizationProduceDetailViewController ()<UITableViewDelegate,UITableViewDataSource,QCBaseTableViewDelegate,AmortizationDetailViewDelegate>{
    AACreatePickerView *_firstPicker;
    AACreatePickerView *_stagePicker;
    
}

@property (nonatomic,strong) QCBaseTableView *tableView;
@property (nonatomic,strong)AmortizationDetailView *header;
@property (nonatomic,strong)CommerceDetail *data;
@property (nonatomic,strong)CommercePayment *payment;

@property (nonatomic,assign) NSInteger currentFirstRow; //首付选中行
@property (nonatomic,assign) NSInteger currentStageRow; //分期选中行

@end

@implementation AmortizationProduceDetailViewController
-(void)dealloc{
    NSLog(@"AmortizationProduceDetailViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"商品详情"];
    
    _currentFirstRow = 0;
    _currentStageRow = 0;
    
    [self initViews];
}

- (void)initViews {
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-50) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
    
    _header = [[AmortizationDetailView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAmortizationDetailViewHeight)];
    _header.delegate = self;
    _tableView.tableHeaderView = _header;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, _tableView.bottom, kDeviceWidth, 50)];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];
    
    UIButton *payButton = [[UIButton alloc] initWithFrame:CGRectMake((kDeviceWidth-200)/2, 5, 200, 40)];
    [payButton setTitle:@"分期购买" forState:UIControlStateNormal];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payButton setBackgroundImage:[UIImage imageNamed:@"blue-but2"] forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(payButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:payButton];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"商品详情";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"配置参数";
    }
    
    
    return cell;
}

#pragma mark - Http
- (void)httpLoad {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AmortizationProduceDetailViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
        
        
    } complete:^(CommerceDetail* r, int taskid) {
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
    CommerceManager *_commerceM = (CommerceManager *)[httpOperation getAopInstance:[CommerceManager class] returnValue:[CommerceDetail class]];
    
    [_commerceM getCommerceDetail:self.commerceID];
}
//请求完成
-(void)httpLoadComplete:(CommerceDetail *)r{
    if (r.errCode == 0) {
        if (r != nil) {
            self.header.data = r;
            self.data = r;
        }
        
    }else  {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
    
    [self.tableView reloadDeals];
    [self.tableView reloadData];
}
- (void)pay {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AmortizationProduceDetailViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [self httpLoadError:error];
        
    } param:^(NSString *s) {
        
        
        [this httpLOad_PayParams:s httpOperation:assginHtttperator];
        
    } complete:^(TResultSet* r, int taskid) {
        [this httpLoad_PayComplete:r];
//        [this.tableView reloadDeals];
//        [this.tableView reloadData];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOad_PayParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    CommerceManager *_commerceM = (CommerceManager *)[httpOperation getAopInstance:[CommerceManager class] returnValue:[TResultSet class]];
    
    [_commerceM __yxb_service__payForCommerce:self.payment];

}
//请求完成
-(void)httpLoad_PayComplete:(TResultSet *)r{
    if (r.errCode == 0) {
        if (r != nil) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"购买成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
        
    }else  {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }

}
#pragma mark - QCBaseTableView delegate
//下拉刷新
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self httpLoad];
}

- (void)payButtonAction:(UIButton *)button {
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {
        [self pay];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
}

#pragma mark - AmortizationDetailView delegate
- (void)amortizationDetailView:(AmortizationDetailView *)view detailButtonDidClickAtIndex:(NSInteger)index {
    __weak AmortizationProduceDetailViewController *this = self;
    
    if (index == 0) {
        //首付
        if (_firstPicker == nil) {
            NSArray *firstArr = [NSArray arrayWithObjects:self.data.downPayment, nil];
            _firstPicker = [[AACreatePickerView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-64, kDeviceWidth, kCreatePickerCustomHeight) Component:1 listArr:firstArr];
            
        
            _firstPicker.rowBlock = ^ (NSInteger row, AACreatePickerView *createPickerView) {
                this.currentFirstRow = row;
                [this.header resetViewsWithFirstRateIndex:this.currentFirstRow stageIndex:this.currentStageRow];
            };
            [self.view addSubview:_firstPicker];
        }
        
        [self hideShowingPicker];
        
        [_firstPicker showPickerView];
    }else if (index == 1) {
        //分期
        if (_stagePicker == nil) {
            NSMutableArray *stageArr = [NSMutableArray new];
            for (StagesInterest *interest in self.data.stagesInterestList) {
                NSString *stage = [NSString stringWithFormat:@"%ld",(long)interest.stagesNum];
                [stageArr addObject:stage];
            }
            _stagePicker = [[AACreatePickerView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-64, kDeviceWidth, kCreatePickerCustomHeight) Component:1 listArr:[NSArray arrayWithObjects:stageArr, nil]];
            
            _stagePicker.rowBlock = ^ (NSInteger row, AACreatePickerView *createPickerView) {
                this.currentStageRow = row;
                [this.header resetViewsWithFirstRateIndex:this.currentFirstRow stageIndex:this.currentStageRow];
            };
            [self.view addSubview:_stagePicker];
        }
        
        [self hideShowingPicker];
        
        [_stagePicker showPickerView];
        
    }
}

- (void)amortizationDetailView:(AmortizationDetailView *)view resetViewsFinished:(CommercePayment *)payment {
    self.payment = payment;
    self.payment.commerceID = self.commerceID;
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    NSString *userToken = userModel.user.yxbToken;
    self.payment.userToken = userToken;
}

- (void)amortizationDetailView:(AmortizationDetailView *)view scrollViewDidClickAtPage:(NSInteger)page {
    
}

- (void)hideShowingPicker {
    if (_stagePicker.isShow) {
        [_stagePicker showPickerView];
    }
    
    if (_firstPicker.isShow) {
        [_firstPicker showPickerView];
    }

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
