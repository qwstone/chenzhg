//
//  QCNewFriendViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 14-5-23.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCNewFriendViewController.h"
#import "QCNewFriendCell.h"
#import "TFriendRelationManager.h"
#import "NSSkyArray.h"
#import "TResultSet.h"
#import "TFriendRelation.h"
#import "User.h"
#import "QCAddressListViewController.h"
#import "FriendDetailViewController.h"
#import "SearchCoreManager.h"
#import "AddFriendsMenuController.h"
#import "QCAddFriendViewController.h"
#import "YXBTool.h"
#import "QCAddressBook.h"
#import "QCSearchBar.h"
#import "AAShareView.h"
#import "FriendScanViewController.h"
#import "QCAddressListNewController.h"
#import "ScannerViewController.h"
#import "AddressDBManager.h"
#import "AddressBookModel.h"
#import "QCFriendModel.h"
#define AddFriendsMenuCellHeight 60
#define AddFriendsMenuControllerSearchHolder @"     输入手机号码添加"
@interface QCNewFriendViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,QCNewFriendCellDelegate,QCSearchBarDelegate,AAShareViewDelegate>
{
    BOOL _isfinished;//添加状态的好友网络请求是否完成
}

@property (nonatomic,retain) NSMutableArray *searchByName; //按名字搜索结果
@property(nonatomic,strong)QCSearchBar *searchBar;//自定义搜索栏
@property(nonatomic,strong)UIControl *cover;
@property (nonatomic,retain)UITableView *tableView;
//@property (nonatomic,retain)QCNoRecordView *noRecordView;
@property (nonatomic,retain)QCNewFriendCell *editingCell;

@property (nonatomic,retain)NSMutableArray *friendArr;
@property(nonatomic,strong)NSMutableArray *friendSecArr;
@property(nonatomic,strong)UISearchBar *topSearchBar;
@property(nonatomic,strong)UISearchDisplayController *mySearchDisplayController;

@property(nonatomic,strong)NSMutableArray *addressBookTemp; //手机通讯录数组
@property(nonatomic,strong)NSMutableArray *addTypeBook; //添加状态的好友

@end

@implementation QCNewFriendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)dealloc
{
    NSLog(@"%@ dealloc",[self class]);
}
-(void)leftClicked
{
    [ProgressHUD dismiss];
    [[AddressDBManager shareInstance] cancel];
    [self.iHttpOperator cancel];
    [super leftClicked];
}
- (void)viewWillAppear:(BOOL)animated{
//    [self generateDicWithAddressBookDataWithBlock];

    [super viewWillAppear:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = rgb(245,244,242,1);
    self.title = @"添加好友";
    
    //存储好友邀请
    self.friendArr = [NSMutableArray new];
    //存储已添加好友
    self.friendSecArr=[NSMutableArray new];
    //存储推荐好友
    _addTypeBook = [NSMutableArray new];
     _addressBookTemp = [NSMutableArray array];
    //判断第一次走cellForRow方法是否已完成(此时还没有数据)
    _isfinished = NO;
    [self setBackView];

    //扫一扫
    [self setNavigationButtonItrmWithiamge:@"sweep-icon" withRightOrleft:@"right" withtargrt:self withAction:@selector(scanAction:)];
    //按名字搜索结果
    NSMutableArray *nameIDArray = [[NSMutableArray alloc] init];
    _searchByName = nameIDArray;
    
    //重置搜索库
    [[SearchCoreManager share] Reset];
    [self _initViews];
    
    //从数据库读(前一页面保存的,后一页面直接从数据库读)
    [self getAlreadyFriend];
    
    [self generateDicWithAddressBookDataWithBlock];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            [self setAllUnReadFlagToReadByUsernameAndQueryType];
        });
        dispatch_group_async(group, queue, ^{

//            [self getFriendType];
        });
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
           [self loadData];
        });
    });
    
}

- (void)getAlreadyFriend{
    
    [self loadAlreadyFriendSavedData];

}
//读取本地数据，构造网络请求返回的数据结构
-(void)loadAlreadyFriendSavedData
{
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
    self.friendSecArr = friendArray;
    [self.tableView reloadData];
    NSLog(@"friendArray----%@",friendArray);
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_searchBar resignFirstResponder];
    if (self.loadHttpOperator != nil) {
        [self.loadHttpOperator cancel];
    }
    if (self.setUnReadHttpOperator != nil) {
        [self.setUnReadHttpOperator cancel];
    }
}

