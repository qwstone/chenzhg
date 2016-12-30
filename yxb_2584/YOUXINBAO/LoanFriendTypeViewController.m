//
//  LoanFriendTypeViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/11/11.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanFriendTypeViewController.h"
#import "YXBTool.h"
#import "LoanAddressBookViewController.h"
#import "FriendSelecteViewController.h"
#import "AddressDBManager.h"
#import "WXApi.h"
#import "UIAlertView+Block.h"
#define kFooterButtonTag 30100
CGFloat footerH = 107;

@interface LoanFriendTypeViewController ()
{
    UIButton *_selectedStyleButton; //底部选中按钮

}

@property(nonatomic,strong)LoanAddressBookViewController *loanController;
@property(nonatomic,strong)FriendSelecteViewController *friendController;
@end

@implementation LoanFriendTypeViewController


-(void)leftClicked
{
    [ProgressHUD dismiss];
    [[AddressDBManager shareInstance] cancel];

    [super leftClicked];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    [self setTitle:@"选择朋友"];
    [self initViews];
    [self addFirstView];
    // Do any additional setup after loading the view.
}

-(void)initViews
{
    

    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - footerH - 64, kDeviceWidth, footerH)];
    footer.layer.borderColor = [YXBTool colorWithHexString:@"#E0E0E0"].CGColor;
    footer.layer.borderWidth = 1.0;
    footer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footer];
    NSArray *images = @[@"xz-footnav1",@"xz-footnav2",@"xz-footnav3"];
    NSArray *selectedImages = @[@"xz-footnav11",@"xz-footnav22",@"xz-footnav33"];
    CGFloat footerButtonW = kDeviceWidth/images.count;
    //        CGFloat footerButtonH = getScreenFitSize(82);
    CGFloat footerButtonH = footerH;
    footerButtonW = self.view.width/2.0;
    
    
    for (int i = 0; i<images.count; i++) {
        UIButton *footerButton = [[UIButton alloc] initWithFrame:CGRectMake(footerButtonW*i, (footerH-footerButtonH)/2, footerButtonW, footerButtonH)];
        [footerButton setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [footerButton setImage:[UIImage imageNamed:selectedImages[i]] forState:UIControlStateSelected];
        if (i == 1) {
            footerButton.width = 0;
            footerButton.height = 0;
        }
        if (i == 2) {
            footerButton.left = footerButtonW;
        }
        footerButton.tag = kFooterButtonTag+i;
        [footerButton addTarget:self action:@selector(footerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [footer addSubview:footerButton];
        
        if (i != 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(footerButton.left, 0, 1, footerH)];
            line.backgroundColor = [YXBTool colorWithHexString:@"#E0E0E0"];
            [footer addSubview:line];
            
        }else {
            footerButton.backgroundColor = [YXBTool colorWithHexString:@"#EFEFEF"];
            footerButton.selected = YES;
            _selectedStyleButton = footerButton;
        }
    }

}

-(void)addFirstView
{
    if (self.friendController) {
        [_friendController.view removeFromSuperview];
    }
    
    self.friendController = [[FriendSelecteViewController alloc] init];
    _friendController.view.frame = ccr(0, 0, kDeviceWidth, kDeviceHeight-footerH);
    _friendController.friendType = _friendType;
    _friendController.payType = _payType;
//    _friendController.loanModel = self.loanModel;
    _friendController.yxbLoanModel = self.yxbLoanModel;
    _friendController.myTableView.frame = ccr(0,getScreenFitSize(75.0/2), kDeviceWidth, kDeviceHeight-64-footerH-getScreenFitSize(75.0/2));
    _friendController.noRecordView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64-footerH);
    _friendController.session0Hidden = YES;
    _friendController.delegate = self.delegate;
    [self.view addSubview:_friendController.view];
}
- (void)footerButtonAction:(UIButton *)button
{
    
    if (button.tag == kFooterButtonTag) {//友信宝好友
        self.loanController.view.hidden = YES;
        self.friendController.view.hidden = NO;
    }else if (button.tag == kFooterButtonTag+1) {//通讯录好友

        if (self.payType == AmorOrderPayTypeOtherPay ||
            self.payType == AmorOrderPayTypeOtherPayAll ||
            self.payType == AmorOrderPayTypeSelectPeople)
        {
            [ProgressHUD showErrorWithStatus:@"通讯录功能暂不支持！"];
            return;
            
        }
        
        //通讯录
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted || ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请开启访问通讯录功能,获取通讯录好友" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            return;
            
        }

        if(!self.loanController)
        {
            self.loanController = [[LoanAddressBookViewController alloc] init];
            _loanController.loanModel = self.loanModel;
            _loanController.bottomHeight = footerH;
            _loanController.view.frame = ccr(0, 0, kDeviceWidth, kDeviceHeight - 64 - footerH);
            
            [self.view addSubview:_loanController.view];

        }
        
        if (self.loanController) {
            self.loanController.view.hidden = NO;
            self.friendController.view.hidden = YES;
        }

        

    }else if (button.tag == kFooterButtonTag+2){
        //微信
        if (![WXApi isWXAppInstalled]) {
            [ProgressHUD showErrorWithStatus:@"请安装微信后重试！"];
            return;
        }
        
        NSString *title = @"您确定向微信好友借款?";
        
        if (self.payType == AmorOrderPayTypeOtherPayAll ||
            self.payType == AmorOrderPayTypeOtherPay)
        {
            [ProgressHUD showErrorWithStatus:@"暂不支持选择微信代付！"];
            return;
            //                title = @"选择微信好友担保?";
            
        }
        else if(self.payType == AmorOrderPayTypeSelectPeople)
        {
            title = @"选择微信好友担保?";
            
        }
            
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:title delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
//                self.loanModel.loanFriendType = YXBPayDesWeChat;
                self.yxbLoanModel.loanFriendType = YXBPayDesWeChat;
                if (self.jiekuanDelegate && [self.jiekuanDelegate respondsToSelector:@selector(httpJiekuanRequest:)]) {
                    
                    if (self.friendType == LoanNewFriendTypeJieRu)
                    {
                        //微信借入
                        [self.jiekuanDelegate httpJiekuanRequest:self.yxbLoanModel];
                        
                    }
                }

                /*
                if (self.delegate && [self.delegate respondsToSelector:@selector(createLoanDetailWithLoan:)]) {
                    
                    if (self.friendType == LoanNewFriendTypeJieRu)
                    {
                        //微信借入
                        [self.delegate createLoanDetailWithLoan:self.loanModel];
                        
                    }
                }
                */
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(callWeChatWithLoanId:)]) {
                    [super leftClicked];
                    
                    //微信担保
                    if (self.friendType == LoanNewFriendTypeDanBao) {
                        [self.delegate callWeChatWithLoanId:self.loanModel.t_id];

                    }
                    
                    
                
                }

                
            }
            
        }];
    }
    
    _selectedStyleButton.backgroundColor = [UIColor clearColor];
    _selectedStyleButton.selected = NO;
    button.backgroundColor = [YXBTool colorWithHexString:@"#EFEFEF"];
    button.selected = YES;
    _selectedStyleButton = button;

    
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
