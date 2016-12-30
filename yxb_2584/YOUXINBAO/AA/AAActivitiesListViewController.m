//
//  AAActivitiesListViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/3/6.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AAActivitiesListViewController.h"
#import "HeaderView.h"
#import "AAActivitiesListTableViewCell.h"
#import "QCConst.h"
#import "HttpOperator.h"
#import "NSSkyArray.h"
#import "QCLocalLocation.h"
#import <CoreLocation/CoreLocation.h>
#import "AADetailsViewController.h"
//#import "TActivityBriefManager.h"
#import "AACreateViewController.h"
#import "QCUserManager.h"
#import "AAManager.h"
#import "YXBTool.h"
#import "QCLoginOneViewController.h"

//#import "AACreateViewController2ViewController.h"

#define AAActivitiesListTopLeft 15

@interface AAActivitiesListViewController()<HeaderViewDelegate,UIScrollViewDelegate,AAFiltrateViewDelegate,UIAlertViewDelegate,QCBaseTableViewDelegate>

@end

@interface AAActivitiesListViewController ()
{
    HeaderView * _headerView;
    
    NSInteger indexPage;

}

@property(nonatomic,strong)UISegmentedControl *segmentControl;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong) AAFiltrateView *filtrateView;
@property (nonatomic,strong)QCBaseTableView * activitiesList;
@property (nonatomic,strong)NSMutableArray *cellHeightArray;//cell的高度数组

@property (nonatomic,copy)NSString  *imgName;
@property (nonatomic,strong)UIImageView *nullImage;
@end

@implementation AAActivitiesListViewController

-(void)dealloc{

    NSLog(@"AAActivitiesListViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellHeightArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"活动·聚会"];

//    self.view.backgroundColor = rgb(238, 236, 246, 1.0);
    //发起AA
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 65, 30);
    [btn addTarget:self action:@selector(createAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"发起" forState:UIControlStateNormal];
    UIBarButtonItem *createItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = createItem;
    
    _listStyle = 0;
    indexPage = 1;
    self.imgName = @"nearnohd";

    _dataArray = [[NSMutableArray alloc]init];
    [self initFiltrateView];
    [self initView];
    [self locationStatus];
    [self.activitiesList reloadDeals];
//    [self httpDowloadWithListStyle:_listStyle];
//    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
//    if (![userModel isLogin]) {
//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请登录账号使用AA功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        alter.tag = 2002;
//        [alter show];
//    }
//    else
//    {
//    [self refreshData];
//    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.iHttpOperator) {
        
        [self.iHttpOperator cancel];
    }
}

- (void)leftClicked
{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)createAction {
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
        QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
        UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
        loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
        return;
    }
    AACreateViewController *createVC = [[AACreateViewController alloc] initWithNibName:@"AACreateViewController" bundle:nil];
    createVC.isFromRoot = _isFromRoot;
//    AACreateViewController2ViewController *createVC = [[AACreateViewController2ViewController alloc] init];
    createVC.listVC = self;
    [self.navigationController pushViewController:createVC animated:YES];
}

- (void)initView
{

//    _headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 15, kDeviceWidth-20, 40)WithArray:array];
//    _headerView.delegate = self;
////    _headerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
////    _headerView.layer.borderWidth = 1.0;
//
//    [self.view addSubview:_headerView];
    
    
    [self initTopSegmentControl];
    _activitiesList = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, _segmentControl.frame.origin.y+_segmentControl.frame.size.height + AAActivitiesListTopLeft, kDeviceWidth, kDeviceHeight-64-_segmentControl.frame.size.height - AAActivitiesListLeftLeft - AAActivitiesListTopLeft) style:UITableViewStylePlain refreshFooter:YES];
    _activitiesList.delegate = self;
    _activitiesList.dataSource = self;
    [_activitiesList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _activitiesList.refreshDelegate = self;
    [self.view addSubview:_activitiesList];
    [self.view sendSubviewToBack:_activitiesList];
}

-(void)initTopSegmentControl
{
//    CGFloat ySpace = 15;
//    CGFloat xSpace = 10;
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"附近活动",@"好友活动",@"我的活动", nil]];
    _segmentControl.frame = CGRectMake(AAActivitiesListLeftLeft, AAActivitiesListTopLeft, kDeviceWidth-2*AAActivitiesListLeftLeft, 40);
    _segmentControl.selectedSegmentIndex = 0;
    _segmentControl.layer.cornerRadius = 5.0;
    _segmentControl.backgroundColor = [UIColor whiteColor];
    _segmentControl.tintColor = rgb(221, 101, 115, 1.0);
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"SnellRoundhand-Bold" size:16],NSFontAttributeName ,nil];
    
    [_segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    [self.view addSubview:_segmentControl];
//    [self.view sendSubviewToBack:_segmentControl];

//    [self.view addSubview:_segmentControl];
    
}