- (void)setAllUnReadFlagToReadByUsernameAndQueryType {
//    if (self.setUnReadHttpOperator == nil) {
    self.setUnReadHttpOperator = [[HttpOperator alloc]init];
        
//    }
    [self.setUnReadHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _setUnReadHttpOperator;
//    __block QCNewFriendViewController *this = self;
    __weak QCNewFriendViewController *this = self;
    [self.setUnReadHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        [this httpLoadParamsOne:assginHtttperator];
    } complete:^(id r, int taskid) {
        _isfinished=YES;
    }];
    [self.setUnReadHttpOperator connect];

}
- (void)httpLoadParamsOne:(HttpOperator *)assginHtttperator{

    QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
    User *user = localUser.user;
    
    TFriendRelationManager* _currFriend = (TFriendRelationManager *)  [assginHtttperator getAopInstance:[TFriendRelationManager class] returnValue:[TResultSet class]];
    
    [_currFriend setAllUnReadFlagToReadByUserId:(int)user.t_id];
}
//网络请求,得到好友邀请,已添加好友
- (void)loadData {
    if (self.loadHttpOperator == nil) {
        self.loadHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.loadHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _loadHttpOperator;
    __weak QCNewFriendViewController *this = self;
    [self.loadHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        [this httpLoadParamsTwo:assginHtttperator];
        
    } complete:^(NSSkyArray *r, int taskid) {

        [this httpLoadCompleteTwo:r];
        
    }];
    [self.loadHttpOperator connect];
    
}
- (void)httpLoadParamsTwo:(HttpOperator *)assginHtttperator{
    QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
    User *user = localUser.user;
    
    TFriendRelationManager* _currFriend = (TFriendRelationManager *)  [assginHtttperator getAopInstance:[TFriendRelationManager class] returnValue:[NSSkyArray class]];
    
    [_currFriend getTFriendRelationByUserIdAndQueryType:user.t_id withType:4];
    
}
- (void)httpLoadCompleteTwo:(NSSkyArray *)r{

    if (r.iArray.count != 0) {
        TFriendRelation *testFriend = [r.iArray lastObject];
        NSInteger errCode = testFriend.errCode;
        
        if (errCode == 0) {
            if (self.friendSecArr.count!=0) {
                [self.friendSecArr removeAllObjects];
                
            }
            else if (self.friendArr.count!=0){
                [self.friendArr removeAllObjects];
            
            }
         
            for (TFriendRelation *friend in r.iArray) {
                if (friend.relationType==0) {
                    [self.friendArr addObject:friend];
                }
                else if (friend.relationType==1){
                  
                     [self.friendSecArr addObject:friend];
                    
                    
                }
                
                
            }
            [self.tableView reloadData];
            _isfinished=YES;
        }
    }
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_isfinished) {//网络请求完成
        if (_searchBar.text == nil || _searchBar.text.length == 0) {
          
            return 3;
        }else {
            
            return 1;
        }
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //网络请求没有完成
    if (!_isfinished) {
        if (section==0) {
            return 0;
        }
        else if (section==1){
            //正式里没有推荐好友,全部都存在已添加好友里
//            if (_addTypeBook.count==0) {
//                return 1;
//            }
           // return _addTypeBook.count;
            return 1;
        }
        else if (section==2){
             return self.friendSecArr.count;
        }
       
    }
    
    if (_searchBar.text == nil || _searchBar.text.length == 0) {
        
        if (section == 0) {
            return self.friendArr.count;
        }else if(section==1){
//            if (_addTypeBook.count==0) {
//                return 1;
//            }
            //return _addTypeBook.count;
            return 1;
        }
        else{
            
            return self.friendSecArr.count;
        }
    }
    
    return _searchByName.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isfinished) {
//        if (indexPath.section==1&&self.addTypeBook.count!=0) {
//            static NSString *kCustomCellID = @"Cell2";
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
//            if (cell == nil)
//            {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            }
//            
//            QCAddressBook *addressBook = nil;
//            if (_addTypeBook.count!=0) {
//                
//                addressBook = (QCAddressBook *)[_addTypeBook objectAtIndex:indexPath.row];
//            }
//            
//            if ([[addressBook.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
//                cell.textLabel.text = addressBook.name;
//            } else {
//                cell.textLabel.font = [UIFont italicSystemFontOfSize:cell.textLabel.font.pointSize];
//                cell.textLabel.text = nil;
//            }
//            cell.textLabel.backgroundColor = [UIColor clearColor];
//            
//            
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button setFrame:CGRectMake(kDeviceWidth-70, 5, 60, 30)];
//            [button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
//            //            button.layer.cornerRadius = 3.0;
//            [button setBackgroundImage:[UIImage imageNamed:@"add-but.png"] forState:UIControlStateNormal];
//            
//            [cell addSubview:button];
//            
//            return cell;
//        }
     if (indexPath.section==2){
        static NSString * cellId = @"cellID2";
        QCNewFriendCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[QCNewFriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
            cell.delegate = self;
            cell.selectedBackgroundView = [[UIView alloc]init];
            cell.backgroundColor = [UIColor whiteColor];
        }
        cell.user=[self.friendSecArr objectAtIndex:indexPath.row];
        [cell.acceptButton setImage:nil forState:UIControlStateNormal];
        [cell.acceptButton setTitleColor:rgb(128, 128, 128, 1) forState:UIControlStateNormal];
        [cell.acceptButton setTitle:@"已添加" forState:UIControlStateNormal];
        cell.acceptButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        return cell;
     }
    else if (indexPath.section==1){//没有推荐好友
        static NSString *kCustomCellID = @"Cell4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        cell.userInteractionEnabled=NO;
        cell.textLabel.text=@"暂无好友推荐";
        return cell;
        
    }

    }
    if (_searchBar.text == nil || _searchBar.text.length == 0) {
        //未搜索
        if (indexPath.section == 0||indexPath.section==2) {//好友邀请、已添加
            if(indexPath.section == 0){//好友邀请
                static NSString * cellId = @"cellID1";
                QCNewFriendCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                if (cell == nil) {
                    cell = [[QCNewFriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    
                    cell.delegate = self;
                    cell.selectedBackgroundView = [[UIView alloc]init];
                    cell.backgroundColor = [UIColor whiteColor];
                    
                }
                cell.user = [self.friendArr objectAtIndex:indexPath.row];
                return cell;
            }else if (indexPath.section == 2){//已添加
                static NSString * cellId = @"cellID22";
                QCNewFriendCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
                if (cell == nil) {
                    cell = [[QCNewFriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                    
                    cell.delegate = self;
                    cell.selectedBackgroundView = [[UIView alloc]init];
                    cell.backgroundColor = [UIColor whiteColor];
                }
                cell.user=[self.friendSecArr objectAtIndex:indexPath.row];
                [cell.acceptButton setImage:nil forState:UIControlStateNormal];
                [cell.acceptButton setTitleColor:rgb(128, 128, 128, 1) forState:UIControlStateNormal];
                [cell.acceptButton setTitle:@"已添加" forState:UIControlStateNormal];
                cell.acceptButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
                
                return cell;
            }
        }
        else if (indexPath.section==1){
            //没有推荐好友
            static NSString *kCustomCellID = @"Cell3";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
            cell.textLabel.font=[UIFont systemFontOfSize:13];
            cell.userInteractionEnabled=NO;
            cell.textLabel.text=@"暂无好友推荐";
            return cell;
            
        }
        
    }
 //           else if(indexPath.section==1&&self.addTypeBook.count!=0){//推荐好友
//            static NSString *kCustomCellID = @"Cell2";
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
//            if (cell == nil)
//            {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            }
//            
//            QCAddressBook *addressBook = nil;
//            if (_addTypeBook.count!=0) {
//                
//                addressBook = (QCAddressBook *)[_addTypeBook objectAtIndex:indexPath.row];
//            }
//            
//            if ([[addressBook.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0) {
//                cell.textLabel.text = addressBook.name;
//            } else {
//                cell.textLabel.font = [UIFont italicSystemFontOfSize:cell.textLabel.font.pointSize];
//                cell.textLabel.text = nil;
//            }
//            cell.textLabel.backgroundColor = [UIColor clearColor];
//
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button setFrame:CGRectMake(kDeviceWidth-70, 5, 60, 30)];
//            [button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
//            [button setBackgroundImage:[UIImage imageNamed:@"add-but.png"] forState:UIControlStateNormal];
//            
//            [cell addSubview:button];
//            
//            return cell;
//        }
        
 
    else {
        //好友搜索
        static NSString *kCustomCellID = @"Cell4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCustomCellID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCustomCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        }
        
        QCAddressBook *addressBook = nil;
        addressBook = (QCAddressBook *)[_searchByName objectAtIndex:indexPath.row];
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(30.0, 0.0, 47, 29.5)];
        [button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"add-friend"] forState:UIControlStateNormal];
        cell.accessoryView = button;
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isfinished) {
        if (indexPath.section==1) {
            QCAddFriendViewController *addVC = [[QCAddFriendViewController alloc] initWithUserType:YES];
            addVC.addressBook = [_addTypeBook objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:addVC animated:YES];
        }
        return;
    }
 
    if (_searchBar.text == nil || _searchBar.text.length == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.section == 0) {
            if (self.editingCell.isEditing == YES) {
                [self.editingCell closeDeleteButton];
                return;
            }
            
            TFriendRelation *user = [self.friendArr objectAtIndex:indexPath.row];
            FriendDetailViewController *controller = [[FriendDetailViewController alloc] init];
            controller.user = user.friendUser;
            [self.navigationController pushViewController:controller animated:YES];
            
        }else if (indexPath.section == 1) {
            QCAddFriendViewController *addVC = [[QCAddFriendViewController alloc] initWithUserType:YES];
            addVC.addressBook = [_addTypeBook objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:addVC animated:YES];
        }
        
    }else {
        QCAddFriendViewController *addVC = [[QCAddFriendViewController alloc] initWithUserType:YES];
        addVC.addressBook = [_addTypeBook objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:addVC animated:YES];
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * subView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 22)];
    if (!_isfinished) {
        if (section==1) {
            subView.backgroundColor = rgb(230, 230, 230, 1);
            [self CreateLabel:@"推荐好友" frame:CGRectMake(15, 1, 100, 20) withView:subView textAlignment:0 fontSize:15 textColor:rgb(51, 51, 51, 1)];
            return subView;

        }
        else if (section==2&&self.friendSecArr.count!=0){
            subView.backgroundColor = rgb(230, 230, 230, 1);
            [self CreateLabel:@"已添加好友" frame:CGRectMake(15, 1, 100, 20) withView:subView textAlignment:0 fontSize:15 textColor:rgb(51, 51, 51, 1)];
            return subView;
        
        }
 
    }
    if (section == 1) {
        subView.backgroundColor = rgb(230, 230, 230, 1);
        [self CreateLabel:@"推荐好友" frame:CGRectMake(15, 1, 100, 20) withView:subView textAlignment:0 fontSize:15 textColor:rgb(51, 51, 51, 1)];
        
        return subView;
    }
    else if(section == 0&&self.friendArr.count!=0) {
        subView.backgroundColor = rgb(230, 230, 230, 1);
        [self CreateLabel:@"好友邀请" frame:CGRectMake(15, 1, 100, 20) withView:subView textAlignment:0 fontSize:15 textColor:rgb(51, 51, 51, 1)];
        
        return subView;
    }
    else if(section == 2&&self.friendSecArr.count!=0) {
        subView.backgroundColor = rgb(230, 230, 230, 1);
        [self CreateLabel:@"已添加好友" frame:CGRectMake(15, 1, 100, 20) withView:subView textAlignment:0 fontSize:15 textColor:rgb(51, 51, 51, 1)];
        
        return subView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!_isfinished) {
         if (section==2&&_friendSecArr.count==0){
            return 0.000001;
        }
    }
    if(section == 0&&self.friendArr.count==0) {
        return 0.000001;
    }
    if(section == 2&&self.friendSecArr.count==0){
        return 0.000001;
    }
    return 22;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_searchBar.text == nil || _searchBar.text.length == 0) {
        if (indexPath.section ==0||indexPath.section==2) {
            return kNewFriendCellHeight;
        }
        return 40;
       
    }else {
        return 40;
        
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    QCAddFriendViewController *addVC = [[QCAddFriendViewController alloc] initWithUserType:YES];
    addVC.addressBook = [_addTypeBook objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:addVC animated:YES];
    
}

