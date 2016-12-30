//
//  LoanCenterViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanCenterViewController.h"
#import "HeaderView.h"
#import "LoanCenterManager.h"
#import "QCLoanCell.h"
#import "QCLoanReceiptViewController.h"
#import "QCMainLoanReceiptViewController.h"
#import "LoanCenterCell.h"
#import "AAManager.h"
#import "AALoan.h"
#import "QCBorrowManageViewController.h"
#import "AALoanUserMemberInfo.h"
#import "AAReceiptViewController.h"
#import "LoanManagerV2.h"
#import "LoanOrRepayListTableViewCell.h"
#import "LoanOrRepayMessageViewController.h"
#import "GuaranteeRequestListData.h"
#import "PayForanotherViewController.h"
#import "GuaranteeManager.h"
#import "GuaranteeDaifuDetailViewController.h"

@interface LoanCenterViewController ()<HeaderViewDelegate,UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate>
{
    NSInteger currentPage;

}
@property(nonatomic,strong)HeaderView *headerView;
@property (nonatomic,strong)HttpOperator * iHttpOperator;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong)QCBaseTableView *tableView;
@property(nonatomic,strong)UISegmentedControl *segmentControl;


@end

@implementation LoanCenterViewController
-(void)dealloc{
    NSLog(@"LoanCenterViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    [self setBackView];
    self.view.backgroundColor = rgb(238, 236, 246, 1.0);

    [self setTitle:@"借据中心"];
    currentPage = 1;
    // Do any additional setup after loading the view.
    
}

-(void)initViews
{
    self.headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 48) WithArray:[NSArray arrayWithObjects:@"借入",@"借出",@"借据",@"AA借据",@"分期担保", nil]];
    [_headerView setHeaderViewColorsWithUnSelectedBgColor:rgb(248, 248, 248, 1) selectedBgColor:rgb(248, 248, 248, 1) unSelectedTextColor:rgb(97, 97, 97, 1.0) selectedTextColor:rgb(217, 30, 61, 1.0)];
    _headerView.backgroundColor = [UIColor whiteColor];
    _headerView.layer.borderColor = rgb(218, 218, 218, 1.0).CGColor;
    _headerView.delegate = self;
    _headerView.layer.borderWidth = 1.0;
    _headerView.selectedIndex = _selectedIndex;
    [self.view addSubview:_headerView];
  
    _dataArray = [NSMutableArray new];
    
    _tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, _headerView.bottom + 10, kDeviceWidth, kDeviceHeight-64-_headerView.height - 10) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)httpDowload {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator *assginHtttperator = _iHttpOperator;
    __weak typeof(self) this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
//        [ProgressHUD dismiss];

    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"网络连接异常" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            [this.tableView reloadDeals];
            [ProgressHUD dismiss];

        }

        
    } param:^(NSString *s) {
        [this httpLOadParams:s httpOperation:assginHtttperator];
    } complete:^(NSSkyArray* r, int taskid) {
        [this httpLoadComplete:r];
        
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    if (self.headerView.selectedIndex == 0) {
        LoanManagerV2* _Loanmanger = (LoanManagerV2*)  [httpOperation getAopInstance:[LoanManagerV2 class] returnValue:[NSSkyArray class]];
        
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        if (userModel != nil) {
            [_Loanmanger getTLoanListByBorrowerInfoAndQueryType:userModel.user.t_id query_type:0 page:currentPage];
            
        }
        else
        {
            [ProgressHUD showSuccessWithStatus:@"您尚未登录"];
            
        }
        
    }
    else if (self.headerView.selectedIndex == 1) {
        LoanManagerV2* _Loanmanger = (LoanManagerV2*)  [httpOperation getAopInstance:[LoanManagerV2 class] returnValue:[NSSkyArray class]];
        
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        if (userModel != nil) {
            [_Loanmanger getTLoanListByLenderInfoAndQueryType:userModel.user.t_id query_type:0 page:currentPage];
            
        }
        else
        {
            [ProgressHUD showSuccessWithStatus:@"您尚未登录"];
            
        }
        
    }
    
    
    else if (self.headerView.selectedIndex == 2) {
        LoanCenterManager* _loanM = (LoanCenterManager*)  [httpOperation getAopInstance:[LoanCenterManager class] returnValue:[NSSkyArray class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        if (userModel != nil) {
            
            [_loanM getTLoanCenterListByUserInfoAndQueryTypeNew:userModel.user.yxbToken roleType:0 queryType:0 categoryType:0 page:currentPage];
            
        }
        else
        {
            [ProgressHUD showSuccessWithStatus:@"您尚未登录"];
            
        }
        
    }
    else if(self.headerView.selectedIndex == 3)
    {
        AAManager* loanM = (AAManager*)  [httpOperation getAopInstance:[AAManager class] returnValue:[NSSkyArray class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        if (userModel != nil) {
            [loanM getAALoanList:userModel.user.yxbToken page:currentPage];
            
        }
        else
        {
            [ProgressHUD showSuccessWithStatus:@"您尚未登录"];
            
        }
        
    }else if(self.headerView.selectedIndex == 4)
    {
        //分期代付
        GuaranteeManager* loanM = (GuaranteeManager*)  [httpOperation getAopInstance:[GuaranteeManager class] returnValue:[NSSkyArray class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        if (userModel != nil) {
            [loanM getGuaranteeList:userModel.user.yxbToken pageNum:currentPage];
            
        }
        else
        {
            [ProgressHUD showSuccessWithStatus:@"您尚未登录"];
            
        }
    }

}
//请求完成
-(void)httpLoadComplete:(NSSkyArray *)r{
    [ProgressHUD dismiss];
    [self.tableView reloadDeals];
    if (r.errCode == 0) {
        if (r.iArray.count>0) {
            [self.dataArray addObjectsFromArray:r.iArray];
            self.tableView.tableFooterView = [UIView new];
        }else{
            if (currentPage == 1)
            {
                
                UILabel *nullImage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _tableView.height)];
                nullImage.text = @"暂无数据";
                nullImage.textColor = [UIColor blueColor];
                nullImage.textAlignment = NSTextAlignmentCenter;
                self.tableView.tableFooterView = nullImage;
                //无数据时先跳到第二个
                //                    if (_selectedIndex==0) {
                //                        _selectedIndex=1;
                //                        _headerView.selectedIndex=_selectedIndex;
                //                    }
                
            }
            
            else
            {
                self.tableView.tableFooterView = [UIView new];
                
            }
        }
        
    }else{
        if (r.errCode == 7)
        {
            if (currentPage == 1)
            {
                UILabel *nullImage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _tableView.height)];
                nullImage.text = @"暂无数据";
                nullImage.textColor = [UIColor blueColor];
                nullImage.textAlignment = NSTextAlignmentCenter;
                self.tableView.tableFooterView = nullImage;
                //                    if (_selectedIndex==0) {
                //                        _selectedIndex=1;
                //                        _headerView.selectedIndex=_selectedIndex;
                //                    }
                
                
            }
            else
            {
                self.tableView.tableFooterView = [UIView new];
            }
            
            
        }
        
        else
        {
            self.tableView.tableFooterView = [UIView new];
            
        }
    }
    
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.tableView.hasFooter = YES;
    }else {
        self.tableView.hasFooter = NO;
    }
    
    [self.tableView reloadData];
}
#pragma -mark HeaderViewDelegate
-(void)headerViewSelectedIndex:(NSInteger)index
{
    [ProgressHUD showWithStatus:@"正在加载..." maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeLongBottom];
    currentPage = 1;
    [self.dataArray removeAllObjects];

    [self QCBaseTableViewDidPullDownRefreshed:_tableView];
}



#pragma -mark TableViewDelegate


#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [_dataArray removeAllObjects];
    currentPage = 1;
    [self httpDowload];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.tableView.isRefresh && _dataArray.count%20==0 && self.tableView.hasFooter == YES) {
        currentPage ++;
        [self httpDowload];
    }else {
        
    }
}

