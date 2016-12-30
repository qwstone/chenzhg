//
//  QCBoardViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/10.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBoardViewController.h"
#import "QCBoardCell.h"
#import "TCreditCenterManager.h"
#import "QCUserDetailView.h"

@interface QCBoardViewController ()<QCBaseTableViewDelegate,QCBoardCellDelegate> {
    
    
    QCUserDetailView *_userDetail;
}

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation QCBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    if (self.type == QCBoardTypeHuoYue) {
        [self setTitle:@"活跃度"];
    }else if (self.type == QCBoardTypeRenYuan) {
        [self setTitle:@"人缘榜"];
    }else if (self.type == QCBoardTypeShiXin) {
        [self setTitle:@"失信榜"];
    }else if (self.type == QCBoardTypeHaoZhaoLi) {
        [self setTitle:@"号召力榜"];
    }else if (self.type == QCBoardTypeYiQi) {
        [self setTitle:@"义气榜"];
    }else if (self.type == QCBoardTypeTuHao) {
        [self setTitle:@"土豪榜"];
    }
    _tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64)    style:UITableViewStylePlain refreshFooter:NO];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    [self.view insertSubview:_tableView belowSubview:_alphaView];
//    [self.view addSubview:_tableView];
    
    _alphaView.backgroundColor = rgb(1, 1, 1, .8);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alphaTapAction:)];
    [_alphaView addGestureRecognizer:tap];
    
    _userDetail = [[QCUserDetailView alloc] initWithFrame:CGRectMake((kDeviceWidth-310)/2, (kDeviceHeight-220)/2-64, 310, 220)];
    [_alphaView addSubview:_userDetail];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self httpDowload];
}

#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpDowload {
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCBoardViewController *this = self;
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

    
    TCreditCenterManager* _creditM = (TCreditCenterManager*)  [assginHtttperator getAopInstance:[TCreditCenterManager class] returnValue:[NSSkyArray class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    [_creditM getTCreditCenterRankListByCategory:userModel.user.t_id category:self.type];

}
- (void)httpLoadComplete:(NSSkyArray *)r{

    
    if (r.errCode == 0) {
        if (r.iArray.count>0) {
            self.dataArray = r.iArray;
        }else{
            [self.dataArray removeAllObjects];
        }
        
    }else{
        [self.dataArray removeAllObjects];
        
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alert show];
    }
    [self.tableView reloadDeals];
    [self.tableView reloadData];


}


#pragma mark - UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kBoardUserHeight+10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (_dataArray.count+1)/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"boardCell";
    QCBoardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QCBoardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    cell.dataArr = self.dataArray;
    cell.row = indexPath.row;
    
    return cell;
}

#pragma mark - QCBoardCell delegate
- (void)QCBoardCellUserDidClick:(QCBoardUserView *)userView {
    _alphaView.hidden = NO;
    _userDetail.creditCenter = userView.creditCenter;
}

- (void)alphaTapAction:(UITapGestureRecognizer *)tap {
    _alphaView.hidden = YES;
}

- (void)leftClicked {
    [self.navigationController popViewControllerAnimated:YES];
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
