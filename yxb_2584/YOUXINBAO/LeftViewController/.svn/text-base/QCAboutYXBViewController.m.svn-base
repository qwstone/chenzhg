//
//  QCAboutYXBViewController.m
//  YOUXINBAO
//
//  Created by 冰冰 on 15/5/21.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCAboutYXBViewController.h"
#import "QCAboutYXBCell.h"

@interface QCAboutYXBViewController (){

    UITableView *_tableView;
}

@end

@implementation QCAboutYXBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    [self setTitle:@"关于无忧借条"];
    self.view.backgroundColor=rgb(241, 240, 248, 1);
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64)];
    _scrollView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight);
    [self.view addSubview:_scrollView];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20,100, kDeviceWidth-40, 420) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.userInteractionEnabled=NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
   
    [_scrollView addSubview:_tableView];
    
    _dataArray=[NSArray array];
    
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 100)];
    imgView.image=[UIImage imageNamed:@"yxb-logo.png"];
    imgView.contentMode = UIViewContentModeCenter;
    [_scrollView addSubview:imgView];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(100, 135, 1, _tableView.height-48-20+4)];
    view.backgroundColor=rgb(225, 225, 225, 1);
    [_scrollView addSubview:view];
    
    

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==4) {
        return 164;
    }
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString * cellId = @"YXBCell";
    QCAboutYXBCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[QCAboutYXBCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    cell.index=indexPath.row;
    self.dataArray=cell.array2;
    
    cell.leftLabel.text=[NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][0]];
    cell.rightLabel.text=[NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][1]];
    
        return cell;


}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
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
