//
//  QCHuankuanDetailViewController.m
//  YOUXINBAO
//
//  Created by Walice on 16/2/18.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCHuankuanDetailViewController.h"
#import "HuankuanDetailCell.h"

@interface QCHuankuanDetailViewController ()

@end

@implementation QCHuankuanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"还款详情";
    //self.selectedUserArray=[NSMutableArray new];
  
    _tableView=[[QCBaseTableView alloc]initWithFrame:CGRectMake(15, 13, kDeviceWidth-30, kDeviceHeight-64-15-40)style:UITableViewStylePlain refreshFooter:NO];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_tableView];
    [self createBottomView];

}

-(void)createBottomView{
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(10, _tableView.bottom, kDeviceWidth-20, 40);
        [sureButton setTitle:@"确 定(0)" forState:UIControlStateNormal];
    
        sureButton.titleLabel.font = [UIFont systemFontOfSize:22];
        sureButton.backgroundColor = rgb(40, 158, 255, 1);
        sureButton.layer.cornerRadius = 5;
        self.sureButton = sureButton;
        [self.view addSubview:self.sureButton];

}

//多选获取用户模型
-(void)selectedUserArrayAdd{

    index++;
    [self.sureButton setTitle:[NSString stringWithFormat:@"确定(%ld)",index] forState:UIControlStateNormal];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellId = @"BillDetailCell";
    HuankuanDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[HuankuanDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
       
    }

   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    

}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
}
- (void)buttonDidClick{

    

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
