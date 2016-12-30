//
//  QCFriendsViewController.m
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCFriendsViewController.h"
#import "QCLinkManCell.h"
#import "SearchCoreManager.h"
#import "QCAddressListViewController.h"
//#import "AADetailsViewController.h"
#import "LoanDetailsViewController.h"
#import "QCNewFriendViewController.h"
#import "TFriendRelationManager.h"
#import "NSSkyArray.h"
#import "TFriendRelation.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "LoanOrRepayViewController.h"
#import "QCUserManager.h"
#import "TResultSet.h"
#import "FriendDetailViewController.h"
#import "AddFriendsMenuController.h"
#import "StatusHttp.h"
#import "PayViewController.h"
#import "MsgCenterMgr.h"
#import "MsgCenterMgr+Public.h"
#import "YXBTool.h"
#import "AverageManager.h"
//#import "AAReceivablesDetailViewController.h"
//#import "QCAACollectMoneyController.h"
#import "YXBPayAction.h"
#import "FriendPopView.h"
#import "FriendScanViewController.h"
#import "QCFriendModel.h"
#import "FriendDetailViewController.h"
#import "ScannerViewController.h"
#define KLetterNum 26                                       // 英文字母 个数
#define kAddressFailAlterTag 30090
@interface QCFriendsViewController ()<UIAlertViewDelegate,QCLinkManCellDelegate,QCBaseTableViewDelegate,StatusHttpDelegate,UISearchBarDelegate,UIActionSheetDelegate,FriendPopViewDelegate>
{
    NSIndexPath * selectPath;
    NSMutableArray * indexPathArray;
    StatusHttp * http;
    UIButton * navbtn;
    UIButton *sureButton;
    NSInteger addelementCount;//测试刷新添加数据
}

@property (nonatomic,retain)QCLinkManCell *editingCell;

@property (nonatomic,retain)UIImageView *badgeView;

@property (nonatomic,assign) ABAuthorizationStatus addressStatus;   //访问通讯录状态
@property (nonatomic,strong) NSMutableArray *savedArray;//数据库读取之后的数组

@end


@implementation QCFriendsViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self]; //关闭通知
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - life time
- (void)viewDidLoad{
    [super viewDidLoad];
    selectPath = nil;
    indexPathArray = [[NSMutableArray alloc]init];
    self.savedArray = [NSMutableArray new];
    self.dataDictionary = [NSMutableDictionary dictionary];
    self.fullModelArray = [NSMutableArray array];
    self.view.backgroundColor = kCustomBackground;
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"好友";
    
    [self createUI];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    self.contactDic = dic;
    
    NSMutableArray *nameIDArray = [[NSMutableArray alloc] init];
    self.searchByName = nameIDArray;
    
    [self loadSavedData];
    
    //扫一扫
    [self setNavigationButtonItrmWithiamge:@"sweep-icon" withRightOrleft:@"right" withtargrt:self withAction:@selector(scanAction:)];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    
    //初始化数据
    _cover.hidden = YES;
    if (_searchBar.text != nil) {
        _searchBar.text = nil;
        [_linkManListView reloadData];
    }
    
    //重置搜索库
    [[SearchCoreManager share] Reset];
    
    if (&ABAddressBookGetAuthorizationStatus != NULL){
        _addressStatus = ABAddressBookGetAuthorizationStatus();
        switch (_addressStatus) {
            case kABAuthorizationStatusNotDetermined:{
                self.navigationItem.rightBarButtonItem.enabled = YES;
                
                ABAddressBookRef addressBooks = NULL;
                ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error) {
                    if (error) CFRelease(error);
                });
            }
                break;
            case kABAuthorizationStatusRestricted:{
                self.navigationItem.rightBarButtonItem.enabled = NO;
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"访问通讯录受限" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                ////                alert.tag = kAddressFailAlterTag;
                //                [alert show];
            }
                break;
            case kABAuthorizationStatusDenied:{
                self.navigationItem.rightBarButtonItem.enabled = NO;
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"访问通讯录被拒绝" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                ////                alert.tag = kAddressFailAlterTag;
                //                [alert show];
            }
                break;
            case kABAuthorizationStatusAuthorized:
                break;
        }
    }
    
    [self loadData];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.iHttpOperator != nil) {
        [self.iHttpOperator cancel];
    }
    
    [_searchBar resignFirstResponder];
    //    _searchBar.isVisible = NO;
    //关闭删除按钮
    [self.editingCell closeDeleteButton];
    
    _linkManListView.scrollEnabled = YES;
}
#pragma mark - Actions
//扫一扫
- (void)scanAction:(UIButton *)button {
    
    ScannerViewController *scan = [[ScannerViewController alloc] init];
    [self.navigationController pushViewController:scan animated:YES];
}
//返回
- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//新朋友
- (void)addNewFriends {
    QCNewFriendViewController *newVC = [[QCNewFriendViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newVC animated:YES];
}

#pragma mark - httpRequest
- (void)loadData {
    self.iHttpOperator = [[HttpOperator alloc]init];
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCFriendsViewController *this = self;
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
            //清空数据库
            [self reSetDB];
            
            self.noRecordView.hidden = YES;
            
            //将数组的数据结构处理为字典
            [self processDataToDicWithArray:r.iArray isSaved:NO];
            self.fullModelArray = r.iArray;
            NSLog(@"this.dataDictionary===%@",self.dataDictionary);
            
        }else{
            self.noRecordView.hidden = NO;
            
        }
        
        [self.linkManListView reloadData];
        
    }else{
        [ProgressHUD showErrorWithStatus:r.errString];
    }
}