//事件
-(void)segmentAction:(UISegmentedControl *)Seg{
    NSInteger index = Seg.selectedSegmentIndex;
    //未登录判断
    if (index != 0) {
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        if (!userModel.isLogin) {
            QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
            UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
            loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
            return;
        }
    }
    if (_listStyle == index) {
        return;
    }
    if (_iHttpOperator != nil) {
        [_activitiesList reloadDeals];
        [self.iHttpOperator cancel];

    }
    [_dataArray removeAllObjects];
    indexPage = 1;
    switch (index) {
        case 0:
            [self locationStatus];
            self.imgName = @"nearnohd";
            _listStyle = L_nearByList;
            break;
        case 1:
            self.imgName = @"nohd";
            _listStyle = L_friendList;
            break;
        case 2:
             self.imgName = @"myhd";
            _listStyle = L_myList;
            break;
    }
    
    //        [self httpDowloadWithListStyle:_listStyle];
    [_activitiesList beginRefreshing];

    
    
    
}

- (void)setListStyle:(ListStyle)listStyle {
    _listStyle = listStyle;

//    for (UIButton *button in _headerView.subviews) {
//        button.selected = NO;
//        if (button.tag == _listStyle+1) {
//            button.selected = YES;
//        }
//    }
    
    [_dataArray removeAllObjects];
    indexPage = 1;
    
    switch (listStyle) {
        case L_nearByList:
            _segmentControl.selectedSegmentIndex = 0;
            break;
        case L_friendList:
            _segmentControl.selectedSegmentIndex = 1;
            break;
        case L_myList:
            _segmentControl.selectedSegmentIndex = 2;
            break;
    }
    
    [self.activitiesList beginRefreshing];

}

#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 2002) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
            QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
            UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
            loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            //    loginView.modalPresentationStyle = UIModalPresentationPopover;
            [self.navigationController presentViewController:loginNav animated:YES completion:nil ];

        }
        
    }
}

#pragma mark   UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AAActivitiesListTableViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"cell";
    AAActivitiesListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[AAActivitiesListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }

    cell.width = _activitiesList.width;
    [cell resetViewsWidth];


    if (indexPath.section < [_dataArray count]) {
        AAActivity *model = _dataArray[indexPath.section];
        
        if (_dataArray.count != 0) {
            [cell setTactivity:model];
            cell.index = indexPath.section;
            
            if (_segmentControl.selectedSegmentIndex == 2) {
                cell.isMine = YES;
                
            }
            else
            {
                cell.isMine = NO;
                
            }
            
        }
        
        //添加融云未读提示  cell里面可隐藏
//        NSInteger unReadCount = [[RCIM sharedRCIM] getUnreadCount:ConversationType_GROUP targetId:model.chatId];
//        cell.unReadCount = unReadCount;
    }
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    if (!userModel.isLogin) {
        QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
        UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
        loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
        return;
    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AADetailsViewController * detailsViewController = [[AADetailsViewController alloc]init];
    AAActivity *activity = [_dataArray objectAtIndex:indexPath.section];
    detailsViewController.activityId = activity.t_id;
    detailsViewController.tagType = _listStyle;
    [self.navigationController pushViewController:detailsViewController animated:YES];
}


#pragma mark HeaderViewDelegate

- (void)headerBtnAction:(UIButton *)sender
{
//    NSLog(@"%ld",sender.tag);
    if (_listStyle+1 != sender.tag) {//判定现在点击的按钮是否是选中状态
        [_dataArray removeAllObjects];
        indexPage = 1;
        switch (sender.tag) {
            case 1:
                _listStyle = L_nearByList;
                break;
            case 2:
                _listStyle = L_friendList;
                break;
            case 3:
                _listStyle = L_myList;
                break;
        }

//        [self httpDowloadWithListStyle:_listStyle];
        [_activitiesList beginRefreshing];

    }
}





