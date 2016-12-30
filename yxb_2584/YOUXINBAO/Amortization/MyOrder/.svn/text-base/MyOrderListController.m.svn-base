//
//  MyOrderListController.m
//  YOUXINBAO
//
//  Created by 冰冰 on 15/5/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyOrderListController.h"
#import "CommerceManagerV2.h"
#import "MyOrderScheduleViewController.h"
#import "Payment_producutPay.h"
#import "ConfirmationPaymentViewController.h"
#import "MyOrderCell.h"
#import "AmorOrderDetailViewController.h"

#define MyOrderListPageNOStart 1



#define MyOrderListControllerPayUrl @"webView/user/producutPay.jsp" //还款
//延期
#define MyOrderListControllerPayDelayUrl @"webView/user/paymentDelay.jsp" //延期

@interface MyOrderListController ()
{
    NSInteger page;

}

@property(nonatomic,strong)PayJsonTools *iPayJsonTools;
@end

@implementation MyOrderListController
-(void)dealloc{
    NSLog(@"MyOrderListController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的订单";
    page=MyOrderListPageNOStart;
    self.view.backgroundColor = [YXBTool colorWithHexString:@"#f4f4f4"];
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    
    _dataArray = [NSMutableArray array];
    
    [self _initViews];

}

- (void)_initViews{

    _tableView=[[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain refreshFooter:YES];
      _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];


}

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    page=MyOrderListPageNOStart;
    [self httpDowloadWithListStyle];
}


//加载更多
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        if (_dataArray.count%20==0) {
            page ++;
            [self httpDowloadWithListStyle];
        }else {
            
        }
    }
    
}


#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpDowloadWithListStyle
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];

    }
    [self.iHttpOperator cancel];


    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak MyOrderListController *this = self;
    [self.iHttpOperator connetStart:^(int d) {

    } cancel:^(int d) {

    } error:^(int d, THttpOperatorErrorCode error) {

        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            [this.tableView reloadDeals];
        }

    } param:^(NSString *s) {

        [this httpLOadParams:s httpOperation:assginHtttperator];

    } complete:^(NSSkyArray * r, int taskid) {

        
        [this httpLoadComplete:r];

    }];
    [self.iHttpOperator connect];

}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    CommerceManagerV2 *_activityM = (CommerceManagerV2 *)[httpOperation getAopInstance:[CommerceManagerV2 class] returnValue:[NSSkyArray class]];
    
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    //        if (style == L_myList) {
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {
        
        [_activityM getUserOrder:userModel.user.yxbToken pageNum:page];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }

}
//请求完成
-(void)httpLoadComplete:(NSSkyArray *)r{
    //测试代码
    for (int i = 1; i < 16; i++) {
        
        /*
         
         couponStr = "\U6682\U65e0\U4f18\U60e0\U4fe1\U606f";
         descript = "Lancome\U5170\U853b \U5c0f\U9ed1\U74f6\U7cbe\U534e\U808c\U5e95\U6db2 30ml";
         firstPayment = "88.0";
         imageUrl = "http://60.195.254.33:8083/upload/2015/5/19/yxbao_14346963317161.jpg";
         orderID = 86;
         orderState = 1;
         orderStateStr = "\U5f85\U5ba1\U6838";
         remark = "";
         stageNum = 12;
         stagePayment = "6.0";
         subDescripe = "";
         
         */
        /*
         CommerceOrder* order = [[CommerceOrder alloc] init];
         order.couponStr = @"aaaa";
         order.descript = @"aaaaaaaaaa";
         order.firstPayment = [NSString stringWithFormat:@"100+%d" ,i];
         order.imageUrl = @"http://60.195.254.33:8083/upload/2015/5/19/yxbao_14346963317161.jpg";
         order.orderID = 100;
         order.orderStateStr = @"dddddd";
         order.remark = @"aafjkfjwiofjqwoifqwiofjwq";
         order.stagePayment = @"9.0";
         order.orderState = i;
         [r.iArray addObject:order];
         */
        
    }
    
    
    
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.tableView.hasFooter = YES;
    }else {
        //数据加载不足一页的事后,将加载更多取消掉
        self.tableView.hasFooter = NO;
    }
    
    [self.tableView reloadDeals];
    //判断如果没有数据的时候,显示的图片
    if (page==1&&r.iArray.count==0) {
        
        UILabel *label= [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2-40, 0, kDeviceWidth, _tableView.height)];
        label.text=@"暂无订单";
        label.contentMode=UIViewContentModeCenter;
        label.textColor=[UIColor blueColor];
        label.backgroundColor=[UIColor clearColor];
        _tableView.tableFooterView=label;
        return ;
    }
    
    self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    
    
    //如果刷新的是第一页,则需要将之前刷新的移除掉,不然第一页的数据会反复出现
    if (page==MyOrderListPageNOStart) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:r.iArray];
    [self.tableView reloadData];
}
#pragma mark - UITableDataSourceDelegate

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    return self.dataArray.count;
//
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150+10;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *iden=@"cell";
    MyOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[MyOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.model = [_dataArray objectAtIndex:indexPath.row];
    
   return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   CommerceOrder *model = [_dataArray objectAtIndex:indexPath.row];
//    MyOrderScheduleViewController *controller = [[MyOrderScheduleViewController alloc] init];
//    controller.orderId = model.orderID;
//    [self.navigationController pushViewController:controller animated:YES];

    AmorOrderDetailViewController *detail=[[AmorOrderDetailViewController alloc]init];
    detail.orderId = model.orderID;
    detail.pushType = 1;
    [self.navigationController pushViewController:detail animated:YES];

    
}


