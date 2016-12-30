//
//  FriendDetailViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/5/12.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "FriendDetailViewController.h"
#import "FriendDetailHeaderView.h"
#import "FriendDetailFooterView.h"
#import "FriendDetailCell.h"
#import "HttpOperator.h"
#import "TFriendRelationManager.h"
#import "TResultSet.h"
#import "UIAlertView+Block.h"
#import "LoanDetailsViewController.h"
#import "QClendToViewController.h"
#import "LoanQuickTabViewController.h"
#import "UserManager.h"
#import "QCBaseTableView.h"
#import "YXBTool.h"
#import "ImageLargeTool.h"
#import "VIPhotoView.h"
#import "FriendScanViewController.h"
#import "QCFriendModel.h"


@interface FriendDetailViewController ()<UITableViewDataSource,UITableViewDelegate,FriendDetailFooterViewDelegate,QCBaseTableViewDelegate,FriendDetailHeaderViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    UIImageView *fullImageView;
    UIScrollView *scrollView;
}
@property(nonatomic,strong)FriendDetailHeaderView *headerView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)QCBaseTableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)HttpOperator * iHttpOperator;

@property(nonatomic,assign)BOOL isFriend;//0——》不是好友默认  1——》已是好友


@end

@implementation FriendDetailViewController

-(void)dealloc{
    
}
-(void)leftClicked
{
    
    NSInteger tmp = [self.navigationController.viewControllers count];
    for (NSInteger i = (tmp - 1); i >= 0; i--) {
        UIViewController* con = [self.navigationController.viewControllers objectAtIndex:i];
        
        if ([con isKindOfClass:[FriendScanViewController class]] || [con isKindOfClass:[FriendDetailViewController class]]) {
            continue;
        }
        
        [self.navigationController popToViewController:con animated:YES];
        break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"详细资料"];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setBackView];
    [self loadViews];
    [self loadSavedData];
    [self loadData];
    
    // Do any additional setup after loading the view.
}


-(void)loadSavedData
{
    __block FriendDetailViewController *this = self;
    //读取数据库
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"yxbId = %@",self.user.yxbId];

    NSArray *users = [[DBManager shareInstance] query:@"QCFriendModel" predicate:predicate];
    
    if ([users count] <= 0) {
        predicate = [NSPredicate predicateWithFormat:@"userId = %ld",(long)self.user.t_id];
        
        users = [[DBManager shareInstance] query:@"QCFriendModel" predicate:predicate];

    }
    if ([users count] <= 0) {
        predicate = [NSPredicate predicateWithFormat:@"username = %@",self.user.username];
        
        users = [[DBManager shareInstance] query:@"QCFriendModel" predicate:predicate];
        
    }

    
    if ([users count] > 0) {
        QCFriendModel *model = users[0];
        this.user.yxbId = model.yxbId;
        this.user.t_id = [model.userId integerValue];
        this.user.username = model.username;
        this.user.nickname = model.nickname;
        this.user.iconAddr = model.iconAddr;
        this.user.realname = model.realName;
        this.user.signature = @"";
        this.isFriend = YES;
        [this loadData];
    }
    
    
    
    
}

