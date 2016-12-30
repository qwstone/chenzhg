//
//  QCFriendpromptController.m
//  YOUXINBAO
//
//  Created by Walice on 15/6/18.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCFriendpromptController.h"
#import "LoanOrRepayTableViewCell.h"
#import "QCCollectMoneyListController.h"
#import "QCSelectRefundViewController.h"
#import "QCAACollectMoneyController.h"


@interface QCFriendpromptController (){

    UITableView *_tableView;
    NSArray *array;
}

@end

@implementation QCFriendpromptController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"友情催款"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(kDeviceWidth-100,300, 80, 20);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"收款记录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)buttonAction{

    QCCollectMoneyListController *collectVC=[[QCCollectMoneyListController alloc]init];
    [self.navigationController pushViewController:collectVC animated:YES];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"CELLID";
    LoanOrRepayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LoanOrRepayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSString * imageName = [NSString stringWithFormat:@"nav%ld",(long)indexPath.row+1];
    
    cell.rowImage.image = [UIImage imageNamed:imageName];
    [cell.rowImage setFrame:CGRectMake(30, 15, cell.rowImage.image.size.width, cell.rowImage.image.size.height)];
    cell.titleLabel.text = array[indexPath.row];
    cell.titleLabel.font = [UIFont systemFontOfSize:21];
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    QCAACollectMoneyController *AACollectVC=[[QCAACollectMoneyController alloc]init];
//    [self.navigationController pushViewController:AACollectVC animated:YES];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {

    }else if (indexPath.row == 1){
        QCAACollectMoneyController *AACollectVC=[[QCAACollectMoneyController alloc]init];
        AACollectVC.isCreate=YES;
        [self.navigationController pushViewController:AACollectVC animated:YES];
    }
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
