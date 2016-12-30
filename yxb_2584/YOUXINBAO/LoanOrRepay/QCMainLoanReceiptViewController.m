//
//  QCMainLoanReceiptViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/5/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCMainLoanReceiptViewController.h"
#import "QCLoanReceiptViewController.h"
#import "LoanCenterManager.h"
#import "LoanCenter.h"
#import "LoanDetailsViewController.h"
#import "TResultSet.h"
#import "Payment_caPdfDownload.h"


@interface QCMainLoanReceiptViewController () {
    UIButton *payBtn;
    UIButton *reminderBtn;//催款按钮
}

@property (nonatomic,strong) QCLoanReceiptViewController* iQCLoanReceiptViewController;
@property (strong, nonatomic) UIScrollView* iScrollView;
@property (nonatomic,strong) UILabel *receiptNum;
@property (nonatomic,strong) LoanCenter *loanCenter;

@end

@implementation QCMainLoanReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = rgb(241, 240, 248, 1);
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"借条详情"];
    
    //发起AA
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 21, 18);
//    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(getPicture:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setTitle:@"保存借条" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    UIBarButtonItem *getItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = getItem;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 43)];
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bhbg"]];
    [self.view addSubview:headerView];
    
    [self CreateLabel:@"单据编号" frame:CGRectMake(10,11.5,100,20) withView:headerView textAlignment:0 fontSize:17 textColor:rgb(116, 116, 116, 1)];
    _receiptNum = [[UILabel alloc] initWithFrame:CGRectMake(78, 11.5, 200, 20)];
    _receiptNum.backgroundColor = [UIColor clearColor];
    _receiptNum.font = [UIFont systemFontOfSize:15];
    _receiptNum.adjustsFontSizeToFitWidth = YES;
    _receiptNum.minimumScaleFactor = 10.0/_receiptNum.font.pointSize;
    _receiptNum.textColor = [UIColor blackColor];
    [headerView addSubview:_receiptNum];
    
    payBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth-10-90, 6.5, 90, 30)];
    [payBtn setImage:[UIImage imageNamed:@"hankuan"] forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(repaymentAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
    
    self.iScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 43, self.view.frame.size.width, kDeviceHeight-43-64)];
     _iQCLoanReceiptViewController = [[QCLoanReceiptViewController alloc] init];
//    [self.view addSubview:iQCLoanReceiptViewController.view];
    _iQCLoanReceiptViewController.view.width = kDeviceWidth;
    [self.iScrollView addSubview:_iQCLoanReceiptViewController.view];
    [self.view addSubview:self.iScrollView];
    // Do any additional setup after loading the view.
    //催款按钮
    reminderBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    reminderBtn.frame =CGRectMake(kDeviceWidth-90-10, 6.5, 90, 30);
    [reminderBtn setImage:[UIImage imageNamed:@"cuikuan"] forState:UIControlStateNormal];
    [reminderBtn addTarget:self action:@selector(reminderAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reminderBtn];
    //logo
    UIImageView *yxbIconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth-125-10, kDeviceHeight-40-64-10, 125, 40)];
    yxbIconImgView.image = [UIImage imageNamed:@"yxbicon"];
    [self.view addSubview:yxbIconImgView];
    
    [self httpDowload];
}
-(void)reminderAction:(UIButton *)sender{
    [self requestReminderData];
}
-(void)requestReminderData{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];

    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCMainLoanReceiptViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpLoadParams:assginHtttperator];
      
    } complete:^(TResultSet* r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{

    LoanCenterManager* _loanM = (LoanCenterManager*)  [assginHtttperator getAopInstance:[LoanCenterManager class] returnValue:[TResultSet class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    [_loanM loanRemindRepay:userModel.user.yxbToken loanCenterId:self.brief.t_id];

}
- (void)httpLoadComplete:(TResultSet *)r{
    if (r.errCode == 0) {
        [ProgressHUD showErrorWithStatus:r.errString];
    }else{
        [ProgressHUD showErrorWithStatus:r.errString];
    }

}
- (void)httpDowload {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCMainLoanReceiptViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
    } param:^(NSString *s) {
        [this httpLoadParamsTwo:assginHtttperator];
    } complete:^(LoanCenter* r, int taskid) {
        [this httpLoadCompleteTwo:r];
        
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParamsTwo:(HttpOperator *)assginHtttperator{

    
    LoanCenterManager* _loanM = (LoanCenterManager*)  [assginHtttperator getAopInstance:[LoanCenterManager class] returnValue:[LoanCenter class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    [_loanM getLoanCenterDetail:userModel.user.yxbToken loanCenterID:self.brief.t_id];
    

}
- (void)httpLoadCompleteTwo:(LoanCenter *)r{

    if (r.errCode == 0) {
        _loanCenter = r;
        self.iQCLoanReceiptViewController.loanCenter = r;
        self.iScrollView.contentSize = CGSizeMake(self.view.frame.size.width, _iQCLoanReceiptViewController.height+50);
        self.receiptNum.text = r.serialNo;
        [self isShowReminderBtn];
        [self isShownQuickPayBtn];
        [self reSetreceiptNumWidth];
        
    }else{
        
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alert show];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)repaymentAciton:(UIButton *)button {
    Loan *loan = [[Loan alloc] init];
    loan.t_id = _brief.loanId;
    LoanDetailsViewController * detailsViewController = [[LoanDetailsViewController alloc]init];
    detailsViewController.loan = loan;
    detailsViewController.bOrL = BORROWER;
    [self.navigationController pushViewController:detailsViewController animated:YES];

    
}

- (void)getPicture:(UIButton *)button {
//    UIImage *image = [self.iQCLoanReceiptViewController capture];
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    

    Payment_caPdfDownload *payModel = [[Payment_caPdfDownload alloc] init];
    payModel.loanID = [NSString stringWithFormat:@"%ld",(long)_brief.t_id];
    NSString *urls = [YXBPaymentUtils getFullWebUrl:payModel];
    NSLog(@"%@",urls);
    urls=[urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:urls];
    [[UIApplication sharedApplication ] openURL:url];
    
}


//保存图片到相册成功之后调用的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    //保存成功
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alterView show];
}

- (void)leftClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

//显示或隐藏快速还款按钮
-(void)isShownQuickPayBtn
{
    QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
    if ([model.user.username isEqualToString:_loanCenter.lenderPhoneNumer] ||
        _loanCenter.status == 1) {
        payBtn.hidden = YES;
    }
    else
    {
        payBtn.hidden = NO;
    }
}
//显示或隐藏催款按钮
-(void)isShowReminderBtn{

    if (!self.iQCLoanReceiptViewController.loanCenter.showReminderBtn) {
        reminderBtn.hidden = YES;
    }else{
        reminderBtn.hidden = NO;
    }
}
//重设单据编号的宽度
-(void)reSetreceiptNumWidth{
    if (reminderBtn.hidden == YES && payBtn.hidden == YES) {
        self.receiptNum.width = kDeviceWidth-78;
    }else{
        self.receiptNum.width = kDeviceWidth-100 - 78;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [self isShownQuickPayBtn];
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
