//
//  AddFriendsMenuController.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/14.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AddFriendsMenuController.h"
//#import "QCSearchBar.h"
#import "QCAddressListViewController.h"
#import "QCLinkManCell.h"
#import "UserManager.h"
#import "FriendDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIAlertView+Block.h"
#import "TFriendRelationManager.h"
#import "TResultSet.h"
#import "FriendDetailViewController.h"
#import "QCNewFriendCell.h"
#import "QCAddressListNewController.h"


#define AddFriendsMenuCellHeight 60
#define AddFriendsMenuControllerSearchHolder @"     手机号码/无忧借条ID"

@interface AddFriendsMenuController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,QCNewFriendCellDelegate>
{
    UITextField *contactfield;
}
@property(nonatomic,strong)QCSearchBar *searchBar;//自定义搜索栏
@property(nonatomic,strong)UITableView *tableView;//
@property(nonatomic,strong)NSMutableArray *dataArray;//数据源
@property(nonatomic,strong)UIButton *secondBtn;//第二栏 跳至联系人按钮
@property(nonatomic,strong)HttpOperator * iHttpOperator;
@property(nonatomic,strong)UILabel *emptyLabel;
@property(nonatomic,strong)UISearchBar *topSearchBar;
@property(nonatomic,strong)UISearchDisplayController *mySearchDisplayController;
@property(nonatomic,strong)NSString *searchText;//搜索的文字

@end

@implementation AddFriendsMenuController
-(void)dealloc{
    NSLog(@"AddFriendsMenuController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"添加好友"];
    self.view.backgroundColor = rgb(240,240,240,1);
    _searchText = @"";
    self.dataArray = [NSMutableArray array];
    [self loadSearchViews1];
    [self setBackView];
//    [self loadViews];
    // Do any additional setup after loading the view.
}


-(void)loadSearchViews1
{
    self.topSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 40)];
    _topSearchBar.backgroundColor = [UIColor whiteColor];
    _topSearchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:_topSearchBar.bounds.size];
    _topSearchBar.placeholder = @" ";
//    _topSearchBar.keyboardType = UIKeyboardTypeNumberPad;
    [_topSearchBar setContentMode:UIViewContentModeLeft];
    _topSearchBar.layer.borderWidth = 1.0;
    _topSearchBar.layer.borderColor = rgb(223, 223, 223, 1.0).CGColor;
    _topSearchBar.delegate = self;
    [_topSearchBar setImage:[UIImage new] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.view addSubview:_topSearchBar];
    
    contactfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 2, 200, _topSearchBar.height)];
    contactfield.font = [UIFont systemFontOfSize:14];
    contactfield.textColor = rgb(136, 136, 140, 1.0);
    contactfield.textAlignment = NSTextAlignmentLeft;
    contactfield.text = AddFriendsMenuControllerSearchHolder;
    contactfield.userInteractionEnabled = NO;
    [_topSearchBar addSubview:contactfield];
    
    
    
    UIImageView *contactImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12, 16, 16)];
    contactImage.image = [UIImage imageNamed:@"friend_search_bar_icon_normal"];
    [contactfield addSubview:contactImage];

    [_topSearchBar addSubview:contactfield];
    
    
    
    self.mySearchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:_topSearchBar contentsController:self];
    _mySearchDisplayController.active = NO;
    _mySearchDisplayController.searchResultsDataSource = self;
    _mySearchDisplayController.searchResultsDelegate = self;
    _mySearchDisplayController.searchResultsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
}
-(void)loadViews
{

    CGFloat space = 20;
    UIButton *fromContactsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fromContactsBtn.frame = CGRectMake(0, _topSearchBar.frame.origin.y + _topSearchBar.height + space, kDeviceWidth, 44);
    [fromContactsBtn addTarget:self action:@selector(toContacts) forControlEvents:UIControlEventTouchUpInside];
//    fromContactsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    fromContactsBtn.layer.borderWidth = 1.0;
    fromContactsBtn.layer.borderColor = rgb(223, 223, 223, 1.0).CGColor;
    fromContactsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [fromContactsBtn setTitleColor:rgb(136, 136, 140, 1.0) forState:UIControlStateNormal];
//    [fromContactsBtn setTitle:@"从手机联系人添加" forState:UIControlStateNormal];
    fromContactsBtn.backgroundColor = [UIColor whiteColor];
    self.secondBtn = fromContactsBtn;
    
    UILabel *contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 130, fromContactsBtn.height)];
    contactLabel.font = [UIFont systemFontOfSize:14];
    contactLabel.textColor = rgb(136, 136, 140, 1.0);
    contactLabel.textAlignment = NSTextAlignmentRight;
    contactLabel.text = @"从手机联系人添加";
    [fromContactsBtn addSubview:contactLabel];
    
    
    
    UIImageView *contactImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 15, 15)];
    contactImage.image = [UIImage imageNamed:@"contacts.png"];
    [contactLabel addSubview:contactImage];
    
    UIImageView *nextImage = [[UIImageView alloc] initWithFrame:CGRectMake(kDeviceWidth - 50, 0, 30, fromContactsBtn.height)];
    nextImage.image = [UIImage imageNamed:@"next.png"];
    nextImage.contentMode = UIViewContentModeCenter;
    [contactLabel addSubview:nextImage];
    
    [self.view addSubview:fromContactsBtn];

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


