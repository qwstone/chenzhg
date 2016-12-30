//
//  QCTouZiJiLuXiangQingViewController.m
//  YOUXINBAO
//
//  Created by 密码是111 on 16/7/27.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCTouZiJiLuXiangQingViewController.h"
#import "FinancialManagerV2.h"
#import "HttpOperator.h"
#import "MyAssetListDetail.h"
#import "MyAssetListItem.h"
#import "TouZiJiLuCell.h"
@interface QCTouZiJiLuXiangQingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)MyAssetListDetail *data;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) NSMutableArray * cellHeightArray;
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (nonatomic,strong) MyAssetListItem *model;
@property(nonatomic,strong)UIView*headView;
@property (nonatomic, strong)UIButton *shareBackView;
@property (nonatomic, strong)UIView *shareView;
@property(nonatomic,strong)NSString*shareUrlStr;




@end

@implementation QCTouZiJiLuXiangQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRGB(238, 236, 246);
    CGFloat x = 0, y = 0, w = kDeviceWidth, h = kDeviceHeight;
    self.tableView = [[UITableView alloc] initWithFrame:ccr(x, y, w, h) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    if (KDeviceOSVersion >= 7.0) {
        [_tableView setSeparatorInset:(UIEdgeInsetsMake(0, 55, 0, 0))];
        
    }
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    x = 0, y = 0, w = kDeviceWidth, h = 272 + 15;
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 180)];
    _tableView.tableHeaderView=_headView;
    _headView.backgroundColor=rgb(254,254,254, 1);;
    _dataArray = [NSMutableArray new];
