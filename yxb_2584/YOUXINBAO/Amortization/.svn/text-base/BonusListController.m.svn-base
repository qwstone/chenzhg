//
//  BonusListController.m
//  YOUXINBAO
//
//  Created by Walice on 15/6/1.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "BonusListController.h"
#import "BonusListCell.h"
#import "ProfitManager.h"

#define MessageCenterPageNOStart 1

@interface BonusListController ()

@end

@implementation BonusListController
-(void)dealloc{
    NSLog(@"BonusListController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = MessageCenterPageNOStart;
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self _initViews];
     self.title=@"收益明细";
    if (self.type==BonusListType) {
        _segmentControl.selectedSegmentIndex = 0;
        [self httpDowloadWithBonusListType:BonusListType];
    }
    else if (self.type==OtherListType){
        _segmentControl.selectedSegmentIndex=1;
        [self httpDowloadWithBonusListType:OtherListType];
    }
}

- (void)_initViews{
  
    _dataArray = [NSMutableArray new];
    
     [self initTopSegmentControl];
    
    _label=[[UILabel alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_label];
    
//    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain refreshFooter:YES];
    
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, _segmentControl.size.height + 2*15, kDeviceWidth, kDeviceHeight-64-_segmentControl.size.height - 2*15-65) style:UITableViewStylePlain refreshFooter:YES];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    
     [self.view addSubview:_tableView];
    
}

-(void)initTopSegmentControl
{

    self.segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"宝赚钱收益",@"其他收益", nil]];
    _segmentControl.frame = CGRectMake(15, 15, kDeviceWidth-2*15, 40);
    _segmentControl.selectedSegmentIndex = 0;
    _segmentControl.layer.cornerRadius = 5.0;
    _segmentControl.backgroundColor = [UIColor whiteColor];
    _segmentControl.tintColor = rgb(221, 101, 115, 1.0);
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"SnellRoundhand-Bold" size:16],NSFontAttributeName ,nil];
    
    [_segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    
    
    [self.view addSubview:_segmentControl];
    

    
    
}

-(void)segmentAction:(UISegmentedControl *)segmentControl
{
    if (segmentControl.selectedSegmentIndex == 0) {
        //        self.isLoan = YES;
        self.type = BonusListType;
        
    }else if (segmentControl.selectedSegmentIndex == 1){
        //        self.isLoan = NO;
        self.type =OtherListType;
        
    }

    [_dataArray removeAllObjects];
    [_tableView reloadDeals];
    [self.tableView beginRefreshing];
    
}

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self refreshData];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>=scrollView.frame.size.height && !self.tableView.isRefresh && self.tableView.hasFooter == YES) {
        if (_dataArray.count%20==0) {
            page ++;
//            if (self.type == BonusListType) {
//                [self httpDowloadWithBonusListType:BonusListType];
//                
//            }else if (self.type == OtherListType) {
//                [self httpDowloadWithBonusListType:OtherListType];
//            }
           // [self httpDowloadWithListStyle:_type];
             [self httpDowloadWithBonusListType:_type];
        }else {

        }
    }
}

//刷新数据
- (void)refreshData {
    page = 1;
    if (self.type == BonusListType) {
        [self httpDowloadWithBonusListType:BonusListType];
        
    }else if (self.type == OtherListType) {
        [self httpDowloadWithBonusListType:OtherListType];
    }
}


//-(void)viewWillAppear:(BOOL)animated
//{
//    [self refreshData];
//    [super viewWillAppear:YES];
//}