#pragma mark - QCLinkManCell delegate
- (void)deleteButtonClickedNewFriendCell:(QCNewFriendCell *)cell userName:(NSString *)name{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    
    NSInteger friendId=0;
    if (indexPath.section==0&&self.friendArr.count!=0) {
        friendId = [[self.friendArr objectAtIndex:indexPath.row] t_id];
    }
    else if (indexPath.section==2&&self.friendSecArr.count!=0){
        friendId= [[self.friendSecArr objectAtIndex:indexPath.row] t_id];
        
    }
        
        if (self.iHttpOperator == nil) {
            self.iHttpOperator = [[HttpOperator alloc]init];
            
        }
        [self.iHttpOperator cancel];
        __weak HttpOperator * assginHtttperator = _iHttpOperator;
        __weak QCNewFriendViewController *this = self;
        [self.iHttpOperator connetStart:^(int d) {
            
        } cancel:^(int d) {
            
        } error:^(int d, THttpOperatorErrorCode error) {
            
            if (error == EHttp_Operator_Failed) {
                //服务器挂了
            }
            
        } param:^(NSString *s) {

            [this httpLoadParamsThree:assginHtttperator friendId:friendId];
        } complete:^(TResultSet *r, int taskid) {
            [this httpLoadCompleteThree:r indexPath:indexPath];
        }];
        [self.iHttpOperator connect];

    

}
- (void)httpLoadParamsThree:(HttpOperator *)assginHtttperator friendId:(NSInteger)friendId{

    TFriendRelationManager* _currFriend = (TFriendRelationManager *)  [assginHtttperator getAopInstance:[TFriendRelationManager class] returnValue:[TResultSet class]];
    
    [_currFriend deleteTFriendRelationNotice:(int)friendId];
    

}
- (void)httpLoadCompleteThree:(TResultSet *)r indexPath:(NSIndexPath *)indexPath{

    if (r.resInteger == 0) {
        if (indexPath.section==0&&self.friendArr.count!=0) {
            [self.friendArr removeObject:[self.friendArr objectAtIndex:indexPath.row]];
        }
        else if (indexPath.section==2&&self.friendSecArr.count!=0){
            [self.friendSecArr removeObject:[self.friendSecArr objectAtIndex:indexPath.row]];
            
        }

        [self.tableView reloadData];
        [self.editingCell closeDeleteButton];
        
    }
  

}

