//
//  FriendSelecteViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/11/10.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "FriendSelecteViewController.h"
#import "QCNewFriendViewController.h"
#import "FriendDetailViewController.h"
#import "ScannerViewController.h"
#import "LoanDetailsViewController.h"

#import "QCBaseTableView.h"
#import "QCSearchBar.h"
#import "YXBTool.h"
#import "NSSkyArray.h"
#import "TFriendRelationManager.h"
#import "DBManager.h"
#import "User.h"
#import "TFriendRelation.h"
#import "MsgCenterMgr.h"
#import "MsgCenterMgr+Public.h"

#import "UIImageView+WebCache.h"
#import "QCLinkManCell.h"

#import "UIAlertView+Block.h"

#import "StatusHttp.h"

#import "YXBPayAction.h"
#import "AppDelegate.h"

#import "LoanManagerV10.h"
#import "LoanSentSuccessfully.h"
@interface FriendSelecteViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,QCSearchBarDelegate,UIAlertViewDelegate,UISearchBarDelegate,QCLinkManCellDelegate,StatusHttpDelegate>


@property(nonatomic,weak)UISearchBar *searchBar;
@property (nonatomic,weak)UIControl *control;
@property (nonatomic,weak)UIView *bottomView;
@property (nonatomic,weak)UIButton *sureButton;
/**
 新朋友和扫一扫
 */
@property(nonatomic,strong)NSArray *haveNewFriendArray;
/**
 用于搜索过滤
 */
@property (nonatomic,strong) NSMutableArray *fullModelArray;
/**
 用于数据展示的字典，替换以前的二维数组
 */
@property (nonatomic,strong) NSMutableDictionary *dataDictionary;
/**
 搜索结果字典
 */
@property (nonatomic,strong) NSMutableDictionary *searchResultDictionary;
/**
 字典key的排序
 */
@property (nonatomic,strong) NSMutableArray *sortedkeysArray;
/**
 AA收款时多选被选中的Cell的下标
 */
@property (nonatomic,strong)NSMutableArray *selectedUserArray;
/**
 判断多选还是单选 yes 多选 no单选
 */
@property (nonatomic,assign)BOOL isMultipleChoices;

@end

@implementation FriendSelecteViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectedUserArray = [[NSMutableArray alloc] init];
        self.sortedkeysArray = [[NSMutableArray alloc] init];
        self.dataDictionary = [[NSMutableDictionary alloc] init];
        self.searchResultDictionary = [[NSMutableDictionary alloc] init];
        self.fullModelArray = [[NSMutableArray alloc] init];
        NSDictionary *dic1 = @{@"imageName":@"hy-add-icon",@"nickName":@"新朋友"};
        NSDictionary *dic2 = @{@"imageName":@"hy-sm-icon",@"nickName":@"扫一扫"};
        
        self.haveNewFriendArray = @[dic1,dic2];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self judge];
    [self setTitle];
    [self initNav];
    [self initView];
    [self httpRequest];
    [self readLocalData];
    if (_maxNames == 0) {
        _maxNames = NSIntegerMax;
    }
}
//状态判断
-(void)judge{
    if (self.friendType == LoanNewFriendTypeDefault) {//好友管理
        self.session0Hidden = NO;
    }else{
        self.session0Hidden = YES;
    }
    
    if (self.friendType == LoanNewFriendTypeAAShouKuan||self.friendType ==LoanNewFriendTypeAAYaoQing) {
        self.isMultipleChoices = YES;
    }else{
        self.isMultipleChoices = NO;
    }
}
-(void)setTitle{
    switch (self.friendType) {
        case 0://好友管理
            self.title = @"好友";
            break;
        case 1://借入
            self.title = @"选择朋友";
            break;
        case 2://借出
            self.title = @"选择朋友";
            break;
        case 3://担保
            break;
        case 4://代付当前期
            break;
        case 5://代付全部
            break;
        case 6://AA活动邀请
            self.title = @"好友";
            break;
        case 7://AA收款
            self.title = @"好友";
            break;
        default:
            break;
    }
    
}

