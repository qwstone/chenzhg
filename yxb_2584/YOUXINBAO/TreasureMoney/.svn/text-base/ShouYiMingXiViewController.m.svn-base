//
//  ShouYiMingXiViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/9/23.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ShouYiMingXiViewController.h"
#import "ProfitManagerV2.h"
#import "NSSkyArray.h"
#import "MingxiNewCell.h"
#import "YXBTool.h"
#import "QCUtils.h"

@implementation ShouYiMingXiViewController

- (void)dealloc {

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"我的红包";
    [self setBackView];

    [self createView];
}


- (void)createView {
    self.page = 1;
    self.dataArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [YXBTool colorWithHexString:@"#f2f2f2"];
//    NSArray *arr = [[NSArray alloc]initWithObjects:@"红包记录",@"理财记录", nil];
//    self.segment = [[UISegmentedControl alloc]initWithItems:arr];
//    [self.segment setTintColor:[YXBTool colorWithHexString:@"#e32f4e"]];
//    self.segment.backgroundColor = [UIColor whiteColor];
//    self.segment.selectedSegmentIndex = 0;
//    self.segment.layer.cornerRadius = 5.0;
//    self.segment.frame = CGRectMake(10, 10, kDeviceWidth-20, 40);
//    [self.segment addTarget:self action:@selector(segmentchange:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:self.segment];
//
    //当前日期
    NSDate *now = [NSDate date];
    NSString * formate = @"yyyyMM";
    NSString *dateString = [QCUtils stringFromDate:now formate:formate];
    NSInteger year = [[dateString substringWithRange:NSMakeRange(0, 4)] integerValue];
    NSInteger month = [[dateString substringWithRange:NSMakeRange(4, 2)] integerValue];
    self.year = [NSString stringWithFormat:@"%ld",(long)year];
    self.mouth = [NSString stringWithFormat:@"%ld",(long)month];
    viewheader = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
    viewheader.backgroundColor = [YXBTool colorWithHexString:@"fbf9f9"];
    [viewheader addTarget:self action:@selector(topButAction) forControlEvents:UIControlEventTouchUpInside];
    _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3, 0, 100, 50)];
    _topLabel.text = [NSString stringWithFormat:@"%ld年%ld月",(long)year,(long)month];
    _topLabel.tag = 123456;
    _topLabel.textAlignment = NSTextAlignmentCenter;
    _topLabel.font = [UIFont systemFontOfSize:23];
    _topLabel.textColor = rgb(179, 179, 179, 1);
    [_topLabel setAdjustsFontSizeToFitWidth:YES];
    [viewheader addSubview:_topLabel];
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/3+110, 22, 12, 6)];
    _topImageView.image = [UIImage imageNamed:@"newbzq-down-icon"];
    _topImageView.tag = 654321;
    [viewheader addSubview:_topImageView];
    
    [self.view addSubview:viewheader];
//    _tableView.tableHeaderView = viewheader;
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0,viewheader.bottom, kDeviceWidth, kDeviceHeight-64-viewheader.bottom) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [self httpLoading];
    
    
    _wushujiimg = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-176/2)/2, 100, 176/2, 233/2)];
    _wushujiimg.image = [UIImage imageNamed:@"wujl"];
    [_tableView addSubview:_wushujiimg];
    _wushujiimg.hidden = YES;
    
    _wushujiimglicai = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-176/2)/2, 100, 176/2, 233/2)];
    _wushujiimglicai.center = self.view.center;
    _wushujiimglicai.image = [UIImage imageNamed:@"wujl"];
    [self.view addSubview:_wushujiimglicai];
    _wushujiimglicai.hidden = YES;
}

//-(void)segmentchange:(UISegmentedControl *)Seg{
//    NSInteger Index = Seg.selectedSegmentIndex;
//    NSLog(@"Index %ld", (long)Index);
//    switch (Index) {
//        case 0:
//            _tableView.hidden = NO;
//            viewheader.hidden = NO;
//            _wushujiimglicai.hidden = YES;
//            break;
//        case 1:
//            _tableView.hidden = YES;
//            viewheader.hidden = YES;
//            _wushujiimglicai.hidden = NO;
//            break;
//    }
//}