//跳转至手机通讯录联系人添加
-(void)toContacts
{
    QCAddressListNewController * addressListView = [[QCAddressListNewController alloc]init];
    [self.navigationController pushViewController:addressListView animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark UITableViewDelegate&dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return AddFriendsMenuCellHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellID";
    QCNewFriendCell * cell = [self.searchDisplayController.searchResultsTableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[QCNewFriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        cell.delegate = self;
        cell.selectedBackgroundView = [[UIView alloc]init];
        cell.selectedBackgroundView.backgroundColor = kViewBackground;
    }
    cell.isFromSearch = YES;
    User *user = _dataArray[indexPath.row];

    if (indexPath.row == 0) {
        CALayer * upLine = [CALayer layer];
        upLine.frame = CGRectMake(0, 0, kDeviceWidth, 1);
        upLine.backgroundColor = kLineColor.CGColor;
        [cell.selectedBackgroundView.layer addSublayer:upLine];
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
        lineView1.backgroundColor = kLineColor;
        [cell.contentView addSubview:lineView1];
    }else {
        CALayer * upLine = [CALayer layer];
        upLine.frame = CGRectMake(0, 0, kDeviceWidth, 1);
        upLine.backgroundColor = [UIColor whiteColor].CGColor;
        [cell.selectedBackgroundView.layer addSublayer:upLine];
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
        lineView1.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:lineView1];
    }
    
    CALayer * downLine = [CALayer layer];
    downLine.frame = CGRectMake(0, AddFriendsMenuCellHeight, kDeviceWidth, 1);
    downLine.backgroundColor = kLineColor.CGColor;
    [cell.selectedBackgroundView.layer addSublayer:downLine];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, AddFriendsMenuCellHeight-1, kDeviceWidth, 1)];
    lineView.backgroundColor = kLineColor;
    
    [cell.contentView addSubview:lineView];
    
    cell.tUser = user;
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    User *user = [_dataArray objectAtIndex:indexPath.row];


    FriendDetailViewController *controller = [[FriendDetailViewController alloc] init];
    controller.user = user;
//    controller.isCheckFriend = YES;
    [self.navigationController pushViewController:controller animated:YES];

    
}



#pragma -mark 添加好友
//- (void)acceptButtonClickedNewFriendCell:(QCNewFriendCell *)cell {
//    NSIndexPath *indexPath = [_searchDisplayController.searchResultsTableView indexPathForCell:cell];
//    [self addFriendsViewWithUser:indexPath];
//}

-(void)acceptButtonClickedNewFriendCell:(QCNewFriendCell *)cell
{

//    [self reloadSearchTableview];
    [self.view endEditing:YES];
    NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForCell:cell];
    [self addFriendsViewWithUser:indexPath];


}

//添加好友网络请求
-(void)addFriendsViewWithUser:(NSIndexPath *)indexPath
{
    User *user = [_dataArray objectAtIndex:indexPath.row];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];

    [self reloadSearchTableview];
    if ([userModel.user.yxbId isEqualToString:_searchBar.textField.text] || [userModel.user.username isEqualToString:_searchBar.textField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您不能添加自己为好友" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }

    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"输入对方知道的验证信息,能更快成为好友哦" delegate:self cancelButtonTitle: @"取消" otherButtonTitles:@"确认发送", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                NSString *message = [alertView textFieldAtIndex:0].text;
                [self requestFriendsWithUser:user message:message];

            }
        }];

    }
    