#pragma mark -----------------------------------------------HttpDownLoad
- (void)httpDowloadWithListStyle:(ListStyle)style
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    
    NSString *longitude = [NSString stringWithFormat:@"%f",[[QCLocalLocation shareInstance] longitude]];
    NSString *latitude = [NSString stringWithFormat:@"%f",[[QCLocalLocation shareInstance] latitude]];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AAActivitiesListViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        [this httpLoadError:error];
    } param:^(NSString *s) {
        
        /*
        TActivityBriefManager* _activityM = (TActivityBriefManager*)  [assginHtttperator getAopInstance:[TActivityBriefManager class] returnValue:[NSSkyArray class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];

        if (style == L_myList) {
            [_activityM getTActivityList:userModel.user.t_id tagType:style longitude:longitude latitude:latitude categoryType:this.filtrateView.mine dateType:this.filtrateView.time keyword:this.filtrateView.text page:indexPage];
        }else {
            [_activityM getTActivityList:userModel.user.t_id tagType:style longitude:longitude latitude:latitude categoryType:this.filtrateView.type dateType:this.filtrateView.time keyword:this.filtrateView.text page:indexPage];
        }
        
        */
        
        
        
        
        [this httpLOadParams:s style:style longitude:longitude localLatitude:latitude httpOperation:assginHtttperator];
        /*
        //是否开启定位服务
        NSInteger gpsStatus = 0;
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
            gpsStatus = 1;
        }
        
        AAManager *_activityM = (AAManager *)[assginHtttperator getAopInstance:[AAManager class] returnValue:[NSSkyArray class]];
        
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        NSString *userToken = userModel.user.yxbToken;
        if (userToken == nil) {
            userToken = @"";
        }
        
        [_activityM getTActivityListWGS84:userToken tagType:style localLongitude:longitude localLatitude:latitude categoryType:this.filtrateView.type dateType:this.filtrateView.time keyword:this.filtrateView.text page:indexPage payType:this.filtrateView.mine costType:this.filtrateView.cost gpsStatus:gpsStatus];
        
        */
        
        
        
        
        
//        if (style == L_myList) {
//            if ((userToken != nil) && [userToken length] > 0)
//            {
//
//            }
//            else
//            {
////                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
////                [alert show];
//            }

//            [_activityM getTActivityList:userModel.user.t_id tagType:style longitude:longitude latitude:latitude categoryType:this.filtrateView.mine dateType:this.filtrateView.time keyword:this.filtrateView.text page:indexPage];
//        }else {
//            [_activityM getTActivityList:userModel.user.yxbToken tagType:style localLongitude:longitude localLatitude:latitude categoryType:this.filtrateView.type dateType:this.filtrateView.time keyword:this.filtrateView.text page:indexPage payType:this.filtrateView.mine costType:this.filtrateView.cost];
//        }

        
        
        
    } complete:^(NSSkyArray* r, int taskid) {
  
        [this httpLoadComplete:r];
        
        
    /*
        this.view.backgroundColor = rgb(238, 236, 246, 1.0);

  
        if (r.errCode == 0) {
            if (r.iArray.count>0) {
                if (indexPage>1) {
                    [this.dataArray addObjectsFromArray:r.iArray];
                    
                }else{
                    this.dataArray = r.iArray ;
                }
                this.activitiesList.tableFooterView = [UIView new];
                
            }else{
                if (indexPage == 1) {
                    [this.dataArray removeAllObjects];
                    if (self.nullImage == nil) {
                        self.nullImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, this.activitiesList.height)];
                    }
                    self.nullImage.contentMode = UIViewContentModeCenter;
                    self.nullImage.image = [UIImage imageNamed:self.imgName];
                    this.activitiesList.tableFooterView = self.nullImage;
                    

                }
                else
                {
                    this.activitiesList.tableFooterView = [UIView new];

                }

                
            }

            
        }else if (r.errCode == 7) {
            
        }else {
            [this.dataArray removeAllObjects];
//            UIView * view = [[UIView alloc]initWithFrame:CGRectZero];
//            this.activitiesList.tableFooterView = view;

            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
        }
        if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
            this.activitiesList.hasFooter = YES;
        }else {
            this.activitiesList.hasFooter = NO;
        }
        [this.activitiesList reloadDeals];
        [this.activitiesList reloadData];
         */
    }];
    [self.iHttpOperator connect];
    
}
//访问出错
- (void)httpLoadError:(THttpOperatorErrorCode) error{
    if (error == EHttp_Operator_Failed) {
        //服务器挂了
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
    }
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s style:(ListStyle)style longitude:(NSString *)longitude localLatitude:(NSString *)latitude httpOperation:(HttpOperator *)httpOperation{
    //是否开启定位服务
    NSInteger gpsStatus = 0;
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        gpsStatus = 1;
    }
    
    AAManager *_activityM = (AAManager *)[httpOperation getAopInstance:[AAManager class] returnValue:[NSSkyArray class]];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    NSString *userToken = userModel.user.yxbToken;
    if (userToken == nil) {
        userToken = @"";
    }
    
    [_activityM getTActivityListWGS84:userToken tagType:style localLongitude:longitude localLatitude:latitude categoryType:self.filtrateView.type dateType:self.filtrateView.time keyword:self.filtrateView.text page:indexPage payType:self.filtrateView.mine costType:self.filtrateView.cost gpsStatus:gpsStatus];
}
//请求完成
- (void)httpLoadComplete:(NSSkyArray *)r{
    self.view.backgroundColor = rgb(238, 236, 246, 1.0);
    
    if (r.errCode == 0) {
        if (r.iArray.count>0) {
            if (indexPage>1) {
                [self.dataArray addObjectsFromArray:r.iArray];
                
            }else{
                self.dataArray = r.iArray ;
            }
            self.activitiesList.tableFooterView = [UIView new];
            
        }else{
            if (indexPage == 1) {
                [self.dataArray removeAllObjects];
                if (self.nullImage == nil) {
                    self.nullImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.activitiesList.height)];
                }
                self.nullImage.contentMode = UIViewContentModeCenter;
                self.nullImage.image = [UIImage imageNamed:self.imgName];
                self.activitiesList.tableFooterView = self.nullImage;
                
                
            }
            else
            {
                self.activitiesList.tableFooterView = [UIView new];
                
            }
            
            
        }
        
        
    }else if (r.errCode == 7) {
        
    }else {
        [self.dataArray removeAllObjects];
        //            UIView * view = [[UIView alloc]initWithFrame:CGRectZero];
        //            this.activitiesList.tableFooterView = view;
        
        
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alert show];
    }
    if (r.iArray.count != 0 && r.iArray.count%20 == 0) {
        self.activitiesList.hasFooter = YES;
    }else {
        self.activitiesList.hasFooter = NO;
    }
    [self.activitiesList reloadDeals];
    [self.activitiesList reloadData];

}







