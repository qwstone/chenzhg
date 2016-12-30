//
//  QClendToViewController.m
//  YOUXINBAO
//
//  Created by Walice on 15/7/2.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QClendToViewController.h"
#import "PayJsonTools.h"
#import "YXBTool.h"
#import "LoanManagerV2.h"
#import "QCFriendsViewController.h"
#import "StatusHttp.h"
#import "PayViewController.h"
#import "LoanConfig.h"
#import "YXBTool.h"
#import "YXBPayAction.h"
#import "YXBProtocolView.h"
#import "LoanOrRepayFriendsViewController.h"
#import "FriendSelecteViewController.h"


@interface QClendToViewController ()<YXBProtocolViewtDelegate>
{
    StatusHttp *statusHttp;
}

@property (nonatomic,strong)Loan *loan;

@end

@implementation QClendToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loan = [[Loan alloc] init];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
 
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64)];
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight);
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 50)];
    label.text=@"救急金额:";
    [_scrollView addSubview:label];
    
    _field=[[UITextField alloc]initWithFrame:CGRectMake(20+(kDeviceWidth - 40)/2.0, 0, (kDeviceWidth - 40)/2.0, 48)];
    _field.textAlignment = NSTextAlignmentRight;
    _field.keyboardType = UIKeyboardTypeNumberPad;
//    [_field becomeFirstResponder];
    _field.placeholder = [NSString stringWithFormat:@"限1-%d元",LoanDetailsViewControllerMaxLoadMoney];
    _field.delegate=self;
    [_scrollView addSubview:_field];
//    _textViewplacehide=[[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth-110, 0,100, 50)];
//    _textViewplacehide.numberOfLines=0;
//    _textViewplacehide.enabled = NO;
//    _textViewplacehide.font = [UIFont systemFontOfSize:16];
//    _textViewplacehide.textColor = [UIColor grayColor];
//    _textViewplacehide.text = @"限1--50000元";
//    _textViewplacehide.backgroundColor = [UIColor clearColor];
//    [_scrollView addSubview: _textViewplacehide];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(16, label.bottom-0.5, kDeviceWidth-16, 1)];
    line1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"HistorySepLine.png"]];
    [_scrollView addSubview:line1];
    
    _button=[UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame=CGRectMake(10, line1.bottom+30, kDeviceWidth-20, 40);
    [_button setBackgroundImage:[UIImage imageNamed:@"blue-but2.png"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(PaySubmit) forControlEvents:UIControlEventTouchUpInside];
    if (self.friendID>0) {
        [_button setTitle:@"支付" forState:UIControlStateNormal];
      
    }
    else{
        [_button setTitle:@"选择好友" forState:UIControlStateNormal];
        }
    
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_scrollView addSubview:_button];
    
    YXBProtocolView *view=[[YXBProtocolView alloc]initWithType:TYPE_TO_SHANDIAN_JIECHU Frame:CGRectMake(0, _button.top-25,kDeviceWidth, 20)location:VIEWAlignmentCenter];
    view.delegate=self;
    [_scrollView addSubview:view];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, _button.bottom+30, 40, 20)];
    label1.text=@"说明:";
    label1.font=[UIFont systemFontOfSize:14];
    [_scrollView addSubview:label1];
    
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(5, label1.bottom+5, 30, 30)];
    imgView.contentMode=UIViewContentModeCenter;
    imgView.image=[UIImage imageNamed:@"1.png"];
    [_scrollView addSubview:imgView];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, label1.bottom+10, kDeviceWidth-20, 50)];
    label2.numberOfLines=0;
    label2.font=[UIFont systemFontOfSize:15];
    //设置UILabel的行间距
    NSString *string=@"      默认借款时长7天(无息),还款日为支付成功后的第6天.";
    [_scrollView addSubview:label2];
    
    NSMutableAttributedString *attribute=[[NSMutableAttributedString alloc]initWithString:string];
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:10];
    [attribute addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [string length])];
    [label2 setAttributedText:attribute];

    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(10, label2.bottom-5, kDeviceWidth-20, 50)];
    label3.numberOfLines=0;
    label3.font=[UIFont systemFontOfSize:15];
