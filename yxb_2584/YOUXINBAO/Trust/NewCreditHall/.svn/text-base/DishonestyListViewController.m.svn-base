//
//  DishonestyListViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "DishonestyListViewController.h"
#import "DishonestyTableViewCell.h"
#import "DishonestBoard.h"
#import "TDishonestBoardManager.h"
#import "YXBTool.h"
#import "QCSearchDishonestController.h"
#import "CreditCenterManager.h"
#define SearchDishonestMenuControllerSearchHolder @"  身份证号/手机号"
@interface DishonestyListViewController ()
{
    UITextField *contactfield;

}

@end

@implementation DishonestyListViewController
-(void)dealloc{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
        self.page = 1;
    [self createView];
    [_tableView reloadDeals];

}


- (void)createView{
    [self setTitle:@"失信榜"];
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kDeviceWidth, 45)];
    view1.backgroundColor = [UIColor whiteColor];
    _searchBar = [[QCSearchBar alloc]initWithFrame: CGRectMake(15, 7.5, kDeviceWidth-15*2, 30)];
    _searchBar.delegate = self;
    _searchBar.textField.placeholder=SearchDishonestMenuControllerSearchHolder;
    [view1 addSubview:_searchBar];
    _tableView.tableHeaderView = view1;
    


    _NoDataLabel = [[UILabel alloc ]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 60)];
    _NoDataLabel.textAlignment = NSTextAlignmentCenter;
    _NoDataLabel.numberOfLines = 0;
    _NoDataLabel.textColor = [YXBTool colorWithHexString:@"969694"];
    _NoDataLabel.center = _tableView.center;
    _NoDataLabel.top -= 64;
    _NoDataLabel.text = @"无忧借条全部注册用户均无失信记录\n这里全部都是讲诚信的人哦!";
    [self.tableView addSubview:_NoDataLabel];
    
    self.nodataimg = [[UIImageView alloc] initWithFrame:CGRectMake(0,_NoDataLabel.bottom+64, kDeviceWidth, kDeviceWidth/489*109)];
    self.nodataimg.contentMode = UIViewContentModeCenter;
    self.nodataimg.image = [UIImage imageNamed:@"sxtxt"];
    [self.tableView addSubview:self.nodataimg];
}

#pragma mark ---- tableviewDelegate

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    self.page = 1;
    [self requestData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>=scrollView.frame.size.height+30 && !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        if (_dataArray.count%20==0) {
            self.page ++;
            [self requestData];
        }
        else
        {
            [self.tableView reloadDeals];
        }
    }
    
}


#pragma mark --- tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 65;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellID";
    DishonestyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == Nil) {
        cell = [[DishonestyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectedBackgroundView = [[UIView alloc]init];
        cell.selectedBackgroundView.backgroundColor = rgb(255, 221, 201, 0.5);
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



#pragma mark --- request
- (void)requestData {

    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = self.iHttpOperator;
    __weak DishonestyListViewController *this = self;
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
    } complete:^(NSSkyArray* r, int taskid) {
        
        [this httpLoadComplete:r];
        
    }];
    [self.iHttpOperator connect];
    
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
//    TDishonestBoardManager* _creditM = (TDishonestBoardManager*)  [httpOperation getAopInstance:[TDishonestBoardManager class] returnValue:[NSSkyArray class]];
    CreditCenterManager* _creditM = (CreditCenterManager*)  [httpOperation getAopInstance:[CreditCenterManager class] returnValue:[NSSkyArray class]];

    //        [_creditM getAllTDishonestBoardRecord:self.page];
    QCUserModel *modeluser = [[QCUserManager sharedInstance] getLoginUser];
    if (modeluser.user.yxbToken != nil) {
        
        [_creditM getAllTDishonestBoardRecord:modeluser.user.yxbToken page:self.page];
    }
}
//请求完成
-(void)httpLoadComplete:(NSSkyArray *)r{
    if (r.errCode == 0) {
        self.tableView.hasFooter = YES;
        if (self.page == 1) {
            [_dataArray removeAllObjects];
            _dataArray = ((NSSkyArray*)r).iArray;
        }else{
            [_dataArray addObjectsFromArray:((NSSkyArray*)r).iArray];
        }
        if (_dataArray.count%20!=0) {
            self.tableView.hasFooter = NO;
        }
        if (_dataArray.count <= 0) {
            self.tableView.hasFooter = NO;
        }
        
        if (_dataArray.count <= 0) {
            self.nodataimg.hidden = NO;
            _NoDataLabel.hidden = NO;
        }else {
            self.nodataimg.hidden = YES;
            _NoDataLabel.hidden = YES;
        }
    }else{
        self.tableView.hasFooter = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    [self.tableView reloadDeals];
    [self.tableView reloadData];
}
//#pragma QCSearchBarDelegate
- (void)QCSearchBarDidBeginEditing:(QCSearchBar *)searchBar {
    [_searchBar resignFirstResponder];
    QCSearchDishonestController  * controller = [[QCSearchDishonestController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}




@end
