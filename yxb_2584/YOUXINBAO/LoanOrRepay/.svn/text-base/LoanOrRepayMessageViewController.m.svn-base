//
//  LoanOrRepayMessageViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanOrRepayMessageViewController.h"
#import "BorrowingInformationView.h"
#import "LoanMessageTableViewCell.h"
#import "LoanMessageSecondTypeTableViewCell.h"
#import "LoanManagerV2.h"
//#import "IMGroupModel.h"
//#import "RongChat.h"
//#import "YXBChatViewController.h"
#import "YXBTool.h"
#import "QCLendDetailViewController.h"
#import "LoanConfig.h"
#import "FriendDetailViewController.h"

@interface LoanOrRepayMessageViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,LoanMessageTableViewCellDelegate>
{
    
    NSMutableArray * logArray;
    TLoanWithLog * _loanWithLog;
   QCUserModel * userModel;
}

@property(nonatomic,strong)TLoanWithLog * loanWithLog;
@property (nonatomic,strong)QCBaseTableView * tableView;
//@property (nonatomic,strong)BorrowingInformationView * borrowingInformationView;

@end

@implementation LoanOrRepayMessageViewController
-(void)dealloc{
    NSLog(@"LoanOrRepayMessageViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_loan != nil) {
        [self setTitle:_loan.friendRealname];

    }
    // Do any additional setup after loading the view.
    logArray = [[NSMutableArray alloc]init];
    userModel = [[QCUserManager sharedInstance]getLoginUser];
    [self initView];
//    [self getTLoanWithLog];
}

- (void)initView
{

    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-40) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.refreshDelegate = self;
    _tableView.hidden = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UIButton * footerView = [[UIButton alloc]initWithFrame:CGRectMake(0, _tableView.size.height, kDeviceWidth, 40)];
    [footerView setTitle:@"发起聊天" forState:UIControlStateNormal];
    footerView.backgroundColor = rgb(190, 50, 50, 1.0);
