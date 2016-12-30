
//  LoanAddressBookViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/11/10.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanAddressBookViewController.h"
#import "AddressDBManager.h"
#import "AddressBookModel.h"
#import "LoanOrRepayAddressbookCell.h"
#import "QCAddressBook.h"
#import "YXBTool.h"
#import "LoanAddressBookCell.h"
#import "UIAlertView+Block.h"
#import "StatusHttp.h"
#import "LoanDetailsViewController.h"
#import "TFriendRelationManager.h"

#define CellHeaderColor [YXBTool colorWithHexString:@"#F2F1F6"]

@interface LoanAddressBookViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,StatusHttpDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableDictionary *dataDic;
@property (nonatomic,strong)NSMutableArray*dataArray;
@property (nonatomic,strong)NSMutableArray*searchArray;
@property(nonatomic,strong)UISearchBar *topSearchBar;
@property(nonatomic,strong)UISearchDisplayController *mySearchDisplayController;
@property (nonatomic,strong)HttpOperator *iHttpOperator;

@end

@implementation LoanAddressBookViewController

-(void)dealloc
{
    NSLog(@"%@---dealloc",[self class]);
}

-(void)leftClicked
{
    [ProgressHUD dismiss];
    [[AddressDBManager shareInstance] cancel];
    [super leftClicked];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    [self setTitle:@"选择朋友"];
    [self generateDicWithAddressBookDataWithBlock];
    [self createMyTableView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}


-(void)generateDicWithAddressBookDataWithBlock
{
    
    __weak typeof(self)this = self;


    if([[[NSUserDefaults standardUserDefaults] objectForKey:hasSavedAddressBook] integerValue] != 1)
    {
        [ProgressHUD showWithStatus:@"正在读取通讯录..." maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeLongBottom];

    }
        
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[AddressDBManager shareInstance] readLocalAddressBookWithCompleteBlock:^(NSMutableArray *resultArray,onAddressBookCompleteBlockTimes times) {
                
                //保存数组用于搜索
            this.dataArray = [NSMutableArray arrayWithArray:resultArray];
                //网络好友同步
            [this synAddressBookWithArray:this.dataArray];
                //将数组处理成字典
            [this handleArrayToDicWithArray:resultArray];
                
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([this.dataArray count] > 0) {
                    [ProgressHUD dismiss];
//                    [ProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%ld条记录",(long)[this.dataArray count]]];
                    
                    [this.tableView reloadData];

                }
                
            });


        }];
        
        
    });
}


-(void)handleArrayToDicWithArray:(NSMutableArray *)modelArray
{
    self.dataDic = [NSMutableDictionary dictionary];
    NSArray *array = [YXBTool getAlphaBetNumbers];
    
    for (NSString *al in array) {
        NSMutableArray *mArray = [[NSMutableArray alloc] init];
        [_dataDic setObject:mArray forKey:al];
    }

    for (QCAddressBook *model in modelArray) {
        NSString *shouzimu =[[model.pinyin substringWithRange:NSMakeRange(0, 1)] uppercaseString];
        if ([array containsObject:shouzimu] ) {
            NSMutableArray *tempArray = _dataDic[shouzimu];
            [tempArray addObject:model];
            
        }
        else
        {
            NSMutableArray *tempArray = _dataDic[@"#"];
            tempArray = [NSMutableArray array];
            [tempArray addObject:model];
            
        }
    }

}