#pragma -mark 搜索好友网络请求
-(void)requestFriendData
{
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak FriendDetailViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        [this stopDefaultAnimation];

    } cancel:^(int d) {
        [this.tableView reloadDeals];

    } error:^(int d, THttpOperatorErrorCode error){
         
         [this.tableView reloadDeals];
         if (error == EHttp_Operator_Failed) {
             //服务器挂了
             [ProgressHUD showSuccessWithStatus:@"加载失败,请检查手机网络"];
         }
         
     } param:^(NSString *s) {
         
         [this httpLOadParams:s httpOperation:assginHtttperator];
         
     } complete:^(UserBriefInfo *r, int taskid){
         [this httpLoadComplete:r];
     }];
    
    [self.iHttpOperator connect];
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    UserManager *userManager = (UserManager *)[httpOperation getAopInstance:[UserManager class] returnValue:[UserBriefInfo class]];
    
    //         [userManager searchFriend:_searchBar.textField.text];
    //         [userManager searchFriend:[NSString stringWithFormat:@"%ld",(long)this.user.t_id]];
    NSString *searchText = @"";
    if (self.user.yxbId != nil && [self.user.yxbId length] > 1) {
        searchText = self.user.yxbId;
    }else if (self.user.username != nil && [self.user.username length] > 1)
    {
        searchText = self.user.username;
    }else if(self.user.t_id != 0)
    {
        searchText = [NSString stringWithFormat:@"%ld",(long)self.user.t_id];
    }
    
    if ([searchText isEqualToString:@""]) {
        [ProgressHUD showErrorWithStatus:@"查询用户信息失败"];
    }
    else
    {
        NSInteger random = arc4random()%1001 + 1000; //生成四位随机数
        [userManager getUserBriefInfo:[YXBTool getUserToken] searchYXBId:[NSString stringWithFormat:@"%@%ld",searchText,(long)random]];
        
    }
    //         [userManager getUserBriefInfo:[YXBTool getUserToken] searchYXBId:@"18601251114"];
    

}
//请求完成
-(void)httpLoadComplete:(UserBriefInfo *)r{
    [self.tableView reloadDeals];
//    NSLog(@"%ld",r.errCode);
    if(r.errCode == 0)
    {
        if ([r isKindOfClass:[UserBriefInfo class]]) {
            User *friendUser = [[User alloc] init];
            friendUser.yxbId = r.yxbUserID;
            friendUser.username = r.loginNum;
            friendUser.nickname = r.nickName;
            friendUser.iconAddr = r.imageUrl;
            friendUser.signature = r.signingMessages;
            friendUser.t_id = r.userID;
            _headerView.xinyongGrade=r.rankLevel;
            _headerView.realName=r.realName;
            _headerView.isFriend=r.isFriend;
            
            self.user = friendUser;
            self.isFriend = r.isFriend;
            //                 [self loadViews];
            [self loadData];
            
        }
        else
        {
            [ProgressHUD showErrorWithStatus:r.errString];
            
        }
    }
    else if(r.errCode == 7)
    {
        [ProgressHUD showErrorWithStatus:r.errString];
    }
    else
    {
        [ProgressHUD showErrorWithStatus:r.errString];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadViews
{

    CGFloat x = 0,y = 0, w = kDeviceWidth, h = 120;
    self.headerView = [[FriendDetailHeaderView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _headerView.delegate = self;
    self.footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, w, 2*h)];
//    
    UIButton  *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(15, 5, kDeviceWidth-30, 36);
    button1.tag=1001;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:button1];
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake(15, button1.bottom+11, kDeviceWidth-30, 36);
    button2.tag=1002;
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:button2];
    
    
    x = 0,y = 0,w = kDeviceWidth,h = kDeviceHeight - 64;
    self.tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(x, y, w, h) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = _footerView;
  
}

-(void)loadData
{
    
//    NSMutableArray *titles = [NSMutableArray array];
    
    if (!_isFriend) {
        //[titles addObject:@"添加好友"];
        UIButton *button1=(UIButton *)[self.view viewWithTag:1001];
        [button1 setImage:[UIImage imageNamed:@"jhy.png"] forState:UIControlStateNormal];
        UIButton *button2=(UIButton *)[self.view viewWithTag:1002];
        button2.hidden=YES;
        

    }
    else
    {
        UIButton *button1=(UIButton *)[self.view viewWithTag:1001];
        //[button1 setImage:[UIImage imageNamed:@"jk-but.png"] forState:UIControlStateNormal];
        button1.hidden=YES;
        UIButton *button2=(UIButton *)[self.view viewWithTag:1002];
        //[button2 setImage:[UIImage imageNamed:@"jk2-but.png"] forState:UIControlStateNormal];
        button2.hidden=YES;
       
        
    }

    
    if (_headerView) {
        _headerView.user = _user;
    }
    
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray array];
    }
    else
    {
        [self.dataArray removeAllObjects];
    }
    

    
}

#pragma mark -----------UITableViewDelegate


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
    return FriendDetailCellHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"detailIdentifier";
    FriendDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[FriendDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.width = _tableView.width;
    cell.indexPath = indexPath;
    
    if (indexPath.section < [_dataArray count]) {
        FriendDetailItemModel *model = _dataArray[indexPath.section];
        cell.user = model;
    }
    
    return cell;
}

-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    [self requestFriendData];
}

- (void)buttonAction:(UIButton *)button{

    if (!_isFriend) {
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        if ([_user.yxbId isEqualToString:userModel.user.yxbId] || [_user.username isEqualToString:userModel.user.username])
        {
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
                    //                    [self requestFriendsWithUser:_user message:message];
                    [self requestFriendsWithUser:_user msg:message];
                    
                }
            }];
            
        }
        

        
    }
    else{
        
//        if (button.tag==1001) {
//            LoanDetailsViewController * loanDetails = [[LoanDetailsViewController alloc]init];
//            loanDetails.bOrL = NEWLOAN;
//            loanDetails.fromFriendUser = _user;
//            
//            [self.navigationController pushViewController:loanDetails animated:YES];
//            
//        }else if(button.tag==1002 )
//        {
//            LoanQuickTabViewController *controller = [[LoanQuickTabViewController alloc] init];
//            controller.friendID=_user.t_id;
//            controller.lendMyFriend = _user;
//            [self.navigationController pushViewController:controller animated:YES];
//            
//        }
//    
    
    
    
    }

}

