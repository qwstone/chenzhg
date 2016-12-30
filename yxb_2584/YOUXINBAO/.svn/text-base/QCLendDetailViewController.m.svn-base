//
//  QCLendDetailViewController.m
//  YOUXINBAO
//
//  Created by Walice on 15/7/2.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCLendDetailViewController.h"
#import "HttpOperator.h"
#import "LoanManagerV2.h"
#import "YXBTool.h"
#import "DetailsFooterView.h"
#import "StatusHttp.h"
#import "PayViewController.h"
#import "YXBPayAction.h"
#import "UIAlertView+Block.h"
@interface QCLendDetailViewController ()<DetailsFooterViewDelegate,StatusHttpDelegate,UIAlertViewDelegate>
{
    DetailsFooterView *footerView;
    StatusHttp *statusHttp;
    UIImageView *statusImageView;//显示已关闭等信息
}
@end

@implementation QCLendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"闪电放款详情"];
    [self initView];
    statusHttp = [[StatusHttp alloc] init];
    statusHttp.delegate = self;
}

- (void)initView{
    self.view.backgroundColor=rgb(238, 236, 246, 1.0);
    
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0,0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStyleGrouped refreshFooter:NO];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.refreshDelegate=self;
  
    [self.view addSubview:_tableView];
    
    _view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0,kDeviceWidth, 100)];
    [_scrollView addSubview:_view1];
    _label=[[UILabel alloc]initWithFrame:CGRectMake((kDeviceWidth-200)/2, 10, 200, 30)];
    _label.font=[UIFont systemFontOfSize:15];
    [_view1 addSubview:_label];
    
    _label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, kDeviceWidth-40, 30)];
    _label1.text=@"前确认收款,若到期未确认,交易将自动关闭";
    _label1.font=[UIFont systemFontOfSize:15];
    [_view1 addSubview:_label1];
    _tableView.tableHeaderView=_view1;
    
 
    
    
}
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    
    [self getTLoanDetailWithLoanID:self.loanId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellID = @"CELLID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  
    }

    if (indexPath.row == 0) {
        cell.textLabel.text = @"救急金额";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"放款时长";
        cell.detailTextLabel.text=@"7天";
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"利息";
        cell.detailTextLabel.text=@"无息";
    }
    else if (indexPath.row==3){
        cell.textLabel.text=@"还款方式";
        cell.detailTextLabel.text=@"全额";
        
        _label3=[[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth-250-10, 60, 250, 20)];
        _label3.textAlignment=NSTextAlignmentRight;
        _label3.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:_label3];
    
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3) {
        return 80;
    }
    return 50;

}

#pragma mark ---- HTTP 获取详情页面
- (void)getTLoanDetailWithLoanID:(NSInteger)loanId
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCLendDetailViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            QCBaseTableView * table = (QCBaseTableView *)_tableView;
            [table reloadDeals];
            
        }
        
    } param:^(NSString *s) {
        
        [this httpLoadParams:assginHtttperator loanId:loanId];
    } complete:^(Loan* r, int taskid) {
        [this httpLoadComplete:r];
}];
    [self.iHttpOperator connect];
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator loanId:(NSInteger)loanId{
    
    LoanManagerV2* _Loanmanger = (LoanManagerV2*)  [assginHtttperator getAopInstance:[LoanManagerV2 class] returnValue:[Loan class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    //        if (loanId != 0) {
    //            [_Loanmanger getTLoanDetail:userModel.user.t_id loanId:loanId];
    //
    //        }
    [_Loanmanger getTLoanDetailNew:userModel.user.t_id loanId:loanId loanFriendType:self.loan.loanFriendType];
}
- (void)httpLoadComplete:(Loan *)r{
    
    [self.tableView reloadDeals];
    if (r.errCode!=0) {
        
        [YXBTool showAlertViewWithString:r.errString];
        return ;
    }
    self.loan=r;
    
    if (r.status!=QUICKLEND_NEEDCONFIRM) {
        _tableView.tableHeaderView = nil;
        
    }
    
    UITableViewCell *firstCell = (UITableViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    firstCell.detailTextLabel.text=r.money;
    
    self.label.text=[NSString stringWithFormat:@"请于%@",r.closeDate];
    
    
    
    NSRange range1=[self.label.text rangeOfString:[NSString stringWithFormat:@"%@",r.closeDate]];
    
    NSMutableAttributedString *aText=[[NSMutableAttributedString alloc]initWithString:self.label.text];
    [aText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range1];
    [aText addAttribute:NSForegroundColorAttributeName value:rgb(221, 11, 12, 1) range:range1];
    self.label.attributedText=aText;
    
    
    self.label3.text=[NSString stringWithFormat:@"还款日%@,到期还款%@元",r.expectRepayDate,r.money];
    [self createFooterViewWith:self.loan];
    
    
    //添加状态标
    if (_loan.status == BORROWERCANCELLED ||
        _loan.status == QUICKLEND_DECLINED ||
        _loan.status == QUICKLEND_CLOSED||
        _loan.status==REPAYED)
    {
        if (statusImageView != nil && statusImageView.superview) {
            [statusImageView removeFromSuperview];
        }
        statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth - 259)/2.0, 100, 259, 103)];
        statusImageView.image = [UIImage imageNamed:[self stateImageNameWithStateCode:_loan.status]];
        [_tableView addSubview:statusImageView];
    }
    


}


