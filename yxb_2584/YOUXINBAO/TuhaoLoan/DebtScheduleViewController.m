//
//  DebtScheduleViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/4/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DebtScheduleViewController.h"
#import "DebtScheduleTopView.h"
#import "DebtScheduleCell.h"
//#import "SModel.h"
#import "HttpOperator.h"
#import "AppBlankNoteManager.h"
#import "BlankNoteData.h"
#import "DebtScheduleBottomView.h"
#import "RepaymentNoteData.h"
#import "InstallmentDetail.h"
#import "QCBaseTableView.h"
#import "YXBTool.h"
#import "Payment_blankNotePay.h"
#define DebtSchedulePageNOStart 1
#define  DebtScheduleCellHeight 44
@interface DebtScheduleViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate>
@property(nonatomic,strong)RepaymentNoteData *bModel;
@property(nonatomic,strong)DebtScheduleTopView  *topView;
@property(nonatomic,strong)QCBaseTableView          *tableView;
@property(nonatomic,strong)NSMutableArray         *dataArray;
@property(nonatomic,strong)HttpOperator    *iHttpOperator;
//@property(nonatomic,strong)QCBaseTableView *myTableView;
@property(nonatomic,strong)UILabel *tintLabel;
@property(nonatomic,strong)DebtScheduleBottomView *bottomView;
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,copy) NSString *failedMsg;//审核失败原因

@end

@implementation DebtScheduleViewController
-(void)dealloc{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftNavigationItem];
    [self initView];
    self.dataArray = [NSMutableArray array];
//    [self requestData];
}

-(void)ifAddBottomView
{
    CGFloat bottomHeight = 110;
    __weak DebtScheduleViewController *bSelf = self;

    if (_bottomView != nil && _bottomView.superview) {
        [_bottomView removeFromSuperview];
    }
//    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    
    if (_bModel.isTuhao == 1)
    {
        bottomHeight = bottomHeight - 48;
        self.bottomView = [[DebtScheduleBottomView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - 64-bottomHeight, kDeviceWidth, bottomHeight) cancelBlock:^{
            
//            [bSelf cancelAll];
        }];

    }
    else
    {
//        TuhaoScheduleTypeHuankuaning
        if (_bModel.state != TuhaoScheduleTypeHuankuaning) {
            bottomHeight = bottomHeight - 48;
        }
        self.bottomView = [[DebtScheduleBottomView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - 64-bottomHeight, kDeviceWidth, bottomHeight) cancelBlock:^{
            
            [bSelf cancelAll];
        }];

    }
    [self.view addSubview:_bottomView];
    _tableView.height = kDeviceHeight - _bottomView.height - 64;

}

-(void)addBottomViews
{
    
    self.tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-_bottomView.height) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = _topView;
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }

    
    self.tintLabel = [self labelWithFrame:CGRectMake(0, _topView.height + 50, kDeviceWidth, 50)];
    _tintLabel.font = [UIFont systemFontOfSize:16.0];
    _tintLabel.textAlignment = NSTextAlignmentCenter;
    
    _tableView.tableFooterView = _tintLabel;
    
//    _tableView.hidden = YES;
//    _bottomView.hidden = YES;
    


}

-(void)loadSchedule
{
    
    NSArray *array = [NSArray arrayWithObjects:@"您发起了申请借款...",@"等待无忧借条电话确认...",@"等待无忧借条约见面签...",@"约见面签已完成,借款即将到账...",@"到账已完成,准备还款...", nil];
    NSInteger noteState = _bModel.state;
    
    if (noteState == 600 || noteState == 500) {
        _tintLabel.hidden = YES;
        _bottomView.hidden = NO;

        

    }
    else
    {
        if (_failedMsg == nil || [_failedMsg length] < 2) {
            _tintLabel.text = array[((noteState-100)/100)];

        }
        else
        {
            _tintLabel.text = _failedMsg;
        }

//       还款未开始时隐藏底部
        _bottomView.hidden = NO;

        _tintLabel.hidden = NO;
        _tableView.height = _tableView.height + _bottomView.height;


    }
    
//    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];

//    if ([_bModel.creditorName isEqualToString:userModel.user.username])
    if (_bModel.isTuhao == 1)
    {
        //            如果是放款人，隐藏底部
        if (_bottomView.hidden == NO) {
//            _bottomView.hidden = YES;
            _tableView.height = _tableView.height + _bottomView.height;

        }
    }

    [_topView setSchedule:noteState];

}


