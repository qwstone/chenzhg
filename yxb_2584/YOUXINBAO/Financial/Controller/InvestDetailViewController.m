//
//  InvestDetailViewController.m
//  YOUXINBAO
//
//  Created by pro on 16/7/22.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "InvestDetailViewController.h"
#import "CTSegmentControl.h"
#import "FinancialManagerV2.h"
#import "BuyView.h"
#import "InvestDetailUpView.h"
#import "YXBTool.h"
#import "AssetDetails.h"
#import "BidRecordCell.h"
#import "YXBTool.h"
#import "CTPhotoWall.h"
@interface InvestDetailViewController ()<UIActionSheetDelegate,CTSegmentControlDelegate,QCBaseTableViewDelegate,UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)HttpOperator        *iHttpOperator;
@property (nonatomic, strong)QCBaseTableView     *tableView;
@property (nonatomic, strong)UIView              *BGview;

@property (nonatomic, strong)CTSegmentControl *headerView;

@property (nonatomic, strong)UITableView        *BidTabel;
@property (nonatomic, strong)NSMutableArray     *BidArray;//投标记录
@property (nonatomic, strong)AssetDetails       *model;
@property (nonatomic, strong)InvestDetailUpView * upView;
@property (nonatomic, assign)NSInteger  page;


@property (nonatomic, strong)UIButton *shareBackView;
@property (nonatomic, strong)UIView *shareView;
@property (nonatomic,copy) NSString *shareUrlStr;

@property (strong, nonatomic) UIWebView * webView;
@property (nonatomic,weak)BuyView * buyview;
@property (nonatomic,weak)UIImageView *AleadyImgV;
@property(nonatomic,assign)BOOL hasFooter;


@property (strong, nonatomic) NSMutableArray *mUrlArray;//web中图片地址数组
@end

@implementation InvestDetailViewController
//-(void)viewWillAppear:(BOOL)animated{
//    self.hidesBottomBarWhenPushed = YES;
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    self.hidesBottomBarWhenPushed = NO;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.BidArray = [[NSMutableArray alloc] init];
    self.title = _assetItemModel.assetTitle;
    self.hasFooter = NO;
    [self createBackView];
    

    self.index = 0;
    self.page = 1;
    
    [self createHeaderView];
}
-(void)shareClick{
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.tableView isRefresh]) {
//        [self.tableView reloadDeals];
    }else{
        [self InvestDetailhttpRequest];
    }
}


#pragma mark    ------初始化UI
-(void)createHeaderView{
//    self.shareUrlStr=@"/wap/h5/3.jsp";
    _tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-kDeviceWidth/750*138) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;

    _tableView.backgroundColor = [YXBTool colorWithHexString:@"#ededed"];
    [self.view addSubview:_tableView];
    
    [self initView];
//    [self segmentControlDidSelectedIndex:self.index];
//    NSURL * url = [NSURL URLWithString:_model.assetInfoUrl];
//    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}


-(void)initView
{
    //背景View
    self.BGview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/750*444)];
    _tableView.tableHeaderView = _BGview;
    
    
    
    
    
    //下部分View  选择器
    NSArray *arr = @[@"产品信息",@"债权信息",@"投标记录",@"常见问题",@"安全保障"];
    self.headerView = [[CTSegmentControl alloc] initWithFrame:CGRectMake(-1, 10, kDeviceWidth+2, 34) andItems:arr andItemFont:[UIFont systemFontOfSize:25.61/2.0]];
    self.headerView.segmentTintColor = rgb(116, 116, 116, 1);
    self.headerView.displayRect = YES;
    self.headerView.rectColor = [YXBTool colorWithHexString:@"dbdbdb"];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.headerView.delegate = self;
    self.headerView.selectedIndex =0;
//    [_BGview addSubview:headerView];
    
    
//    //投标记录
//    self.BidTabel = [[UITableView alloc] initWithFrame:CGRectMake(0, headerView.bottom, kDeviceWidth, 60*_BidArray.count)];
//    _BidTabel.delegate = self;
//    _BidTabel.dataSource = self;
////    _BidTabel.userInteractionEnabled = NO;
//    _BidTabel.hidden = YES;
//    [_BGview addSubview:_BidTabel];
    
    
    //webview
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.BGview.bottom+44, kDeviceWidth, kDeviceHeight - 44 -self.BGview.bottom- kDeviceWidth/750*138 - 64)];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.scrollView.backgroundColor = [UIColor whiteColor];
    _webView.scrollView.bounces = NO;
