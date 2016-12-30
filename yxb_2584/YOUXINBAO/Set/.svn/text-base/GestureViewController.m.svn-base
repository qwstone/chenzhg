//
//  GestureViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "GestureViewController.h"
#import "GestureLoginViewController.h"
#import "QCUserModel.h"
#import "YLInitSwipePasswordController.h"

@interface GestureViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * cellNamearray;
    UISwitch * openSwitch;
    QCUserModel * userModel;
}

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"设置手势密码"];
    // Do any additional setup after loading the view.
    cellNamearray = @[@"开启手势密码",@"修改手势密码"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellNamearray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"CELLID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.row == 0) {
        for (UIView * view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        if (openSwitch == nil) {
            openSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(kDeviceWidth-70, 10, 0, 0)];
//            BOOL isOpenGesture = [[[NSUserDefaults standardUserDefaults] objectForKey:__isGestureOpen] boolValue];
//            openSwitch.on = userModel.gestureOpen;
            [openSwitch addTarget:self action:@selector(openSwitch:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:openSwitch];
        }
        if (userModel.gestureOpen) {
            openSwitch.on = YES;
        }
        else
        {
            openSwitch.on = NO;
        }
        
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = cellNamearray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 1) {
        if (userModel.gestureOpen) {
            
            YLInitSwipePasswordController * passWordViewController = [[YLInitSwipePasswordController alloc]init];
            [self.navigationController pushViewController:passWordViewController animated:YES];
        }
        else
        {
            //请先开启手势密码。
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"请先开启手势密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
        }
    }
}

- (void)openSwitch:(UISwitch *)sender
{

//    NSString *savedPassword = [[NSUserDefaults standardUserDefaults] objectForKey:@"gesturePassword"];
//    if (savedPassword == nil) {
//        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您还没有设置手势密码,请先设置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
//        sender.on = !sender.on;
//    }else{
//        QCUserManager * um = [QCUserManager sharedInstance];
//        userModel.gestureOpen = sender.on;
//        [um setLoginUser:userModel];
//        
////        NSString *isGestureOpen = [NSString stringWithFormat:@"%d",sender.on];
////        [[NSUserDefaults standardUserDefaults] setObject:isGestureOpen forKey:__isGestureOpen];
////        [[NSUserDefaults standardUserDefaults] synchronize];
//
//    }
    
    
    
    //点击开关跳入验证密码界面
    GestureLoginViewController * gestureLogin = [[GestureLoginViewController alloc]init];
    gestureLogin.gestureSwith = sender.on;
    [self.navigationController pushViewController:gestureLogin animated:YES];
 }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_tableView) {
        userModel = [[QCUserManager sharedInstance]getLoginUser];
        [_tableView reloadData];
        
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