- (void)QCNewFriendCellDidEditing:(QCNewFriendCell *)cell {
    
    for (UITableViewCell *newFriendCell in _tableView.visibleCells) {
        if ([newFriendCell isEqual:cell]) {
            
        }else {
            if ([newFriendCell isKindOfClass:[QCNewFriendCell class]]) {
                [(QCNewFriendCell *)newFriendCell closeSwipeAction];
                
            }
        }
    }
    _tableView.scrollEnabled = NO;
    self.editingCell = cell;
}

- (void)QCNewFriendCellDidClose:(QCNewFriendCell *)cell {
    for (UITableViewCell *newFriendCell in _tableView.visibleCells) {
        if ([newFriendCell isEqual:cell]) {
            
        }else {
            if ([newFriendCell isKindOfClass:[QCNewFriendCell class]]) {
                [(QCNewFriendCell *)newFriendCell openSwipeAction];
                
            }
        }
    }
    
    _tableView.scrollEnabled = YES;
}

- (void)acceptButtonClickedNewFriendCell:(QCNewFriendCell *)cell {
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    
    if (self.friendArr.count != 0) {
        User *friendUser = [[self.friendArr objectAtIndex:indexPath.row] friendUser];
        if (self.iHttpOperator == nil) {
            self.iHttpOperator = [[HttpOperator alloc]init];
            
        }
        [self.iHttpOperator cancel];
        __weak HttpOperator * assginHtttperator = _iHttpOperator;
        __weak QCNewFriendViewController *this = self;
        [self.iHttpOperator connetStart:^(int d) {
            
        } cancel:^(int d) {
            
        } error:^(int d, THttpOperatorErrorCode error) {
            
            if (error == EHttp_Operator_Failed) {
                //服务器挂了
            }
            
        } param:^(NSString *s) {
            
            [this httpLoadParamsFour:assginHtttperator friendUser:friendUser];
        } complete:^(TResultSet *r, int taskid) {
            [this httpLoadCompleteFour:r cell:cell];
            
        }];
    }
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParamsFour:(HttpOperator *)assginHtttperator friendUser:(User *)friendUser{
    
    QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
    User *user = localUser.user;
    
    TFriendRelationManager* _currFriend = (TFriendRelationManager *)  [assginHtttperator getAopInstance:[TFriendRelationManager class] returnValue:[TResultSet class]];
    
    [_currFriend acceptTFriendRelationRequest:(int)user.t_id withFriendId:(int)friendUser.t_id];
}
- (void)httpLoadCompleteFour:(TResultSet *)r cell:(QCNewFriendCell *)cell{
    if (r.errCode == 0) {

        NSLog(@"%@",r);
        [cell changeAcceptType];
        
        [self showLoadingWithTitle:@"好友添加成功" imageName:@"friends_send"];
        [self performSelector:@selector(hideLoading) withObject:nil afterDelay:2];
        
    }else if (r.errCode != 0) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        NSLog(@"%@",r.errString);
    }
    

}