#pragma mark - refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self loadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    NSInteger count;
    count = [_sortedkeysArray count];
    if (count <= 0) {
        count = 1;
    }
    if ([_searchBar.text length] <= 0){
        return count+1;
    }else{
    
        return count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count = 0;

    if ([_searchBar.text length] <= 0) {
        if (section == 0) {
            count = 2;
        }else{
            if (_sortedkeysArray.count > 0) {
                count = [[self.dataDictionary objectForKey:_sortedkeysArray[section - 1]] count];
            }
        }

    }else{ //搜索出来的
    
        if ([_sortedkeysArray count] == 0){
            count = 0;
        }else{
            count = [[self.dataDictionary objectForKey:_sortedkeysArray[section]] count];
            
        }


    }
    NSLog(@"number rows==%ld",(long)count);
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kLinkManCellHeight;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if ([_searchBar.text length]){
            return kSectionHeight;
        }
        else{
            return 0;
        }
    }else{
        return kSectionHeight;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellId = @"cellID";
    QCLinkManCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[QCLinkManCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.width = _linkManListView.width;
        cell.height = kLinkManCellHeight;
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //左上角飘new
    if (indexPath.section ==0 && indexPath.row == 0 && ([[MsgCenterMgr sharedInstance] hasNewFriend])) {
        [cell showNewIcon:YES];
    }else{
        [cell showNewIcon:NO];
    }
    if ([_searchBar.text length] <= 0) {
        if ([_sortedkeysArray count] != 0) {
            
            if (indexPath.section == 0) {
     
                if (indexPath.row==0) {
                    cell.nameLabel.text = @"新朋友";
                    cell.imageview.image = [UIImage imageNamed:@"hy-add-icon"];
                    cell.arrow.image=[UIImage imageNamed:@"wxck-next"];

                }else if (indexPath.row==1){
                
                    cell.nameLabel.text = @"扫一扫";
                    cell.imageview.image = [UIImage imageNamed:@"hy-sm-icon"];
                    cell.arrow.image=[UIImage imageNamed:@"wxck-next"];
                
                }
            }else {
                //@"hy-usermr-icon.png"
                NSArray *mArray = [self.dataDictionary objectForKey:_sortedkeysArray[indexPath.section - 1]];
                User *friendUser = mArray[indexPath.row];
                [cell.imageview sd_setImageWithURL:[NSURL URLWithString:friendUser.iconAddr] placeholderImage:[UIImage imageNamed:@"userPlace"]];
                cell.nameLabel.text = friendUser.nickname;
                cell.arrow.image=[UIImage imageNamed:@""];
            }
        }
            
    }else {
    
        NSLog(@"section--%ld,  row----%ld",(long)indexPath.section,(long)indexPath.row);
        NSArray *mArray = [self.dataDictionary objectForKey:_sortedkeysArray[indexPath.section]];
        User *friendUser = mArray[indexPath.row];

        cell.nameLabel.text = friendUser.nickname;
        [cell.imageview sd_setImageWithURL:[NSURL URLWithString:friendUser.iconAddr] placeholderImage:[UIImage imageNamed:@"userPlace"]];
        cell.arrow.image=[UIImage imageNamed:@""];
    }
    
    cell.nameLabel.font = [UIFont systemFontOfSize:CellLabelFont];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_searchBar.text length] <= 0) {
        if (self.editingCell.isEditing == YES) {
            [self.editingCell closeDeleteButton];
        }else {
            if (indexPath.section == 0) {
                if (indexPath.row==0) {
                    
                    if ([[MsgCenterMgr sharedInstance] hasNewFriend]) {
                        [[MsgCenterMgr sharedInstance] removeFriend];
                        
                    }
                    
                    [self addNewFriends];
                    
                }else if (indexPath.row==1){
                    
                    ScannerViewController *svc = [[ScannerViewController alloc] init];
                     self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:svc animated:YES];
                }
                
            }else{
                
                FriendDetailViewController *controller = [[FriendDetailViewController alloc] init];
                controller.user = [[self.dataDictionary objectForKey:_sortedkeysArray[indexPath.section - 1]] objectAtIndex:indexPath.row];
                 self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
    }else{
        NSMutableArray *nameArr = [self.dataDictionary objectForKey:self.sortedkeysArray[indexPath.section]];
        User *friendUser = nameArr[indexPath.row];
        FriendDetailViewController *controller = [[FriendDetailViewController alloc] init];
        controller.user = friendUser;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView * subView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kSectionHeight)];
