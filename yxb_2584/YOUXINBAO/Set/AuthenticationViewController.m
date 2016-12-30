//
//  AuthenticationViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "QCUserModel.h"
#import "PhotoViewController.h"
#import "QCFiveViewController.h"
#import "LoginCell.h"
#import "UserAuthModel.h"
#import "RealnameAuthentication.h"
#import "HttpOperator.h"
#import "QCBaseTableView.h"
#import "RealnameAuthenticationManager.h"
#import "YXBTool.h"
#import "realModeViewController.h"
#import "UserManager.h"
#import "FMDeviceManager.h"

@interface AuthenticationViewController ()<UITableViewDataSource,UITableViewDelegate,QCBaseTableViewDelegate,UIScrollViewDelegate>
{
    NSArray * cellNameArray;
}
@property(nonatomic,strong)QCBaseTableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UserAuthModel  *authModel;
@property(nonatomic,strong)HttpOperator   *iHttpOperator;
@property(nonatomic,strong)RealnameAuthentication *myAuthModel;
@property(nonatomic,strong)HttpOperator *httpOperator;

@end

@implementation AuthenticationViewController

-(void)dealloc
{
    NSLog(@"AuthenticationViewController is dealloc");

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"身份认证"];
    [self registerForKeyboardNotifications];
    self.dataArray = [NSMutableArray array];
    [self initViews];
    
    
}

-(void)initViews
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 60)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = rgb(137, 137, 137, 1.0);
    label.font = [UIFont systemFontOfSize:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"认证身份信息，能享受更多的优惠和功能哦!";
    label.userInteractionEnabled = YES;
    [self.view addSubview:label];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [label addGestureRecognizer:tap];
    
    
    
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, label.origin.y + label.height, kDeviceWidth, kDeviceHeight-64-label.height) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    [self.view addSubview:_tableView];

}

-(void)endEdit
{
    [self.view endEditing:YES];
    [self.view endEditing:NO];
}

-(void)loadData
{
    if (_dataArray != nil && [_dataArray count] > 0) {
        [_dataArray removeAllObjects];
    }
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];

    self.authModel = [[UserAuthModel alloc] init];
    _authModel.username = userModel.user.username;
    _authModel.realname = _myAuthModel.realname;
    _authModel.idCardNo = _myAuthModel.idCardNo;
    NSArray *statusArray = [NSArray arrayWithObjects:@"",@"待审核",@"审核通过",@"审核失败", nil];
    IdentityCheckStatus checkStatus = userModel.user.accountStatus;
    
//#warning ==
//    checkStatus = IdentityCheckStatusRegisted;
    
    NSString *statusStr = @"";
    if (checkStatus >= IdentityCheckStatusRegisted && checkStatus <= IdentityCheckStatusFailed) {
        statusStr = statusArray[checkStatus];
    }
//    NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:@"photo.png",@"lock.png", nil];
//    NSMutableArray *title1Array = [NSMutableArray arrayWithObjects:
//                                   (userModel.user.username == nil)?@"":userModel.user.username,
//                                   (_myAuthModel.realname == nil)?@"":_myAuthModel.realname,
//                                   (_myAuthModel.idCardNo == nil)?@"":_myAuthModel.idCardNo,
//                                   statusStr
//                                   ,
//                                   (_myAuthModel.email == nil)?@"":_myAuthModel.email,
//                                   nil];
    /*
    NSMutableArray *title1Array = [NSMutableArray arrayWithObjects:
                                   (userModel.user.username == nil)?@"":userModel.user.username,
                                   @"",
                                   statusStr
                                   ,
                                   (_myAuthModel.email == nil)?@"":_myAuthModel.email,
                                   nil];
    */
    NSMutableArray *title1Array = [NSMutableArray arrayWithObjects:
                                   (userModel.user.username == nil)?@"":userModel.user.username,
                                   @"",
                                   nil];

//    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"手机号码:",@"真实姓名:",@"身份证号:",@"照      片:",@"电子邮箱:",nil];
//    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"手机号码:",@"实名认证",@"照      片:",@"电子邮箱:",nil];
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"手机号码:",@"实名认证",nil];

    
    for (int i = 0; i < [title1Array count]; i ++) {
        LoginModel *model = [[LoginModel alloc] init];
        model.titleName = titleArray[i];
        model.text = title1Array[i];
        [_dataArray addObject:model];
    }

}