#pragma mark - Pravite Methods
//- (void)getPhoneNum {
//    NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
//
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            //子线程
//            if (users.count==0) {
//                [self getAddressBookSaveToDB];
//                [self getFriendType];
//            }
//            else{
//                 [self loadAddressBookSavedData];
//                dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                    [self getAddressBookSaveToDB];
//                    [self getFriendType];
//                    
//                });
//            
//            }
//            //回归主线程
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//            });
//        });
//    
//
//}

-(void)generateDicWithAddressBookDataWithBlock
{
    
    __weak typeof(self)this = self;
    
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:hasSavedAddressBook] integerValue] != 1)
    {
//        [ProgressHUD showWithStatus:@"正在读取通讯录..." maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeLongBottom];
        
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[AddressDBManager shareInstance] readLocalAddressBookWithCompleteBlock:^(NSMutableArray *resultArray,onAddressBookCompleteBlockTimes times) {
        //resultArray保存的是所有的通讯录
            NSMutableArray *tempAddArray = [NSMutableArray array];
            for (QCAddressBook *model in resultArray) {
                NSLog(@"~~~~%@",model);
                if (model.resStatus==0) {
                    [this.addTypeBook addObject:model];
                    [tempAddArray addObject:model];

                    
                }
                
            }
         //addTypeBook保存的是只是"推荐好友"
            this.addTypeBook = [NSMutableArray arrayWithArray:tempAddArray];
            this.addressBookTemp=resultArray;

            [this getFriendType];

            dispatch_async(dispatch_get_main_queue(), ^{
                if (resultArray.count>0) {
                    [ProgressHUD dismiss];
                }
                    [this.tableView reloadData];
            });
            
            
        }];
        
        
    });
}