//    [self reloadSearchTableview];

}

#pragma -mark 添加好友网络请求
-(void)requestFriendsWithUser:(User *)user message:(NSString *)message
{

    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AddFriendsMenuController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error)
     {
         
         if (error == EHttp_Operator_Failed) {
             //服务器挂了
         }
         
     } param:^(NSString *s) {
         
         [this httpLOadParams:s httpOperation:assginHtttperator user:user message:message];
         
     } complete:^(TResultSet *r, int taskid){
         
         [this httpLoadComplete:r];
     }];
    
    [self.iHttpOperator connect];

    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation user:(User *)user message:(NSString *)message
{
    QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
    User *userMe = localUser.user;
    
    TFriendRelationManager *userManager = (TFriendRelationManager *)[httpOperation getAopInstance:[TFriendRelationManager class] returnValue:[TResultSet class]];
    
    [userManager addTFriendRelationByMobile:userMe.username withFriendName:user.username withNote:message];
}
//请求完成
-(void)httpLoadComplete:(TResultSet *)r{
    if(r.errCode == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
            [self leftClicked];
        }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }

}
#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchText = searchText;
    [self loadFriendData];
}



#pragma -mark 搜索好友网络请求
-(void)loadFriendData
{
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AddFriendsMenuController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error)
     {
         
         if (error == EHttp_Operator_Failed) {
             //服务器挂了
         }
         
     } param:^(NSString *s) {
         
         [this loadFriendDataHttpLOadParams:s httpOperation:assginHtttperator];
         
     } complete:^(User *r, int taskid)
     {
         [this loadFriendDataHttpLoadComplete:r];
     }];
    
    [self.iHttpOperator connect];
}
//上传参数
- (void)loadFriendDataHttpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    UserManager *userManager = (UserManager *)[httpOperation getAopInstance:[UserManager class] returnValue:[User class]];
    
    //         [userManager searchFriend:_searchBar.textField.text];
    [userManager searchFriend:_searchText];

}
//请求完成
-(void)loadFriendDataHttpLoadComplete:(User *)r{
    if(r.errCode == 0)
    {
        User *user = r;
        if((self.dataArray != nil) && ([self.dataArray count] > 0))
        {
            [self.dataArray removeAllObjects];
            [self.dataArray addObject:user];
            
        }
        else
        {
            [self.dataArray addObject:user];
            //                 [this.tableView reloadData];
            
        }
        
        [self reloadSearchTableview];
        
    }
    else if(r.errCode == 7)
    {
        if((self.dataArray != nil) && ([self.dataArray count] > 0))
        {
            [self.dataArray removeAllObjects];
        }
        
        [self reloadSearchTableview];
        
    }
    else
    {
        //             _emptyLabel.hidden = NO;
        //             _tableView.hidden = YES;
        [self.dataArray removeAllObjects];
        NSLog(@"%@",r.errString);
    }

}
#pragma -mark 刷新搜索tableview
-(void)reloadSearchTableview
{
    [self.searchDisplayController.searchResultsTableView reloadData];
}

#pragma UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    if ([searchBar.text isEqualToString:@""]) {
        contactfield.text = AddFriendsMenuControllerSearchHolder;

    }
    else
    {
        contactfield.text = @"";

    }
    return YES;
}

-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([searchBar.text isEqualToString:@""] && [text length] > 0) {
        contactfield.text = @"";

    }
    else
    {
        NSMutableString *mText = [[NSMutableString alloc] initWithString:searchBar.text];
        [mText replaceCharactersInRange:range withString:text];
        if ([searchBar.text isEqualToString:@""]) {
            contactfield.text = AddFriendsMenuControllerSearchHolder;
            
        }
        else
        {
            contactfield.text = @"";
            
        }

    }
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    contactfield.text = AddFriendsMenuControllerSearchHolder;

}
-(void)setBackView
{
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    
}

-(void)leftClicked
{
    
    [self.navigationController popViewControllerAnimated:YES];
 
}
@end
