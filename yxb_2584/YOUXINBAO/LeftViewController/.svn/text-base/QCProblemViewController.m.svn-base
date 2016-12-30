//
//  QCProblemViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCProblemViewController.h"
#import "QCMineBorrowViewController.h"
#import "QCRechargeViewController.h"

@interface QCProblemViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;
    NSArray *_borrowOut;
    NSArray *_borrowIn;
}

@end

@implementation QCProblemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"常见问题"];
    
    _borrowIn = @[@"如何向好友借款",@"借款利息怎么算",@"怎么加快借款进度",@"如何还钱",@"逾期不还怎么办",@"关于无忧借条"];
    _borrowOut = @[@"如何借钱给好友",@"如何收款"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //将下边的单元格取消掉
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
//    self.dataArray1=@[@"如何向好友借款",@"借款利息怎么算",@"怎么加快借款进度",@"如何还钱",@"逾期不还怎么办",@"关于友信宝"];
}

- (void)leftClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  {
    return 30.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 30)];
    view.backgroundColor = rgb(241, 240, 248, 1);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 14)];
    label.textColor = rgb(185, 185, 185, 1);
    [view addSubview:label];
    
    if (section == 0) {
        label.text = @"关于借入";
    }else if(section==1){
        label.text = @"关于借出";
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    }else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellId = @"borrowCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = _borrowIn[indexPath.row];
    }else {
        cell.textLabel.text = _borrowOut[indexPath.row];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