#pragma mark - UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger height = 100;
    if (_headerView.selectedIndex==0||_headerView.selectedIndex==1) {
        height=80;
    }
    if(_headerView.selectedIndex == 2)
    {
        height = 70;
    }
    else if(_headerView.selectedIndex==3)
    {
        height = LoanCenterCellHeight;
    }
    else if(_headerView.selectedIndex==4)
    {
        height = 80;
    }
    return height;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_headerView.selectedIndex==0||_headerView.selectedIndex==1) {
        static NSString * cellID  =@"cellID";
        LoanOrRepayListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == Nil) {
            cell = [[LoanOrRepayListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        if (_dataArray.count != 0) {
            Loan * loanModel =_dataArray[indexPath.row];
            if (loanModel.loanFriendType==2||loanModel.loanFriendType==3) {
                     cell.nameLabel.textColor=[UIColor redColor];
               
            }
            else{
            
                cell.nameLabel.textColor=[UIColor blackColor];
            }
            
            [cell setLoanModel:loanModel];
  
        }
        return cell;
        
    }
    if (_headerView.selectedIndex == 2)
    {
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        static NSString *identifier = @"loanCell";
        QCLoanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[QCLoanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.backgroundColor=[UIColor whiteColor];
        }
        
        if (self.dataArray.count != 0) {
            cell.loanBrief = [self.dataArray objectAtIndex:indexPath.row];
            
        }
        return cell;

    }
    else if (_headerView.selectedIndex == 3)
    {
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

        NSString * cellId = @"cell";
        LoanCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[LoanCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            //cell.selectionStyle = UITableViewCellSelectionStyleNone;
             cell.backgroundColor=[UIColor whiteColor];
            
        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.width = _tableView.width;
        [cell resetViewsWidth];
        
        
        if (indexPath.section < [_dataArray count])
        {
            AALoan *model = _dataArray[indexPath.row];
            
            if (_dataArray.count != 0) {
                [cell setModel:model];
                cell.index = indexPath.row;
                
            }
        }
        
        return cell;
    }
    else if (_headerView.selectedIndex == 4)
    {
        static NSString * celdd  =@"GuaranteecellID";
        LoanOrRepayListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:celdd];
        if (cell == Nil) {
            cell = [[LoanOrRepayListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celdd];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if (_dataArray.count != 0) {
            cell.GuaranteeModel = _dataArray[indexPath.row];
        }
        return cell;
    }
    else
    {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= _dataArray.count) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_headerView.selectedIndex==0||_headerView.selectedIndex==1) {
          LoanOrRepayMessageViewController * messageViewController = [[LoanOrRepayMessageViewController alloc]init];
        if (_headerView.selectedIndex==0) {
            messageViewController.bOrL = BORROWER;
        
        }
        else if (_headerView.selectedIndex==1){
        messageViewController.bOrL =LENDERS ;
    
        }
        messageViewController.loan = _dataArray[indexPath.row];
        [self.navigationController pushViewController:messageViewController animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    else if (_headerView.selectedIndex == 2) {
        QCMainLoanReceiptViewController* con = [[QCMainLoanReceiptViewController alloc] init];
        con.brief = [self.dataArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:con animated:YES];

    }
    else if(_headerView.selectedIndex==3)
    {
       AALoan *loan= _dataArray[indexPath.row];
        if (loan.stateOfInitiator==1) {
            QCBorrowManageViewController *manage=[[QCBorrowManageViewController alloc]init];
            manage.AALoanId=loan.AALoanID;
            [self.navigationController pushViewController:manage animated:YES];
        }
        else if (loan.stateOfInitiator==2){
            AAReceiptViewController *receipt=[[AAReceiptViewController alloc]init];
            receipt.loanId=loan.AALoanID;
            [self.navigationController pushViewController:receipt animated:YES];
            
        
        }
    }
    else if (_headerView.selectedIndex == 4) {
//分期代付
        GuaranteeRequestListData *GuaranteeModel = _dataArray[indexPath.row];
        GuaranteeDaifuDetailViewController *ctr = [[GuaranteeDaifuDetailViewController alloc] init];
        ctr.guaranteeID = GuaranteeModel.guaranteeID;
        [self.navigationController pushViewController:ctr animated:YES];
        
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self QCBaseTableViewDidPullDownRefreshed:_tableView];
    [super viewWillAppear:YES];
}

-(void)leftClicked
{
    [ProgressHUD dismiss];
    [super leftClicked];
}

@end