//    label3.text=@"例: 支付日期为05-01,还款日期为05-08";
    
    label3.textColor=[UIColor grayColor];
    [_scrollView addSubview:label3];
    
    NSString * formate = @"MM-dd";

    NSDate *date = [NSDate date];
    NSString *lDate = [QCUtils stringFromDate:date formate:formate];
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceNow: 7*24*60*60];
    NSString *pDate = [QCUtils stringFromDate:newDate formate:formate];
    
    NSString *text = [NSString stringWithFormat:@"例: 支付日期为 %@,还款日期为 %@",lDate,pDate];
    label3.text = text;
    
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(10, label3.bottom, kDeviceWidth-20, 100)];
    label4.numberOfLines=0;
    label4.font=[UIFont systemFontOfSize:15];


    NSString *string1=@"      成功发出借款后,有效期为24小时,若对方未在有效期内确认收款,则该借款单自动关闭.";

    [_scrollView addSubview:label4];
    
    
    
    NSMutableAttributedString *attribute1=[[NSMutableAttributedString alloc]initWithString:string1];
    NSMutableParagraphStyle *style1=[[NSMutableParagraphStyle alloc]init];
    [style1 setLineSpacing:10];
    [attribute1 addAttribute:NSParagraphStyleAttributeName value:style1 range:NSMakeRange(0, [string1 length])];
    [label4 setAttributedText:attribute1];
    CGSize size=[YXBTool getFontSizeWithString:string1 font:label4.font constrainSize:CGSizeMake(kDeviceWidth, kDeviceHeight)];
    label4.height=size.height+10;
    
    UIImageView *imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(5, label3.bottom-5, 30, 30)];
    imgView1.contentMode=UIViewContentModeCenter;
    imgView1.image=[UIImage imageNamed:@"2.png"];
    [_scrollView addSubview:imgView1];

}

- (void)tapAction{
  
    [_field resignFirstResponder];
   
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if([string isEqualToString:@"\n"]) {
        [_field resignFirstResponder];
        return NO;
    }
    
    if (string.length>0) {
        _textViewplacehide.hidden = YES;
    }else{
        if (range.location ==0) {
            _textViewplacehide.hidden = NO;
        }
        
        
    }
    
    NSMutableString *str = [[NSMutableString alloc] initWithString:_field.text];
    
    [str replaceCharactersInRange:range withString:string];
    
        if ([str integerValue] > LoanDetailsViewControllerMaxLoadMoney)
        {
            [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"借款金额最高%d",LoanDetailsViewControllerMaxLoadMoney]];
            _field.text = [NSString stringWithFormat:@"%d",LoanDetailsViewControllerMaxLoadMoney];
            return NO;
            
        }
    if ([str integerValue] == 0 && string.integerValue == 0 &&[textField.text integerValue] == 0) {
        return NO;
    }
    
    
    return YES;



}