//同步通讯录到服务器 自动关联好友
-(void)synAddressBookWithArray:(NSMutableArray *)dataArray
{
    //拼接电话号码的字符串
    NSMutableString *telStr = [NSMutableString stringWithString:@""];
    for (int i = 0; i < [dataArray count]; i ++) {
        QCAddressBook *book = dataArray[i];
        [telStr appendString:[NSString stringWithFormat:@"%@,",book.tel]];
    }
    if ([telStr length] > 1) {
        [telStr deleteCharactersInRange:NSMakeRange([telStr length] - 1, 1)];

    }
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator =[[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __block HttpOperator * assginHtttperator = _iHttpOperator;
    __block typeof(self)this = self;
    [self.iHttpOperator connetStart:^(int d) {
        [assginHtttperator stopAnimation];
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            //            [this.tableView reloadDeals];
        }
        
    } param:^(NSString *s) {
        
        QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
        User *user = localUser.user;
        NSString *userName = user.username;
        
        TFriendRelationManager* _currFriend = (TFriendRelationManager *)  [assginHtttperator getAopInstance:[TFriendRelationManager class] returnValue:[NSSkyArray class]];
        
        [_currFriend getTFriendRelationByPhoneBook:userName withPhoneArr:telStr];

        
    } complete:^(NSSkyArray *r, int taskid) {
        
        
    }];
    
    [self.iHttpOperator connect];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createMyTableView
{
    CGFloat x = 0, y = 0, w = kDeviceWidth, h = kDeviceHeight - 64 - _bottomHeight;
    self.tableView = [[UITableView alloc] initWithFrame:ccr(x, y, w, h)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    
    self.topSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
    self.topSearchBar.backgroundColor =rgb(238, 238, 238, 1);
    self.topSearchBar.backgroundImage = [YXBTool imageWithColor:[UIColor clearColor]];
    _topSearchBar.placeholder = @"搜索联系人";
    
    _topSearchBar.layer.borderWidth = 0.3;
    _topSearchBar.layer.borderColor = rgb(180, 180, 180, 1.0).CGColor;
    _topSearchBar.delegate = self;
    _tableView.tableHeaderView=_topSearchBar;
    
    self.mySearchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:_topSearchBar contentsController:self];
    _mySearchDisplayController.active = NO;
    _mySearchDisplayController.searchResultsDataSource = self;
    _mySearchDisplayController.searchResultsDelegate = self;
    _mySearchDisplayController.delegate= self;
    _mySearchDisplayController.searchResultsTableView.backgroundColor = rgb(242, 239, 248, 0.98);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    NSArray *array = [YXBTool getAlphaBetNumbers];

    return _searchArray?1:[array count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [YXBTool getAlphaBetNumbers];

    NSMutableArray *cArray = _dataDic[array[section]];
    return _searchArray?[_searchArray count]:[cArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [YXBTool getAlphaBetNumbers];

    static NSString * cellID  =@"cellID";
    LoanAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[LoanAddressBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    NSMutableArray *cArray = _dataDic[array[indexPath.section]];
    if (_searchArray) {
        cArray = _searchArray;
    }
    if ([cArray count] == 0) {
        return cell;
    }
    if (indexPath.row < [cArray count]) {
        QCAddressBook *model = cArray[indexPath.row];
        cell.addressBook = model;
        cell.friendStyle = LoanOrRepayAddressbookCellStyleAddressNotFriend;

    }

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSArray *array = [YXBTool getAlphaBetNumbers];
    NSMutableArray *cArray = _dataDic[array[section]];
    if ([cArray count] == 0) {
        return 0;
    }
    return 20;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSString *title = [YXBTool getAlphaBetNumbers][section];
//    if (_searchArray) {
//        title = @"搜索结果";
//    }
//    return title;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSString *title = [YXBTool getAlphaBetNumbers][section];
    title = [NSString stringWithFormat:@"    %@",title];
    if (_searchArray) {
        title = @"搜索结果";
    }

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:ccr(10, 0, kDeviceWidth-20, 20)];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.backgroundColor = CellHeaderColor;

    titleLabel.text = title;
    
    return titleLabel;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *array = [YXBTool getAlphaBetNumbers];
    NSMutableArray *cArray = _dataDic[array[indexPath.section]];
    if (_searchArray) {
        cArray = _searchArray;
    }
    
    if (indexPath.row < [cArray count])
    {
        QCAddressBook *model = cArray[indexPath.row];
        self.loanModel.loanFriendType = 2;
        self.loanModel.lenderId = 0;
        self.loanModel.phoneNumberOfAddressBook = model.tel;

        QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
//        self.loanModel.borrowerId = userModel.user.t_id;

        NSString *phoneNO = model.name;
        if (userModel != nil)
        {
            if ([phoneNO isEqualToString:userModel.user.username]) {
                
                [ProgressHUD showErrorWithStatus:@"您不能向自己借款"];
                return;
            }
            
        }
        
        NSString *title = [NSString stringWithFormat:@"是否向\"%@\"发起借款",model.name];
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


//设置索引条
-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray *array = [YXBTool getAlphaBetNumbers];
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:array];
    for (NSString *key in array) {
        if ([_dataDic[key] count] == 0) {
            [tempArray removeObject:key];
        }
    }
    
    return array;
    
}

#pragma mark - UISearchDisplayController 代理

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    NSString *s = [NSString stringWithFormat:@"name CONTAINS '%@'|| tel BEGINSWITH '%@'||_pinyin BEGINSWITH '%@'||_maxPinyin BEGINSWITH '%@'",searchString,searchString,searchString,searchString];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:s];
    
    self.searchArray = [NSMutableArray arrayWithArray:[self.dataArray filteredArrayUsingPredicate:predicate]];
    [self.tableView reloadData];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
    
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _searchArray = nil;
    [self.tableView reloadData];
}// called when cancel button pressed


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

@end