#pragma mark - UI创建
-(void)initNav{
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
}
-(void)initView{
    
    [self createTableView];
    
    [self createNoRecordView];
    
    [self createBottomView];
}

-(void)createTableView{
    CGFloat headerH = getScreenFitSize(75.0/2);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, headerH)];
    headerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headerView];
    
    //系统自带搜索框
    UISearchBar *serBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, headerH)];
    serBar.barTintColor = CellHeaderColor;
    serBar.placeholder = @"搜索";
    //去掉黑线
    serBar.showsCancelButton = NO;
    serBar.layer.borderWidth = 1;
    serBar.layer.borderColor = [[UIColor whiteColor] CGColor];
    serBar.delegate = self;
    _searchBar = serBar;
    [headerView addSubview:_searchBar];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,headerView.bottom, kDeviceWidth, kDeviceHeight-64-headerView.height) style:UITableViewStylePlain];
    tableView.dataSource = self;
//    tableView.refreshDelegate = self;
    tableView.delegate = self;
    //多选
    if (self.isMultipleChoices) {
        tableView.allowsMultipleSelectionDuringEditing=YES;
        [tableView setEditing:YES animated:YES];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView = tableView;
    [self.view addSubview:self.myTableView];
    
    if (KDeviceOSVersion>=7.0) {
        self.myTableView.sectionIndexBackgroundColor = [UIColor clearColor];
        self.myTableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
    }
    if (KDeviceOSVersion>=6.0) {
        self.myTableView.sectionIndexColor = rgb(85, 85, 85, 1);
    }

}

-(void)createNoRecordView{

    UIView *tempnoRecordView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64)];
    tempnoRecordView.backgroundColor = [UIColor whiteColor];
    tempnoRecordView.hidden = YES;
    self.noRecordView = tempnoRecordView;
    [self.view addSubview:_noRecordView];
    
    CGFloat noRecordLabelGap = getScreenFitSize(40);
    CGFloat noRecordLabelH = getScreenFitSize(25.0);
    
    UILabel *noRecordLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(noRecordLabelGap, 0, kDeviceWidth-noRecordLabelGap*2, noRecordLabelH)];
    noRecordLabel1.text = @"您还没有无忧借条好友，";
    noRecordLabel1.backgroundColor = [UIColor clearColor];
    noRecordLabel1.font = [UIFont systemFontOfSize:getScreenFitSize(22)];
    [_noRecordView addSubview:noRecordLabel1];
    
    noRecordLabel1.center = CGPointMake(_noRecordView.center.x, _noRecordView.center.y/5*2);
    
    UILabel *noRecordLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(noRecordLabelGap, 0, kDeviceWidth-noRecordLabelGap*2, noRecordLabelH)];
    noRecordLabel2.text = @"马上添加朋友吧!";
    noRecordLabel2.backgroundColor = [UIColor clearColor];
    noRecordLabel2.font = [UIFont systemFontOfSize:getScreenFitSize(22)];
    [_noRecordView addSubview:noRecordLabel2];
    
    noRecordLabel2.center = CGPointMake(_noRecordView.center.x, _noRecordView.center.y/5*3);
    
    CGFloat addButtonGap = getScreenFitSize(25.0);
    CGFloat addButtonH = getScreenFitSize(50.0);
    UIButton *addFriend = [[UIButton alloc] initWithFrame:CGRectMake(addButtonGap, 0, kDeviceWidth-addButtonGap*2, addButtonH)];
    [addFriend setBackgroundImage:[UIImage imageNamed:@"blue-but2"] forState:UIControlStateNormal];
    [addFriend addTarget:self action:@selector(addNewFriends) forControlEvents:UIControlEventTouchUpInside];
    [addFriend setTitle:@"添加朋友" forState:UIControlStateNormal];
    addFriend.titleLabel.font = [UIFont systemFontOfSize:getScreenFitSize(21)];
    
    addFriend.center = _noRecordView.center;
    
    [_noRecordView addSubview:addFriend];
}