//    subView.backgroundColor = CellHeaderColor;
//    
//    NSString *title = nil;
//        if (section == 0) {
//            return nil;
//    
//        }else {
//                if (_sortedkeysArray.count != 0) {
//                        NSString *first = _sortedkeysArray[section - 1];
//                        NSString *uppercaseString = first.uppercaseString;
//    
//                        title = [NSString stringWithFormat:@"%@",uppercaseString];
//                    }
//                }
//                [self CreateLabel:title frame:CGRectMake(15, 0, 50, kSectionHeight) withView:subView textAlignment:0 fontSize:14 textColor:kCellHeaderTextColor];
//          
//            return subView;
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

//显示通讯录右侧索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView !=_linkManListView) {
        return nil;
    }else{
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        [titles addObject:UITableViewIndexSearch];
        return _sortedkeysArray;
    }
}

#pragma mark - QCSearchBar
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    _searchBar.showsCancelButton = YES;

}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    [_searchBar endEditing:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if([searchText isEqualToString:@""]){
        [self.view endEditing:YES];
        [_searchBar endEditing:YES];
        [self fileterFullModelArrayWithKey:@""];
        [self loadSavedData];
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
    
    [self loadSavedData];
    
    _searchBar.showsCancelButton = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    [self.view endEditing:YES];

    [_searchBar resignFirstResponder];
}
#pragma mark - public  methods
//读取本地数据，构造网络请求返回的数据结构
-(void)loadSavedData{
    
    NSMutableArray *friendArray = [NSMutableArray array];
    
    //读取数据库
    NSArray *users = [[DBManager shareInstance] query:@"QCFriendModel" predicate:nil];
    
    for (QCFriendModel *model in users) {
        User *user = [[User alloc] init];
        user.yxbId = model.yxbId;
        user.t_id = [model.userId integerValue];
        user.username = model.username;
        user.nickname = model.nickname;
        user.iconAddr = model.iconAddr;
        user.realname = model.realName;
        user.nameSpell = [YXBTool pinyinWithText:model.nickname];
        
        TFriendRelation *fuser = [[TFriendRelation alloc] init];
        fuser.errCode = 0;
        fuser.friendUser = user;
        [friendArray addObject:fuser];
    }
    self.fullModelArray = friendArray;
    [self updateUIWithArray:friendArray isSaved:YES];
    NSLog(@"friendArray----%@",friendArray);
    
}

//根据本地数据更新界面
-(void)updateUIWithArray:(NSArray *)dataArray isSaved:(BOOL)isSaved{
    NSLog(@"updateUIWithArray");
    //分组原理字典以前是( 构造一个二维数组,二维数组中每一个数组的第一个元素是 该分组的首字母)
    __block QCFriendsViewController *this = self;
    
    if (dataArray.count != 0) {
        this.noRecordView.hidden = YES;
        //将数组的数据结构处理为字典
        [this processDataToDicWithArray:dataArray isSaved:isSaved];
        NSLog(@"this.dataDictionary===%@",this.dataDictionary);
    }else {
        this.noRecordView.hidden = NO;
    }
    
}

//对数据进行分组排序
-(void)processDataToDicWithArray:(NSArray *)result isSaved:(BOOL)isSaved{
    
    if(self.dataDictionary != nil){
        [self.dataDictionary removeAllObjects];
    }
    
    
    for (TFriendRelation *friend in result) {
        User *friendUser = friend.friendUser;
        if (friendUser != nil && friendUser.t_id != 0){
            if (friendUser.nameSpell.length == 0) {
                friendUser.nameSpell = [YXBTool pinyinWithText:friendUser.nickname];
            }else{
                NSLog(@"直接去");
                NSLog(@"pinyin---%@",friendUser.nameSpell);
            }
            NSString *pinYin = [friendUser.nameSpell lowercaseString];
            
            //构造字典
            NSString *first = nil;
            if (pinYin.length>0) {
                first =[pinYin substringToIndex:1];
            }else{
                first = @"";
            }
            if ([YXBTool isAlphabetContainsChar:first]) {
                NSMutableArray *array = [self.dataDictionary objectForKey:first];
                if (array == nil) {
                    array = [NSMutableArray array];
                    [array addObject:friendUser];
                    [self.dataDictionary setObject:array forKey:first];
                }else{
                    [array addObject:friendUser];
                    
                }
                
            }else{ //在字母之外
                //把以#号为key的数组添加到字典中
                NSMutableArray *array = [self.dataDictionary objectForKey:@"#"];
                
                if (array == nil) {
                    array = [NSMutableArray array];
                    [self.dataDictionary setObject:array forKey:@"#"];
                }
                [array addObject:friendUser];
            }
            
            //保存数据到数据库
            if (!isSaved) {
                [self saveDataToDBWithUser:friendUser];
                
            }
            
        }
        
    }
    self.sortedkeysArray = [NSMutableArray arrayWithArray:[[self.dataDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    //将”#“移动到最后
    if ([self.sortedkeysArray containsObject:@"#"]){
        NSInteger index = [self.sortedkeysArray indexOfObject:@"#"];
        [self.sortedkeysArray addObject:@"#"];
        if (index == 0) {
            [self.sortedkeysArray removeObjectAtIndex:0];
            
        }
        
    }
    
    if (_AddressSearchText != nil && [_AddressSearchText length] > 0 && _isLoanRepay){
        //过滤掉搜索的
        //借款好友 来的，直接保存
        
        self.addressDataDictionary = [NSMutableDictionary dictionaryWithDictionary:self.dataDictionary];
        self.addressSortedkeysArray = [NSMutableArray arrayWithArray:self.sortedkeysArray];
        
    }
    
    
    [self.linkManListView reloadData];
    
    NSLog(@"this.dataDictionary===%@",self.dataDictionary);
    
}
-(void)setSelectedCell{}

#pragma mark - private methods
//创建UI
- (void)createUI{
    //搜索栏
    CGFloat headerH = getScreenFitSize(75.0/2);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, headerH)];
    headerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:headerView];
    //系统自带搜索框
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, headerH)];
    _searchBar.barTintColor = CellHeaderColor;
    _searchBar.placeholder = @"搜索";
    //去掉黑线
    _searchBar.showsCancelButton = NO;
    _searchBar.layer.borderWidth = 1;
    _searchBar.layer.borderColor = [[UIColor whiteColor] CGColor];
    _searchBar.delegate = self;
    [headerView addSubview:_searchBar];
    
    //tabView
    _linkManListView = [[UITableView alloc]initWithFrame:CGRectMake(0, headerView.bottom, kDeviceWidth, kDeviceHeight-64-headerView.height-49)];
    _linkManListView.delegate = self;
    _linkManListView.dataSource =self;
    
    if (KDeviceOSVersion>=7.0) {
        _linkManListView.sectionIndexBackgroundColor = [UIColor clearColor];
        _linkManListView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
    }
    if (KDeviceOSVersion>=6.0) {
        _linkManListView.sectionIndexColor = rgb(85, 85, 85, 1);
    }
    _linkManListView.multipleTouchEnabled = YES;
    _linkManListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _linkManListView.showsVerticalScrollIndicator = YES;
    
    [self.view addSubview:_linkManListView];
    
    //没有好友时
    _noRecordView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64)];
    _noRecordView.backgroundColor = [UIColor whiteColor];
    _noRecordView.hidden = YES;
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
//清空数据库
-(void)reSetDB{
    NSArray *users = [[DBManager shareInstance] query:@"QCFriendModel" predicate:nil];
    for (NSManagedObject *user in users) {
        [[DBManager shareInstance] removeManagerObj:user];
        
    }
    
}