//
    [self createBackView];   

}
-(void)viewWillAppear:(BOOL)animated
{
    
//    [self requestData];
    [self httpLoading];
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
//#pragma mark  --------------------------- refresh
//- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
//    [self httpLoading];
//}

//创建_headView UI
-(void)createMyTableView{
    //标题
    [self setTitle:[NSString stringWithFormat:@"%@",_data.assetTitle]];
    //收益进度
    UITextField*shouyijindu=[[UITextField alloc]initWithFrame:CGRectMake(8, 25, 100, 20)];
    shouyijindu.enabled=NO;
    shouyijindu.font=[UIFont systemFontOfSize:25*72/96];
    shouyijindu.textColor=kRGB(90,90,90);
    shouyijindu.text=@"收益进度";
    [_headView addSubview:shouyijindu];
    UIView*LineView=[[UIView alloc]init];
    LineView.frame=CGRectMake(12, shouyijindu.bottom+20, kDeviceWidth-12*2, 1);
    LineView.backgroundColor=rgb(226, 226, 226, 1);
    [_headView addSubview:LineView];
     //进度条
    UIProgressView *pro1=[[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
    pro1.frame=CGRectMake(100, 34, kDeviceWidth-112, 100);
    pro1.transform = CGAffineTransformMakeScale(1.0f,4.0f);
    pro1.trackTintColor=rgb(234, 232, 232, 1);
    pro1.progress=0;
    pro1.progressTintColor=rgb(253, 116, 38, 1);
    pro1.layer.masksToBounds=YES;
    pro1.layer.cornerRadius=10;
   NSString*progressStr=[NSString stringWithFormat:@"%@",self.data.percentage];
    [pro1 setProgress:[progressStr floatValue]/100 animated:YES];
    [_headView addSubview:pro1];
    //_headView底部图片
    UIImageView*footImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, _headView.bottom, kDeviceWidth, 20)];
    footImg.image=[UIImage imageNamed:@"LiCaiJiLuB.png"];
    [_tableView addSubview:footImg];
    
    //H5页面
    UIWebView*H5View=[[UIWebView alloc]initWithFrame:CGRectMake(0, footImg.bottom, kDeviceWidth, kDeviceHeight-64-footImg.bottom-20)];
    H5View.scrollView.bounces=NO;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.data.url]]];
    [H5View loadRequest:request];
    [_tableView addSubview:H5View];
    float sizeHeight = [[H5View stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    NSLog(@"%f",sizeHeight);
    
    //进度标识
    UIView*BiaoZhiView=[[UIView alloc]init];
    UITextField*BiaoZhiText=[[UITextField alloc]init];
    UIImageView*BiaoZhiImg=[[UIImageView alloc]init];
   float aa =[self.data.percentage floatValue];
//    float aa =100;
    if(aa>=80){
        BiaoZhiImg.frame=CGRectMake(40, 0, 8, 12);
        BiaoZhiImg.image=[UIImage imageNamed:@"LiCaiJinDuBiaoZhi.png"];
        BiaoZhiText.frame=CGRectMake(0, 0, 40, 12);
        BiaoZhiView.frame=CGRectMake(100+pro1.frame.size.width*aa/100-55, 15, 50, 12);
        if(aa==100){
        UIImageView*LiCaiFinishedImg=[[UIImageView alloc]init];
        LiCaiFinishedImg.frame=CGRectMake((kDeviceWidth-105)/2, _headView.bottom+15, 105, 105);
        LiCaiFinishedImg.image=[UIImage imageNamed:@"yijieshu.png"];
            [_tableView addSubview:LiCaiFinishedImg];
        }
   
    }
    else{
    BiaoZhiImg.frame=CGRectMake(3, 0, 8, 12);
    BiaoZhiImg.image=[UIImage imageNamed:@"LiCaiJinDuBiaoZhi.png"];
    BiaoZhiText.frame=CGRectMake(13, 0, 60, 12);
    BiaoZhiView.frame=CGRectMake(100+pro1.frame.size.width*aa/100-5, 15, 70, 12);
    }
    BiaoZhiText.enabled=NO;
    BiaoZhiText.font=[UIFont systemFontOfSize:10];
    BiaoZhiText.textColor=kRGB(90,90,90);
    BiaoZhiText.text=[NSString stringWithFormat:@"%@",self.data.percentTxt];
    [BiaoZhiView addSubview:BiaoZhiImg];
    [BiaoZhiView addSubview:BiaoZhiText];
    [_headView addSubview:BiaoZhiView];


    //起始时间
    UITextField*StartTime=[[UITextField alloc]initWithFrame:CGRectMake(100, pro1.bottom+5, 100, 15)];
    StartTime.enabled=NO;
    StartTime.font=[UIFont systemFontOfSize:16*72/96];
    StartTime.textColor=kRGB(152,149,149);
    StartTime.text=[NSString stringWithFormat:@"%@",self.data.startTime];
    
    [_headView addSubview:StartTime];
    //结束时间
    UITextField*EndTime=[[UITextField alloc]initWithFrame:CGRectMake(kDeviceWidth-110, pro1.bottom+5, 100, 15)];
    EndTime.textAlignment=NSTextAlignmentRight;
    EndTime.enabled=NO;
    EndTime.font=[UIFont systemFontOfSize:16*72/96];
    EndTime.textColor=kRGB(149,149,149);
    EndTime.text=[NSString stringWithFormat:@"%@",self.data.endTime];
    [_headView addSubview:EndTime];

    
    //投资金额
    UITextField*JinELab=[[UITextField alloc]init];
    JinELab.text=[NSString stringWithFormat:@"投资金额: %@元",self.data.money];
    [JinELab setAdjustsFontSizeToFitWidth:YES];
    JinELab.frame=CGRectMake(8, LineView.bottom+15, 170, 20);
    NSMutableAttributedString *mAttStri1 = [[NSMutableAttributedString alloc] initWithString:JinELab.text];
    NSRange range1 = [JinELab.text rangeOfString:[NSString stringWithFormat:@"%@元",self.data.money]];
    [mAttStri1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
    JinELab.font=[UIFont systemFontOfSize:22*72/96];
    JinELab.textColor=rgb(99,99,99, 1);
    JinELab.enabled=NO;
    JinELab.attributedText=mAttStri1;
    [JinELab setAdjustsFontSizeToFitWidth:YES];
    [_headView addSubview:JinELab];
    
    //到期收益
    UITextField*ShouYiLab=[[UITextField alloc]init];
    ShouYiLab.text=[NSString stringWithFormat:@"到期收益: %@元",self.data.exceptReturn];
    [ShouYiLab setAdjustsFontSizeToFitWidth:YES];
    ShouYiLab.frame=CGRectMake(8, JinELab.bottom+15, 170, 20);
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:ShouYiLab.text];
    NSRange range = [ShouYiLab.text rangeOfString:[NSString stringWithFormat:@"%@元",self.data.exceptReturn]];
    [mAttStri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    ShouYiLab.font=[UIFont systemFontOfSize:22*72/96];
    ShouYiLab.textColor=rgb(99,99,99, 1);
    ShouYiLab.enabled=NO;
    ShouYiLab.attributedText=mAttStri;
    [_headView addSubview:ShouYiLab];
    //项目周期
    UILabel*XiangMuZhouQi=[[UILabel alloc]init];
    XiangMuZhouQi.frame=CGRectMake(8,ShouYiLab.bottom+15, 340, 20);
    XiangMuZhouQi.font=[UIFont systemFontOfSize:22*72/96];
    XiangMuZhouQi.textColor=rgb(99,99,99, 1);
    XiangMuZhouQi.text=[NSString stringWithFormat:@"项目周期:%@",self.data.limitStr];
    [_headView addSubview:XiangMuZhouQi];
    
    //购买时间
    UILabel*TimeLab=[[UILabel alloc]init];
    TimeLab.frame=CGRectMake(kDeviceWidth-163,LineView.bottom+15, 200, 20);
    TimeLab.font=[UIFont systemFontOfSize:22*72/96];
    TimeLab.textColor=rgb(99,99,99, 1);
    TimeLab.text=[NSString stringWithFormat:@"购买时间:%@",self.data.buyDate];
    [_headView addSubview:TimeLab];

    //年化收益
    UITextField*NianHuaShouYi=[[UITextField alloc]init];
    NianHuaShouYi.frame=CGRectMake(kDeviceWidth-163, TimeLab.bottom+15, 200, 20);
    NianHuaShouYi.font=[UIFont systemFontOfSize:22*72/96];
    NianHuaShouYi.textColor=rgb(99,99,99, 1);
    NianHuaShouYi.text=[NSString stringWithFormat:@"预期年化：%@",self.data.annualizedRate];
    NianHuaShouYi.enabled=NO;
    [_headView addSubview:NianHuaShouYi];
    if (kDeviceHeight <= 568){
        
    }
    [self createShareView];
   
   }
#pragma mark    ------Share
-(void)createBackView{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, kDeviceWidth/750*40, kDeviceWidth/750*40);
    [btn setBackgroundImage:[UIImage imageNamed:@"ShareIcon.png"]  forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}


-(void)createShareView{
    _shareBackView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    _shareBackView.backgroundColor = [UIColor blackColor];
    _shareBackView.alpha = 0.7;
    _shareBackView.hidden = YES;
    [_shareBackView addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shareBackView];
    _shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - 150-64, kDeviceWidth, 150)];
    //    _shareView.hidden = YES;
    _shareView.transform = CGAffineTransformMakeTranslation(0, 150);
    _shareView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_shareView];
    [self.view bringSubviewToFront:_shareView];
    
    NSArray *imageNameArray = @[@"Share-wechat",@"Share-pyq"];
    
    for (int i = 0; i <2; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20+80*i, 10, 60, 84);
        [btn setImage:[UIImage imageNamed:imageNameArray[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageNameArray[i]] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.tag = i+100;
        [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView addSubview:btn];
    }
    
    UIButton *cancleBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    cancleBtn.layer.borderColor =  rgb(244, 240, 240, 1).CGColor;
    cancleBtn.layer.borderWidth = 1.0;
    cancleBtn.frame = CGRectMake(-1, 150-45, kDeviceWidth+2, 46);
    [cancleBtn setTitle:@"取    消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:rgb(103, 196, 250, 1) forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    cancleBtn.backgroundColor = [UIColor whiteColor];
    [cancleBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_shareView addSubview:cancleBtn];
    
}


-(void)shareClick:(UIButton *)btn{
    if (btn.tag == 100) {//微信好友
        
        [YXBTool shareToWeixinSessionContent:@"产品丰富，收益稳健。"imgName:[UIImage imageNamed:@"shareImg"] url:[NSString stringWithFormat:@"%@wap/h5/3.jsp",YXB_IP_address_share] title:@"无忧理财稳赚计划！立即点击，稳健大赚！" callBackBlock:^{
            
        }];
    }else{//朋友圈
        [YXBTool shareToWeixinTimelineContent:nil imgName:[UIImage imageNamed:@"shareImg"] url:[NSString stringWithFormat:@"%@wap/h5/3.jsp",YXB_IP_address_share] title:@"无忧理财稳赚计划！立即点击，稳健大赚！" callBackBlock:^{
            
        }];
    }
}

//分享到朋友圈
-(void)rightClick:(UIButton *)btn{
    NSLog(@"%@",self.shareUrlStr);
    _shareBackView.hidden = NO;
    //    _shareView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _shareView.transform = CGAffineTransformIdentity;
    }];
    
}
-(void)cancleBtnClick:(UIButton *)btn{
    _shareBackView.hidden = YES;
    //    _shareView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        _shareView.transform = CGAffineTransformMakeTranslation(0, 150);
    }];
}


#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
//#pragma mark  --------------------------- refresh
//- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
//    [self httpLoading];
//}
#pragma mark -----------------------------------------------Http
- (void)httpLoading
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak QCTouZiJiLuXiangQingViewController *this = self;
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
    FinancialManagerV2* manager = (FinancialManagerV2*)  [assginHtttperator getAopInstance:[FinancialManagerV2 class] returnValue:[MyAssetListDetail class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    NSString *token = @"";
    token = userModel.user.yxbToken;
    if (token == nil) {
        token = @"";
    }
//    int recordID=[[NSString stringWithFormat:@"%@",AssModel.recordId]intValue];
    NSString*ID=[NSString stringWithFormat:@"%@",_recordID];
    [manager getMyAssetListDetail:token recordId:[ID intValue]];
    
    
}
- (void)httpLoadComplete:(MyAssetListDetail *)r{
    
    if (r.errCode == 0) {
        self.data = r;
    [self createMyTableView];
    }else{
        NSString * string = r.errString;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    
//    [self.tableView reloadDeals];
    [self.tableView reloadData];
    
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