-(void)cancelAll
{
    NSLog(@"全部分期还款");
    
    UILabel *allPayLabel = [self labelWithFrame:CGRectMake(0, 0, kDeviceWidth-20, 50)];
    allPayLabel.font = [UIFont systemFontOfSize:14.0];
    allPayLabel.text = @"是否全部还款？";
    allPayLabel.textAlignment = NSTextAlignmentCenter;
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:allPayLabel];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"确认", nil]];
//    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        if (buttonIndex == 1) {
            NSLog(@"确认");
            Payment_blankNotePay *pay = [[Payment_blankNotePay alloc]init];
            pay.type = @"2";
            pay.qici = @"0";
            pay.noteDetailId = [NSString stringWithFormat:@"%ld",(long)_bModel.repaymentNoteID];
            pay.money = [NSString stringWithFormat:@"%.2lf",[self moneyWithAllNotPayed]];
            NSString *url = [YXBPaymentUtils getFullWebUrl:pay];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];

            
        }
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    // And launch the dialog
    [alertView show];
    
    
    
}

//获取全额还款金额
-(double)moneyWithAllNotPayed
{
    double money = 0;
    NSArray *modelArray = _bModel.installmentDetailList;
    
    for (int i = 0; i < modelArray.count; i ++) {
        InstallmentDetail *detail = modelArray[i];
        if (detail.installmentState == 0) {
            money = money + [detail.money doubleValue];
            
        }
    }
    return money;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addLeftNavigationItem
{
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(backDefault)];
    [self setTitle:[NSString stringWithFormat:@"%@的白条",_noteSummary.debtorName]];
    
}


-(void)initView
{
    CGFloat x = 0,y = 0,w = kDeviceWidth,h = 240;
    self.topView = [[DebtScheduleTopView alloc] initWithFrame:CGRectMake(x, y, w, h)];
//    [self.view addSubview:_topView];
    
    [self addBottomViews];
    
    
//    [self.view addSubview:_topView];
}

-(void)loadViewWithModel
{
    if (_topView != nil) {
        _topView.model = _bModel;
    }
    NSArray *stateArray = [NSArray arrayWithObjects:@"0",@"100",@"200",@"300",@"400",@"500",@"600", nil];
    if ([stateArray containsObject:[NSString stringWithFormat:@"%ld",(long)_bModel.state]])
    {
        [_topView showSchedulePabel];
        [self loadSchedule];

    }
}

