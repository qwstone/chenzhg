//
//  DebtScheduleViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/4/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyOrderScheduleViewController.h"
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
#import "MyOrderScheduleTopView.h"
#import "CommerceOrderDetail.h"
#import "CommerceManager.h"
#import "MyOrderScheduleTopViewNew.h"
#import "Payment_producutPay.h"
#define MyOrderListControllerPayUrl @"webView/user/producutPay.jsp" //还款

#define MyOrderSchedulePageNOStart 1
#define  DebtScheduleCellHeight 44
@interface MyOrderScheduleViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,MyOrderScheduleTopViewDelegate,MyOrderScheduleTopViewNewDelegate>
@property(nonatomic,strong)CommerceOrderDetail *bModel;
//@property(nonatomic,strong)MyOrderScheduleTopView  *topView;
@property(nonatomic,strong)MyOrderScheduleTopViewNew  *topViewNew;

@property(nonatomic,strong)QCBaseTableView          *tableView;
@property(nonatomic,strong)NSMutableArray         *dataArray;
@property(nonatomic,strong)HttpOperator    *iHttpOperator;
//@property(nonatomic,strong)QCBaseTableView *myTableView;
@property(nonatomic,strong)UILabel *tintLabel;
@property(nonatomic,strong)DebtScheduleBottomView *bottomView;
@property(nonatomic,assign)NSInteger pageNo;
@property(nonatomic,strong)PayJsonTools *iPayJsonTools;

@end

@implementation MyOrderScheduleViewController
-(void)dealloc{
    NSLog(@"MyOrderScheduleViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"订单详情"];
    [self addLeftNavigationItem];
    [self initView];
    self.dataArray = [NSMutableArray array];
    [self requestData];
//    [self loadViewWithModel];
}

-(void)addBottomViews
{
    __weak MyOrderScheduleViewController *bSelf = self;
    const CGFloat bottomHeight = 64;
    self.bottomView = [[DebtScheduleBottomView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - 64-bottomHeight, kDeviceWidth, bottomHeight) cancelBlock:^{
        
        [bSelf cancelAll];
    }];
    self.bottomView.clipsToBounds = YES;
    [self.view addSubview:_bottomView];
    
    self.tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-_bottomView.height) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.refreshDelegate = self;
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = _topViewNew;
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    /*
    self.tintLabel = [self labelWithFrame:CGRectMake(0, _topViewNew.height + 50, kDeviceWidth, 50)];
    _tintLabel.font = [UIFont systemFontOfSize:16.0];
    _tintLabel.textAlignment = NSTextAlignmentCenter;
    
    _tableView.tableFooterView = _tintLabel;
     */
    
    //    _tableView.hidden = YES;
    //    _bottomView.hidden = YES;
    
    
    
}

-(void)loadSchedule
{
    
//    NSArray *array = [NSArray arrayWithObjects:@"您发起了申请借款...",@"等待友信宝电话确认...",@"等待友信宝约见面签...",@"约见面签已完成,借款即将到账...",@"到账已完成,准备还款...", nil];
    NSInteger noteState = _bModel.orderState;
    if (noteState == 600 || noteState == 500 || noteState == 400) {
        _tintLabel.hidden = YES;
        _tableView.tableFooterView = nil;
        _bottomView.hidden = NO;
        
        
        
    }
    else
    {
        
//        _tintLabel.text = array[(noteState/100)];
        _tintLabel.text = @"稍后我们客服会联系您，请保持电话畅通哦！";
        //       还款未开始时隐藏底部
        _bottomView.hidden = YES;
        
        _tintLabel.hidden = NO;
        _tableView.height = _tableView.height + _bottomView.height;
        
        
    }
    
//    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
//    if ([_bModel.creditorName isEqualToString:userModel.user.username]) {
//        //            如果是放款人，隐藏底部
//        if (_bottomView.hidden == NO) {
//            _bottomView.hidden = YES;
//            _tableView.height = _tableView.height + _bottomView.height;
//            
//        }
//    }
//    
//    [_topView setSchedule:noteState];
    
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
        }
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    // And launch the dialog
    [alertView show];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addLeftNavigationItem
{
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(backDefault)];
//    [self setTitle:[NSString stringWithFormat:@"%@的白条",_noteSummary.debtorName]];
    
}


