//
//  MyzhangbenViewController.m
//  YOUXINBAO
//
//  Created by Walice on 15/12/14.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "MyzhangbenViewController.h"
#import "SelectView.h"
#import "YXBTool.h"
#import "NSSkyArray.h"
#import "ProfitManagerV3.h"
#import "ProfitUserSummarize.h"
#import "LicaijiluCell.h"
#import "yuejiluCell.h"
#import "FundDetailHomeViewController.h"

#define pageNOStart 1
@interface MyzhangbenViewController ()

@end

@implementation MyzhangbenViewController


- (void)dealloc {
    NSLog(@"我的账本 dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的账本";
    [self setBackView];
    [self createView];
    page=pageNOStart;
    [self httpLoadWithType];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self refreshData];
}


- (void)createView{
    
    //(1)理财赚钱记录
    _dataArray = [NSMutableArray new];
    //上部选择selectTab
    NSArray *arr = @[@"理财赚钱记录",@"余额收益记录"];
    SelectView *selectTab = [[SelectView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 49) WithArray:arr imgArray:nil imgArraylight:nil];
    selectTab.delegate =self;
    [self.view addSubview:selectTab];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, 12, 1,25)];
    line1.backgroundColor = rgb(220, 220, 220, 1);
    [selectTab addSubview:line1];
    //中部view,middleView
    middleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 110)];
    UILabel *numLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 26, kDeviceWidth, 44)];
    numLabel.textAlignment=NSTextAlignmentCenter;
    numLabel.textColor=rgb(237, 46, 36, 1);
    numLabel.text=@"";
    numLabel.tag=1001;
    numLabel.font=[UIFont systemFontOfSize:44];
    UILabel *desLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, numLabel.bottom+17, kDeviceWidth, 15)];
    desLabel.textAlignment=NSTextAlignmentCenter;
    desLabel.text=@"明日预期收益(元)";
    desLabel.font=[UIFont systemFontOfSize:15];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(18, desLabel.bottom+22,kDeviceWidth-36,1)];
    line2.backgroundColor = rgb(220, 220, 220, 1);
    [middleView addSubview:line2];
    [middleView addSubview:numLabel];
    [middleView addSubview:desLabel];
    //三个小部分,thirdView
    thirdView=[[UIView alloc]initWithFrame:CGRectMake(18, middleView.bottom, kDeviceWidth-36, 100)];
    LicaiButton *dongjie=[[LicaiButton alloc]initWithFrame:CGRectMake(0, 10, kDeviceWidth/3, 100)];
    dongjie.tag=1002;
    [dongjie setMoneyButtonWithMoney:@"" name:@"理财冻结金额"];
    [thirdView addSubview:dongjie];
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(dongjie.right, 20, 1, 70)];
    line3.backgroundColor = rgb(220, 220, 220, 1);
    [thirdView addSubview:line3];
    
    LicaiButton *weidaozhang=[[LicaiButton alloc]initWithFrame:CGRectMake(dongjie.right, 10, (kDeviceWidth-18)/3, 100)];
    weidaozhang.tag=1003;
    [weidaozhang setMoneyButtonWithMoney:@"" name:@"未到账收益"];
    [thirdView addSubview:weidaozhang];
    UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(weidaozhang.right, 20, 1, 70)];
    line4.backgroundColor = rgb(220, 220, 220, 1);
    [thirdView addSubview:line4];
    LicaiButton *licaizong=[[LicaiButton alloc]initWithFrame:CGRectMake(weidaozhang.right, 10, (kDeviceWidth-18)/3, 100)];
    licaizong.tag=1004;
    [licaizong setMoneyButtonWithMoney:@"" name:@"理财总收益"];
    [thirdView addSubview:licaizong];
    //第四部分
    UIView *fourThView=[[UIView alloc]initWithFrame:CGRectMake(0, thirdView.bottom, kDeviceWidth, 40)];
    fourThView.backgroundColor=[UIColor redColor];
    UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(0, 13, kDeviceWidth/4, 14)];
    time.text=@"时间";
    time.textAlignment=NSTextAlignmentCenter;
    time.font=[UIFont systemFontOfSize:13];
    time.textColor=[UIColor whiteColor];
    UILabel *type=[[UILabel alloc]initWithFrame:CGRectMake(time.right, 13, kDeviceWidth/4, 14)];
    type.text=@"产品类型";
    type.textAlignment=NSTextAlignmentCenter;
    type.font=[UIFont systemFontOfSize:13];
    type.textColor=[UIColor whiteColor];
    UILabel *buy=[[UILabel alloc]initWithFrame:CGRectMake(type.right, 13, kDeviceWidth/4, 14)];
    buy.textAlignment=NSTextAlignmentCenter;
    buy.text=@"购买金额";
    buy.font=[UIFont systemFontOfSize:13];
    buy.textColor=[UIColor whiteColor];
    UILabel *status=[[UILabel alloc]initWithFrame:CGRectMake(buy.right, 13, kDeviceWidth/4, 14)];
    status.textAlignment=NSTextAlignmentCenter;
    status.font=[UIFont systemFontOfSize:13];
    status.text=@"产品状态";
    status.textColor=[UIColor whiteColor];
    [fourThView addSubview:time];
    [fourThView addSubview:type];
    [fourThView addSubview:buy];
    [fourThView addSubview:status];
    
    
    view1=[[UIView alloc]initWithFrame:CGRectMake(0, selectTab.bottom, kDeviceWidth,250)];
    [view1 addSubview:middleView];
    [view1 addSubview:thirdView];
    [view1 addSubview:fourThView];
    
    //(2)余额收益记录
    view2=[[UIView alloc]initWithFrame:CGRectMake(0, selectTab.bottom, kDeviceWidth,117)];
    UILabel *labelText=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 25)];
    labelText.textColor=rgb(237, 46, 36, 1);
    labelText.font=[UIFont systemFontOfSize:12];
    labelText.adjustsFontSizeToFitWidth=YES;
    labelText.minimumScaleFactor=8.0/labelText.font.pointSize;
    labelText.textAlignment=NSTextAlignmentCenter;
    labelText.tag=1005;
    [view2 addSubview:labelText];
    
    //当前日期
    NSDate *now = [NSDate date];
    NSString * formate = @"yyyyMM";
    NSString *dateString = [QCUtils stringFromDate:now formate:formate];
    NSInteger year = [[dateString substringWithRange:NSMakeRange(0, 4)] integerValue];
    NSInteger month = [[dateString substringWithRange:NSMakeRange(4, 2)] integerValue];
    self.year = [NSString stringWithFormat:@"%ld",(long)year];
    self.mouth = [NSString stringWithFormat:@"%ld",(long)month];
    viewheader = [[UIButton alloc] initWithFrame:CGRectMake(0, labelText.bottom, kDeviceWidth, 50)];
    viewheader.backgroundColor = [YXBTool colorWithHexString:@"fbf9f9"];
    [viewheader addTarget:self action:@selector(topButAction) forControlEvents:UIControlEventTouchUpInside];
    _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3, 0, 100, 50)];
    _topLabel.text = [NSString stringWithFormat:@"%ld年%ld月",(long)year,(long)month];
    _topLabel.tag = 123456;
    _topLabel.textAlignment = NSTextAlignmentCenter;
    _topLabel.font = [UIFont systemFontOfSize:23];
    _topLabel.textColor = [UIColor blackColor];
    [_topLabel setAdjustsFontSizeToFitWidth:YES];
    [viewheader addSubview:_topLabel];
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth/3+110, 22, 12, 6)];
    _topImageView.image = [UIImage imageNamed:@"newbzq-down-icon"];
    _topImageView.tag = 654321;
    [viewheader addSubview:_topImageView];
    [view2 addSubview:viewheader];
    
    UIView *desView=[[UIView alloc]initWithFrame:CGRectMake(0, viewheader.bottom, kDeviceWidth, 34)];
    desView.backgroundColor=[UIColor redColor];
    UILabel *time1=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, kDeviceWidth/2, 15)];
    time1.textAlignment=NSTextAlignmentCenter;
    time1.textColor=[UIColor whiteColor];
    time1.text=@"时间";
    [desView addSubview:time1];
    UILabel *shoyi1=[[UILabel alloc]initWithFrame:CGRectMake(time1.right, 10, kDeviceWidth/2, 15)];
    shoyi1.textAlignment=NSTextAlignmentCenter;
    shoyi1.text=@"收益";
    shoyi1.textColor=[UIColor whiteColor];
    [desView addSubview:shoyi1];
    [view2 addSubview:desView];
    

    noDataLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, _tableView.height)];
    noDataLabel.text=@"暂无数据";
    noDataLabel.textAlignment=NSTextAlignmentCenter;
    noDataLabel.contentMode=UIViewContentModeCenter;
    noDataLabel.textColor=[UIColor blueColor];
    noDataLabel.backgroundColor=[UIColor clearColor];
    
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0,49, kDeviceWidth, kDeviceHeight-64-49) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.tableHeaderView=view1;
    [self.view addSubview:_tableView];
    
    
}