//保存用户数据
-(void)saveDataToDBWithUser:(User *)friendUser{
    
    QCFriendModel *model = (QCFriendModel *)[[DBManager shareInstance] createMO:@"QCFriendModel"];
    model.username = friendUser.username;
    model.nickname = friendUser.nickname;
    model.iconAddr = friendUser.iconAddr;
    model.realName = friendUser.realname;
    model.yxbId = friendUser.yxbId;
    model.userId = [@(friendUser.t_id) stringValue];
    [[DBManager shareInstance] saveManagerObj:model];
    
}
//根据搜索过滤数据
-(void)fileterFullModelArrayWithKey:(NSString *)key{
    NSMutableArray *tempSearchArray = [NSMutableArray array];
    NSLog(@"count===%@,%@",tempSearchArray,_fullModelArray);
    
    //    if ([key length] > 0) {
    //        NSString *pinyinKey = [[YXBTool pinyinWithText:key] lowercaseString];
    //        for (int i = 0; i < [_fullModelArray count]; i ++)
    //        {
    //            TFriendRelation *tf = _fullModelArray[i];
    //            User *user = tf.friendUser;
    //            NSLog(@"nickname---%@===%@",user.nickname,[YXBTool pinyinWithText:user.nickname]);
    //            NSString *pinyinNickName = [YXBTool pinyinWithText:user.nickname];
    //            if ([YXBTool containString:pinyinKey sourceString:pinyinNickName])
    //            {
    //                [tempSearchArray addObject:tf];
    //            }
    //        }
    //
    //
    //    }
    if ([key length] > 0) {
        NSString *pinyinKey = [[YXBTool pinyinWithText:key] lowercaseString];
        for (int i = 0; i < [_fullModelArray count]; i ++){
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
    
    NSLog(@"count===%@,%@",tempSearchArray,_fullModelArray);
    
    if (tempSearchArray.count!=0) {
        [self processDataToDicWithArray:tempSearchArray isSaved:YES];
    }else{
        
        [self.sortedkeysArray removeAllObjects];
        [self.linkManListView reloadData];
        [self processDataToDicWithArray:@[] isSaved:YES];
    }
}
//#pragma mark - QCLinkManCell delegate
//- (void)deleteButtonClickedLinkManCell:(QCLinkManCell *)cell userName:(NSString *)name{
//   
//}
//
//- (void)QCLinkManCellDidEditing:(QCLinkManCell *)cell {
//    
//    for (QCLinkManCell *linkManCell in _linkManListView.visibleCells) {
//        if ([linkManCell isEqual:cell]) {
//            
//        }else {
//            [linkManCell closeSwipeAction];
//        }
//    }
//    _linkManListView.scrollEnabled = NO;
//    self.editingCell = cell;
//}
//
//- (void)QCLinkManCellDidClose:(QCLinkManCell *)cell {
//    for (QCLinkManCell *linkManCell in _linkManListView.visibleCells) {
//        if ([linkManCell.nameLabel.text isEqualToString:@"新朋友"] || !linkManCell.canDelete) {
//            [linkManCell closeSwipeAction];
//        }else {
//            [linkManCell openSwipeAction];
//        }
//    }
//    
//    _linkManListView.scrollEnabled = YES;
//}
//
//- (void)acceptButtonClickedLinkManCell:(QCLinkManCell *)cell {
//    
//}
//
//#pragma mark - Actions
//- (void)sureButtonAction:(UIButton *)button {
//    
//    NSLog(@"array = %@",indexPathArray);
//    if (self.isFromBorrow) {
//        for (UIViewController * viewController in self.navigationController.viewControllers) {
//            if ([viewController isKindOfClass:[LoanDetailsViewController class]]) {
//                if (selectPath == nil) {
//                    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请选择向那位好友发送借款申请" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                    [alertView show];
//                    
//                }else{
//                    NSMutableArray *nameArr = [self.dataDictionary objectForKey:self.sortedkeysArray[selectPath.section]];
//                    User *friendUser = nameArr[selectPath.row];
//
//                    http = [[StatusHttp alloc]init];
//                    http.delegate =self;
//                    self.loanModel.lenderId  = friendUser.t_id;
//                    [http __yxb_service__createAndModifyTLoan:self.loanModel];
//                    sureButton.userInteractionEnabled = NO;
//                }
//
//            }
//        }
//
//    }else if (_isFromLender){
//
//        //快速放款进来没有 LoanDetailsViewController 加的是他的view
//        if (selectPath == nil) {
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请选择借哪位好友款" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alertView show];
//            
//        }else{
//            
//            NSMutableArray *nameArr = [self.dataDictionary objectForKey:self.sortedkeysArray[selectPath.section]];
//            User *friendUser = nameArr[selectPath.row];
//
//            http = [[StatusHttp alloc]init];
//            http.delegate =self;
//            self.loanModel.borrowerId  = friendUser.t_id;
//            
//            YXBPayAction *pay = [[YXBPayAction alloc] init];
//            pay.payWay = YXBPayWayFukuan;
//            pay.isQuickLend = YES;
//            pay.loan = self.loanModel;
//            [pay payAction];
//
//        }
//        
//    }else if (self.isAAshoukuan){
//        if (indexPathArray.count != self.isAAshoukuanNumeber ) {
////            [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"请选择%ld个好友",(long)self.isAAshoukuanNumeber]];
//            [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请选择%ld人",(long)self.isAAshoukuanNumeber]];
//            return;
//        }
//        
//        [self httpDowloadWithListStyle];
//        [indexPathArray removeAllObjects];
//        [sureButton setTitle:[NSString stringWithFormat:@"确 定(%ld)",(unsigned long)indexPathArray.count] forState:UIControlStateNormal];
//        NSLog(@"%@",indexPathArray);
//    }
//    else if (self.isSelectPeople){
//        //代付选人多人
//        if (indexPathArray.count <= 0 ) {
//            [ProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请至少选择1人"]];
//            return;
//        }
//        
//        NSString *gids = [self getGids]; //获取选择的所有好友id
//        NSLog(@"gids---%@",gids);
//        if (_delegate && [_delegate respondsToSelector:@selector(amorOrderDetailCallBackWithType:gid:)]) {
//            [_delegate amorOrderDetailCallBackWithType:_payType gid:gids];
//        }
//        [indexPathArray removeAllObjects];
//        [sureButton setTitle:[NSString stringWithFormat:@"确 定(%ld)",(unsigned long)indexPathArray.count] forState:UIControlStateNormal];
//        [self leftAction];
//        NSLog(@"%@",indexPathArray);
//    }
//    else if(self.isFromInvite){
//        for (UIViewController *viewController in self.navigationController.viewControllers) {
//            if ([viewController isKindOfClass:[AADetailsViewController class]]) {
//                if (indexPathArray.count==0) {
//                    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请选择至少一位好友发送邀请" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                    [alertView show];
//                }else{
//                    
//                    http = [[StatusHttp alloc]init];
////                    http.delegate =self;
////                    [http addTActivityInviteeWithMaodel:_activity withArrray:indexPathArray];
//                    NSMutableString *userIdStr = [[NSMutableString alloc] initWithCapacity:0];
//                    for (NSNumber *num in indexPathArray) {
//                        NSInteger integer = [num integerValue];
//                        [userIdStr appendFormat:@"%ld",(long)integer];
//                    }
//                    if (userIdStr.length != 0) {
//                        [http addTActivityInviteeListActivityId:_activity.t_id userIdStr:userIdStr complete:^(TResultSet *resultSet) {
//                            if (resultSet.errCode == 0) {
//                                UIAlertView *altert = [[UIAlertView alloc] initWithTitle:nil message:@"邀请成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                                [altert show];
//                                [self leftClicked];
//                            }else {
//                                UIAlertView *altert = [[UIAlertView alloc] initWithTitle:nil message:resultSet.errString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                                [altert show];
//                                
//                            }
//                        }];
//                        
//                    }
//                    
//                }
//                
//            }
//        }
//
//    }
//    
//    
//}

//- (void)httpCompleteWithResultSet:(TResultSet *)set withHttpTag:(NSInteger)tag
//{
//    if (set.errCode == 0) {
//        [self performSelector:@selector(hideLoading) withObject:nil afterDelay:2];
//        
//        for (UIViewController *viewController in self.navigationController.viewControllers) {
//            if ([viewController isKindOfClass:[AADetailsViewController class]]) {
//                [self.navigationController popToViewController:viewController animated:YES];
//            }else if ([viewController isKindOfClass:[LoanOrRepayViewController class]]){
//                [self.navigationController popToViewController:viewController animated:YES];
//            }
//        }
//    }else{
//        UIAlertView * alertView  = [[UIAlertView alloc]initWithTitle:@"" message:set.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
//    }
//}

//#pragma mark- FriendPopView delegate
//- (void)FriendPopView:(FriendPopView *)popView clickedAtIndex:(NSInteger)index {
//    if (index == 0) {
//        //扫一扫
////        FriendScanViewController *scan = [[FriendScanViewController alloc] init];
//        ScannerViewController *scan = [[ScannerViewController alloc] init];
//        [self.navigationController pushViewController:scan animated:YES];
//    }else if (index == 1) {
//        //添加朋友
//        [self addNewFriends];
//    }
//}
//
//#pragma mark - QCTimerManager delegate
//- (void)GetUnreadNoticeFlagByUserInfoChange {
//}
//
//- (void)newFriendChange {
////    [self addFriendCount];
//}


//添加按钮事件响应
//- (void)addFriends
//{
//    NSArray *images = @[@"sweep-icon-gray",@"addfriends-icon"];
//    NSArray *titles = @[@"扫一扫",@"添加朋友"];
//    NSMutableArray *itmes = [NSMutableArray new];
//    for (int i = 0; i<images.count; i++) {
//        FriendPopItem *item = [FriendPopItem menuItem:titles[i] image:[UIImage imageNamed:images[i]]];
//        [itmes addObject:item];
//    }
//    FriendPopView *popView = [[FriendPopView alloc] initWithItems:itmes];
//    popView.delegate = self;
//    [popView showFromPoint:CGPointMake(kDeviceWidth-6, 64)];
//}

//- (void)coverAction:(UIControl *)cover {
//    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
//    if (userModel.unreadCont.newFriendRelationFlagCount != 0) {
////        _badgeView.hidden = NO;
//    }
//    [_searchBar resignFirstResponder];
//    [_linkManListView reloadData];
//    
//    [self setSelectedCell];
//}
//
//- (void)setSelectedCell {
//    if (!(_isAAshoukuan || _isFromInvite || _isSelectPeople)) {
//        return;
//    }
//    for (int i = 0; i < self.sortedkeysArray.count; i++)
//    {
//        NSArray *sectionArr = [self.dataDictionary objectForKey:self.sortedkeysArray[i]];
//        for (int j = 0; j < sectionArr.count-1; j++) {
//            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:j inSection:i];
//            QCLinkManCell *cell = (QCLinkManCell *)[_linkManListView cellForRowAtIndexPath:indexpath];
//            NSMutableArray *nameArr = [self.dataDictionary objectForKey:self.sortedkeysArray[i]];
//            User *friendUser = nameArr[j];
//            
//            if (indexPathArray.count != 0 ) {
//                if([indexPathArray containsObject:[NSNumber numberWithInteger:friendUser.t_id]]) {
//                    [cell setChecked:YES];
//                }else {
//                    [cell setChecked:NO];
//
//                }
//            }
//        }
//    }
//}

//- (void)httpDowloadWithListStyle
//{
//    if (self.iHttpOperator == nil) {
//        self.iHttpOperator = [[HttpOperator alloc]init];
//        
//    }
//    [self.iHttpOperator cancel];
//    
//    
//    __weak HttpOperator * assginHtttperator = _iHttpOperator;
//    __weak QCFriendsViewController *this = self;
//    [self.iHttpOperator connetStart:^(int d) {
//        
//    } cancel:^(int d) {
//        
//    } error:^(int d, THttpOperatorErrorCode error) {
//        
//        [this httpLoadError:error];
//        
//    } param:^(NSString *s) {
//        
//        [this httpLoadParamsTwo:assginHtttperator];
//    } complete:^(TResultSet * r, int taskid) {
//
//        [this httpLoadCompleteTwo:r];
//    }];
//    [self.iHttpOperator connect];
//    
//}
//- (void)httpLoadParamsTwo:(HttpOperator *)assginHtttperator{
//
//    AverageManager *manager = (AverageManager *)[assginHtttperator getAopInstance:[AverageManager class] returnValue:[TResultSet class]];
//    
//    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
//    
//    //        if (style == L_myList) {
//    NSString *userToken = userModel.user.yxbToken;
//    if ((userToken != nil) && [userToken length] > 0)
//    {
//        
//        NSMutableString *str=[[NSMutableString alloc]init];
//        if (indexPathArray.count!=0) {
//            for (id object in indexPathArray) {
//                [str appendFormat:@"%@|",object];
//                
//            }
//            [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
//        }
//        else if (indexPathArray.count==0){
//            [str appendString:@""];
//            
//        }
//        
//        
//        [manager createAAAverage:userToken title:self.subject sumPeople:self.allNum.integerValue sumMoney:self.allMoney.integerValue descript:self.desc mode:1 tokenArr:str couponId:0];
//        
//        
//    }
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
//    }
//    
//
//
//}
//- (void)httpLoadCompleteTwo:(TResultSet *)r{
//
//    if (r.errCode == 0) {
//        
//        //            [YXBTool showAlertViewWithString:@"发起AA收款成功!\n请在右上角收款记录查看。"];
//        
//        
//        [self leftClicked];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"发起AA收款成功!\n请在右上角收款记录查看。" delegate:self.delegate cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        alert.tag = 100111;
//        [alert show];
//        
//        if ([self.delegate respondsToSelector:@selector(QCFriendsViewControllerBackAction:)]) {//查看万能卷
//            [self.delegate QCFriendsViewControllerBackAction:r.resInteger];
//        }
//    }
//    else
//    {
//        [ProgressHUD showErrorWithStatus:r.errString];
//    }
//
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//-(NSString *)getGids
//{
//    NSMutableString *str=[[NSMutableString alloc]initWithString:@""];
//    if (indexPathArray.count!=0) {
//        for (id object in indexPathArray) {
//            [str appendFormat:@"%@,",object];
//            
//        }
//        [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
//    }
//    else if (indexPathArray.count==0){
//        [str appendString:@""];
//        
//    }
//    
//    return str;
//
//}


@end