-(void)clearAddressBooks
{
    NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
    for (NSManagedObject *user in users) {
        [[AddressDBManager shareInstance] removeManagerObj:user];
        
    }
    
}

//- (void)getAddressBookSaveToDB{
//    
//    //获取通讯录信息
//    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted || ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请开启访问通讯录功能,获取通讯录好友" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }
// 
//      //
//
//    //获取通讯录信息
//    _addressBookTemp = [NSMutableArray array];
//    //新建一个通讯录类
//    ABAddressBookRef addressBooks = NULL;
//    
//    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
//        if (&ABAddressBookCreateWithOptions != NULL){
//            
//            CFErrorRef errorRef = NULL;
//            addressBooks = ABAddressBookCreateWithOptions(nil, &errorRef);
//            
//            if (!addressBooks){
//                if (errorRef) CFRelease(errorRef);
//                
//                return;
//            }
//            
//            
//        }
//    }
//    else
//    {
//        addressBooks =ABAddressBookCreate();
//    }
//    //获取通讯录中的所有人
//    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
//    //通讯录中人数
//    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
//    
//    //循环，获取每个人的个人信息
//    for (NSInteger i = 0; i < nPeople; i++)
//    {
//        QCAddressBook *addressBook = [[QCAddressBook alloc] init];
//        //获取个人
//        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
//        //获取个人名字
//        CFStringRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
//        CFStringRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
//        CFStringRef abFullName = ABRecordCopyCompositeName(person);
//        
//        
//        NSString *nameString = (__bridge NSString *)abName;
//        NSString *lastNameString = (__bridge NSString *)abLastName;
//        
//        if ((__bridge id)abFullName != nil) {
//            nameString = (__bridge NSString *)abFullName;
//        } else {
//            if ((__bridge id)abLastName != nil)
//            {
//                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
//            }
//        }
//        
//            addressBook.name = nameString;
//            addressBook.recordID = (int)ABRecordGetRecordID(person);;
//            addressBook.rowSelected = NO;
//        
//        ABPropertyID multiProperties[] = {
//            kABPersonPhoneProperty,
//            kABPersonEmailProperty
//        };
//        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
//        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
//            ABPropertyID property = multiProperties[j];
//            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
//            NSInteger valuesCount = 0;
//            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
//            
//            if (valuesCount == 0) {
//                CFRelease(valuesRef);
//                continue;
//            }
//            //获取电话号码和email
//            for (NSInteger k = 0; k < valuesCount; k++) {
//                CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
//                switch (j) {
//                    case 0: {// Phone number
//                        if (k == 0) {
//                            
//                            addressBook.tel = (__bridge NSString*)value;
//                            
//                        }else if (k == 1) {
//                            addressBook.tel2 = (__bridge NSString*)value;
//                            
//                        }
//                        break;
//                    }
//                    case 1: {// Email
//                        addressBook.email = (__bridge NSString*)value;
//                        break;
//                    }
//                }
//                CFRelease(value);
//            }
//            
//            
//            CFRelease(valuesRef);
//        }
//        
//        //存储
//        if (addressBook.name!=nil&&addressBook.tel!=nil) {
//            [self.addressBookTemp addObject:addressBook];
//        }
//        
//        
//    }
//
//}

-(NSInteger)loadAddressBookSavedData
{
    
    //读取数据库
    NSArray *users = [[AddressDBManager shareInstance] query:DBAddressBookModelName predicate:nil];
    NSLog(@"~~~~~~~~~~~~~~~~%ld",(unsigned long)users.count);
    for (AddressBookModel *model in users) {
        NSLog(@"~~~~%@",model);
        if ([model.resStatus integerValue]==0) {
            QCAddressBook *user = [[QCAddressBook alloc] init];
            user.city = model.city;
            user.name = model.name;
            user.recordID = [model.recordID integerValue];
            user.rowSelected = [model.rowSelected boolValue];
            user.tel = model.tel;
            user.tel2 = model.tel2;
            user.resStatus=[model.resStatus integerValue];
            user.pinyin= model.pinyin;
            user.maxPinyin=model.maxPinyin;
            [self.addTypeBook addObject:user];
            
        }

    }

    return [self.addTypeBook count];

}