-(void)requestData
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak DebtScheduleViewController *this = self;
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
    
    [this.iHttpOperator connect];
    
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    AppBlankNoteManager* blankNote = (AppBlankNoteManager *)  [httpOperation getAopInstance:[AppBlankNoteManager class] returnValue:[RepaymentNoteData class]];
    NSString *token = @"";
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    token = userModel.user.yxbToken;
    if (token == nil) {
        token = @"";
    }
    //        [blankNote claimNote:token noteID:_model.blankNoteID];
    [blankNote getRepaymentNoteData:token repaymentNoteDataID:self.noteSummary.repaymentNoteID];
    

}
//请求完成
-(void)httpLoadComplete:(id)r{
    NSLog(@"r=  %@",r);
    RepaymentNoteData *data = (RepaymentNoteData *)r;
    if (data.errCode == 0 || data.errCode == 10) {
        self.bModel = data;
        [self setTitle:[NSString stringWithFormat:@"%@的白条",self.bModel.debtorName]];
        self.failedMsg = self.bModel.reviewFailReason;
        
        //            if (_bModel.state == 300) {
        //                _bModel.state = 600;
        //            }
        //            if (_bModel.state == 400) {
        //                _bModel.state = 300;
        //            }
        //            if (_bModel.state == 500) {
        //                _bModel.state = 400;
        //            }
        [self.tableView reloadDeals];
        
        if ((_pageNo == DebtSchedulePageNOStart) && (self.dataArray != nil) && [self.dataArray count] > 0) {
            [self.dataArray removeAllObjects];
        }
        //            this.dataArray = this.bModel.installmentDetailList;
        if (self.dataArray.count != 0 && self.dataArray.count%20 == 0) {
            self.tableView.hasFooter = YES;
        }else {
            self.tableView.hasFooter = NO;
        }
        
        [self.dataArray addObjectsFromArray:self.bModel.installmentDetailList];
        [self loadViewWithModel];
        [self ifAddBottomView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (_bModel.state >= 500) {
            _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            
        }
        
        [self.tableView reloadData];
        
    }
    else
    {
        [self.tableView reloadDeals];
        [ProgressHUD showErrorWithStatus:data.errString];
        NSLog(@"%@===%@",[self class],data.errString);
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DebtScheduleCellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_bModel.state < 500) {
        return 0;
    }
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellID";
    DebtScheduleCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == Nil) {
        cell = [[DebtScheduleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.isTuhao = _bModel.isTuhao;
    InstallmentDetail * debtModel = _dataArray[indexPath.row];
    cell.number = indexPath.row + 1;
    cell.model = debtModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    InstallmentDetail *model = [self.dataArray objectAtIndex:indexPath.row];

    if (_bModel.isTuhao == 0) {
        if (model.installmentState == 0) {
            Payment_blankNotePay *pay = [[Payment_blankNotePay alloc]init];
            pay.type = @"2";
            pay.qici = [NSString stringWithFormat:@"%ld",(long)model.installmentDetailID];
            pay.noteDetailId = [NSString stringWithFormat:@"%ld",(long)_bModel.repaymentNoteID];
            pay.money = model.money;
            NSString *url = [YXBPaymentUtils getFullWebUrl:pay];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"支付"];
            
        }

    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSInteger const leftAlign = 0;

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    CGFloat x = leftAlign, y = 0,w = kDeviceWidth-2*x,h = 44;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    label.font = [UIFont systemFontOfSize:18.0];
    label.textAlignment = NSTextAlignmentLeft;
    label.layer.borderColor = rgb(213, 213, 213, 1.0).CGColor;
    label.layer.borderWidth = 1.0;
    label.text = @"   还款详情";
    [view addSubview:label];
    
    NSArray *nameArray = [NSArray arrayWithObjects:@"期数",@"还款日期",@"金额",@"状态", nil];
    y = y + label.height,w = w/4.0,h = 35;
    for (int i = 0; i < 4; i ++) {
        
        UILabel *label = [self labelWithFrame:CGRectMake(x, y, w, h)];
        label.font = [UIFont systemFontOfSize:15.0];
        [view addSubview:label];
//        label.backgroundColor = [YXBTool generateRandomColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = nameArray[i];
        x = x + w;
        
    }

    UILabel *label1 = [self labelWithFrame:CGRectMake(leftAlign, 79, w*4-leftAlign, 1)];
    label1.backgroundColor = rgb(213, 213, 213, 1.0);
    [view addSubview:label1];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
    
}

- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    _pageNo = DebtSchedulePageNOStart;
    [self requestData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>=scrollView.frame.size.height && !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        if (_dataArray.count%20==0) {
            _pageNo ++;
            [self requestData];
        }
        else
        {
            [self.tableView reloadDeals];
            
        }
    }
}



-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UILabel *)labelWithFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [self generateRandomColor];
    label.font = [UIFont systemFontOfSize:12];
    return label;
}

-(UIColor *)generateRandomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    color = [UIColor clearColor];
    
    return color;
    
}

-(void)reloadCustomTableView
{
    if (_tableView.delegate == nil) {
        _tableView.delegate = self;

    }
    if (_tableView.dataSource == nil) {
        _tableView.dataSource = self;

    }
    [_tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self QCBaseTableViewDidPullDownRefreshed:_tableView];
    [super viewWillAppear:YES];
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
