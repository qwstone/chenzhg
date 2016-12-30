//
//  TreasureHomeViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "TreasureHomeViewController.h"
#import "ProfitManager.h"
#import "ProfitHomeData.h"
#import "ProfitDetailOfMonth.h"
#import "BonusListController.h"
#import "TreasureMoneyView.h"
#import "PayHomeViewController.h"

#define TreasureHomeViewControllerOtherFinancialProductsUrl @"webView/user/otherFinancial.jsp?t=1"
@interface TreasureHomeViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate> {
    CalculatorView  *_jisuanview;
}
@property (nonatomic,copy)NSString *lilv;
@property (nonatomic,strong) ProfitHomeData *data;
@property (nonatomic,assign) NSInteger currentMonthIndex;   //当前月索引
@property (nonatomic,assign) BOOL refreshAccountMoney;      //刷新账户余额
@property (nonatomic,weak) TreasureMoneyView *secondView;

@end

@implementation TreasureHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"宝·赚钱";
    [self setBackView];
    [self setNavigationButtonItrmWithiamge:@"ques-icon" withRightOrleft:@"right" withtargrt:self withAction:@selector(questionAction)];
    
    _currentMonthIndex = 0;
    _tableView.refreshDelegate = self;
    _refreshAccountMoney = YES;

}

- (void)questionAction {
    NSString *url = [YXBTool getURL:@"webView/explain/zhuanqianExplain.jsp" params:nil];
//    NSString *url = [NSString stringWithFormat:@"%@webView/explain/zhuanqianExplain.jsp",YXB_IP_ADRESS];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"宝赚钱说明"];
}

//- (IBAction)redBag:(UITapGestureRecognizer *)sender {
//    BonusListController *bonusCtrl=[[BonusListController alloc]init];
//    [self.navigationController pushViewController:bonusCtrl animated:YES];
//}

- (IBAction)countAction:(UIButton *)sender {
    _jisuanview = [[CalculatorView alloc] initWithFrame:[[UIApplication sharedApplication].delegate window].bounds];
    _jisuanview.delegate = self;
    _jisuanview.lilv = self.data.interestRate;
    [[[UIApplication sharedApplication].delegate window] addSubview:_jisuanview];
}
- (IBAction)payMent:(UIButton *)sender {
//    NSString *payUrl = @"http://60.195.254.33:8083/charge/withdraw.jsp?a=23";
//    [YXBTool jumpSafariWithUrl:[YXBTool getURL:payUrl params:nil]];
    PayHomeViewController *pay = [[PayHomeViewController alloc] init];
    [self.navigationController pushViewController:pay animated:YES];
}
- (IBAction)lastMonth:(UIButton *)sender {
    _currentMonthIndex--;
    _refreshAccountMoney = NO;
    [_tableView reloadData];
}
- (IBAction)nextMonth:(UIButton *)sender {
    _currentMonthIndex++;
    _refreshAccountMoney = NO;
    [_tableView reloadData];
}