//    [_webView setUserInteractionEnabled:YES];
//    [_webView setOpaque:NO];
//    [_webView setScalesPageToFit:YES];
    [_tableView addSubview:_webView];
    self.webView.scalesPageToFit = YES;

    self.webView.opaque = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    
    
    //底部抢购按钮和计算器
    BuyView * buyview = [[BuyView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - kDeviceWidth/750*138 - 64, kDeviceWidth, kDeviceWidth/750*138)];
    buyview.backgroundColor = [UIColor whiteColor];
//    buyview.model = _model;
    self.buyview = buyview;
    [self.view addSubview:buyview];
    
    
    //如果产品不可购买  添加不可购买图片
    UIImage *img = [UIImage imageNamed:@"yijieshu"];
    UIImageView * AleadyImg = [[UIImageView alloc] initWithFrame:CGRectMake((kDeviceWidth-img.size.width)/2, _webView.top+10, img.size.width, img.size.height)];
    AleadyImg.image = img;
    AleadyImg.hidden = YES;
    [self.view addSubview:AleadyImg];
    self.AleadyImgV = AleadyImg;
    [self createShareView];
}
#pragma mark    ------Share
-(void)createBackView{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, kDeviceWidth/750*40, kDeviceWidth/750*40);
    [btn setBackgroundImage:[UIImage imageNamed:@"ShareIcon"]  forState:UIControlStateNormal];
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

//    [_tableView reloadData];

    
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

#pragma mark    ------CTSegmentControlDelegate
-(void)segmentControlDidSelectedIndex:(NSInteger)index
{

    self.index = index;
    
    if (self.index != 2) {
        self.tableView.hasFooter = NO;
        CGFloat offsetY = self.tableView.contentOffset.y;
        
        if (offsetY>kDeviceWidth/750*444+44) {
            _webView.height = kDeviceHeight - 44 -self.BGview.bottom- kDeviceWidth/750*138 - 64+kDeviceWidth/750*444+44;
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }else{
            _webView.height = kDeviceHeight - 44 -self.BGview.bottom- kDeviceWidth/750*138 - 64+offsetY;
            [self.tableView setContentOffset:CGPointMake(0, offsetY)];
        }
        
    }else{
        
        self.tableView.hasFooter = self.hasFooter;
    }
    
    switch (index) {
        case 0:
            {
//                [[NSURLCacheshared URLCache] removeAllCachedResponses];

                [[NSURLCache sharedURLCache] removeAllCachedResponses];
                NSURL * url = [NSURL URLWithString:_model.assetInfoUrl];
                [_webView loadRequest:[NSURLRequest requestWithURL:url]];
//                _BidTabel.hidden = YES;
                _webView.hidden = NO;
            }
            break;
        case 1:
        {
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            NSURL * url = [NSURL URLWithString:_model.assignmentUrl];
            [_webView loadRequest:[NSURLRequest requestWithURL:url]];
//            _BidTabel.hidden = YES;
            _webView.hidden = NO;
        }
            break;
        case 2:
        {
//            CGRect bgFrame = _BGview.frame;
//            bgFrame.size.height = 60*_BidArray.count + kDeviceWidth/750*444 + 64 + 34;
//            _BGview.frame = bgFrame;
//            _tableView.tableHeaderView = _BGview;
//
//            _BidTabel.hidden = NO;
//            [self InvestDetailhttpRequest];
            [self.tableView reloadData];
            _webView.hidden = YES;
        }
            break;
        case 3:
        {
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            NSURL * url = [NSURL URLWithString:_model.faqUrl];
            [_webView loadRequest:[NSURLRequest requestWithURL:url]];
//            _BidTabel.hidden = YES;
            _webView.hidden = NO;
        }
            break;
        case 4:
        {
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            NSURL * url = [NSURL URLWithString:_model.aqbzUrl];
            [_webView loadRequest:[NSURLRequest requestWithURL:url]];
            _webView.hidden = NO;
        }
            break;
            
        default:
            break;
    }
//    [self.tableView reloadData];
}

#pragma mark - UITableView delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [YXBTool colorWithHexString:@"f5f5f5"];
    
    [view addSubview:self.headerView];
    
