//
//  QCWuYouLiCaiViewController.m
//  YOUXINBAO
//
//  Created by 密码是111 on 16/7/25.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCWuYouLiCaiViewController.h"
#import "MineViewModel.h"
#import "UserManager.h"
#import "MineViewNewCell.h"
#import "QCTouZiJiLuViewController.h"
#import "MoneyButton.h"
#import "MyInfoConfig.h"
#import "User.h"
#import "FinanceReturn.h"
#import "FinancialManagerV2.h"
#import "HttpOperator.h"

@interface QCWuYouLiCaiViewController ()
{
    MoneyButton*_ZuoRiShouYiBtn;
    MoneyButton*_LeiJiShouYiBtn;

}

@property (nonatomic,strong)UIImageView*headImgview;
@property (nonatomic,strong)UIView*headview;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *itemSectionArray;
@property (nonatomic,strong)User*userInfo;
@property(nonatomic,strong)FinanceReturn *data;
@property (nonatomic,strong)QCBaseTableView *tableView;
@property (retain, nonatomic) HttpOperator* iHttpOperator;


@end

@implementation QCWuYouLiCaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"无忧理财"];

    // Do any additional setup after loading the view.
        self.view.backgroundColor = kRGB(238, 236, 246);
    [self setMyYXBData];
    CGFloat x = 0, y = 0, w = kDeviceWidth, h = kDeviceHeight;
    self.tableView = [[QCBaseTableView alloc] initWithFrame:ccr(x, y, w, h) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    if (KDeviceOSVersion >= 7.0) {
        [_tableView setSeparatorInset:(UIEdgeInsetsMake(0, 55, 0, 0))];
        
    }
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   [self.view addSubview:_tableView];



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
#pragma -mark 初始化信息
-(void)setMyYXBData
{
    self.dataArray = [NSMutableArray array];
    //初始数据
    //每一个section里的row数
    self.itemSectionArray = [NSMutableArray arrayWithObjects:@"1", nil];
    NSMutableArray *itemTitleArray = [NSMutableArray arrayWithObjects:
                                      @"投资记录"                                     ,nil];
    
    NSMutableArray *itemImageArray = [NSMutableArray arrayWithObjects:
                                       @"LiCaiTouZiJiLuIcon.png",nil];
    
    NSMutableArray *itemTypeArray = [NSMutableArray arrayWithObjects:
                                     [NSNumber numberWithInteger:1001],
                                     nil
                                     ];
    
    
    if ((self.dataArray != nil) &&([self.dataArray count] > 0)) {
        [self.dataArray removeAllObjects];
    }
    
    
    for (int i = 0; i < [itemTitleArray count]; i ++)
    {
        MineViewModel *model = [[MineViewModel alloc] initWithTitle:itemTitleArray[i] imageName:itemImageArray[i] type:[itemTypeArray[i] integerValue]];
        [self.dataArray addObject:model];
    }
    
}


-(void)createMyTableView
{
    
    
    _headview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 55+kDeviceWidth/750*310)];
    _headview.backgroundColor=[UIColor whiteColor];
    //H5页面
    UIImageView*H5View=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/750*310)];
    H5View.contentMode=UIViewContentModeScaleToFill;
    H5View.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.data.img]]]];
    [_headview addSubview:H5View];

    UITextField*ZuoRiShouYi1=[[UITextField alloc]initWithFrame:CGRectMake((kDeviceWidth/2-100)/2, H5View.bottom+10, 100, 15)];
    ZuoRiShouYi1.textAlignment=NSTextAlignmentCenter;
    ZuoRiShouYi1.enabled=NO;
    ZuoRiShouYi1.font=[UIFont systemFontOfSize:14];
    ZuoRiShouYi1.textColor=kRGB(254,168,163);
    ZuoRiShouYi1.text=@"昨日收益(元)";
    NSString*str=@"(参考收益)";
    UITextField*ZuoRiShouYi2=[[UITextField alloc]initWithFrame:CGRectMake(0, ZuoRiShouYi1.bottom+10, kDeviceWidth/2-10, 15)];
    
    ZuoRiShouYi2.textAlignment=NSTextAlignmentCenter;
    ZuoRiShouYi2.enabled=NO;
    ZuoRiShouYi2.font=[UIFont systemFontOfSize:18];
    ZuoRiShouYi2.textColor=kRGB(237,46,36);
    ZuoRiShouYi2.text=[NSString stringWithFormat:@"%@ %@",self.data.yesterdayIncome,str];
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:ZuoRiShouYi2.text];
    NSRange range = [ZuoRiShouYi2.text rangeOfString:[NSString stringWithFormat:@"%@",str]];
    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    
    [mAttStri addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0] range:range];
    ZuoRiShouYi2.attributedText=mAttStri;


    UIView*lineView=[[UIView alloc]initWithFrame:ccr(kDeviceWidth/2, H5View.bottom+6, 1, 43)];
    lineView.backgroundColor=kRGB(254,168,163);

  
    UITextField*LeiJiShouYi1=[[UITextField alloc]initWithFrame:CGRectMake(kDeviceWidth/2 , H5View.bottom+10, kDeviceWidth/2, 15)];
    LeiJiShouYi1.enabled=NO;
    LeiJiShouYi1.textAlignment=NSTextAlignmentCenter;
    LeiJiShouYi1.font=[UIFont systemFontOfSize:14];
    LeiJiShouYi1.textColor=kRGB(254,168,163);
    LeiJiShouYi1.text=@"累计收益(元)";
    UITextField*LeiJiShouYi2=[[UITextField alloc]initWithFrame:CGRectMake((kDeviceWidth/2-100)/2+kDeviceWidth/2, ZuoRiShouYi1.bottom+10, 100, 15)];
    LeiJiShouYi2.textAlignment=NSTextAlignmentCenter;
    LeiJiShouYi2.enabled=NO;
    LeiJiShouYi2.font=[UIFont systemFontOfSize:18];
    LeiJiShouYi2.textColor=kRGB(237,46,36);
       LeiJiShouYi2.text=[NSString stringWithFormat:@"%@",self.data.allIncome];
    

     [_headview addSubview:lineView];
     [_headview addSubview:ZuoRiShouYi1];
     [_headview addSubview:ZuoRiShouYi2];
     [_headview addSubview:LeiJiShouYi1];
     [_headview addSubview:LeiJiShouYi2];
      _tableView.tableHeaderView = _headview;
   
 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    NSInteger count = [self.itemSectionArray count];
    if (count == 0) {
        count = 1;
    }
    return count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = [_itemSectionArray[section] integerValue];
    NSLog(@"rows--%ld",(long)rows);
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellID";
    MineViewNewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == Nil) {
        cell = [[MineViewNewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSInteger itemIndex = 0;
    for (int i = 0; i < indexPath.section; i++) {
        
        itemIndex = itemIndex + [self.itemSectionArray[i] integerValue];
    }
    
    itemIndex = itemIndex + indexPath.row;
    MineViewModel *model = [self.dataArray objectAtIndex:itemIndex];
    model.itemAddImageName =nil;
    
  
    cell.model = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (section == [self.itemSectionArray count] - 1) {
        height = 10;
    }
    
    return height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger itemIndex = 0;
    for (int i = 0; i < indexPath.section; i++) {
        
        itemIndex = itemIndex + [self.itemSectionArray[i] integerValue];
    }
    
    itemIndex = itemIndex + indexPath.row;
//    MineViewModel *model = [self.dataArray objectAtIndex:itemIndex];
    self.hidesBottomBarWhenPushed = YES;
    if(indexPath.section==0){
       
        {
            //投资记录
            QCTouZiJiLuViewController *JiLu = [[QCTouZiJiLuViewController alloc] init];
            
            [self.navigationController pushViewController:JiLu animated:YES];
            
        }
        

          
    }
}
#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self httpLoading];
}
#pragma mark -----------------------------------------------Http
- (void)httpLoading
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCWuYouLiCaiViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this.iHttpOperator stopAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
        
    } param:^(NSString *s) {
        [this httpLoadParams:assginHtttperator];
    } complete:^(MyAssetListDetail* r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    FinancialManagerV2* manager = (FinancialManagerV2*)  [assginHtttperator getAopInstance:[FinancialManagerV2 class] returnValue:[FinanceReturn class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    NSString *token = @"";
    token = userModel.user.yxbToken;
    if (token == nil) {
        token = @"";
    }
    [manager getFinanceReturn:token];
    
    
}
- (void)httpLoadComplete:(FinanceReturn *)r{
    
    if (r.errCode == 0) {
        self.data = r;
        [self createMyTableView];
    }else{
        NSString * string = r.errString;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    
    [self.tableView reloadDeals];
    [self.tableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