-(void)initView
{
    /*
    CGFloat x = 0,y = 0,w = kDeviceWidth,h = 380;
    self.topView = [[MyOrderScheduleTopView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _topView.backgroundColor = rgb(241, 241, 241, 1.0);
    _topView.delegate = self;
    [_topView isShowItemsBelowLine:YES];
    
    */
    
    CGFloat x = 0,y = 0,w = kDeviceWidth,h = 190 + 220 - 70;
    self.topViewNew = [[MyOrderScheduleTopViewNew alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _topViewNew.backgroundColor = rgb(241, 241, 241, 1.0);
    _topViewNew.delegate = self;
    
    [self addBottomViews];
    
    
    //    [self.view addSubview:_topView];
}

-(void)loadViewWithModel
{
    if (_topViewNew != nil) {
        _topViewNew.model = _bModel;
    }
    /*
    NSArray *stateArray = [NSArray arrayWithObjects:@"0",@"1",@"100",@"200",@"300",@"400",@"500",@"600", nil];
    if ([stateArray containsObject:[NSString stringWithFormat:@"%ld",(long)_bModel.orderState]])
    {
        [self loadSchedule];
        
    }
     */
}

-(void)requestData
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak MyOrderScheduleViewController *this = self;
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
    } complete:^(CommerceOrderDetail *r, int taskid) {
        [this httpLoadComplete:r];
    }];
    
    [this.iHttpOperator connect];
    
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    CommerceManager* blankNote = (CommerceManager *)  [httpOperation getAopInstance:[CommerceManager class] returnValue:[CommerceOrderDetail class]];
    NSString *token = @"";
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    token = userModel.user.yxbToken;
    if (token == nil) {
        token = @"";
    }
    [blankNote getCommerceOrderDetail:_orderId userToken:token];
}
//请求完成
-(void)httpLoadComplete:(CommerceOrderDetail *)r{
    //        NSLog(@"r=  %@",r);
    [self.tableView reloadDeals];
    
    CommerceOrderDetail *data = (CommerceOrderDetail *)r;
    if (data.errCode == 0) {
        self.bModel = data;
        //            [this.bModel.installmentDetailList removeAllObjects];
        if ([self.bModel.installmentDetailList count] == 0 && data.orderState != 5) {
            
            [self loadViewWithModel];
            [self.tableView reloadData];
            
            self.tintLabel = [self labelWithFrame:CGRectMake(0, _topViewNew.height + 50, kDeviceWidth, 50)];
            _tintLabel.font = [UIFont systemFontOfSize:16.0];
            _tintLabel.textAlignment = NSTextAlignmentCenter;
            
            _tableView.tableFooterView = _tintLabel;
            _tintLabel.text = @"稍后我们客服会联系您，请保持电话畅通哦！";
            
        }
        else
        {
            if ((_pageNo == MyOrderSchedulePageNOStart) && (self.dataArray != nil) && [self.dataArray count] > 0) {
                [self.dataArray removeAllObjects];
            }
            
            [self.dataArray addObjectsFromArray:self.bModel.installmentDetailList];
            if (self.dataArray.count != 0 && self.dataArray.count%20 == 0) {
                self.tableView.hasFooter = YES;
            }else {
                self.tableView.hasFooter = NO;
            }
            
            
            [self loadViewWithModel];
            [self.tableView reloadData];
            
        }
        
        
        
    }
    else
    {
        NSLog(@"%@===%@",[self class],data.errString);
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DebtScheduleCellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (_bModel.orderState < 500) {
//        return 0;
//    }
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
    InstallmentDetail * debtModel = _dataArray[indexPath.row];
    cell.number = indexPath.row + 1;
    cell.model = debtModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    InstallmentDetail * debtModel = _dataArray[indexPath.row];
    if (debtModel.installmentState == 0) {
//        DebtScheduleCell *cell = (DebtScheduleCell *)[tableView cellForRowAtIndexPath:indexPath];
        
//        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        //还款
        /*
        self.iPayJsonTools = [[PayJsonTools alloc] init];
        
        CommerceManager* mgr = [_iPayJsonTools getAopInstance:[CommerceManager class]];
        _iPayJsonTools.iOnJsonStr = ^(NSString *str){
            NSLog(@"ccpay---%@",str);
            
            if (str != nil) {
                NSString *url = [YXBTool getURL:MyOrderListControllerPayUrl params:[NSString stringWithFormat:@"json=%@",str]];
                [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"分期还款"];
                
            }
        };
        [mgr paymentOrder:userModel.user.yxbToken orderId:debtModel.installmentDetailID money:@"0" qici:[NSString stringWithFormat:@"%ld",(long)cell.number]];
        
        */
        
        Payment_producutPay *productPay = [[Payment_producutPay alloc] init];
        productPay.money = debtModel.money;
        productPay.type = @"2";
        productPay.qici = [NSString stringWithFormat:@"%ld",(long)debtModel.installmentDetailID]; //当前期次
        productPay.orderId = [NSString stringWithFormat:@"%ld",(long)self.bModel.orderID];
        NSString *url = [YXBPaymentUtils getFullWebUrl:productPay];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"去还款"];


    }

    //    SModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if([self.bModel.installmentDetailList count] > 0)
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
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if([self.bModel.installmentDetailList count] > 0)
    {
        return 80;

    }
    
    return 0;
    
}

- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    _pageNo = MyOrderSchedulePageNOStart;
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

-(void)contactInfo
{
    [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:_bModel.stagesUrl params:nil] hasTopBar:YES titleName:@"合同条款"];
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