-(void)createBottomView{
    if (self.isMultipleChoices) {//多选时才执行
        UIView *botView = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-64-49, kDeviceWidth, 49)];
        CALayer *bottomLayer = [CALayer layer];
        bottomLayer.frame = CGRectMake(0.0f, 0.0f, botView.width, 1.0f);
        bottomLayer.backgroundColor = kLineColor.CGColor;
        [botView.layer addSublayer:bottomLayer];
        
        botView.backgroundColor = [UIColor whiteColor];
        self.bottomView = botView;
        [self.view addSubview:_bottomView];
        
        //上移tableview
        self.myTableView.height = kDeviceHeight-64-75/2.0 - _bottomView.height;
        
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(10, (_bottomView.height-40)/2, kDeviceWidth-20, 40);
        [sureButton setTitle:@"确 定(0)" forState:UIControlStateNormal];
        
        sureButton.titleLabel.font = [UIFont systemFontOfSize:22];
        sureButton.backgroundColor = rgb(40, 158, 255, 1);
        sureButton.layer.cornerRadius = 5;
        [sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.sureButton = sureButton;
        [_bottomView addSubview:self.sureButton];
    }
}


//多选时底部确定按钮
-(void)sureButtonAction:(UIButton *)btn{
    
    if(_selectedUserArray != nil && [_selectedUserArray count] > 0)
    {
        NSString *names = [self namesWithUserArray:self.selectedUserArray];
        if (_delegate && [_delegate respondsToSelector:@selector(createAACollectMoneyRequestWithNames:)]) {
            //处理aa收款和aa邀请
            
            [_delegate createAACollectMoneyRequestWithNames:names];
        }
        
    }
    else
    {
        [ProgressHUD showSuccessWithStatus:@"选择好友需大于一人"];
    }
    
}

//没有好友时添加好友
- (void)addNewFriends {
    QCNewFriendViewController *newVC = [[QCNewFriendViewController alloc] init];
    
    [[YXBTool getCurrentNav] pushViewController:newVC animated:YES];
}

//读取本地数据
-(void)readLocalData{
    __weak typeof(self)this = self;
    [[DBManager shareInstance] readLocalFriendRelationsDBWithCompleteBlock:^(NSMutableArray *resultArray) {
        if(this.dataDictionary.count)
        {
            [this.dataDictionary removeAllObjects];
        }
        if (this.fullModelArray.count) {
            [this.fullModelArray removeAllObjects];
        }
        this.fullModelArray = resultArray;
        [this processDataToDicWithArray:resultArray isSaved:NO];
        [this.myTableView reloadData];
    }];
}