//    footerView.layer.cornerRadius = 5.0;
//    [footerView addTarget:self action:@selector(footerViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:footerView];
}
/*r
- (void)footerViewAction:(UIButton *)sender
{//聊天入口
    
    

    QCUserModel *userModel1 = [[QCUserManager sharedInstance] getLoginUser];
    NSString *token = userModel1.user.ryToken;
    if(token != nil && [token length] > 0)
    {
        RongChat *chat  = [RongChat shareRongChat];
        [chat connectRongServerWithRongToken:nil];
        
        if ((_loanWithLog.chatId == nil) || [_loanWithLog.chatId length] < 2) {
            [YXBTool showAlertViewWithString:@"聊天信息获取失败"];
            return;
        }

        YXBChatViewController *temp = [[YXBChatViewController alloc]init];
        temp.portraitStyle = RCUserAvatarCycle;//圆头像
        temp.currentTarget = _loanWithLog.chatId;
        temp.conversationType = ConversationType_GROUP;
        temp.currentTargetName = _loanWithLog.chatName;
        if ([ temp.currentTargetName isEqualToString:@""]) {
             temp.currentTargetName = @"聊天";
        }
        [self.navigationController pushViewController:temp animated:YES];

    }
//    [chat enterGroupWithViewController:self loan:self.loan];

}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [BorrowingInformationView getViewHeightWithLoanLog:[logArray firstObject]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BorrowingInformationView *borrowingInformationView = [[BorrowingInformationView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kCustomHeight)];
    [borrowingInformationView setLoanWithLog:_loanWithLog];
    [borrowingInformationView addTarget:self action:@selector(BorrowingInforMationAction:) forControlEvents:UIControlEventTouchUpInside];
    if ((logArray != nil) && [logArray count] > 0) {
        TLoanLog *loanLog = logArray[0];
        //判断当前是借款人还是放款人
//        BOOL isLender = NO;
//        QCUserModel * userModel1 = [[QCUserManager sharedInstance]getLoginUser];
//        if (userModel1.user.t_id == loanLog.t_id) {
//            isLender = YES;
//        }
        if (_bOrL == LENDERS) {
            borrowingInformationView.systemLabel.text = loanLog.lenderNote;
            borrowingInformationView.stautsLabel.text = [borrowingInformationView getStatusWithBorrower:NO];
        }
        else if (_bOrL == BORROWER)
        {
            borrowingInformationView.systemLabel.text = loanLog.borrowerNote;
            borrowingInformationView.stautsLabel.text = [borrowingInformationView getStatusWithBorrower:YES];
        }
        
        borrowingInformationView.creator.text = loanLog.creatorName;
        borrowingInformationView.identity.text = loanLog.creatorIdCardNo;
        
        if (!loanLog.loanCenterValidNote || loanLog.loanCenterValidNote.length == 0) {
            borrowingInformationView.loanTip.hidden = YES;
        }else {
            borrowingInformationView.loanTip.text = loanLog.loanCenterValidNote;
            borrowingInformationView.loanTip.hidden = NO;
            
        }
        borrowingInformationView.height = [BorrowingInformationView getViewHeightWithLoanLog:loanLog];

    }

    return borrowingInformationView;
}

- (void)BorrowingInforMationAction:(UIButton *)sender
{
    if (_loan.loanType== LoanQuickTypeQuick) {
        QCLendDetailViewController *detail=[[QCLendDetailViewController alloc]init];
        detail.loan = self.loan;
        detail.loanId=self.loan.t_id;
//        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        detail.bOrL = _bOrL;
        if (userModel.user.t_id == self.loan.lenderId) {
            detail.bOrL = LENDERS;
        }
        
        [self.navigationController pushViewController:detail animated:YES];

    }else{
    LoanDetailsViewController * detailsViewController = [[LoanDetailsViewController alloc]init];
    detailsViewController.loan = _loan;
    
    detailsViewController.bOrL = _bOrL;
    if (_loan.status == QUICKLEND_NEEDCONFIRM) {
        detailsViewController.isShowTimer = YES;
    }
        [self.navigationController pushViewController:detailsViewController animated:YES];}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLoanLog *loanLog =(TLoanLog *)[self.loanWithLog.loanLog objectAtIndex:indexPath.row];
    if (loanLog.msgType==2) {
        CGSize size = [YXBTool getFontSizeWithString:loanLog.msgDetail font:[UIFont systemFontOfSize:14] constrainSize:CGSizeMake(kDeviceWidth-60-30, 1000000)];
        return size.height+30;
    }
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return logArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLoanLog *loanLog = (TLoanLog *)[self.loanWithLog.loanLog objectAtIndex:indexPath.row];
    if (loanLog.msgType==2||loanLog.msgType==3) {
        static NSString *cellID = @"cellSecondId";
        LoanMessageSecondTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[LoanMessageSecondTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setLoanWithLog:_loanWithLog];
        [cell setLoanLog:logArray[indexPath.row]];
        
        return cell;
    }else{
        static NSString * cellID = @"cellId";
        LoanMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[LoanMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell setLoanLog:logArray[indexPath.row]];
        [cell setLoanWithLog:_loanWithLog];
        cell.delegate = self;
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

-(void)userImageClickedWithUserId:(NSInteger)uId
{
    User *user = [[User alloc] init];
    user.t_id = uId;
    
    FriendDetailViewController *controller = [[FriendDetailViewController alloc] init];
    controller.user = user;
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark  Htttpdownload
- (void)getTLoanWithLog
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak LoanOrRepayMessageViewController *this = self;
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
        
    } complete:^(TLoanWithLog* r, int taskid) {

        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    LoanManagerV2* _Loanmanger = (LoanManagerV2*)  [httpOperation getAopInstance:[LoanManagerV2 class] returnValue:[TLoanWithLog class]];
    
    //        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    //        [_Loanmanger getTLoanWithLog:userModel.user.t_id loanId:_loan.t_id];
    [_Loanmanger getTLoanWithLogV2:userModel.user.t_id loanId:_loan.t_id loanFriendType:_loan.loanFriendType];
}
//请求完成
-(void)httpLoadComplete:(TLoanWithLog *)r{
    if (r.errCode == 0) {
        self.tableView.hidden = NO;
//        RCUserInfo *rongUserInfo = [[RCUserInfo alloc] initWithUserId:r.friendRyId name:r.friendNickname portrait:r.friendIconAddr];
//        
//        [[RongChat shareRongChat] setRongUserInfoDicWithUserInfo:rongUserInfo];
        _loanWithLog = r;
        
        if(_loan.loanFriendType == YXBPayDesContact)
        {
            [self setTitle:@"通讯录好友"];
        }else if (_loan.loanFriendType == YXBPayDesWeChat)
        {
            [self setTitle:@"微信好友"];
        }else
        {
            [self setTitle:_loanWithLog.friendNickname];
            
        }
        
        if ([r.loanLog count]>0) {
            //                [this setTitle:r.friendRealname];
            logArray = r.loanLog;
        }
        
        
        
    }else{
        NSLog(@"%@",r.errString);
    }
    [self.tableView reloadData];
    [self.tableView reloadDeals];

}
#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self refreshData];
}


//刷新数据
- (void)refreshData {
    [self getTLoanWithLog];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
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