//    //    [self.headerView addSubview:sele];
//    UIView* line1 = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceWidth/640*70, kDeviceWidth, kDeviceWidth/640*18)];
//    line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [view addSubview:line1];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 44;
}
#pragma mark - UITableViewDataSouce

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.index==2) {
        return kDeviceWidth/750*116;
    }
    return kDeviceHeight - 44 - kDeviceWidth/750*138 - 64;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.index==2) {
        return _BidArray.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.index==2) {
        BidRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"bidcell"];
        if (cell == nil) {
            cell = [[BidRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bidcell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        AssetParticipation * model = [_BidArray objectAtIndex:indexPath.row];
        cell.model = model;
        return cell;
    }
    static NSString *identifier = @"cells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - UIscrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    [_commentBar giveUpFirstResponder];
    CGFloat offsetY = scrollView.contentOffset.y;
    

    if (self.index != 2) {
        self.webView.height = kDeviceHeight - 44 -self.BGview.bottom- kDeviceWidth/750*138 - 64+offsetY;

    }

    
}

#pragma mark    ------下拉刷新
//-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
//{
//    [self InvestDetailhttpRequest];
//}

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    self.page = 1;
   [self InvestDetailhttpRequest];
    
}
//上拉加载
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.tableView.isRefresh && _BidArray.count%20==0&&self.tableView.hasFooter == YES) {
        self.page++;
        [self InvestDetailhttpRequest];
    }else {
        
    }
}
//上拉加载更多
- (void)QCBaseTableViewDidPullUpRefreshed:(QCBaseTableView *)tableView {
    self.page++;
    [self InvestDetailhttpRequest];
}





#pragma mark - UIWebViewDelegate
float tempH = 0.0;
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
   
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    NSString * url = [request.URL absoluteString];
    NSString *transString = [NSString stringWithString:[url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //如果地址中含有popimage://  需要放大图片
 

    //预览图片
    if ([request.URL.scheme isEqualToString:@"popimage"] && transString.length > 0) {
        
        //截取JSON字符串
        NSMutableString * dataStr = [[NSMutableString alloc] initWithString:transString];
        NSString * jsonStr = [dataStr substringFromIndex:[dataStr rangeOfString:@"{"].location];
        //解析Json字符串
        NSData* data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        //图片地址添加http前缀
        NSArray * photoArr = [json objectForKey:@"imArr"];
        NSMutableArray * newArr = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < photoArr.count; i++) {
            NSString * path = [NSString stringWithFormat:@"%@%@",@"https://",photoArr[i]];
            [newArr addObject:path];
        }
        NSInteger index = [[json objectForKey:@"imgIndex"] integerValue];
        //图片预览
        [self showWebPhotoWithPhotoArr:newArr andIndex:index];
        return NO;
    }
    return YES;

}


#pragma mark - 产品详情数据请求
-(void)InvestDetailhttpRequest{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block InvestDetailViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        [this stopDefaultAnimation];
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        if (error == EHttp_Operator_Failed) {
            [ProgressHUD showErrorWithStatus:@"加载失败,请检查手机网络"];
        }
        
    } param:^(NSString *s) {
        
        FinancialManagerV2 * manager = (FinancialManagerV2*)[assginHtttperator getAopInstance:[FinancialManagerV2 class] returnValue:[AssetDetails class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        NSString *userToken = userModel.user.yxbToken;

        [manager getAssetDetails:_assetItemModel.assetID userToken:userToken pageNum:self.page];
//        [manager getAllAssetList:[YXBTool getUserToken] pageNum:index];
        
    } complete:^(AssetDetails *r, int taskid){
        [this InvestDetailhttpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}

-(void)InvestDetailhttpLoadComplete:(AssetDetails *)r{
    [_tableView reloadDeals];
    if (r.errCode == 0) {
        //请求成功
        self.model = r;
        
        if (self.page == 1) {
            [_BidArray removeAllObjects];
            _BidArray = r.participationList;
        }else
        {
            [_BidArray addObjectsFromArray:_model.participationList];
        }
        //判断还有没有数据，没有隐藏下面的加载更多
        if (r.participationList.count < 20) {
            self.tableView.hasFooter = NO;
            self.hasFooter = NO;
        }else
        {
            self.hasFooter = YES;
        }
        //更新投标记录
//        [_BidArray removeAllObjects];
//        [_BidArray addObjectsFromArray:_model.participationList];
        
        //上部分View
        self.upView = [[InvestDetailUpView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/750*444)];
        self.upView.model = r;
        [_BGview addSubview:self.upView];
        self.buyview.model = self.model;
        
        if ([_model.percentage integerValue] >= 100) {
            [self.view bringSubviewToFront:self.AleadyImgV];
            self.AleadyImgV.hidden = NO;
        }else{
            self.AleadyImgV.hidden = YES;
        }
        if (self.index == 0) {
            NSURL * url = [NSURL URLWithString:_model.assetInfoUrl];
            [_webView loadRequest:[NSURLRequest requestWithURL:url]];
        }
    }
    else{
        [ProgressHUD showErrorWithStatus:r.errString];
    }
    [_tableView reloadData];
    [_tableView reloadDeals];
    
}



#pragma mark  ========= 点击web中的图片放大

-(void)showWebPhotoWithPhotoArr:(NSArray*)array andIndex:(NSInteger)index{
    
    [CTPhotoWall photoWallShowWithImgUrlDataArr:array Index:index];
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