#pragma mark - 网络请求
#pragma mark - 获取好友
- (void)httpRequest {
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block FriendSelecteViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        [this stopDefaultAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        if (error == EHttp_Operator_Failed) {
            [ProgressHUD showErrorWithStatus:@"加载失败,请检查手机网络"];
        }
        
    } param:^(NSString *s) {
        
        [this httpLoadParams:assginHtttperator];
    } complete:^(NSSkyArray *r, int taskid){
         
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator{
    
    QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
    User *user = localUser.user;
    
    TFriendRelationManager* _currFriend = (TFriendRelationManager *)  [assginHtttperator getAopInstance:[TFriendRelationManager class] returnValue:[NSSkyArray class]];
    
    [_currFriend getTFriendRelationByUserIdAndQueryType:user.t_id withType:2];
    
}
- (void)httpLoadComplete:(NSSkyArray *)r{
    if (r.errCode == 0 ||r.errCode==7) {
        if (r.iArray.count != 0) {
            //将数组的数据结构处理为字典
            NSLog(@"%@",r.iArray);
            if(self.dataDictionary != nil)
            {
                [self.dataDictionary removeAllObjects];
            }
            [self processDataToDicWithArray:r.iArray isSaved:NO];
            self.fullModelArray = r.iArray;
            NSLog(@"this.dataDictionary===%@",self.dataDictionary);
        }else{
            self.noRecordView.hidden = NO;
        }
        [self.myTableView reloadData];
    }
    else{
        [ProgressHUD showErrorWithStatus:r.errString];
    }
}
#pragma mark - 借款请求
- (void)httpJiekuanRequest:(YXBLoan*)yxbLoanModel
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block FriendSelecteViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        [this stopDefaultAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        if (error == EHttp_Operator_Failed) {
            [ProgressHUD showErrorWithStatus:@"加载失败,请检查手机网络"];
        }
        
    } param:^(NSString *s) {
        LoanManagerV10 *managerV3 = (LoanManagerV10*)[assginHtttperator getAopInstance:[LoanManagerV10 class] returnValue:[CreateLoanResponse class]];
        [managerV3 __yxb_service__createYXBLoan:this.yxbLoanModel];
        
    } complete:^(CreateLoanResponse *r, int taskid){

        if (r.errCode == 0) {
            //发送成功  清空借款数据
            JieKuanInstance *loanInstance = [JieKuanInstance shareInstance];
            loanInstance.yxbLoan = nil;

            
            LoanSentSuccessfully * loanViewControllers = [[LoanSentSuccessfully alloc]init];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loanViewControllers];
            loanViewControllers.data = r;
            [[YXBTool getCurrentNav] pushViewController:loanViewControllers animated:YES];
            
        }else{
            [ProgressHUD showErrorWithStatus:r.errString];
        }
        
    }];
    [self.iHttpOperator connect];
}