#pragma mark --- MyOrderLisetDelegate
- (void)MyOrderLisetPushAction:(CommerceOrder *)model butTag:(NSInteger)butTag {
    
    //QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (butTag==1003) {
        if (model.orderState==ORDERSTATE_SUBSCRIBE_PASS||model.orderState==ORDERSTATE_NON_PAYMENT) {
            NSLog(@"去支付");
            
            //首付的
            /*
            self.iPayJsonTools = [[PayJsonTools alloc] init];
            
            CommerceManager* mgr = [_iPayJsonTools getAopInstance:[CommerceManager class]];
            _iPayJsonTools.iOnJsonStr = ^(NSString *str){
                NSLog(@"ccpay---%@",str);
                
                if (str != nil) {
                    NSString *url = [YXBTool getURL:MyOrderListControllerPayUrl params:[NSString stringWithFormat:@"json=%@&money=%@",str,model.firstPayment]];
                    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"首付"];
                    
                }
            };
            [mgr downPaymentOrder:userModel.user.yxbToken orderId:model.orderID money:model.firstPayment];
            
            */
            Payment_producutPay *productPay = [[Payment_producutPay alloc] init];
            productPay.money = model.firstPayment;
            productPay.type = @"1";
            productPay.qici = @"-2";
            productPay.orderId = [NSString stringWithFormat:@"%ld",(long)model.orderID];
            NSString *url = [YXBPaymentUtils getFullWebUrl:productPay];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"去支付"];
            
            
    }
        else if (model.orderState==ORDERSTATE_RECEIVE||model.orderState==ORDERSTATE_ONTHEDAYOFPAYMENT||model.orderState==ORDERSTATE_POSTPONE||model.orderState==ORDERSTATE_OVERDUE_PAYMENT){
            NSLog(@"去还款");
            
            /*
            ConfirmationPaymentViewController *confir = [[ConfirmationPaymentViewController alloc] init];
            confir.orderId = model.orderID;
            [self.navigationController pushViewController:confir animated:YES];
       */
            
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
            [mgr paymentOrder:userModel.user.yxbToken orderId:model.orderID money:@"0" qici:@"-1"];

            */
            Payment_producutPay *productPay = [[Payment_producutPay alloc] init];
            productPay.money = model.stagePayment;
            productPay.type = @"2";
            productPay.qici = @"-1"; //当前期次
            productPay.orderId = [NSString stringWithFormat:@"%ld",(long)model.orderID];
            NSString *url = [YXBPaymentUtils getFullWebUrl:productPay];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"去还款"];
            


            
        }
        else if (model.orderState==ORDERSTATE_EXPRESS_INFO){
            NSLog(@"查看物流");
            Payment_producutPay *productPay = [[Payment_producutPay alloc] init];
//            productPay.money = model.stagePayment;
//            productPay.type = @"2";
//            productPay.qici = @"-1"; //当前期次
            productPay.orderId = [NSString stringWithFormat:@"%ld",(long)model.orderID];
//            NSString *url = [YXBPaymentUtils getFullWebUrl:productPay];
//            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"首付"];
            NSString *str=[NSString stringWithFormat:@"webView/user/expressInfo.jsp?orderId=%@",productPay.orderId];
            NSString *url = [YXBTool getURL:str params:nil];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"查看物流"];
            
        }
        else if (model.orderState==ORDERSTATE_TO_REPAYMENT){
            NSLog(@"去还款");
            Payment_producutPay *productPay = [[Payment_producutPay alloc] init];
            productPay.money = model.stagePayment;
            productPay.type = @"2";
            productPay.qici = @"-1"; //当前期次
            productPay.orderId = [NSString stringWithFormat:@"%ld",(long)model.orderID];
            NSString *url = [YXBPaymentUtils getFullWebUrl:productPay];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"去还款"];
        
        }

    }
    if(butTag==1002){
        if (model.orderState==ORDERSTATE_RECEIVE||model.orderState==ORDERSTATE_ONTHEDAYOFPAYMENT||model.orderState==ORDERSTATE_POSTPONE||model.orderState==ORDERSTATE_OVERDUE_PAYMENT) {
            NSLog(@"全额还款");
            
            //全部还款
            /*
            self.iPayJsonTools = [[PayJsonTools alloc] init];
            
            CommerceManager* mgr = [_iPayJsonTools getAopInstance:[CommerceManager class]];
            _iPayJsonTools.iOnJsonStr = ^(NSString *str){
                NSLog(@"ccpay---%@",str);
                
                if (str != nil) {
                    NSString *url = [YXBTool getURL:MyOrderListControllerPayUrl params:[NSString stringWithFormat:@"json=%@",str]];
                    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"全额还款"];
                    
                }
            };
            [mgr paymentOrder:userModel.user.yxbToken orderId:model.orderID money:@"0" qici:@"0"];

            */
            
            Payment_producutPay *productPay = [[Payment_producutPay alloc] init];
            productPay.money = @"0";
            productPay.type = @"2";
            productPay.qici = @"0"; //全额
            productPay.orderId = [NSString stringWithFormat:@"%ld",(long)model.orderID];
            NSString *url = [YXBPaymentUtils getFullWebUrl:productPay];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"全额还款"];

            
            
        }
        
    }
    if (butTag==1001) {
        if (model.orderState==ORDERSTATE_ONTHEDAYOFPAYMENT) {
            NSLog(@"延期还款");
            
            //全部还款
            /*
            self.iPayJsonTools = [[PayJsonTools alloc] init];
            
            CommerceManager* mgr = [_iPayJsonTools getAopInstance:[CommerceManager class]];
            _iPayJsonTools.iOnJsonStr = ^(NSString *str){
                NSLog(@"ccpay---%@",str);
                
                if (str != nil) {
                    NSString *url = [YXBTool getURL:MyOrderListControllerPayDelayUrl params:[NSString stringWithFormat:@"json=%@&orderId=%ld",str,(long)model.orderID]];
                    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"延期还款"];
                    
                }
            };            
            [mgr paymentDelay:userModel.user.yxbToken orderId:model.orderID];
            
            [mgr paymentOrder:userModel.user.yxbToken orderId:model.orderID money:@"0" qici:@"0"];
            
            */
            Payment_producutPay *productPay = [[Payment_producutPay alloc] init];
            productPay.money = @"-1";
            productPay.type = @"2";
            productPay.qici = @"-1"; //当前期次
            productPay.orderId = [NSString stringWithFormat:@"%ld",(long)model.orderID];
            NSString *url = [YXBPaymentUtils getFullWebUrl:productPay];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"延期还款"];


        }
    }

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self httpDowloadWithListStyle];

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
