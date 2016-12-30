//
//  QCMakeMoneyViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/6/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCMakeMoneyViewController.h"
#import "QCCarouselCell.h"
#import "ProfitManager.h"
#import "YXBTool.h"
#import "PayHomeViewController.h"
#import "BonusListController.h"
#import "CalculatorView.h"
#import "QCHomeDataManager.h"
#define kElseButtonTag 2001
#define kChargeButtonTag 2002
#define kCountButtonTag 2003

@interface QCMakeMoneyViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,CalculatorViewDelegate,QCCarouselCellDelegate> {
     CalculatorView  *_jisuanview;
}

@property (nonatomic,strong)QCBaseTableView *tableView;
@property (nonatomic,strong)ProfitNewHomeData *data;

@end

@implementation QCMakeMoneyViewController

- (void)dealloc {
    [_timerManager stop];
}
//-(void)leftClicked
//{
//    if (_timerManager != nil) {
//        [_timerManager stop];
//        
//    }
//    [super leftClicked];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"宝·赚钱"];
    [self setBackView];
    [self setNavigationButtonItrmWithiamge:@"ques-icon" withRightOrleft:@"right" withtargrt:self withAction:@selector(questionAction)];
    [self initViews];

}

- (void)initViews {
    _tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-kDeviceWidth/320*60) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
    
    
    //底部视图
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, _tableView.bottom, kDeviceWidth, kDeviceWidth/320*60)];
    footer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footer];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0.5)];
    line.backgroundColor = [YXBTool colorWithHexString:@"d3d1d1"];
    [footer addSubview:line];
    
    float gap = (kDeviceWidth-kDeviceWidth/320*124-kDeviceWidth/320*123.5-kDeviceWidth/320*32)/4;
    //248*88
    UIButton *elseMoney = [[UIButton alloc] initWithFrame:CGRectMake(gap, (kDeviceWidth/320*60-kDeviceWidth/320*44)/2, kDeviceWidth/320*124, kDeviceWidth/320*44)];
    [elseMoney setBackgroundImage:[UIImage imageNamed:@"bzq-lcsm-but"] forState:UIControlStateNormal];
    elseMoney.tag = kElseButtonTag;
    [elseMoney addTarget:self action:@selector(makeMoneyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:elseMoney];
    
    //247*86
    UIButton *charge = [[UIButton alloc] initWithFrame:CGRectMake(elseMoney.right+gap, (kDeviceWidth/320*60-kDeviceWidth/320*43)/2, kDeviceWidth/320*123.5, kDeviceWidth/320*43)];
    [charge setBackgroundImage:[UIImage imageNamed:@"bzq-charge-but"] forState:UIControlStateNormal];
    charge.tag = kChargeButtonTag;
    [charge addTarget:self action:@selector(makeMoneyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:charge];
    
    //64*88
    UIButton *count = [[UIButton alloc] initWithFrame:CGRectMake(charge.right+gap, (kDeviceWidth/320*60-kDeviceWidth/320*44)/2, kDeviceWidth/320*32, kDeviceWidth/320*44)];
    [count setBackgroundImage:[UIImage imageNamed:@"bzq-suan"] forState:UIControlStateNormal];
    count.tag = kCountButtonTag;
    [count addTarget:self action:@selector(makeMoneyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:count];
}

- (void)questionAction {
    NSString *url = [YXBTool getURL:@"webView/explain/zhuanqianExplain.jsp" params:nil];
    //    NSString *url = [NSString stringWithFormat:@"%@webView/explain/zhuanqianExplain.jsp",YXB_IP_ADRESS];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"宝赚钱说明"];
}

- (void)makeMoneyButtonAction:(UIButton *)button {
    if (button.tag == kElseButtonTag) {
//        [YXBTool showAlertViewWithString:@"产品即将上线敬请期待"];

//        http://60.195.254.33:8083/webView/user/otherLicai.jsp?t=1
        NSString *url = [YXBTool getURL:@"webView/user/otherLicai.jsp?t=1" params:nil];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"其它理财"];
        
    }else if (button.tag == kChargeButtonTag) {
        PayHomeViewController *pay = [[PayHomeViewController alloc] init];
        [self.navigationController pushViewController:pay animated:YES];
    }else if (button.tag == kCountButtonTag) {
        _jisuanview = [[CalculatorView alloc] initWithFrame:[[UIApplication sharedApplication].delegate window].bounds];
        _jisuanview.delegate = self;
        _jisuanview.lilv = self.data.interestRate;
        [[[UIApplication sharedApplication].delegate window] addSubview:_jisuanview];
    }
}

#pragma mark - UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%f",kCarouselCellHeight);
    if (indexPath.row == 0) {
        return kCarouselCellHeight;
    }else if (indexPath.row == 1) {
        return (_tableView.height-kCarouselCellHeight-30);

    }else if (indexPath.row == 2) {
        return 30;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *identifier = @"carouselCell";
        QCCarouselCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[QCCarouselCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        
        cell.data = _data;
        
        return cell;
    }else if (indexPath.row == 1){
        static NSString *identifier = @"twoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            _dynamicView = [[BaoDynamicView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _tableView.height-kCarouselCellHeight-30)];
            [cell.contentView addSubview:_dynamicView];
        }
        if (self.data.iProfitBannerData != nil) {
            _dynamicView.listData = _data.iProfitBannerData;
//            for (int i = 0; i < 5; i++) {
//                [_dynamicView.listData addObject:_data.iProfitBannerData[0]];
//            }
            if (_timerManager == nil) {
                [self createTimer];
            }
            
        }
        
        return cell;
        
    }else {
        static NSString *identifier = @"threeCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kDeviceWidth-40, 30)];
            label.textColor = [YXBTool colorWithHexString:@"#787777"];
            label.font = [UIFont systemFontOfSize:12];
            label.backgroundColor = [UIColor clearColor];
            label.tag = 1888;
            [cell.contentView addSubview:label];
        }
        
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:1888];
        NSString *text = [NSString stringWithFormat:@"宝·赚钱累计发放红包%@元",_data.moneyOfYXB];
        
        if (_data.moneyOfYXB.length != 0 && _data.moneyOfYXB != nil) {
            if (KDeviceOSVersion>5.0) {
                NSMutableAttributedString *moneyAttributString = [[NSMutableAttributedString alloc] initWithString:text];
                //设置字符串的样式   NSFontAttributeName:样式名称
                NSRange moneyRange = [text rangeOfString:_data.moneyOfYXB];
                [moneyAttributString addAttribute:NSForegroundColorAttributeName
                                            value:[YXBTool colorWithHexString:@"#DB2C2C"]
                                            range:moneyRange];
                [moneyAttributString addAttribute:NSFontAttributeName
                                            value:[UIFont systemFontOfSize:16]
                                            range:moneyRange];
                label.attributedText = moneyAttributString;
                
            }else {
                label.text = text;
            }
            
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - QCCarouselCell delegate
- (void)QCCarouselCell:(QCCarouselCell *)cell carouselClickedAtIndex:(NSInteger)index {
    // index == 0 红; index == 1 黄; index == 2 蓝
    BonusListController *bonus = [[BonusListController alloc] init];
    if (index == 0) {
        bonus.type = BonusListType;
    }else if (index == 1) {
        bonus.type = OtherListType;
    }else if (index == 2) {
        return;
    }
    
    [self.navigationController pushViewController:bonus animated:YES];
}

#pragma mark --- CalculatorViewDelegate
- (void)pushChongzhiWebView {
    //    NSString *payUrl = @"http://60.195.254.33:8083/charge/recharge.jsp?a=23";
    //    [YXBTool jumpSafariWithUrl:[YXBTool getURL:payUrl params:nil]];
    PayHomeViewController *pay = [[PayHomeViewController alloc] init];
    [self.navigationController pushViewController:pay animated:YES];
    
}

#pragma mark -----------------------------------------------Http
- (void)httpLoading
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCMakeMoneyViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        [this httpLoadParams:assginHtttperator];
    } complete:^(ProfitNewHomeData* r, int taskid) {
        
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{

    ProfitManager* manager = (ProfitManager*)  [assginHtttperator getAopInstance:[ProfitManager class] returnValue:[ProfitNewHomeData class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.user.yxbToken != nil) {
        
        [manager getProfitNewHomeData:userModel.user.yxbToken];
    }
    
}
- (void)httpLoadComplete:(ProfitNewHomeData *)r{
    if (r.errCode == 0) {
        self.data = r;
        
    }else{
        NSString * string = r.errString;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    
    [self.tableView reloadDeals];
    [self.tableView reloadData];
    
}




#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self httpLoading];
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



- (void)createTimer {
    _timerManager = [[CPBTimerManager alloc]initWithTimeInterval:2 userInfo:Nil repeats:YES];
    _timerManager.delegate = self;
    [self CPBTimerManagerAction:nil];
}

#pragma mark -- CPBTimerDelegate
- (void)CPBTimerManagerAction:(CPBTimerManager *)timer {
    NSLog(@"定时器方法 - indexPath.row:%ld",(long)postion);
    postion++;
    if (postion >= self.data.iProfitBannerData.count-1) {
        postion = 0;
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:postion inSection:0];
        [self.dynamicView.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        postion++;
        NSIndexPath *scrollIndexPath1 = [NSIndexPath indexPathForRow:postion inSection:0];
        [self.dynamicView.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath1 atScrollPosition:UITableViewScrollPositionTop animated:YES];

    }else {
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:postion inSection:0];
        [self.dynamicView.HomeLiseTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}
@end