//把请求得到的数组转化为字典
-(void)processDataToDicWithArray:(NSArray *)result isSaved:(BOOL)isSaved{
    
    if (self.sortedkeysArray.count) {
        [self.sortedkeysArray removeAllObjects];
    }
    if(!result.count){
        return;
    }
    for (TFriendRelation *friend in result) {
        User *friendUser = friend.friendUser;
        if (friendUser != nil && friendUser.t_id != 0)
        {
            if (friendUser.nameSpell == nil) {
                friendUser.nameSpell = [YXBTool pinyinWithText:friendUser.nickname];
            }

            NSString *pinYin = [friendUser.nameSpell lowercaseString];
            
            //构造字典
            NSString *first = [pinYin substringToIndex:1];
            if ([YXBTool isAlphabetContainsChar:first]) {
                NSMutableArray *array = [_searchBar.text.length<=0?self.dataDictionary:self.searchResultDictionary objectForKey:first];

                if (array == nil) {
                    array = [NSMutableArray array];
                    [array addObject:friendUser];
                    [_searchBar.text.length<=0?self.dataDictionary:self.searchResultDictionary setObject:array forKey:first];
                }else{
                    [array addObject:friendUser];
                }
                
            }else{ //在字母之外
                //把以#号为key的数组添加到字典中
                NSMutableArray *array = [_searchBar.text.length<=0?self.dataDictionary:self.searchResultDictionary objectForKey:@"#"];
                
                if (array == nil) {
                    array = [NSMutableArray array];
                    [_searchBar.text.length<=0?self.dataDictionary:self.searchResultDictionary setObject:array forKey:@"#"];
                }
                [array addObject:friendUser];
                
            }
                
        }
        
    }
    if (_searchBar.text.length<=0) {
        self.sortedkeysArray = [NSMutableArray arrayWithArray:[[self.dataDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    }else{
        self.sortedkeysArray = [NSMutableArray arrayWithArray:[[self.searchResultDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    }
    
    
    //将”#“移动到最后
    if ([self.sortedkeysArray containsObject:@"#"])
    {
        NSInteger index = [self.sortedkeysArray indexOfObject:@"#"];
        [self.sortedkeysArray addObject:@"#"];
        if (index == 0) {
            [self.sortedkeysArray removeObjectAtIndex:0];
        }
    }
    DBManager *dbManager = [DBManager shareInstance];
    [dbManager saveFriendRelationsToDB:self.dataDictionary];
}

#pragma mark - QCBaseTableViewDelegate
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView{
    
    
}
#pragma mark - UITableViewDataSourceDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger count = 1;

    if ([_searchBar.text length] <= 0){//不是搜索的结果

            count  = [_sortedkeysArray count] + 1;

    }else{//搜索的结果
        
        count = [_sortedkeysArray count];

    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count = 0;
    
    if ([_searchBar.text length] <= 0) {//不是搜索出来的
        if (section == 0) {

            count = 2;
        }else{
            count = [[self.dataDictionary objectForKey:_sortedkeysArray[section - 1]] count];
        }
    }else{ //搜索出来的
    
        if ([_sortedkeysArray count] == 0) {
            count = 0;
        }else{
            count = [[self.searchResultDictionary objectForKey:_sortedkeysArray[section]] count];
        }
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId0 = @"cellID0";//session0
    static NSString * cellId1 = @"cellID1";
    QCLinkManCell * cell;
    if (indexPath.section == 0&&[_searchBar.text length] <= 0&&[_sortedkeysArray count]) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellId0];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
    }
    if (cell == nil) {
        if (indexPath.section == 0&&[_searchBar.text length] <= 0&&[_sortedkeysArray count]) {
            cell = [tableView dequeueReusableCellWithIdentifier:cellId0];
            
                cell = [[QCLinkManCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId0];
                [cell closeSwipeAction];
                cell.delegate = self;
            
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
                cell = [[QCLinkManCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1];
                [cell closeSwipeAction];
                cell.delegate = self;
        }
    }
    if ([_searchBar.text length] <= 0) {
        if ([_sortedkeysArray count]>0) {
            cell.m_checkImageView.hidden = YES;
            if (indexPath.section == 0) {
                if (!self.session0Hidden) {
                    cell.dic = [self.haveNewFriendArray objectAtIndex:indexPath.row];
                }else{
                    cell.dic = nil;
                }
                
                if ([[MsgCenterMgr sharedInstance] hasNewFriend]) {
                    UIImageView * cellIndicator = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new-icon"]];
                    cellIndicator.frame = CGRectMake(0, 0, 26, 26);
                    cell.accessoryView = cellIndicator;
                }else {
                    cell.accessoryView = nil;
                }
            }else {
                NSArray *mArray = [self.dataDictionary objectForKey:_sortedkeysArray[indexPath.section - 1]];
                User *friendUser = mArray[indexPath.row];
                cell.userModel = friendUser;
                cell.arrow.image=[UIImage imageNamed:@""];
                cell.accessoryView = nil;
                cell.canDelete = YES;
            }
        }else {
            //无数据同样显示新朋友
            cell.m_checkImageView.hidden = YES;
        }
    }else {
        cell.accessoryView = nil;
        NSArray *mArray = [self.searchResultDictionary objectForKey:_sortedkeysArray[indexPath.section]];
        User *friendUser = mArray[indexPath.row];
        cell.userModel = friendUser;
        cell.arrow.image=[UIImage imageNamed:@""];
        
    }
    if (self.isMultipleChoices) {
        cell.m_checkImageView.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }


    return cell;
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([_searchBar.text length] <= 0) {
        UIView * subView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kSectionHeight)];
        subView.backgroundColor = CellHeaderColor;
        NSString *title = nil;
        if (section == 0) {
            return nil;
            
        }else {
            if (_sortedkeysArray.count >0) {

                NSString *first = _sortedkeysArray[section - 1];
                NSString *uppercaseString = first.uppercaseString;
                
                title = [NSString stringWithFormat:@"%@",uppercaseString];
            }
        }
        [self CreateLabel:title frame:CGRectMake(15, 0, 50, kSectionHeight) withView:subView textAlignment:0 fontSize:14 textColor:kCellHeaderTextColor];
        return subView;
    } else {
        UIView * subView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kSectionHeight)];
        subView.backgroundColor = CellHeaderColor;
        NSString *title = nil;

        if (_sortedkeysArray.count >0) {
            
            NSString *first = _sortedkeysArray[section];
            NSString *uppercaseString = first.uppercaseString;
            
            title = [NSString stringWithFormat:@"%@",uppercaseString];
        }
        [self CreateLabel:title frame:CGRectMake(15, 0, 50, kSectionHeight) withView:subView textAlignment:0 fontSize:14 textColor:kCellHeaderTextColor];
        return subView;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QCLinkManCell *cell = (QCLinkManCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (_searchBar.text.length<=0) {

        if (indexPath.section == 0) {
            if (indexPath.row==0) {//新朋友
                
                if ([[MsgCenterMgr sharedInstance] hasNewFriend]) {
                    [[MsgCenterMgr sharedInstance] removeFriend];
                    
                }
                
                [self addNewFriends];
                
            }else if (indexPath.row==1){//扫一扫
                
                ScannerViewController *svc = [[ScannerViewController alloc] init];
                [self.navigationController pushViewController:svc animated:YES];
            }
            
            
            
        }else{
            
            User *friendUser =[[self.dataDictionary objectForKey:_sortedkeysArray[indexPath.section - 1]] objectAtIndex:indexPath.row];
            
            if (self.friendType == LoanNewFriendTypeDefault) {//好友管理
                [self pushToFriendDetailVC:friendUser];
            }else if (self.isMultipleChoices){//多选 AA收款 aa邀请
                
                if (self.friendType == LoanNewFriendTypeAAShouKuan && _maxNames == [_selectedUserArray count]) {
                    
                    [ProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"AA收款最多%ld人",(long)_maxNames]];
                    return;
                }

                [cell setChecked:YES];
                [self selectedUserArrayAdd:YES user:friendUser];
            }
            else{
                [self getUserModelSelectedAtIndexPath:friendUser];
                [cell setChecked:YES];
            }
        }
    }else{
        
        User *friendUser = [[self.searchResultDictionary objectForKey:_sortedkeysArray[indexPath.section]] objectAtIndex:indexPath.row];
        if (self.friendType == LoanNewFriendTypeDefault) {//好友管理
            [self pushToFriendDetailVC:friendUser];
        }else if (self.isMultipleChoices){//多选
            [cell setChecked:YES];
            [self selectedUserArrayAdd:YES user:friendUser];
        }else{
            [self getUserModelSelectedAtIndexPath:friendUser];
        }
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    QCLinkManCell *cell = (QCLinkManCell*)[tableView cellForRowAtIndexPath:indexPath];
    User *friendUser;
    if(self.searchBar.text.length<=0){//不是搜索的结果
        NSArray *arr = [self.dataDictionary objectForKey:_sortedkeysArray[indexPath.section-1]];
        friendUser = [arr objectAtIndex:indexPath.row];
    }else{
        NSArray *arr = [self.searchResultDictionary objectForKey:_sortedkeysArray[indexPath.section]];
        friendUser = [arr objectAtIndex:indexPath.row];
    }
    
    if (self.isMultipleChoices) {
        
        [cell setChecked:NO];
        [self selectedUserArrayAdd:NO user:friendUser];
        
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0&&self.session0Hidden&&self.searchBar.text.length<=0){

        return 0.000001;
    }
    return kLinkManCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(_searchBar.text.length>0){
        return kSectionHeight;
    }else{
        if (section == 0) {
            return 0.000001;
        }else {
            return kSectionHeight;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;

}
//取消编辑状态下的缩进
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}


//显示通讯录右侧索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView !=self.myTableView) {
        return nil;
    }else{
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        [titles addObject:UITableViewIndexSearch];
        return _sortedkeysArray;
    }
}
-(void)getUserModelSelectedAtIndexPath:(User *)selectedUser{
    
    switch (_friendType) {
        case LoanNewFriendTypeJieRu:
        {
            //借入
            [self jieRuActionWithUser:selectedUser];
        }
            break;
        case LoanNewFriendTypeJieChu:
        {
            //借出
            [self jieChuActionWithUser:selectedUser];
        }
            break;
        case LoanNewFriendTypeDanBao:
        case LoanNewFriendTypeDaiFuDangQianQi:
        case LoanNewFriendTypeDaiFuQuanBu:
        {
            //担保&代付
            [self danbaoDaifuActionWithUser:selectedUser];
        }
            
        default:
            break;
    }
    
}



//多选获取用户模型
-(void)selectedUserArrayAdd:(BOOL)isAdd user:(User *)user{
    if (isAdd) {
        [self.selectedUserArray addObject:user];
        
        
    }else{
        for (User *user0 in self.selectedUserArray) {
            if (user0.t_id == user.t_id) {
                [self.selectedUserArray removeObject:user0];
                break;
            }
        }
        
    }
    [self.sureButton setTitle:[NSString stringWithFormat:@"确定(%ld)",(unsigned long)self.selectedUserArray.count] forState:UIControlStateNormal];
}

-(NSString *)namesWithUserArray:(NSArray *)users
{
    NSMutableString *names = [[NSMutableString alloc] init];
    for (int i = 0; i < [users count]; i ++) {
        User *user = users[i];
        [names appendString:[NSString stringWithFormat:@"%ld|",(long)user.t_id]];
    }
    
    if ([names length] > 1) {
        [names deleteCharactersInRange:NSMakeRange([names length] - 1, 1)];
        NSLog(@"names---%@",names);
    }
    
    return names;
}

-(void)pushToFriendDetailVC:(User *)friendUser{
    FriendDetailViewController *controller = [[FriendDetailViewController alloc] init];
    controller.user = friendUser;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark --------- QCSearchBar--------------------

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    _searchBar.showsCancelButton = YES;
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    [_searchBar endEditing:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if([searchText isEqualToString:@""])
    {
        [self.view endEditing:YES];
        [_searchBar endEditing:YES];

        [self fileterFullModelArrayWithKey:@""];
        [self readLocalData];
        _searchBar.showsCancelButton = NO;
    }else{
        [self fileterFullModelArrayWithKey:searchText];
        
    }
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    [_searchBar endEditing:YES];
    _searchBar.text = @"";
    [self fileterFullModelArrayWithKey:@""];
    
    [self readLocalData];
    
    _searchBar.showsCancelButton = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.view endEditing:YES];
    
    [_searchBar resignFirstResponder];
}

//根据搜索过滤数据
-(void)fileterFullModelArrayWithKey:(NSString *)key
{
    NSMutableArray *tempSearchArray = [NSMutableArray array];
    if ([key length] > 0) {
        NSString *pinyinKey = [[YXBTool pinyinWithText:key] lowercaseString];
        for (int i = 0; i < [_fullModelArray count]; i ++)
        {
            TFriendRelation *tf = _fullModelArray[i];
            User *user = tf.friendUser;
            NSString *pinyinNickName = [YXBTool pinyinWithText:user.nickname];

            NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"nickname CONTAINS '%@'",key]];
            NSPredicate *predicate1 = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF CONTAINS '%@'",pinyinKey]];
            
            NSRange range = {0,1};
            
            NSString *subStr = [key substringWithRange:range];
            if(strlen([subStr UTF8String])==3){
//                NSLog(@"汉字");
                if ([predicate evaluateWithObject:user]) {
                    [tempSearchArray addObject:tf];
                }
            }else{
//                NSLog(@"非汉字");
                if ([predicate1 evaluateWithObject:pinyinNickName]) {
                    [tempSearchArray addObject:tf];
                }
            }
            
            
            

        }
    }
    
    if ([tempSearchArray count] > 0) {
        if(self.searchResultDictionary.count){
            [self.searchResultDictionary removeAllObjects];
        }
        [self processDataToDicWithArray:tempSearchArray isSaved:YES];
    }else{
        [self processDataToDicWithArray:@[] isSaved:YES];
    }
    [self.myTableView reloadData];
}


#pragma mark 处理点击事件
-(void)jieRuActionWithUser:(User *)selectedUser
{
    self.yxbLoanModel.lenderId = selectedUser.t_id;
    self.yxbLoanModel.loanFriendType =  1;
    NSString *title = [NSString stringWithFormat:@"是否向\"%@\"发起借款",selectedUser.nickname];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"发起", nil];
    __weak FriendSelecteViewController *this = self;
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            if (this.yxbLoanModel) {
                [this httpJiekuanRequest:this.yxbLoanModel];
            }
        }
    }];
    if(/* DISABLES CODE */ (NO)){
        //借入
        self.loanModel.lenderId  = selectedUser.t_id;
        self.loanModel.loanFriendType = 1;
        NSString *title = [NSString stringWithFormat:@"是否向\"%@\"发起借款",selectedUser.nickname];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"发起", nil];
        
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            if(buttonIndex == 1)
            {
                StatusHttp* http = [[StatusHttp alloc]init];
                http.delegate =self;
                [ProgressHUD showWithStatus:@"正在加载..." maskType:ProgressHUDMaskTypeBlack tipsType:ProgressHUDTipsTypeLongBottom networkIndicator:YES];
                [http __yxb_service__createAndModifyTLoan:self.loanModel];
                
            }
        }];
        
    }
    
}