- (void)getFriendType {
    if (_addressBookTemp.count == 0) {
        //通讯录为空处理。
        return;
    }
    
    NSMutableString *phoneNumbs = [NSMutableString stringWithFormat:@""];
    for (int i = 0; i<_addressBookTemp.count; i++) {
        
        QCAddressBook *addressBook = [_addressBookTemp objectAtIndex:i];
        NSMutableString *appendStr;
        NSString *realName = [YXBTool base64EncodedWithString:addressBook.name];

        if (i < _addressBookTemp.count-1) {
            
            appendStr = [NSMutableString stringWithFormat:@"%@|%@,",addressBook.tel,realName];
        }else {
            appendStr = [NSMutableString stringWithFormat:@"%@|%@",addressBook.tel,realName];
        }
        [phoneNumbs appendString:appendStr];
    }
    
    self.iHttpOperator = [[HttpOperator alloc]init];
    
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block QCNewFriendViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [this stopDefaultAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        [this httpLoadParamsFive:assginHtttperator phoneNumbs:phoneNumbs];
        
    } complete:^(NSSkyArray *r, int taskid) {
        [this httpLoadCompleteFive:r];
        
    }];
    [self.iHttpOperator connect];

}
- (void)httpLoadParamsFive:(HttpOperator *)assginHtttperator phoneNumbs:(NSString *)phoneNumbs{

    QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
    User *user = localUser.user;
    NSString *userName = user.username;
    
    TFriendRelationManager* _currFriend = (TFriendRelationManager *)  [assginHtttperator getAopInstance:[TFriendRelationManager class] returnValue:[NSSkyArray class]];
    
//    [_currFriend getTFriendRelationByPhoneBookAutoAddFriend:userName phonelist:phoneNumbs];
    [_currFriend getTFriendRelationByPhoneBookAutoAddFriendV2:userName phonelist:phoneNumbs];


}
- (void)httpLoadCompleteFive:(NSSkyArray *)r{
    if (r.iArray.count != 0) {
        TResultSet *testResult = [r.iArray lastObject];
        NSInteger errCode = testResult.errCode;
        
        if (errCode == 0) {
            NSMutableArray *goodFriends = [NSMutableArray new];
            for (int i = 0; i<r.iArray.count; i++) {
                TResultSet *result = [r.iArray objectAtIndex:i];
                if (result.resInteger == 0 && i < [_addressBookTemp count]) {
                    //友信宝用户&&手机通讯录朋友
                    QCAddressBook *addressBook = [self.addressBookTemp objectAtIndex:i];
                    [goodFriends addObject:addressBook];
                    //添加到搜索库
                    [[SearchCoreManager share] AddContact:[NSNumber numberWithInteger:addressBook.recordID] name:addressBook.name phone:nil];
                }
            }
            
            //友信宝用户&&手机通讯录朋友
            if (goodFriends.count == 0) {
                [self.addTypeBook removeAllObjects];
            }else {
                self.addTypeBook = goodFriends;
            }
            
            _isfinished = YES;
            
            [self.tableView reloadData];
            
            
        } else {
            UIAlertView *alter = [[UIAlertView alloc]initWithTitle:nil message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];

        }
    }


}
- (void)checkButtonTapped:(id)sender event:(id)event{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint: currentTouchPosition];
    
    if (indexPath != nil)
    {
        [self tableView:_tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
    
}

- (NSString*)telephoneWithReformat:(NSString *)value{
    NSMutableString *string = [NSMutableString new];
    for (int i = 0; i<value.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subStr = [value substringWithRange:range];
        if ([subStr isEqualToString:@"-"]) {
            subStr = @"";
        }else if ([subStr isEqualToString:@" "]) {
            subStr = @"";
        }else if ([subStr isEqualToString:@"("]) {
            subStr = @"";
        }else if ([subStr isEqualToString:@")"]) {
            subStr = @"";
        }
        
        [string appendString:subStr];
    }
    
    
    return (NSString *)string;
}


- (void)_initViews {

    //标示图
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    _tableView.separatorColor = rgb(230, 230, 230, 1);
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0,0,kDeviceWidth,0.00001)];
    _tableView.backgroundColor = rgb(238, 236, 246, 1.0);
    [self.view addSubview:_tableView];

    UIView *viewtop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceWidth/4+45+30)];
    self.tableView.tableHeaderView = viewtop;

    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kDeviceWidth, 45)];
    view1.backgroundColor = [UIColor whiteColor];
    [viewtop addSubview:view1];
    
    _searchBar = [[QCSearchBar alloc]initWithFrame: CGRectMake(15, 7.5, kDeviceWidth-15*2, 30)];
    
    _searchBar.delegate = self;
    [view1 addSubview:_searchBar];
    
    _cover = [[UIControl alloc] initWithFrame:CGRectMake(0, view1.bottom, kDeviceWidth, kDeviceHeight)];
    _cover.backgroundColor = [UIColor colorWithWhite:0 alpha:.3];
    _cover.hidden = YES;
    [_cover addTarget:self action:@selector(coverAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cover];


    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, view1.bottom+10, kDeviceWidth, kDeviceWidth/4)];
    [viewtop addSubview:view2];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth/3, view2.height)];
    [button1 addTarget:self action:@selector(buttonAC1) forControlEvents:UIControlEventTouchUpInside];
    [button1 setImage:[UIImage imageNamed:@"hy-adsjlxr"] forState:UIControlStateNormal];
    [view2 addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/3, 0, kDeviceWidth/3, view2.height)];
    [button2 addTarget:self action:@selector(buttonAC2) forControlEvents:UIControlEventTouchUpInside];
    [button2 setImage:[UIImage imageNamed:@"hy-adwxpy"] forState:UIControlStateNormal];
    [view2 addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(kDeviceWidth/3*2, 0, kDeviceWidth/3, view2.height)];
    [button3 addTarget:self action:@selector(buttonAC3) forControlEvents:UIControlEventTouchUpInside];
    [button3 setImage:[UIImage imageNamed:@"hy-adpyq"] forState:UIControlStateNormal];
    [view2 addSubview:button3];


}
//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//手机联系人
- (void)buttonAC1 {
   
    [self addFriendss];
}