-(void)makeCellHeightArrayWithArray:(NSMutableArray *)dataArray
{
    
    CGFloat width = kDeviceWidth - 130;
    if (indexPage == 1) {
        [_cellHeightArray removeAllObjects];
    }
    for (AAActivity *detail in dataArray) {
        NSString *detailStr = detail.destName;
        CGSize size = [YXBTool getFontSizeWithString:detailStr font:[UIFont systemFontOfSize:17] constrainSize:CGSizeMake(width, CGFLOAT_MAX)];
        
        [_cellHeightArray addObject:[NSString stringWithFormat:@"%f",size.height]];
    }
    
}


#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self refreshData];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float h = scrollView.contentOffset.y + scrollView.height - scrollView.contentSize.height;
    if (h > 30 && !self.activitiesList.isRefresh && self.activitiesList.hasFooter == YES) {
        if (_dataArray.count%20==0) {
            indexPage ++;
            [self httpDowloadWithListStyle:_listStyle];
        }else {
            
        }
    }

}

//刷新数据
- (void)refreshData {
    indexPage = 1;
    [self httpDowloadWithListStyle:_listStyle];
}

#pragma mark - FiltrateView
- (void)initFiltrateView {
    UIButton *filtrateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    filtrateButton.frame = CGRectMake(self.view.width - 80, kDeviceHeight-64-50-20, 50, 50);
//    filtrateButton.backgroundColor = [UIColor grayColor];
//    filtrateButton.alpha = 0.5;
//    filtrateButton.layer.cornerRadius = filtrateButton.height/2;
//    [filtrateButton setTitle:@"筛" forState:UIControlStateNormal];
    [filtrateButton setImage:[UIImage imageNamed:@"AA_shai-icon"] forState:UIControlStateNormal];
    
    [filtrateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [filtrateButton addTarget:self action:@selector(filtrateAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:filtrateButton];
    
    _filtrateView = [[[NSBundle mainBundle] loadNibNamed:@"AAFiltrateView" owner:self options:nil] lastObject];
    _filtrateView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
    _filtrateView.delegate = self;
    if (_listStyle == L_myList) {
        _filtrateView.mineView.hidden = NO;
        _filtrateView.nearbyView.hidden = YES;
    }else {
        _filtrateView.nearbyView.hidden = NO;
        _filtrateView.mineView.hidden = YES;
    }
    _filtrateView.type = _filtrateType;
//    _filtrateView.hidden = YES;
//    [self.view addSubview:_filtrateView];
}

- (void)filtrateAction:(UIButton *)button {
//    _filtrateView.hidden = NO;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:_filtrateView];
    if (_listStyle == L_myList) {
        _filtrateView.mineView.hidden = NO;
        _filtrateView.nearbyView.hidden = YES;
    }else {
        _filtrateView.nearbyView.hidden = NO;
        _filtrateView.mineView.hidden = YES;
    }
}

#pragma mark - FiltrateView delegate
- (void)sureButtonDidTouch:(AAFiltrateView *)filtrateView {
//    [self refreshData];
    [self.activitiesList beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LocationStatus
- (void)locationStatus {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        //用户拒绝使用位置服务
//        if (KDeviceOSVersion >= 8.0) {
//            
//        }else {
//            
//        }
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"为了您更好的体验，请打开位置服务功能。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alterView.tag = 2001;
        [alterView show];
    }
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
