//
//  StrengthsViewController.m
//  YOUXINBAO
//
//  Created by 密码是111 on 16/9/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "StrengthsViewController.h"
#import "HomeCtrMidView.h"
@implementation StrengthsViewController


-(void)dealloc{
    NSLog(@"LoanCenterViewController1 is dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb(238, 236, 246, 1.0);
    [self setTitle:@"五项安全保障"];
    [self addwebView];
    
}
-(void)addwebView{
    NSString*url;
     if(_flagNumber==1000){
        url=[NSString stringWithFormat:@"%@webView/single/advantage-list.jsp#e1",YXB_IP_address_web];
    }

    else if(_flagNumber==1001){
        url=[NSString stringWithFormat:@"%@webView/single/advantage-list.jsp#e2",YXB_IP_address_web];
    }
    else if(_flagNumber==1002){
        url=[NSString stringWithFormat:@"%@webView/single/advantage-list.jsp#e3",YXB_IP_address_web];
    }
    else if(_flagNumber==1003){
        url=[NSString stringWithFormat:@"%@webView/single/advantage-list.jsp#e4",YXB_IP_address_web];
    }
    else if(_flagNumber==1004){
        url=[NSString stringWithFormat:@"%@webView/single/advantage-list.jsp#e5",YXB_IP_address_web];
    }
    else{
         [self setTitle:@"借条优势"];
        url= [NSString stringWithFormat:@"%@webView/single/advantage.jsp",YXB_IP_address_web];
    }
     UIWebView*webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
}
@end
