//
//  SetNewViewController.m
//  YOUXINBAO
//
//  Created by Walice on 15/9/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "SetNewViewController.h"
#import "SDImageCache.h"
#import "QCAboutUsViewController.h"
#import "QCLoginOneViewController.h"
#import "DBManager.h"
#import "QCHomeDataManager.h"
@interface SetNewViewController ()

@end

@implementation SetNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"设置"];
    self.view.backgroundColor = rgb(237, 237, 246, 1);
    [self _createUI];
}

- (void)_createUI{

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kDeviceWidth, 100)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton * LogOutBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 60, kDeviceWidth-40, 40)];
    [LogOutBtn addTarget:self action:@selector(logOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [LogOutBtn setImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
    [footerView addSubview:LogOutBtn];
    _tableView.tableFooterView = footerView;
    
}

//viewForHeader与heightForHeader搭配使用可以调整section的高度
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 20)];
    view.backgroundColor =[UIColor clearColor];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellId = @"messageCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.font=[UIFont systemFontOfSize:15];

    if (indexPath.section==0&&indexPath.row==0) {
        cell.textLabel.text=@"清除缓存";

    }
    else if (indexPath.section==1&&indexPath.row==0){
        
        cell.textLabel.text=@"关于我们";
    }
   
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0&&indexPath.row==0) {
        //清楚缓存
        [[SDImageCache sharedImageCache] clearDisk];
        [ProgressHUD showSuccessWithStatus:@"清除成功"];
        
    }
    else if (indexPath.section==1&&indexPath.row==0){
        
        //关于我们
        QCAboutUsViewController *aboutUsVC = [[QCAboutUsViewController alloc] init];
        //        [rootNav pushViewController:aboutUsVC animated:YES];
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }

    
    
}


- (void)logOutAction:(UIButton *)sender
{
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"确定退出当前账户？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alterView.tag = 10010;
    [alterView show];
    
}

#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10010) {
        if (buttonIndex == 1) {
            [self loginout];
        }
    }
}

- (void)loginout {
    [QCHomeDataManager sharedInstance].zuorishouyi = nil;
    QCUserManager * um = [QCUserManager sharedInstance];
    QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
    model.isLogin = NO;
    model.gestureOpen = NO;
    //    [YXBTool setGesturePassWord:nil];
    model.user.yxbCookie = nil;
    model.user.yxbToken = nil;
    model.user.yestodayMoney = nil;
    [um setLoginUser:model];
    [DBManager clearDataBaseWhenExit];
    
    //关闭上一个人手势密码的判断
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"gesturePassword"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //断开融云连接   不接受推送消息
//    [[RCIM sharedRCIM] disconnect:NO];
    //[self.navigationController popViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
   [self.navigationController popToRootViewControllerAnimated:YES];
    
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
