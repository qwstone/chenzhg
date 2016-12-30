//
//  CreditHallTuhaoListViewController.m
//  YOUXINBAO
//
//  Created by zjp on 15/6/15.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "CreditHallTuhaoListViewController.h"
#import "CreditHallTuhaoListCell.h"
#import "TCreditCenter.h"
#import "CreditPopUpView.h"
#import "UIAlertView+Block.h"
#import "UserManager.h"
#import "TFriendRelationManager.h"
#import "UIAlertView+Block.h"
#import "CreditCenterManager.h"
#import "QCLoginOneViewController.h"
@interface CreditHallTuhaoListViewController ()
{
    CreditPopUpView *popView;
    UILabel *label;
}
@end

@implementation CreditHallTuhaoListViewController

-(void)dealloc{
    NSLog(@"CreditHallTuhaoListViewController is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [_tableView reloadDeals];

}


- (void)leftAction {

    
}

- (void)createView{
//    //左侧
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 30, 30);
//    [btn setImage:[UIImage imageNamed:@"index-user-icon.png"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *createItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    self.navigationItem.rightBarButtonItem = createItem;

    
    self.view.backgroundColor = rgb(238, 236, 246, 1.0);
    if (self.type == QCBoardTypeHuoYue) {
        [self setTitle:@"活跃度"];
    }else if (self.type == QCBoardTypeRenYuan) {
        [self setTitle:@"人缘榜"];
    }else if (self.type == QCBoardTypeShiXin) {
        [self setTitle:@"失信榜"];
    }else if (self.type == QCBoardTypeHaoZhaoLi) {
        [self setTitle:@"号召力榜"];
    }else if (self.type == QCBoardTypeYiQi) {
        [self setTitle:@"义气榜"];
    }else if (self.type == QCBoardTypeTuHao) {
        [self setTitle:@"土豪榜"];
    }
    

    
    _tableView = [[QCBaseTableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain refreshFooter:NO];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 30)];
    label.center = _tableView.center;
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    [_tableView addSubview:label];
}


#pragma mark ---- tableviewDelegate

#pragma mark  --------------------------- refresh
- (void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView {
    [self requestData];
}

#pragma mark --- tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 65;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *topView = [[UIView alloc] init];
    
    UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 39, kDeviceWidth, 1)];
    viewbg.backgroundColor = [YXBTool colorWithHexString:@"#e0dede"];
    [topView addSubview:viewbg];
   
   UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, kDeviceWidth/640*150, 35)];
    title1.font = [UIFont systemFontOfSize:16];
    title1.text = @"排名";
//    title1.textAlignment = NSTextAlignmentCenter;
    title1.textColor = [UIColor lightGrayColor];
    [title1 setAdjustsFontSizeToFitWidth:YES];
    [topView addSubview:title1];
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/5+60, 5, kDeviceWidth/3, 35)];
    if (kDeviceWidth >= 375) {
        title2.left = kDeviceWidth/5+70;
    }
    title2.font = [UIFont systemFontOfSize:16];
    title2.text = @"用户等级";
//    title2.textAlignment = NSTextAlignmentCenter;
    title2.textColor = [UIColor lightGrayColor];
    [title2 setAdjustsFontSizeToFitWidth:YES];
    [topView addSubview:title2];
    
    UILabel *title3 = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth - 100, 5, 100, 35)];
    title3.font = [UIFont systemFontOfSize:16];
    title3.text = @"累计积分";
    title3.textAlignment = NSTextAlignmentCenter;
    title3.textColor = [UIColor lightGrayColor];
    [title3 setAdjustsFontSizeToFitWidth:YES];
    [topView addSubview:title3];
     topView.backgroundColor = [YXBTool colorWithHexString:@"#f7f3f3"];
    return topView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellID";
    CreditHallTuhaoListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == Nil) {
        cell = [[CreditHallTuhaoListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(10, 7.5, kDeviceWidth-20, 65)];
        cell.selectedBackgroundView.backgroundColor = rgb(255, 221, 201, 0.5);
        if (self.type == QCBoardTypeHuoYue) {
            cell.levelView.stateString = @"00100";
        }else if (self.type == QCBoardTypeRenYuan) {
            cell.levelView.stateString = @"00001";
        }else if (self.type == QCBoardTypeShiXin) {
//            cell.levelView.stateString = @"101";
        }else if (self.type == QCBoardTypeHaoZhaoLi) {
            cell.levelView.stateString = @"01000";
        }else if (self.type == QCBoardTypeYiQi) {
            cell.levelView.stateString = @"00010";
        }else if (self.type == QCBoardTypeTuHao) {
            cell.levelView.stateString = @"10000";
        }
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     CreditCenter *model = self.dataArray[indexPath.row];

    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
    popView = [[CreditPopUpView alloc] initWithFrame:CGRectZero];
    
    popView.model = model;

    __weak typeof(self) this = self;
    popView.iOnAddFriend = ^(NSInteger userId)
    {
        if (userModel.isLogin == NO) {

        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有登录，请登录" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [this toLogin];

            }
        }];
            
            
        }
        else
        {
            [this addFriendsViewWithUserId:userId];

        }
        
    };
    [popView show];


    
}


- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
}

#pragma mark --- request
- (void)requestData {
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = self.iHttpOperator;
    __weak CreditHallTuhaoListViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
        }
        [this.tableView reloadDeals];
        
    } param:^(NSString *s) {
        
        [this httpLOadParams:s httpOperation:assginHtttperator];
        
    } complete:^(NSSkyArray* r, int taskid) {
        
        [this httpLoadComplete:r];
        
    }];
    [self.iHttpOperator connect];
    
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation
{
    CreditCenterManager* _creditM = (CreditCenterManager*)  [httpOperation getAopInstance:[CreditCenterManager class] returnValue:[NSSkyArray class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    [_creditM getTCreditCenterRankListByCategory:userModel.user.yxbToken categoryIndex:self.type];
}
//请求完成
-(void)httpLoadComplete:(NSSkyArray *)r{
    if (r.errCode == 0) {
        if (r.iArray.count>0) {
            [self.dataArray removeAllObjects];
            self.dataArray = ((NSSkyArray*)r).iArray;
        }else{

        }
        
    }else{
        
        
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //            [alert show];
    }
    if (self.dataArray.count > 0) {
                    label.hidden = YES;
    }else {
        label.text = r.errString;
                label.hidden = NO;
    }
    [self.tableView reloadDeals];
    [self.tableView reloadData];
}
//添加好友网络请求
-(void)addFriendsViewWithUserId:(NSInteger)userId
{
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    if ([userModel.user.username integerValue] == userId)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您不能添加自己为好友" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"输入对方知道的验证信息,能更快成为好友哦" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认发送", nil];
        
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                NSString *message = [alertView textFieldAtIndex:0].text;
                [self requestFriendsWithUserId:userId message:message];

            }
        }];
        
    }
    
    //    [self reloadSearchTableview];
    
}

#pragma -mark 添加好友网络请求
-(void)requestFriendsWithUserId:(NSInteger)userId message:(NSString *)message
{
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = self.iHttpOperator;
    __weak CreditHallTuhaoListViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error)
     {
         
         if (error == EHttp_Operator_Failed) {
             //服务器挂了
         }
         
     } param:^(NSString *s) {
         
         [this httpLOad_RequestFriendsParams:s httpOperation:assginHtttperator UserId:userId message:message];
         
     } complete:^(TResultSet *r, int taskid){

         [this httpLoad_RequestFriendsComplete:r];
     }];
    
    [self.iHttpOperator connect];
    
    
}
//上传参数
- (void)httpLOad_RequestFriendsParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation UserId:(NSInteger)userId message:(NSString *)message
{
    TFriendRelationManager *userManager = (TFriendRelationManager *)[httpOperation getAopInstance:[TFriendRelationManager class] returnValue:[TResultSet class]];
    QCUserModel *um = [[QCUserManager sharedInstance] getLoginUser];
    [userManager addTFriendRelationByMobile:[NSString stringWithFormat:@"%ld",(long)um.user.username] withFriendName:[NSString stringWithFormat:@"%ld",(long)userId] withNote:message];
}
//请求完成
-(void)httpLoad_RequestFriendsComplete:(TResultSet *)r{
    [popView hidden];
    if(r.errCode == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            
        }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:r.errString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