#pragma SelectViewDelegate
- (void)SelectViewSelectedIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
    [self.dataArray removeAllObjects];
    if ([self.delegate respondsToSelector:@selector(TreasureMoneyNewCell:)]) {
        [self.delegate TreasureMoneyNewCell:index];
    }
    if (index == 0) {
        _tableView.tableHeaderView=view1;
        self.type=LicaiType;
    }else if (index ==1) {
        _tableView.tableHeaderView=view2;
        self.type=YueType;
    }
    [self refreshData];
}

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self refreshData];
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@"ccc--%f",scrollView.contentOffset.y);
//
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    
    // NSLog(@"ddd%f",scrollView.contentOffset.y);
    if (h >= 30&& !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        
        if (_dataArray.count%20==0) {
            page++;
            [self httpDowloadWithBonusListType:_type];
        }
        else
        {
            [self.tableView reloadDeals];
            
        }
    }
}

//刷新数据
- (void)refreshData {
    page = 1;
    if (self.type == LicaiType) {
        [self httpDowloadWithBonusListType:LicaiType];
        
    }else if (self.type == YueType) {
        [self httpDowloadWithBonusListType:YueType];
    }
}

#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpLoadWithType{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak MyzhangbenViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
    } param:^(NSString *s) {
        
        [this httpLoadParamsOne:s assginHtttperator:assginHtttperator];
        
    } complete:^(ProfitUserSummarize * r, int taskid) {
        
        [this httpLoadCompleteOne:r];
        
    }];
    [self.iHttpOperator connect];
    
    
}
- (void)httpLoadParamsOne:(NSString *)s assginHtttperator:(HttpOperator *)assginHtttperator{
    
    ProfitManagerV3 *manager = (ProfitManagerV3 *)[assginHtttperator getAopInstance:[ProfitManagerV3 class] returnValue:[ProfitUserSummarize class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {
        
        [manager getProfitUserSummarize:userToken];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
}
- (void)httpLoadCompleteOne:(ProfitUserSummarize *)r{
    if (r.errCode==0) {
        UILabel *label1=[middleView viewWithTag:1001];
        label1.text=[NSString stringWithFormat:@"%@",r.earningTomorrow];
        LicaiButton *button2=[thirdView viewWithTag:1002];
        [button2 setMoneyButtonWithMoney:[NSString stringWithFormat:@"%@",r.frozenMoney] name:@"理财冻结金额(元)"];
        LicaiButton *button3=[thirdView viewWithTag:1003];
        [button3 setMoneyButtonWithMoney:[NSString stringWithFormat:@"%@",r.noToTheAccountMoney] name:@"未到账收益(元)"];
        LicaiButton *button4=[thirdView viewWithTag:1004];
        [button4 setMoneyButtonWithMoney:[NSString stringWithFormat:@"%@",r.sumMoney] name:@"理财总收益(元)"];
        UILabel *labell=[view2 viewWithTag:1005];
        labell.text=[NSString stringWithFormat:@"%@",r.thisMonthEarningMoney];
    }
    
    
}

- (void)httpDowloadWithBonusListType:(selectType)type
{
    if (self.httpOperator == nil) {
        self.httpOperator = [[HttpOperator alloc]init];
        
    }
    [self.httpOperator cancel];
    __weak HttpOperator * assginHtttperator = _httpOperator;
    __weak MyzhangbenViewController *this = self;
    [self.httpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
    } param:^(NSString *s) {
        [this httpLoadParamsTwo:s assginHtttperator:assginHtttperator type:type];
    } complete:^(NSSkyArray * r, int taskid) {
        
        [this httpLoadCompleteTwo:r];
        
    }];
    [self.httpOperator connect];
    
    
}
//请求失败
-(void)httpLoadError:(THttpOperatorErrorCode)error{
    if (error == EHttp_Operator_Failed) {
        //服务器挂了
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        [self.tableView reloadDeals];
    }
    
}
- (void)httpLoadParamsTwo:(NSString *)s assginHtttperator:(HttpOperator *)assginHtttperator type:(selectType)type{
    
    ProfitManagerV3 *manager = (ProfitManagerV3 *)[assginHtttperator getAopInstance:[ProfitManagerV3 class] returnValue:[NSSkyArray class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {
        if (type==LicaiType) {
            [manager getProfitDepositList:userToken pageNum:page];
        }
        else{
            
            [manager getNewProfitList:userToken pageNum:page year:self.year month:self.mouth];
        }
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
    
    
}

- (void)httpLoadCompleteTwo:(NSSkyArray *)r{
    
    if (r.errCode==0) {
        if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
            self.tableView.hasFooter = YES;
        }else {
            //数据加载不足一页的事后,将加载更多取消掉
            self.tableView.hasFooter = NO;
        }
        
        
        //判断如果没有数据的时候,显示的图片
        if (page==1&&r.iArray.count==0) {
            
//            UILabel *label= [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2-40, 0, kDeviceWidth, _tableView.height)];
//            label.text=@"暂无数据";
//            label.contentMode=UIViewContentModeCenter;
//            label.textColor=[UIColor blueColor];
//            label.backgroundColor=[UIColor clearColor];
            _tableView.tableFooterView=noDataLabel;
            [self.tableView reloadDeals];
            return ;
          
        }
        
        self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
        
        //如果刷新的是第一页,则需要将之前刷新的移除掉,不然第一页的数据会反复出现
        if (page==pageNOStart) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:r.iArray];
        [self.tableView reloadData];
        [self.tableView reloadDeals];
        
    }
    
    
    
}

- (void)topButAction {
    [self imgtoujiantouUp];
    
    if (_timePicker == nil) {
        _timePicker = [[MouthPickerView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-64, kDeviceWidth, kTimeCustomHeight) withHour:NO];
        __weak MyzhangbenViewController *this = self;
        __weak UILabel *time = (UILabel *)[self.view viewWithTag:123456];
        _timePicker.selectedBlock = ^ (NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minIndexppp, MouthPickerView *timePickerView) {
            this.year = [NSString stringWithFormat:@"%ld",(long)year];
            this.mouth = [NSString stringWithFormat:@"%ld",(long)month];
            page=pageNOStart;
            [this httpDowloadWithBonusListType:YueType];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type==LicaiType) {
        static NSString *identifier = @"cells";
        LicaijiluCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[LicaijiluCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if(_dataArray.count > 0){
            cell.model = [_dataArray objectAtIndex:indexPath.row];
        }
        return cell;
    }
    
    else {
        
        static NSString *identifier1 = @"cell";
        yuejiluCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (cell == nil) {
            cell = [[yuejiluCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
            
        }
        if(_dataArray.count > 0){
            cell.model = [_dataArray objectAtIndex:indexPath.row];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type==LicaiType) {
        FundDetailHomeViewController *controller = [[FundDetailHomeViewController alloc] init];
        ProfitDepositListItem *model = [_dataArray objectAtIndex:indexPath.row];
        controller.regularId = model.userRegularID;
        [self.navigationController pushViewController:controller animated:YES];
    }





}

@end
