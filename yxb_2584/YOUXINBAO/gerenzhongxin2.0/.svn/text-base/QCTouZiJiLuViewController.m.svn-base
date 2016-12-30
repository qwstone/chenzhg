//
//  QCTouZiJiLuViewController.m
//  YOUXINBAO
//
//  Created by 密码是111 on 16/7/25.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCTouZiJiLuViewController.h"
#import "TouZiJiLuCell.h"
#import "QCMessageCell.h"
#import "YXBTool.h"
#import "UserManager.h"
#import "FinancialManagerV2.h"
#import "HttpOperator.h"
#import "MyAssetListDetail.h"
#import "QCTouZiJiLuXiangQingViewController.h"


@interface QCTouZiJiLuViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate>
@property (nonatomic,strong)QCBaseTableView *tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) NSMutableArray * cellHeightArray;
@property (retain, nonatomic) HttpOperator* iHttpOperator;





@end

@implementation QCTouZiJiLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    page =1;
    [self setTitle:@"投资记录"];
    self.view.backgroundColor = kRGB(238, 236, 246);
    _dataArray = [NSMutableArray new];
    self.cellHeightArray = [NSMutableArray array];
    [self _initViews];

}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self requestData];
    [super viewWillAppear:YES];
}
-(void)requestData
{
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    if (userModel.isLogin == YES) {
        //        [self httpLoading];
    }else {
        [self toLogin];
    }
    
}
- (void)_initViews{
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.allowsSelection=NO;
    [self.view addSubview:_tableView];

}
#pragma mark   UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kDeviceWidth/640*248;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"TouZiJiLuCell";
    TouZiJiLuCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];

    if (cell == nil) {
        cell = [[TouZiJiLuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if ((indexPath.row < [_dataArray count]) && (indexPath.row < [_cellHeightArray count])) {
       cell.model = [_dataArray objectAtIndex:indexPath.row];
//        cell.detailHeight = [_cellHeightArray[indexPath.row] floatValue];
    }
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
   MyAssetListItem *model = [_dataArray objectAtIndex:indexPath.row];
   QCTouZiJiLuXiangQingViewController *XiangQingVC = [[QCTouZiJiLuXiangQingViewController alloc] init];
   XiangQingVC.recordID = model.recordId;
   [self.navigationController pushViewController:XiangQingVC animated:YES];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>=scrollView.frame.size.height && !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        if (_dataArray.count%20==0) {
            page ++;
            [self httpDowload];
        }else {
            
        }
    }
    
}

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    page = 1;
    [self httpDowload];
}
////刷新数据
//- (void)refreshData {
//    page = 1;
////    if (self.type == BonusListType) {
////        [self httpDowloadWithBonusListType:BonusListType];
////        
////    }else if (self.type == OtherListType) {
////        [self httpDowloadWithBonusListType:OtherListType];
////    }
//}


#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpDowload
{
      if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCTouZiJiLuViewController *this = self;
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

- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation{
    
    FinancialManagerV2 *_fundM = (FinancialManagerV2 *)[httpOperation getAopInstance:[FinancialManagerV2 class] returnValue:[NSSkyArray class]];
     QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *token = @"";
    token = userModel.user.yxbToken;
    if (token == nil) {
        token = @"";
    }
    [_fundM getMyAssetList:token pageNum:page];
    
    
}
- (void)httpLoadComplete:(NSSkyArray *)r{
    
    if (r.errCode == 0) {
        if (r.iArray.count>0) {
            [self makeCellHeightArrayWithArray:r.iArray];
            
            if (page>1) {
                [self.dataArray addObjectsFromArray:r.iArray];
                
            }else{
//                NSString*ID=AssetListDetail.assetTitle;
                self.dataArray = r.iArray ;
            }
            
            _tableView.tableFooterView = [UIView new];
            
            
        }else{
            if (page == 1) {
                UILabel *nullImage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _tableView.height)];
                nullImage.text = @"暂无数据";
                nullImage.textColor = [UIColor blueColor];
                nullImage.textAlignment = NSTextAlignmentCenter;
                _tableView.tableFooterView = nullImage;
                
                
            }
            else
            {
                _tableView.tableFooterView = [UIView new];
                
            }
        }
        
    }else if (r.errCode == 7) {
        if (page == 1) {
            UILabel *nullImage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _tableView.height)];
            nullImage.text = @"暂无数据";
            nullImage.textColor = [UIColor blueColor];
            nullImage.textAlignment = NSTextAlignmentCenter;
            _tableView.tableFooterView = nullImage;
            
            
        }
        else
        {
            _tableView.tableFooterView = [UIView new];
            
        }
        
    }else {
        [self.dataArray removeAllObjects];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.tableView.hasFooter = YES;
    }else {
        self.tableView.hasFooter = NO;
    }
    
    //        [this reloadSubviews:r.iArray.count];
    [self.tableView reloadDeals];
    [self.tableView reloadData];
    
}

#pragma mark - Private Methods

-(void)makeCellHeightArrayWithArray:(NSMutableArray *)dataArray
{
    CGFloat width = kDeviceWidth - 150;
    if (page == 1) {
        [_cellHeightArray removeAllObjects];
    }
    for (MyAssetListItem *detail in dataArray) {
        NSString *detailStr = detail.assetTitle;
        CGSize size = [YXBTool getFontSizeWithString:detailStr font:[UIFont systemFontOfSize:15.0] constrainSize:CGSizeMake(width, CGFLOAT_MAX)];
        
        [_cellHeightArray addObject:[NSString stringWithFormat:@"%f",size.height]];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
