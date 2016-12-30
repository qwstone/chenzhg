//
//  QCCheckDetailViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCCheckDetailViewController.h"
#import "TFundDetailManager.h"
#import "TFundDetailItem.h"


@interface QCCheckDetailViewController ()<UITableViewDataSource,UITableViewDelegate> {
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation QCCheckDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIView *titleBtn = [self.navigationController.navigationBar viewWithTag:NavigationBarTitleBtnTag];
    if (titleBtn != nil) {
        titleBtn.hidden = YES;
        
    }
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"账单详情"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, kDeviceWidth, kDeviceHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    [self httpDownload];
}

- (void)leftClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpDownload
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCCheckDetailViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        [this httpLoadParams:assginHtttperator];
        
    } complete:^(NSSkyArray* r, int taskid) {
        
        [this httpLoadComplete:r];
        
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    
    TFundDetailManager* _fundM = (TFundDetailManager*)  [assginHtttperator getAopInstance:[TFundDetailManager class] returnValue:[NSSkyArray class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (_fundId != 0) {
        [_fundM getFundDecipherByID:userModel.user.yxbToken fundID:_fundId];
        
    }

}
- (void)httpLoadComplete:(NSSkyArray *)r{
    if (r.errCode == 0) {
        if (r.iArray.count>0) {
            self.dataArray = r.iArray ;
            
        }else{
            //                [_dataArray removeAllObjects];
        }
        
    }else if (r.errCode == 7) {
        
    }else {
        [self.dataArray removeAllObjects];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    [self.tableView reloadData];
    

}

- (CGFloat)getCellHeightWithIndex:(NSInteger)index {
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = CGSizeMake(kDeviceWidth-100, 29999);
    TFundDetailItem *item = [_dataArray objectAtIndex:index];
    NSString *text = item.contentStr;
    
    if (KDeviceOSVersion >= 7.0)
    {
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        
        size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    }
    else
    {
        NSDictionary *dic = @{NSFontAttributeName:font};

//        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        size = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    }
    
    return size.height+20;
}

#pragma mark - UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self getCellHeightWithIndex:indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellId = @"detailCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor clearColor];
        UILabel *topic = [[UILabel alloc] initWithFrame:CGRectZero];
        topic.backgroundColor = [UIColor clearColor];
        topic.tag = 10000+indexPath.row;
        topic.font = [UIFont systemFontOfSize:14];
        topic.textColor = [UIColor blackColor];
        [cell.contentView addSubview:topic];
        
        UILabel *detail = [[UILabel alloc] initWithFrame:CGRectZero];
        detail.backgroundColor = [UIColor clearColor];
        detail.numberOfLines = 0;
        detail.tag = 20000+indexPath.row;
        detail.font = [UIFont systemFontOfSize:14];
        detail.textColor = [UIColor blackColor];
        [cell.contentView addSubview:detail];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CGFloat cellHeight = [self getCellHeightWithIndex:indexPath.row];
    TFundDetailItem *item = [_dataArray objectAtIndex:indexPath.row];
    
    UILabel *topic = (UILabel *)[cell.contentView viewWithTag:10000+indexPath.row];
    topic.frame = CGRectMake(10, (cellHeight-20)/2, 100, 20);
    topic.text = item.titleStr;
    
    UILabel *detail = (UILabel *)[cell.contentView viewWithTag:20000+indexPath.row];
    detail.frame = CGRectMake(90, 10, kDeviceWidth-100, cellHeight-20);
    detail.text = item.contentStr;
    
    return cell;
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