//微信好友
- (void)buttonAC2 {
  
    [self AAShareViewWeixinSessionButtonDidClicked:nil];
}

//朋友圈
- (void)buttonAC3 {
    
    [self AAShareViewWeixinTimelineContentButtonDidClicked :nil];
}

//添加按钮事件响应
- (void)addFriends{

    AAShareView *share = [[AAShareView alloc] initWithType:AAShareViewTypeFriend];
    share.delegate = self;
    [share show];
}

//添加按钮事件响应
- (void)addFriendss{
    //获取通讯录信息
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted || ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请开启访问通讯录功能,获取通讯录好友" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    QCAddressListNewController * addressListView = [[QCAddressListNewController alloc]init];
    [self.navigationController pushViewController:addressListView animated:YES];
}

#pragma mark - ShareView delegate
- (void)AAShareViewWeixinSessionButtonDidClicked:(AAShareView *)view {
    //微信好友
    //    邀请好友 http://60.195.254.33:8083/wap/user/shareFriend.jsp?userId=用户id
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    NSString *URLString = [NSString stringWithFormat:@"%@wap/user/shareFriend.jsp?userId=%ld",YXB_IP_ADRESS,(long)userModel.user.t_id];
    [YXBTool shareToWeixinSessionContent:@"我是无忧借条，你只要想来，我随时待命。为呵护你的珍贵友情，安全认证的无忧借条为你保驾护航。" imgName:nil url:URLString title:@"无忧借条，为你的资金安全、友情无忧撑起保护伞！" callBackBlock:^{
        
    }];
}

- (void)AAShareViewWeixinTimelineContentButtonDidClicked:(AAShareView *)view {
    //朋友圈
    //    邀请好友 http://60.195.254.33:8083/wap/user/shareFriend.jsp?userId=用户id
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    NSString *URLString = [NSString stringWithFormat:@"%@wap/user/shareFriend.jsp?userId=%ld",YXB_IP_ADRESS,(long)userModel.user.t_id];
    [YXBTool shareToWeixinTimelineContent:@"我是无忧借条，你只要想来，我随时待命。为呵护你的珍贵友情，安全认证的无忧借条为你保驾护航。" imgName:nil url:URLString title:@"无忧借条，为你的资金安全、友情无忧撑起保护伞！" callBackBlock:^{
        
    }];

}

#pragma mark --------- QCSearchBar--------------------
- (void)QCSearchBarDidBeginEditing:(QCSearchBar *)searchBar {
    AddFriendsMenuController * controller = [[AddFriendsMenuController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}



#pragma mark - Actions
//扫一扫
- (void)scanAction:(UIButton *)button {

    ScannerViewController *scan = [[ScannerViewController alloc] init];
    [self.navigationController pushViewController:scan animated:YES];
}

- (void)coverAction:(UIControl *)cover {
    
    [_searchBar resignFirstResponder];
    [_tableView reloadData];
}

//- (void)leftAction {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)noRecordTapAction:(UITapGestureRecognizer *)tap {
    QCAddressListViewController * addressListView = [[QCAddressListViewController alloc]init];
    [self.navigationController pushViewController:addressListView animated:YES];
}

//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