-(NSString *)stateImageNameWithStateCode:(L_LoanStatus)status
{
    NSString *imageName = @"";
    if(status == REPAYED)
    {
        imageName = @"loan_completed.png";
    }else if (status == BORROWERCANCELLED)
    {
        imageName = @"loan_cancel.png";
    }else if (status == DECLINED || status == QUICKLEND_DECLINED)
    {
        imageName = @"loan_rejected.png";
    }
    else if (status == CLOSED || status == QUICKLEND_CLOSED)
    {
        imageName = @"loan_closed.png";
    }
    
    return imageName;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  创建底部按钮
- (void)createFooterViewWith:(Loan *)loan
{
//    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSArray * array;
    if (_bOrL == BORROWER) {
        switch (loan.status) {
            case APPLYING_NEEDCONFIRM://【  申请中   】	100-> 借款中-待放款人同意
                array = @[@"取消借款"];
                break;
            case APPLYING_NEEDCONFIRM_NEEDAGREE_BYBORROWER://【  申请中   】	200-> 借款中-待借款人确认
                array = @[@"取消借款",@"同意修改并借款",];
                break;
            case APPLYING_NEEDPAY://【  申请中   】	300-> 借款中-待打款
                array = @[@"取消借款"];
                break;
            case OFFLINE_LENDMONEY_CONFIRM://【  申请中   】	350-> 线下打款确认
                array = @[@"未收到打款",@"已收到打款"];
                break;
            case NEEDREPAY://【  还款中   】	400-> 待还款
                array = @[@"去还款"];
                break;
            case MODIFY_AFTERLEND_NEEDCONFIRM_BYLENDER://【  还款中   】	500-> 申请修改-放款方确认
                array = @[@"取消延期"];
                break;
            case NEEDRECEIVE://【  还款中   】	600-> 线下还款确认(全额)
                array = @[@"电话通知"];
                break;
            case REPAYED://【历史记录】	700-> 还款成功
                array = nil;
                break;
            case BORROWERCANCELLED://【历史记录】	800-> 已取消
                array = @[@"发送给其他好友试试"];
                break;
            case DECLINED://【历史记录】	810-> 已拒绝
                array = @[@"发送给其他好友试试"];
                break;
            case CLOSED://【历史记录】	820-> 已关闭
                array = @[@"发送给其他好友试试"];
                break;
            case QUICKLEND_NEEDCONFIRM://
                array = @[@"同意收款",@"拒绝收款"];
                break;
                
            default:
                array = Nil;
                break;
        }
    }else if (_bOrL == LENDERS){
        switch (loan.status) {
            case APPLYING_NEEDCONFIRM://【  申请中   】	100-> 借款中-待放款人同意
                array = @[@"拒绝借款",@"同意借款"];
                break;
            case APPLYING_NEEDCONFIRM_NEEDAGREE_BYBORROWER://【  申请中   】	200-> 借款中-待借款人确认
                array = @[@"拒绝借款"];
                break;
            case  APPLYING_NEEDPAY://【  申请中   】	300-> 借款中-待打款
                array = @[@"去打款"];
                break;
            case OFFLINE_LENDMONEY_CONFIRM://【  申请中   】	350-> 线下打款确认
                array = nil;
                break;
            case NEEDREPAY://【  还款中   】	400-> 待还款:
                array = nil;
                break;
            case MODIFY_AFTERLEND_NEEDCONFIRM_BYLENDER://【  还款中   】	500-> 申请修改-放款方确认
                array = @[@"拒绝延期",@"同意延期"];
                break;
            case NEEDRECEIVE://【  还款中   】	600-> 线下还款确认(全额)
                array = @[@"未收到还款",@"确认已收到还款"];
                break;
                //            case REPAYED://【历史记录】	700-> 还款成功
                //                array = nil;
                //                break;
                //            case BORROWERCANCELLED://【历史记录】	800-> 已取消
                //                array = @[@"查看新单据"];
                //                break;
                //            case DECLINED://【历史记录】	810-> 已拒绝
                //                array = @[@"查看新单据"];
                //                break;
                //            case CLOSED://【历史记录】	820-> 已关闭
                //                array = @[@"拒绝延期",@"同意延期"];
                //                break;
            default:
                array = nil;
                break;
        }
    }
    
    if (footerView != nil && footerView.superview) {
        [footerView removeFromSuperview];
    }
    
    if (array) {
        footerView = [[DetailsFooterView alloc]initWithNameArr:array];
        footerView.delegate =self;
        [self.view addSubview:footerView];
    }
    
}

#pragma mark  底部按钮回调
- (void)footerViewbuttonActionWithSender:(UIButton *)sender
{
    NSString *str=@"";
    if ([sender.titleLabel.text isEqualToString:@"借款"]) {
        str=@"同意借款";
    }else if ([sender.titleLabel.text isEqualToString:@"同意收款"]){
        str=@"同意收款";
        
    }

    else if ([sender.titleLabel.text isEqualToString:@"拒绝借款"]){
        str=@"拒绝借款";
    
    }else if ([sender.titleLabel.text isEqualToString:@"去还款"]){
    
        str=@"去还款";
    }else if ([sender.titleLabel.text isEqualToString:@"拒绝收款"]) {
        str = @"拒绝收款";
    }
    else
    {
        str = sender.titleLabel.text;
    }
    NSString *message=[NSString stringWithFormat:@"您是否确认%@",str];

    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex==1) {
            
            if([sender.titleLabel.text isEqualToString:@"同意收款"])
            {
                [statusHttp __yxb_service__operateTLoan:CONFIRM_QUICK_LEND withTloan:_loan];
                
            }
            else if ([sender.titleLabel.text isEqualToString:@"拒绝收款"])
            {
                [statusHttp __yxb_service__operateTLoan:DECLINE_QUICK_LEND withTloan:_loan];
                
            }else if ([sender.titleLabel.text isEqualToString:@"去还款"])
            {
                /*
                 PayViewController * payViewcontroller = [[PayViewController alloc]init];
                 payViewcontroller.payWay = YXBPayWayHuankuan;
                 payViewcontroller.loan = self.loan;
                 [self.navigationController pushViewController:payViewcontroller animated:YES];
                 */
                
                YXBPayAction *pay = [[YXBPayAction alloc] init];
                pay.payWay = YXBPayWayHuankuan;
                pay.loan = self.loan;
                [pay payAction];
            }
            else if ([sender.titleLabel.text isEqualToString:@"未收到打款"]){
                
                QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
                CgLoan * cgloan = [[CgLoan alloc]init];
                cgloan.yxbToken = userModel.user.yxbToken;
                cgloan.userId = userModel.user.t_id;
                cgloan.mainId = _loan.t_id;
                cgloan.operationType = LOAN_PAY_NOTYXB_NOT_BE_PAID;
                cgloan.totalMoney = _loan.money;
                
                [statusHttp __yxb__chargeTLoanwithTloan:cgloan];
                
            }else if ([sender.titleLabel.text isEqualToString:@"已收到打款"]){
                QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
                CgLoan * cgloan = [[CgLoan alloc]init];
                cgloan.yxbToken = userModel.user.yxbToken;
                cgloan.userId = userModel.user.t_id;
                cgloan.mainId = _loan.t_id;
                cgloan.operationType = LOAN_PAY_NOTYXB_BE_PAID;
                cgloan.totalMoney = _loan.money;
                
                [statusHttp __yxb__chargeTLoanwithTloan:cgloan];
            
            }else if ([sender.titleLabel.text isEqualToString:@"未收到还款"]){
                
                QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
                CgLoan * cgloan = [[CgLoan alloc]init];
                cgloan.yxbToken = userModel.user.yxbToken;
                cgloan.userId = userModel.user.t_id;
                cgloan.mainId = _loan.t_id;
                cgloan.operationType = LOAN_REPAY_NOTYXB_NOT_BE_PAID;
                cgloan.totalMoney = _loan.money;
                
                [statusHttp __yxb__chargeTLoanwithTloan:cgloan];
                
            }else if ([sender.titleLabel.text isEqualToString:@"确认已收到还款"]){
                QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
                CgLoan * cgloan = [[CgLoan alloc]init];
                cgloan.yxbToken = userModel.user.yxbToken;
                cgloan.userId = userModel.user.t_id;
                cgloan.mainId = _loan.t_id;
                cgloan.operationType = LOAN_REPAY_NOTYXB_BE_PAID;
                cgloan.totalMoney = _loan.money;
                
                [statusHttp __yxb__chargeTLoanwithTloan:cgloan];
                
            }

            
        }
       else
           return ;
        
    }];
   //    [ProgressHUD showSuccessWithStatus:sender.titleLabel.text];
}

- (void)httpCompleteWithResultSet:(TResultSet *)set withHttpTag:(NSInteger)tag{
    if (set.errCode == [Authentication integerValue]) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:set.errString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"认证", nil];
        alterView.tag = 10086;
        [alterView show];
        return;
    }
    [ProgressHUD showSuccessWithStatus:set.errString];
    if (set.errCode == 0) {
        [self getTLoanDetailWithLoanID:_loan.t_id];

    }


}

#pragma mark ----alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10086){
        if (buttonIndex == 1) {
            AuthenticationViewController *authentic = [[AuthenticationViewController alloc] init];
            [self.navigationController pushViewController:authentic animated:YES];
        }
    }
    
}
@end
