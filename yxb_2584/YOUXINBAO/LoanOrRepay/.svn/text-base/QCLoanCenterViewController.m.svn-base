//
//  QCLoanCenterViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCLoanCenterViewController.h"
#import "LoanCenterManager.h"
#import "QCLoanCell.h"
#import "QCLoanReceiptViewController.h"
#import "QCMainLoanReceiptViewController.h"

@interface QCLoanCenterViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate> {
    
    NSInteger currentPage;
    
}

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong)QCBaseTableView *tableView;

@end

@implementation QCLoanCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"借条中心"];
    
    _dataArray = [NSMutableArray new];
    
    _tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
    
}

- (void)httpDowload {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCLoanCenterViewController *this = self;
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
        [this httpLoadParams:assginHtttperator];
        
         } complete:^(NSSkyArray* r, int taskid) {
             [this httpLoadComplete:r];
        
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    LoanCenterManager* _loanM = (LoanCenterManager*)  [assginHtttperator getAopInstance:[LoanCenterManager class] returnValue:[NSSkyArray class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    [_loanM getTLoanCenterListByUserInfoAndQueryType:userModel.user.yxbToken role:0 query:0 page:currentPage];


}

- (void)httpLoadComplete:(NSSkyArray *)r{
    
    [self.tableView reloadDeals];
    if (r.errCode == 0) {
        if (r.iArray.count>0) {
            [self.dataArray addObjectsFromArray:r.iArray];
            self.tableView.tableFooterView = nil;
        }else{
            if (currentPage == 1)
            {
                
                UILabel *nullImage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _tableView.height)];
                nullImage.text = @"暂无数据";
                nullImage.textColor = [UIColor blueColor];
                nullImage.textAlignment = NSTextAlignmentCenter;
                self.tableView.tableFooterView = nullImage;
                
            }
            
            else
            {
                self.tableView.tableFooterView = nil;
                
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
                
                
            }
            else
            {
                self.tableView.tableFooterView = nil;
            }
            
            
        }
        
        else
        {
            self.tableView.tableFooterView = nil;
            
        }
    }
    
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.tableView.hasFooter = YES;
    }else {
        self.tableView.hasFooter = NO;
    }
    
    [self.tableView reloadData];
    

}


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
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"loanCell";
    QCLoanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QCLoanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (self.dataArray.count != 0) {
        cell.loanBrief = [self.dataArray objectAtIndex:indexPath.row];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QCMainLoanReceiptViewController* con = [[QCMainLoanReceiptViewController alloc] init];
    con.brief = [self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:con animated:YES];
//    QCLoanReceiptViewController *receiptVC = [[QCLoanReceiptViewController alloc] init];
//    [self.navigationController pushViewController:receiptVC animated:YES];
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