#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpDowloadWithBonusListType:(BonusOrOtherListType)type
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak BonusListController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
    } param:^(NSString *s) {
        

        [this httpLOadParams:s httpOperation:assginHtttperator BonusListType:type];
        
    } complete:^(NSSkyArray * r, int taskid) {
        /*if (r.errCode==0) {
        
           this.label.frame=CGRectMake((kDeviceWidth-250)/2.0,_tableView.height+80, 250, 50);
            [self.view addSubview:_label];
            
            this.label.text=[NSString stringWithFormat:@"历史累计收益:%@元",r.errString];
            this.label.font=[UIFont systemFontOfSize:20];
            NSRange range1=[this.label.text rangeOfString:[NSString stringWithFormat:@"%@",r.errString]];
            NSMutableAttributedString *aText=[[NSMutableAttributedString alloc]initWithString:this.label.text];
            [aText addAttribute:NSForegroundColorAttributeName value:rgb(221, 11, 12, 1) range:range1];
            
            this.label.attributedText=aText;
        }
        
        if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
            this.tableView.hasFooter = YES;
        }else {
            //数据加载不足一页的事后,将加载更多取消掉
            this.tableView.hasFooter = NO;
        }
        
        [this.tableView reloadDeals];

        //判断如果没有数据的时候,显示的图片
        if (page==1&&r.iArray.count==0) {
            
            UILabel *label= [[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/2-40, 0, kDeviceWidth, _tableView.height)];
//                imgVIew.image=[UIImage imageNamed:@"imgimg.jpg"];
//            imgVIew.contentMode=UIViewContentModeCenter;
//                self.tableView.tableFooterView=imgVIew;
            label.text=@"暂无数据";
            label.contentMode=UIViewContentModeCenter;
            label.textColor=[UIColor blueColor];
            label.backgroundColor=[UIColor clearColor];
            _tableView.tableFooterView=label;
           // [self.view addSubview:label];
            //self.tableView.tableFooterView=label;
                return ;
            }

       self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
        
        
        //如果刷新的是第一页,则需要将之前刷新的移除掉,不然第一页的数据会反复出现
        if (page==MessageCenterPageNOStart) {
            [this.dataArray removeAllObjects];
        }
        [this.dataArray addObjectsFromArray:r.iArray];
        [this.tableView reloadData];
        
        
        
    }];
    [self.iHttpOperator connect];
         */
        [this httpLoadComplete:r];
        
    }];
    [self.iHttpOperator connect];
   
        
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
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation BonusListType:(BonusOrOtherListType)type
{
    ProfitManager *manager = (ProfitManager *)[httpOperation getAopInstance:[ProfitManager class] returnValue:[NSSkyArray class]];
    
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    //        if (style == L_myList) {
    NSString *userToken = userModel.user.yxbToken;
    if ((userToken != nil) && [userToken length] > 0)
    {
        
        [manager getNewProfitList:userToken pageNum:page type:type];
        
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}
//请求完成
-(void)httpLoadComplete:(NSSkyArray *)r{
    if (r.errCode == 0) {
        
        self.label.frame=CGRectMake((kDeviceWidth-250)/2.0,_tableView.height+80, 250, 50);
        [self.view addSubview:_label];
        
        self.label.text=[NSString stringWithFormat:@"历史累计收益:%@元",r.errString];
        self.label.textColor=rgb(55, 55, 56, 1);
        self.label.textAlignment=NSTextAlignmentCenter;
        self.label.font=[UIFont systemFontOfSize:18];
        NSRange range1=[self.label.text rangeOfString:[NSString stringWithFormat:@"%@",r.errString]];
        NSMutableAttributedString *aText=[[NSMutableAttributedString alloc]initWithString:self.label.text];
        [aText addAttribute:NSForegroundColorAttributeName value:rgb(221, 11, 12, 1) range:range1];
        [aText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:range1];
        
        self.label.attributedText=aText;
        if (r.iArray.count>0) {
            
            if (page>1) {
                [self.dataArray addObjectsFromArray:r.iArray];
                
            }else{
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    BonusListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BonusListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isCollectMoney=NO;
        
    }
    if (indexPath.row<_dataArray.count) {
        cell.model = [_dataArray objectAtIndex:indexPath.row];
    }
    
    
    
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
