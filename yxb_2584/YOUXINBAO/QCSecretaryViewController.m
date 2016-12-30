//
//  QCSecretaryViewController.m
//  YOUXINBAO
//
//  Created by Walice on 15/7/7.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCSecretaryViewController.h"
#import "QCSecretaryListViewController.h"
#import "YXBTool.h"

@interface QCSecretaryViewController ()

@end

@implementation QCSecretaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=rgb(238, 236, 246, 1.0);
    [self setBackView];
    self.title=@"催款小秘书";
    [self _initView];
}

- (void)_initView{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth,150 )];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(18, 9, kDeviceWidth-36, 150)];
    label.font=[UIFont systemFontOfSize:16];
    label.backgroundColor=[UIColor clearColor];
    label.textColor=rgb(48, 48, 48, 1);
    NSString *string=@"不好意思向欠钱的人开口要钱?                                 不知道如何向欠钱的人开口要钱?                              催款小秘书来帮您!";
    label.numberOfLines=3;
    [view addSubview:label];
    NSMutableAttributedString *attribute=[[NSMutableAttributedString alloc]initWithString:string];
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:16];
    [attribute addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [string length])];
    [label setAttributedText:attribute];
    
    
    
    UILabel *selecLabel=[[UILabel alloc]initWithFrame:CGRectMake(18, label.bottom+35, 200, 30)];
    selecLabel.text=@"选择催款方式";
    [self.view addSubview:selecLabel];
    
    
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame=CGRectMake(18, selecLabel.bottom+18, kDeviceWidth-36, 45);
    UIImage *image=[UIImage imageNamed:@"wxck-ftpbut.png"];
    
    [button1 setImage: image forState:UIControlStateNormal];
    button1.imageView.contentMode=UIViewContentModeCenter;
    button1.tag=1001;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    
    
    
//    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
//    button2.frame=CGRectMake(18, button1.bottom+18, kDeviceWidth-36, 45);
//    [button2 setImage:[UIImage imageNamed:@"wxck-fwzbut.png"] forState:UIControlStateNormal];
//    button2.imageView.contentMode=UIViewContentModeCenter;
//    button2.tag=1002;
//    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button2];
    
    


}

- (void)buttonAction:(UIButton *)button{
    if (button.tag==1001) {
        NSString *url = [YXBTool getURL:@"webView/reminder/index.jsp?t=1" params:nil];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"微信催款"];
    }
    else if (button.tag==1002){

    QCSecretaryListViewController *list=[[QCSecretaryListViewController alloc]init];
    [self.navigationController pushViewController:list animated:YES];
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