-(void)jieChuActionWithUser:(User *)selectedUser
{
    //借出
    
        self.loanModel.borrowerId  = selectedUser.t_id;
        
    NSString *title = [NSString stringWithFormat:@"是否借款给\"%@\"",selectedUser.nickname];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"发起", nil];
    
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        
        if(buttonIndex == 1)
        {
            YXBPayAction *pay = [[YXBPayAction alloc] init];
            pay.payWay = YXBPayWayFukuan;
            pay.isQuickLend = YES;
            pay.loan = self.loanModel;
            [pay payAction];

            
        }
    }];
    
    
}


#pragma mark - http delegates
- (void)httpCompleteWithResultSet:(TResultSet *)set withHttpTag:(NSInteger)tag
{
    [ProgressHUD dismiss];
    if (set.errCode == 0) {
        
        for (UIViewController *viewController in [YXBTool getCurrentNav].viewControllers) {
            if ([viewController isKindOfClass:[LoanDetailsViewController class]]) {
                [[YXBTool getCurrentNav] popToViewController:viewController animated:YES];
                return;
                
            }
        }
    }else{
        UIAlertView * alertView  = [[UIAlertView alloc]initWithTitle:@"" message:set.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
}

//处理担保代付
-(void)danbaoDaifuActionWithUser:(User *)friendUser
{
    
    NSString *friendId = [NSString stringWithFormat:@"%ld",(long)friendUser.t_id];
    if (friendId != nil) {
        NSLog(@"contact name---%@",friendId);
        NSString *titleStr = @"";
        
        if (self.payType == AmorOrderPayTypeOtherPay) {
            titleStr = [NSString stringWithFormat:@"选择\"%@\"为你代付当前期?",friendUser.nickname];
        }else if (self.payType == AmorOrderPayTypeOtherPayAll)
        {
            titleStr = [NSString stringWithFormat:@"选择\"%@\"为你代付全部金额?",friendUser.nickname];
            
        }else if (self.payType == AmorOrderPayTypeSelectPeople)
        {
            titleStr = [NSString stringWithFormat:@"选择\"%@\"做你的担保人?",friendUser.nickname];
            
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:titleStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            if(buttonIndex == 1)
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(amorOrderDetailCallBackWithType:gid:)])
                {
                    [self.delegate amorOrderDetailCallBackWithType:self.payType gid:[NSString stringWithFormat:@"%@",friendId]];
                    [super leftClicked];
                }
                
            }
            
        }];
        
        
    }
    else
    {
        [ProgressHUD showSuccessWithStatus:@"请选择好友"];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
}
@end