-(void)requestData
{
    if (self.iHttpOperator == nil) {
//        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    self.httpOperator = [[HttpOperator alloc]init];
//    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _httpOperator;
    __weak AuthenticationViewController *this = self;
    [_httpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
        
    } error:^(int d, THttpOperatorErrorCode e) {
        
        [this httpLoadError:e];
        
    } param:^(NSString *s) {

        [this httpLOadParams:s httpOperation:assginHtttperator];
        
    } complete:^(RealnameAuthentication *r, int taskid) {
        [this httpLoadComplete:r];
    }];
    
    [_httpOperator connect];
    
    
}
//请求失败
-(void)httpLoadError:(THttpOperatorErrorCode)error{
    if (error == EHttp_Operator_Failed) {
        //服务器挂了
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        [self.tableView reloadDeals];
    }
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    RealnameAuthenticationManager *manager = (RealnameAuthenticationManager *)[httpOperation getAopInstance:[RealnameAuthenticationManager class] returnValue:[RealnameAuthentication class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    [manager getInfo:userModel.user.yxbToken];
}
//请求完成
-(void)httpLoadComplete:(RealnameAuthentication *)r{
    NSLog(@"r=  %@",r);
    
    [self.tableView reloadDeals];
    if (r.errCode == 0 || r.errCode == 7) {
        self.myAuthModel = r;
        [self loadData];
        [self.tableView reloadData];
        
    }
    else
    {
        NSLog(@"请求错误---");
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LoginCellContentHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellID";
    LoginCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == Nil) {
        
        cell = [[LoginCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID width:_tableView.width height:LoginCellContentHeight];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    __weak  AuthenticationViewController *this = self;
    
    [cell setMyTextfieldBeginBlock:^{
        
        
    } EndBlock:^(NSString *text) {

//        if (indexPath.row == 0) {
//            //            this.myAuthModel.username = text;
//        }
//        else if(indexPath.row == 1)
//        {
//            this.myAuthModel.realname = text;
//            
//        }else if(indexPath.row == 2)
//        {
//            this.myAuthModel.idCardNo = text;
//            
//        }else if(indexPath.row == 4)
//        {
//            this.myAuthModel.email = text;
//            
//        }
        if (indexPath.row == 0) {
            //            this.myAuthModel.username = text;
        }
        if (indexPath.row == 1) {

        }
        else if(indexPath.row == 3)
        {
            this.myAuthModel.email = text;
            
        }

        
    }];
    
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];

    //设置是否可编辑
    if (indexPath.row == 3) {
        [cell editEnable:YES];
    }
    else
    {
        [cell editEnable:NO];

    }
        

    if (indexPath.row < [_dataArray count]) {
        LoginModel* model = _dataArray[indexPath.row];
        
        cell.model = model;
        
    }
    
    //第二行显示箭头&&第一行显示箭头
    if (indexPath.row == 1) {
        if (userModel.user.accountStatus == IdentityCheckStatusRegisted) {
            [cell setRightNextImage:YES];
            cell.textfield.text = nil;
        }
        else
        {
            [cell setRightNextImage:NO];
            cell.textfield.text = @"已认证";
        }
    }else {
        [cell setRightNextImage:NO];
    }

    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self.view endEditing:YES];
    [self.view endEditing:NO];
    if (indexPath.row == 2) {
        if ((_myAuthModel.realname == nil) || [_myAuthModel.realname length] <= 0) {
            [YXBTool showAlertViewWithString:@"请先进行实名认证！"];
            return;
        }
        if ((_myAuthModel.idCardNo == nil) || [_myAuthModel.idCardNo length] <= 0) {
            [YXBTool showAlertViewWithString:@"请先进行实名认证！"];
            return;
        }
        
        //照片认证
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        if (userModel.user.accountStatus == IdentityCheckStatusPresented || userModel.user.accountStatus == IdentityCheckStatusFailed) {
            QCFiveViewController * photoViewController = [[QCFiveViewController alloc]init];
            photoViewController.model = _myAuthModel;
            [self.navigationController pushViewController:photoViewController animated:YES];
            

        }
        else if (userModel.user.accountStatus == IdentityCheckStatusChecking)
        {
            [YXBTool showAlertViewWithString:@"审核中"];
        }else if (userModel.user.accountStatus == IdentityCheckStatusPass)
        {
            [YXBTool showAlertViewWithString:@"已通过"];

        }

        
    }else if (indexPath.row == 1) {
        realModeViewController *mode = [[realModeViewController alloc] init];
        [self.navigationController pushViewController:mode animated:YES];
    }
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self.view endEditing:YES];
//    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//}

-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    [self httpLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self registerForKeyboardNotifications];
    
//    [self httpLogin];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [self.iHttpOperator cancel];
}
//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"hight_hitht:%f",kbSize.height);
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, kbSize.height, 0)];
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];

    //do something
}

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (void)httpLogin
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
//    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak AuthenticationViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_StatusCodeError) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        
        [this httpLOad_LoginParams:s httpOperation:assginHtttperator];
    } complete:^(User* r, int taskid) {
        
        [this httpLoad_LoginComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOad_LoginParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    UserManager* _currUser = (UserManager*)  [httpOperation getAopInstance:[UserManager class] returnValue:[User class]];
    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    //        NSString * pwd = [MyMD5 md5:[NSString stringWithFormat:@"%@%@",Md5String,[MyMD5 md5:userModel.user.pwd]]];
//    [_currUser userLogin:userModel.user.username pass:userModel.user.pwd];
    NSString *blackBox = [YXBTool getFMString];
    [_currUser userLoginWithFraudmetrix:userModel.user.username pwd:userModel.user.pwd fraudmetrixToken:blackBox];
}
-(void)httpLoad_LoginComplete:(User *)r{
    if (r.errCode == 0) {
        QCUserModel * currUser = [[QCUserModel alloc]init];
        currUser.isLogin = YES;
        currUser.user = r;
        TUnreadFlagCount * unReaderCount = [[TUnreadFlagCount alloc]init];
        currUser.unreadCont = unReaderCount;
        currUser.unreadCont.lastQueryDate = @"";
        currUser.firstMessageTime = @"";
        currUser.lastMessageTime = @"";
        QCUserManager * um  = [QCUserManager sharedInstance];
        QCUserModel * oldUser = [um getLoginUser];
        if (![oldUser.user.username isEqualToString:r.username]) {
            currUser.gestureOpen = NO;
            [YXBTool setGesturePassWord:nil];
            
        }
        else
        {
            currUser.gestureOpen = oldUser.gestureOpen;
            
        }
        
        [um setLoginUser:currUser];
        [self requestData];
        
    }else{
        NSString * string = r.errString;
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }

}

@end
