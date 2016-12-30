//
//  CuiShouViewController.m
//  YOUXINBAO
//
//  Created by pro on 2016/12/7.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#define CUISHOU         @"专业催收"
#define LITIGATION      @"法院诉讼"

#import "CSSSViewController.h"
#import "CSSSCell.h"
#import "CSSSmodel.h"
#import "ServiceView.h"

#import "CuiShouCenterViewController.h"
#import "LitigationCenterViewController.h"
#import "CSrecordViewController.h"
@interface CSSSViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView   * SCCCtable;
@property (strong, nonatomic) NSArray       * functionArray;

@end

@implementation CSSSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"催收诉讼";
    
    [self createRightBar];
    [self initData];
    [self initTableView];
    

}

/**
 添加RightBar
 */
-(void)createRightBar{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 75, 40);
    [btn setTitle:@"查看记录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}


/**
 初始化数据   暂定催收和诉讼两个功能
 */
-(void)initData{
    CSSSmodel * model1 = [[CSSSmodel alloc] init];
    model1.functionIcon = @"cuishouIcon ";
    model1.functionName = CUISHOU;
    model1.functionDescribe = @"丢面子、撕破脸的事在这里交给我";
    
    CSSSmodel * model2 = [[CSSSmodel alloc] init];
    model2.functionIcon = @"litigationIcon";
    model2.functionName = LITIGATION;
    model2.functionDescribe = @"写诉状、举证出庭的事情轻松交给我";
    
    self.functionArray = [NSArray arrayWithObjects:model1, model2, nil];
}

/**
 初始化tableview
 */
-(void)initTableView{
    self.SCCCtable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 123*_functionArray.count)];
    _SCCCtable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _SCCCtable.delegate = self;
    _SCCCtable.dataSource = self;
    [self.view addSubview:_SCCCtable];
    
    //添加详细说明按钮
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:@"查看详细说明"];
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, str.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[YXBTool colorWithHexString:@"#2AC4FD"] range:NSMakeRange(0, str.length)];  //设置颜色
    UIButton * explainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    explainBtn.frame = CGRectMake(kDeviceWidth - 160, _SCCCtable.bottom + 10, 150, 25);
    [explainBtn setAttributedTitle:str forState:UIControlStateNormal];
    [explainBtn addTarget:self action:@selector(DetailedInstructions) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:explainBtn];
    
    //添加客服电话
    ServiceView * serviceView = [[ServiceView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - 29 - 21 - 64, kDeviceWidth, 21)];
    [self.view addSubview:serviceView];
}



#pragma mark  ====  UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 123;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _functionArray.count;
}


-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *IdentifierStr = @"functionCell";
    CSSSCell * cell = [tableView dequeueReusableCellWithIdentifier:IdentifierStr];
    
    if (cell == nil) {
        cell = [[CSSSCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = _functionArray[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSSSmodel * model = _functionArray[indexPath.row];
    if ([model.functionName isEqualToString:CUISHOU]) {
        //跳转到催收中心
        CuiShouCenterViewController * cuishouVC = [[CuiShouCenterViewController alloc] init];
        [self.navigationController pushViewController:cuishouVC animated:YES];
    }
    else if ([model.functionName isEqualToString:LITIGATION]){
        //跳转到诉讼中心
        LitigationCenterViewController * litigationVC = [[LitigationCenterViewController alloc] init];
        [self.navigationController pushViewController:litigationVC animated:YES];
    }
    
}


#pragma mark - Action

/**
 查看催收记录
 */
-(void)rightClick{
    CSrecordViewController * CSrecordVC = [[CSrecordViewController alloc] init];
    [self.navigationController pushViewController:CSrecordVC animated:YES];
}

/**
 查看详细说明
 */
-(void)DetailedInstructions{
    
        NSString *url = [NSString stringWithFormat:@"%@webView/helpcenter/loanDescription.jsp",YXB_IP_ADRESS];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:YES titleName:@"详细说明"];
    
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
