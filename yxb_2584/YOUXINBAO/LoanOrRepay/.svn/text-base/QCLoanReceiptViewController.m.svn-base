//
//  QCLoanReceiptViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/13.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCLoanReceiptViewController.h"
#import "LoanManagerV2.h"
#import "Loan.h"
#import "LoanDetailsInstallmentView.h"

@interface QCLoanReceiptViewController ()<UIScrollViewDelegate,loanDetailsInstallmentViewDelegate> {
    LoanDetailsInstallmentView *_installmentView;
}

@property (nonatomic,strong)UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *effectiveImage;

@end

@implementation QCLoanReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"借条中心"];
    
//    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 43, kDeviceWidth, kDeviceHeight-43-64)];
//    _scrollView.delegate = self;
//    _scrollView.backgroundColor = [UIColor whiteColor];
//    _scrollView.contentSize = CGSizeMake(kDeviceWidth, 568);
//    [self.view addSubview:_scrollView];
    
//    for (int i = 0; i<5; i++) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake((kDeviceWidth-20-240)/6+10+(80+(kDeviceWidth-20-240)/3)*(i%3), _jieJuDetail.bottom+10+(45+10)*(i/3), 80, 45)];
//        view.backgroundColor = [UIColor redColor];
//        [self.view addSubview:view];
//    }
    
    _installmentView = [[LoanDetailsInstallmentView alloc]initWithFrame:CGRectMake(0, _jieJuDetail.bottom, kDeviceWidth, 0)];
    _installmentView.delegate = self;
    _installmentView.installmentStatus = DoNotChoose;
    [self.view addSubview:_installmentView];
    
    
    
//    [self httpDowload];
    
}

- (void)setLoanCenter:(LoanCenter *)loanCenter {
    _loanCenter = loanCenter;
    
    _borrowName.text = self.loanCenter.borrowerRealname;
    _borrowTel.text = self.loanCenter.borrowerPhoneNum;
    _borrowId.text = self.loanCenter.borrowerIdCardNo;
    _loanName.text = self.loanCenter.lenderRealname;
    _loanTel.text = self.loanCenter.lenderPhoneNumer;
    _loanId.text = self.loanCenter.lenderIdCardNo;
    _borrowTime.text = self.loanCenter.expectBorrowDate;
    _repayTime.text = self.loanCenter.realBorrowDate;
    _interestType.text = self.loanCenter.interestTypeDesc;
    _borrowLong.text = self.loanCenter.loanPeriodDesc;
    _repayType.text = self.loanCenter.repayTypeDesc;
    _borrowMoney.text = self.loanCenter.money;
    _interestMoney.text = self.loanCenter.interest;
    _compensation.text = self.loanCenter.sumCompensation;
    
//改变有效无效 图片
    if (_loanCenter.status == 1) {
        _effectiveImage.image = [UIImage imageNamed:@"wuxiao.png"];
    }
    else
    {
        _effectiveImage.image = [UIImage imageNamed:@"youxiao.png"];
    }
    
    _installmentView.array = self.loanCenter.installmentList;
//    [_installmentView refreshWith:[QCLoanReceiptViewController getLoanPeriodWithDesc:self.loanCenter.loanPeriodDesc]];
    [_installmentView refreshFromReceiptWith:[QCLoanReceiptViewController getLoanPeriodWithDesc:self.loanCenter.loanPeriodDesc]];
    self.height = 287+_installmentView.height;
}

//获取借款单的快照图片
- (UIImage *)capture {
    
    if (_jieJuDetail == nil) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(_jieJuDetail.bounds.size, _jieJuDetail.opaque, 0.0);
    [_jieJuDetail.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"%f,%f",img.size.height,img.size.width);
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - loanDetailsInstallmentViewDelegate

- (void)InstallmentViewButtonAction:(UIButton *)sender {
    
}

+ (LoanPeriod)getLoanPeriodWithDesc:(NSString *)desc {
    LoanPeriod period;
    if ([desc isEqualToString:@"1天"]) {
        period = LoanPeriod_DAY_1;
    }else if ([desc isEqualToString:@"2天"]) {
        period = LoanPeriod_DAY_2;
    }else if ([desc isEqualToString:@"3天"]) {
        period = LoanPeriod_DAY_3;
    }else if ([desc isEqualToString:@"4天"]) {
        period = LoanPeriod_DAY_4;
    }else if ([desc isEqualToString:@"5天"]) {
        period = LoanPeriod_DAY_5;
    }else if ([desc isEqualToString:@"6天"]) {
        period = LoanPeriod_DAY_6;
    }else if ([desc isEqualToString:@"一周"]) {
        period = LoanPeriod_WEEK_1;
    }else if ([desc isEqualToString:@"二周"]) {
        period = LoanPeriod_WEEK_2;
    }else if ([desc isEqualToString:@"三周"]) {
        period = LoanPeriod_WEEK_3;
    }else if ([desc isEqualToString:@"1月"]) {
        period = LoanPeriod_MONTH_1;
    }else if ([desc isEqualToString:@"2月"]) {
        period = LoanPeriod_MONTH_2;
    }else if ([desc isEqualToString:@"3月"]) {
        period = LoanPeriod_MONTH_3;
    }else if ([desc isEqualToString:@"4月"]) {
        period = LoanPeriod_MONTH_4;
    }else if ([desc isEqualToString:@"5月"]) {
        period = LoanPeriod_MONTH_5;
    }else if ([desc isEqualToString:@"6月"]) {
        period = LoanPeriod_MONTH_6;
    }else if ([desc isEqualToString:@"7月"]) {
        period = LoanPeriod_MONTH_7;
    }else if ([desc isEqualToString:@"8月"]) {
        period = LoanPeriod_MONTH_8;
    }else if ([desc isEqualToString:@"9月"]) {
        period = LoanPeriod_MONTH_9;
    }else if ([desc isEqualToString:@"10月"]) {
        period = LoanPeriod_MONTH_10;
    }else if ([desc isEqualToString:@"11个月"]) {
        period = LoanPeriod_MONTH_11;
    }else if ([desc isEqualToString:@"1年"]) {
        period = LoanPeriod_YEAR_1;
    }
    return period;
}

- (void)leftClicked {
    [self.navigationController popViewControllerAnimated:YES];
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