-(void)friendDetailFooterViewSelectItem:(FootViewButtonType)buttonType
{
    /*
    NSArray *array = [NSArray arrayWithObjects:@"向他借款",@"快速放款",@"加入黑名单",@"确认添加", nil];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:array[buttonType] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    */
    if (buttonType == FootViewButtonTypeConform) {
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];

        if ([_user.yxbId isEqualToString:userModel.user.yxbId] || [_user.username isEqualToString:userModel.user.username])
        {
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
//                    [self requestFriendsWithUser:_user message:message];
                    [self requestFriendsWithUser:_user msg:message];
                    
                }
            }];

        }
        
        

    }
    else
    {
//        NSArray *array = [NSArray arrayWithObjects:@"向他借款",@"快速放款",@"加入黑名单",@"确认添加", nil];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:array[buttonType] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
        if (buttonType == FootViewButtonTypeBorrow) {
            LoanDetailsViewController * loanDetails = [[LoanDetailsViewController alloc]init];
            loanDetails.bOrL = NEWLOAN;
            loanDetails.fromFriendUser = _user;

            [self.navigationController pushViewController:loanDetails animated:YES];

        }else if(buttonType == FootViewButtonTypeLend)
        {
//            LoanDetailsViewController * loanDetails = [[LoanDetailsViewController alloc]init];
//            loanDetails.bOrL = BorrowerORLendersQuickLend;
//            loanDetails.lendMyFriend = _user;
//            
//            [self.navigationController pushViewController:loanDetails animated:YES];
//            QClendToViewController *lend=[[QClendToViewController alloc]init];
//            lend.friendID=_user.t_id;
//            [self.navigationController pushViewController:lend animated:YES];
            LoanQuickTabViewController *controller = [[LoanQuickTabViewController alloc] init];
            controller.friendID=_user.t_id;
            controller.lendMyFriend = _user;
            [self.navigationController pushViewController:controller animated:YES];
            
        }

    }
    
}

-(void)requestFriendsWithUser:(User *)user msg:(NSString *)msg
{
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __block FriendDetailViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        [ProgressHUD dismiss];

        
    } error:^(int d, THttpOperatorErrorCode error){
         
         if (error == EHttp_Operator_Failed) {
             //服务器挂了
         }
         [ProgressHUD dismiss];

         
     } param:^(NSString *s) {
         
         [this httpLOad_RequestFriendsParams:s httpOperation:assginHtttperator User:user msg:msg];
         
     } complete:^(TResultSet *r, int taskid){
         [this httpLoad_RequestFriendsComplete:r];
     }];
    
    [self.iHttpOperator connect];
    [ProgressHUD showWithStatus:@"请求发送中..." maskType:ProgressHUDMaskTypeNone tipsType:ProgressHUDTipsTypeLongBottom];
    
    
}
//上传参数
- (void)httpLOad_RequestFriendsParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation User:(User *)user msg:(NSString *)msg
{
    QCUserModel *localUser = [[QCUserManager sharedInstance] getLoginUser];
    User *userMe = localUser.user;
    
    TFriendRelationManager *userManager = (TFriendRelationManager *)[httpOperation getAopInstance:[TFriendRelationManager class] returnValue:[TResultSet class]];
    
    [userManager addTFriendRelationByMobile:userMe.username withFriendName:_user.username withNote:msg];
}
//请求完成
-(void)httpLoad_RequestFriendsComplete:(TResultSet *)r{
    [ProgressHUD dismiss];
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
-(void)imageActionWithImageView:(UIImageView *)imageView
{
//    QCImageToolViewController *controller = [[QCImageToolViewController alloc] init];
//    controller.baseImageView = imageView;
//    [controller actionTap];
//    [self.view addSubview:controller.view];
//    [self.navigationController pushViewController:controller animated:YES];

//    ImageLargeTool *tool = [[ImageLargeTool alloc] init];
//    tool.baseImageView = imageView;
//    [tool actionTap];
//    [self actionTap:imageView];
    [self seeLargeImageWithImage:imageView.image];
}

-(void)seeLargeImageWithImage:(UIImage *)image
{
//    UIImage *image = [UIImage imageNamed:@"test.jpg"];
    UIWindow *mWindow = [[[UIApplication sharedApplication] delegate] window];
    if (!mWindow.isKeyWindow) {
        [mWindow makeKeyAndVisible];
        
    }

    VIPhotoView *photoView = [[VIPhotoView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) andImage:image];
    photoView.backgroundColor = [UIColor blackColor];
    photoView.autoresizingMask = (1 << 6) -1;
    [mWindow addSubview:photoView];
    
    photoView.frame=CGRectMake(20, 90, 60, 60);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        photoView.frame = mWindow.bounds;
        
        
    } completion:^(BOOL finished) {
        
        
    }];


    
}


@end
