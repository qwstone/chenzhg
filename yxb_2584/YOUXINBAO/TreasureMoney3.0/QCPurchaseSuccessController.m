//
//  QCPurchaseSuccessController.m
//  YOUXINBAO
//
//  Created by Walice on 15/12/17.
//  Copyright © 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCPurchaseSuccessController.h"
#import "MyzhangbenViewController.h"

@interface QCPurchaseSuccessController ()

@end

@implementation QCPurchaseSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackView];
    self.title=@"支付成功";
    [self _initView];
}
- (void)_initView{
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth-140)/2, 80, 44, 44)];
    imgView.image=[UIImage imageNamed:@"right"];
    [self.view addSubview:imgView];
    
    UILabel *successlabel=[[UILabel alloc]initWithFrame:CGRectMake(imgView.right+10, 80, 100, 44)];
    successlabel.text=@"购买成功";
    [self.view addSubview:successlabel];
    
    UILabel *moneyLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, imgView.bottom+30, kDeviceWidth, 25)];
//    moneyLabel.text=[NSString stringWithFormat:@"购买金额%@元",self.money];
    moneyLabel.text=[NSString stringWithFormat:@"购买金额%@元",self.money];
    NSRange range=[moneyLabel.text rangeOfString:[NSString stringWithFormat:@"%@",self.money]];
    NSMutableAttributedString *aText=[[NSMutableAttributedString alloc]initWithString:moneyLabel.text];
    [aText addAttribute:NSForegroundColorAttributeName value:rgb(237, 46, 36, 1) range:range];
    moneyLabel.attributedText=aText;
    moneyLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:moneyLabel];
    
    UILabel *detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, moneyLabel.bottom+40, kDeviceWidth-60, 100)];
    detailLabel.text=@"您的理财资金已进入冻结状态,今日收益将于明日8:00前到账.您可以去宝赚钱-我的账本中查询您的理财收益";
    detailLabel.numberOfLines=0;
    [self.view addSubview:detailLabel];
    
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(30, kDeviceHeight-100-64, 122, 44) ;
    [button1 setBackgroundImage:[UIImage imageNamed:@"xq"] forState:UIControlStateNormal];
    button1.tag=1001;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake(kDeviceWidth-30-122, kDeviceHeight-100-64, 122, 44) ;
    button2.tag=1002;
    [button2 setBackgroundImage:[UIImage imageNamed:@"redbuy2"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    

}

- (void)buttonAction:(UIButton *)button{
    if (button.tag==1001) {
        MyzhangbenViewController *zhangben=[[MyzhangbenViewController alloc]init];
        [self.navigationController pushViewController:zhangben animated:YES];
    }
    else if (button.tag==1002){
    
        [self.navigationController popViewControllerAnimated:YES];
    
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
