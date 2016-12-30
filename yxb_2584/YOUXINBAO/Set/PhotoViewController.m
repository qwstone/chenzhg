//
//  PhotoViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()
{
//    UIImageView 
}

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self setNavigationButtonItrmWithiamge:<#(NSString *)#> withRightOrleft:<#(NSString *)#> withtargrt:<#(id)#> withAction:<#(SEL)#>
}

- (void)initView{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 20)];
    label.text = @"请上传真实照片并保证照片清晰,如下所示";
    [self.view addSubview:label];
    
    
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