#pragma mark - Http
- (void)httpLoad {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak TreasureHomeViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        
        [this httpLoadParams:assginHtttperator];
        
    } complete:^(ProfitHomeData* r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{

    ProfitManager *_profitM = (ProfitManager *)[assginHtttperator getAopInstance:[ProfitManager class] returnValue:[ProfitHomeData class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {
        [_profitM getProfitHomeData:userToken];
        
    }
    else
    {
        //            未登录可使用
        [_profitM getProfitHomeData:@""];
        
    }


}

- (void)httpLoadComplete:(ProfitHomeData *)r{

    if (r.errCode == 0) {
        if (r != nil) {
            self.data = r;
            self.currentMonthIndex = r.iProfitDetailOfMonth.count-1;
            self.refreshAccountMoney = YES;
            //                self.lilv = r.interestRate;
        }
        
    }else  {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
    
    [self.tableView reloadDeals];
    [self.tableView reloadData];

}

#pragma mark - QCBaseTableView delegate
//下拉刷新
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self httpLoad];
}


#pragma mark - UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    switch (indexPath.row) {
        case 0:
            height = _firstView.height;
            break;
        case 1:
            height = kDeviceWidth-30+17.5;
            break;
        case 2:
            height = _thirdView.height;
            break;
        case 3:
            height = _fourthView.height;
            break;
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.data == nil) {
        return 0;
    }else {
        return self.data.hasMoreProfit ? 4:3;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if (indexPath.row == 0) {
        _firstView.width = kDeviceWidth;
        [cell.contentView addSubview:_firstView];
    }else if (indexPath.row == 1) {
        _secondView = [[[NSBundle mainBundle] loadNibNamed:@"TreasureMoneyView" owner:nil options:nil] lastObject];
        _secondView.width = kDeviceWidth;
        _secondView.height =  kTreasureMoneyViewHeight;
        _secondView.viewController = self;
        [cell.contentView addSubview:_secondView];
    }else if (indexPath.row == 2) {
        _thirdView.width = kDeviceWidth;
        [cell.contentView addSubview:_thirdView];
    }else if (indexPath.row == 3) {
        _fourthView.width = kDeviceWidth;
        [cell.contentView addSubview:_fourthView];
    }
    
    ProfitDetailOfMonth *monthDetail = [self.data.iProfitDetailOfMonth objectAtIndex:self.currentMonthIndex];
    
    if (indexPath.row == 0) {
        ProfitDetailOfMonth *lastMonthDetail;       //上个月
        ProfitDetailOfMonth *nextMonthDetail;       //下个月
        if (self.currentMonthIndex != 0) {
            lastMonthDetail = [self.data.iProfitDetailOfMonth objectAtIndex:self.currentMonthIndex-1];
            _monthLeft.hidden = NO;
            [_monthLeft setTitle:lastMonthDetail.briefData forState:UIControlStateNormal];
        }else {
            _monthLeft.hidden = YES;
        }
        if (self.currentMonthIndex != self.data.iProfitDetailOfMonth.count-1) {
            nextMonthDetail = [self.data.iProfitDetailOfMonth objectAtIndex:self.currentMonthIndex+1];
            _monthRight.hidden = NO;
            [_monthRight setTitle:nextMonthDetail.briefData forState:UIControlStateNormal];
        }else {
            _monthRight.hidden = YES;
        }
        _briefData.text = monthDetail.data;
        
    }else if (indexPath.row == 1) {
        _secondView.currentMonth = self.currentMonthIndex;
        _secondView.data = self.data;
        
    }else if (indexPath.row == 2) {
        //刷新账户余额
        if (_refreshAccountMoney) {
            _refreshAccountMoney = NO;
            [_moneyOfAccount numberFrom:0 to:[self.data.moneyOfAccount doubleValue] fitFontSize:NO style:QCCountLabelStyleRemainMoney];
            NSString *interest = [NSString stringWithFormat:@"每万元每天%.2f元红包",10000*self.data.interestRate.doubleValue];
            NSString *interestRate = [NSString stringWithFormat:@"%.2f",10000*self.data.interestRate.doubleValue];
            if (KDeviceOSVersion>5.0) {
                
                NSMutableAttributedString *interestAttributString = [[NSMutableAttributedString alloc] initWithString:interest];
                //设置字符串的样式   NSFontAttributeName:样式名称
                NSRange interestRange = [interest rangeOfString:interestRate];
                
                [interestAttributString addAttribute:NSForegroundColorAttributeName
                                               value:rgb(230, 50, 37, 1)
                                               range:interestRange];
                _interest.attributedText = interestAttributString;
                
            }else {
                _interest.text = interest;
            }
        }
    }else if (indexPath.row == 3) {
        
    }
    
    return cell;
}


#pragma mark --- CalculatorViewDelegate
- (void)pushChongzhiWebView {
//    NSString *payUrl = @"http://60.195.254.33:8083/charge/recharge.jsp?a=23";
//    [YXBTool jumpSafariWithUrl:[YXBTool getURL:payUrl params:nil]];
    PayHomeViewController *pay = [[PayHomeViewController alloc] init];
    [self.navigationController pushViewController:pay animated:YES];

}
- (IBAction)otherFinancialProducts:(id)sender {
    
    NSString *url = [YXBTool getURL:TreasureHomeViewControllerOtherFinancialProductsUrl params:nil];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"更多理财产品"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end

