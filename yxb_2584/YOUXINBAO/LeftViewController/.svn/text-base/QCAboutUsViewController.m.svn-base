//
//  QCAboutUsViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/30.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#define kAboutUsButtonTag 2000

#import "QCAboutUsViewController.h"
#import "QCFeedbackViewController.h"
#import "QCProblemViewController.h"
#import "QCAboutYXBViewController.h"
#import "YXBTool.h"
#import "QCHomeDataManager.h"

@interface QCAboutUsViewController (){

     UITableView *_tableView;

}

@property(nonatomic,strong)NSArray *data;

@end

@implementation QCAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    self.title=@"关于无忧借条";
    //是否显示微信登录
    if ([QCHomeDataManager sharedInstance].showThirdLogin.boolValue) {
            //self.data = @[@"常见问题",@"意见反馈",@"关于友信宝"];
          self.data = @[@"常见问题",@"意见反馈"];
    }else {
           self.data = @[@"常见问题",@"意见反馈"];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kDeviceWidth, 150) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.data.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellId = @"YXBCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.textLabel.textColor=rgb(48, 48, 48, 1);
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth-40, 20, 20, 20)];
        imgView.contentMode = UIViewContentModeCenter;
        imgView.image=[UIImage imageNamed:@"next.png"];
        [cell.contentView addSubview:imgView];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
    }
    cell.textLabel.text = self.data[indexPath.row];

    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        //常见问题
//        QCProblemViewController *problemVC = [[QCProblemViewController alloc] init];
//        [self.navigationController pushViewController:problemVC animated:YES];
#define Newchangjianwenti @"webView/helpcenter/index.jsp?id="
//#define Oldchangjianwenti @"webView/explain/FAQ.jsp"
        NSString *url = [YXBTool getURL:Newchangjianwenti params:nil];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"常见问题"];
        
    }
    if (indexPath.row==1) {
        //意见反馈
        QCFeedbackViewController * feedBackViewController = [[QCFeedbackViewController alloc]init];
        [self.navigationController pushViewController:feedBackViewController animated:YES];
        
    }
    if (indexPath.row==2) {
        //关于友信宝
        QCAboutYXBViewController *yxbViewController=[[QCAboutYXBViewController alloc]init];
        [self.navigationController pushViewController:yxbViewController animated:YES];
        
        
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
