//
//  ZhifuViewController.m
//  YOUXINBAO
//
//  Created by zjp on 16/3/10.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "ZhifuViewController.h"
#import "YXBLoanCenterViewController.h"
#import "MyLoanViewController.h"
#import "UIAlertView+Block.h"
#import "MyLoanViewController.h"

@implementation ZhifuViewController

- (id)initWithURL:(NSString *)url
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        
        self.urlStr = url;
        [self setLeftView];
    }
    return self;
}

- (void)leftClicked {
    //视频审核页面返回提示
    if (self.type==1||self.type==2||self.type==3) {
        NSArray *ctrlArray = self.navigationController.viewControllers;
        
        for (UIViewController *ctrl in ctrlArray) {
            if ([ctrl isKindOfClass:[YXBLoanCenterViewController class]]) {
                [self.navigationController popToViewController:ctrl animated:YES];
                return;
            }
        }
    }

    if (self.type == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (self.type == 2){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (self.type == 3){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if(self.type==4){
        
        [self shipinshenheLeft];
    }
    else if (self.type==5){

        NSArray *array=self.navigationController.viewControllers;
        for (UIViewController *viewCtrl in array) {
            if ([viewCtrl isKindOfClass:[MyLoanViewController class]]) {
                MyLoanViewController *ctrl=(MyLoanViewController *)viewCtrl;
                ctrl.isFromVideo=NO;
                [self.navigationController popToViewController:ctrl animated:YES];
                
            }
            
            
        }
    
    }
    else{
        [self.navigationController popToRootViewControllerAnimated:YES];
        
     }
    
}

- (void)shipinshenheLeft{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"放弃审核,已付借款将冻结,无法到达对方账户,确定放弃审核吗?" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }];
}

-(void)showAlert
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"您已充值成功，立即支付给好友，完成借款操作吧！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}

//刷新界面
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.webView reload];
}

@end