- (void)PaySubmit{
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    self.loan.loanFriendType = YXBPayDesFriend;

    if (self.friendID>0) {
        if ([_field.text isEqualToString:@""]) {
            [YXBTool showAlertViewWithString:@"请输入金额"];
            return;
        }
        if (_field.text.integerValue>LoanDetailsViewControllerMaxLoadMoney) {
            [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"借款金额最高%d",LoanDetailsViewControllerMaxLoadMoney]];
            return;
        }
        
        
        statusHttp = [[StatusHttp alloc]init];
//        statusHttp.delegate = self;
        //                self.loan.operationType = LOAN_APPLY;
        [self lendWithOperationType:LOAN_QUICK_SEND_QUICK_LEND];
        
        self.loan.borrowerId = _friendID ;
        self.loan.lenderId = userModel.user.t_id;
        self.loan.yxbToken = userModel.user.yxbToken;
        self.loan.loanType = LoanQuickTypeQuick;
        self.loan.money = _field.text;
        self.loan.loanFriendType = YXBPayDesFriend;
//        self.loan.expectBorrowDate = @"2015-07-03";
//        self.loan.loanPeriod = 6;

//        self.loan.interestType = 2;
        /*
        PayViewController * payViewcontroller = [[PayViewController alloc]init];
        payViewcontroller.payWay = YXBPayWayFukuan;
        payViewcontroller.loan = self.loan;
        payViewcontroller.isQuickLend = YES;
        
        [[YXBTool getCurrentNav] pushViewController:payViewcontroller animated:YES];

        */
        
        YXBPayAction *pay = [[YXBPayAction alloc] init];
        pay.payWay = YXBPayWayFukuan;
        pay.isQuickLend = YES;
        pay.loan = self.loan;
        [pay payAction];

        /*
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        NSString *userToken = userModel.user.yxbToken;
        NSString *urlstr = [NSString stringWithFormat:@"webView/user/loanPay.jsp"];
        PayJsonTools *paytools = [[PayJsonTools alloc] init];
        paytools.iOnJsonStr = ^(NSString *s){
            NSLog(@"%@",s);
            NSString *dic = [NSString stringWithFormat:@"&json=%@&money=%@",s,_field.text];
            
            NSString *urlstrs = [YXBTool getURL:urlstr params:dic];
            NSLog(@"%@",urlstrs);
            [YXBTool jumpInnerSafaryWithUrl:urlstrs hasTopBar:NO titleName:nil];
        };
        LoanManager *manager = [paytools getAopInstance:[LoanManager class]];
        
        [manager createLightningLoanOut:userToken money:_field.text friendID:self.friendID];
        */
 

    }
    else{
        if ([_field.text isEqualToString:@""]) {
            [YXBTool showAlertViewWithString:@"请输入金额"];
            return;
        }
        if (_field.text.integerValue>LoanDetailsViewControllerMaxLoadMoney) {
            [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"借款金额最高%d",LoanDetailsViewControllerMaxLoadMoney]];
            return;
        }

//        QCFriendsViewController * friendsViewController = [[QCFriendsViewController alloc]init];
        /*
         有借有还好友修改
         */
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted || ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请开启通讯录访问功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
//        LoanOrRepayFriendsViewController * friendsViewController = [[LoanOrRepayFriendsViewController alloc]init];
        [self lendWithOperationType:LOAN_QUICK_SEND_QUICK_LEND];
        self.loan.lenderId = userModel.user.t_id;
        self.loan.yxbToken = userModel.user.yxbToken;
        self.loan.loanType = LoanQuickTypeQuick;
        self.loan.loanFriendType = YXBPayDesFriend;
        self.loan.money = _field.text;
//        self.loan.interestType = 2;
//        friendsViewController.loanModel = self.loan;
//        friendsViewController.isFromLender = YES;
//        [[YXBTool getCurrentNav] pushViewController:friendsViewController animated:YES];
        
        FriendSelecteViewController *friendController = [[FriendSelecteViewController alloc] init];
        friendController.friendType = LoanNewFriendTypeJieChu;
        friendController.loanModel = self.loan;
        [[YXBTool getCurrentNav] pushViewController:friendController animated:YES];

    }

   
}

-(void)lendWithOperationType:(int)type
{
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    self.loan.lenderId = userModel.user.t_id;
    
    self.loan.operationType = type;
    self.loan.yxbToken = userModel.user.yxbToken;
    
}

- (void)checkButton:(UIButton *)sender{
    
    
    if (sender.selected==YES) {
        _button.userInteractionEnabled=YES;
        _button.alpha=1;
        
    }
    else if (sender.selected==NO){
        
        _button.userInteractionEnabled=NO;
        _button.alpha=0.3;
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