- (void)topButAction {
    [self imgtoujiantouUp];

    if (_timePicker == nil) {
        _timePicker = [[MouthPickerView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-64, kDeviceWidth, kTimeCustomHeight) withHour:NO];
        __weak ShouYiMingXiViewController *this = self;
        __weak UILabel *time = (UILabel *)[self.view viewWithTag:123456];
        _timePicker.selectedBlock = ^ (NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minIndexppp, MouthPickerView *timePickerView) {
            this.year = [NSString stringWithFormat:@"%ld",(long)year];
            this.mouth = [NSString stringWithFormat:@"%ld",(long)month];
            this.page = 1;
            [this httpLoading];
            time.text = [NSString stringWithFormat:@"%ld年%ld月",(long)year,(long)month];

            [this imgtoujiantouUp];
        };
        _timePicker.caeclSelectBlock = ^ (NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minIndexppp, MouthPickerView *timePickerView) {
            [this imgtoujiantouUp];
        };
        [self.view addSubview:_timePicker];
    }
    
    [_timePicker showPickerView];
}
#pragma mark -- _imgtoJiantou 动画
- (void)imgtoujiantouUp {
    if (self.isShow == YES) {
        [self imgtoujiantouDown];
    }else {
    
        UIImageView * ImageView = (UIImageView *)[self.view viewWithTag:654321];
        [UIView animateWithDuration:0.5f animations:^{
            [ImageView.layer setTransform:CATransform3DMakeRotation(M_PI, 1, 0, 0)];
        } completion:^(BOOL finished) {
                    self.isShow = YES;
        }];
    }
}
- (void)imgtoujiantouDown {

    UIImageView * ImageView = (UIImageView *)[self.view viewWithTag:654321];
    [UIView animateWithDuration:0.5f animations:^{
        ImageView.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
            self.isShow = NO;
    }];
}

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    self.page = 1;
    [self httpLoading];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"%ld",(long)scrollView.contentOffset.y);
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    NSLog(@"%f",h);
    if (h>=30 && !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        if (_dataArray.count%20==0) {
            self.page ++;
            [self httpLoading];
        }
        else
        {
            [self.tableView reloadDeals];
        }
    }
    
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;

   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellss";
    MingxiNewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MingxiNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.layer.borderColor = [YXBTool colorWithHexString:@"#efefef"].CGColor;
        cell.layer.borderWidth = 0.5;
        
        
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = rgb(225, 39, 39, 1);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth/2, 30)];
    label.text = @"时间";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 0, kDeviceWidth/2, 30)];
    label1.text = @"红包";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont boldSystemFontOfSize:17];
    label1.textColor = [UIColor whiteColor];
    [view addSubview:label1];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
#pragma mark -----------------------------------------------Http
- (void)httpLoading
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak ShouYiMingXiViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        [this httpLoadParams:assginHtttperator];
    } complete:^(NSSkyArray* r, int taskid) {
        [this httpLoadComplete:r];
       
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    
    ProfitManagerV2* manager = (ProfitManagerV2*)  [assginHtttperator getAopInstance:[ProfitManagerV2 class] returnValue:[NSSkyArray class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [manager getNewProfitList:userModel.user.yxbToken pageNum:self.page year:self.year month:self.mouth];
}
- (void)httpLoadComplete:(NSSkyArray *)r{

    if (r.errCode == 0) {
        if (self.page == 1) {
            [_dataArray removeAllObjects];
            _dataArray = ((NSSkyArray*)r).iArray;
        }else{
            [_dataArray addObjectsFromArray:((NSSkyArray*)r).iArray];
        }
        if (((NSSkyArray*)r).iArray.count != 0 && ((NSSkyArray*)r).iArray.count%20 == 0) {
            self.tableView.hasFooter = YES;
        }else {
            self.tableView.hasFooter = NO;
        }
        //            [_dataArray removeAllObjects];
        if (_dataArray.count <= 0) {
            _wushujiimg.hidden = NO;
        }else {
            _wushujiimg.hidden = YES;
        }
        
        
    }else{
        NSString * string = r.errString;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    
    [self.tableView reloadData];
    [self.tableView reloadDeals];
}
@end
