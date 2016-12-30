//
//  QCFriendInviteViewController.m
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCFriendInviteViewController.h"
#import "TResultSet.h"
#import "TFriendRelationManager.h"
#import "HttpOperator.h"
#import "QCUserManager.h"
#import "QCUserModel.h"
#import "User.h"
#import <MessageUI/MFMessageComposeViewController.h>

@interface QCFriendInviteViewController ()<UIActionSheetDelegate,MFMessageComposeViewControllerDelegate> {
    UILabel *_nameLabel;    //名字
    UILabel *_telLabel1;    //电话
    UILabel *_telLabel2;    //电话
    UILabel *_tipLabel;     //未开通提示
}

@end

@implementation QCFriendInviteViewController

- (void)dealloc {
    Release(_addressBook);
    Release(_nameLabel);
    Release(_telLabel1);
    Release(_telLabel2);
    Release(_tipLabel);
    self.iHttpOperator = nil;

    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (id)initWithUserType:(BOOL)isAdd {
//    self = [super init];
//    
//    if (self) {
//        self.isAdd = isAdd;
//    }
//    
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title  = @"详细资料";
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftAction)];
    //self.view.backgroundColor = kCustomBackground;
      self.view.backgroundColor = rgb(238, 236, 246, 1.0);
    [self createUI];
}
//创建UI
- (void)createUI
{
    //背景
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 120)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderWidth = 1.0;
    bgView.layer.borderColor = [rgb(222, 222, 222, 1) CGColor];
    [self.view addSubview:bgView];
    [bgView release];
    //头像
    UIImageView * touxiangImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 50, 50)];
    touxiangImage.image = [UIImage imageNamed:@"hy-usermr-icon.png"];
    touxiangImage.layer.cornerRadius=10;
    [bgView addSubview:touxiangImage];
    [touxiangImage release];
    //名字
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(touxiangImage.right+5, 25, 200, 16)];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.textColor = rgb(41, 45, 61, 1);
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textAlignment = 0;
    [bgView addSubview:_nameLabel];
    
    //手机号
    _telLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(touxiangImage.right+5, _nameLabel.bottom+13, kDeviceWidth-touxiangImage.right, 14)];
    _telLabel1.backgroundColor = [UIColor clearColor];
    _telLabel1.textColor = rgb(131, 131, 131, 1);
    _telLabel1.font = [UIFont systemFontOfSize:14];
    _telLabel1.textAlignment = 0;

    [bgView addSubview:_telLabel1];
    
//    _telLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(113, 60, 150, 20)];
//    _telLabel2.backgroundColor = [UIColor clearColor];
//    _telLabel2.textColor = rgb(136, 136, 136, 1);
//    _telLabel2.font = [UIFont systemFontOfSize:15];
//    _telLabel2.textAlignment = 0;
//    [bgView addSubview:_telLabel2];
    
    //未开通提示
    _tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, bgView.bottom+13, kDeviceWidth, 20)];
    _tipLabel.backgroundColor = [UIColor clearColor];
    _tipLabel.textColor = rgb(149, 149, 149, 1);
    _tipLabel.font = [UIFont systemFontOfSize:14];
    _tipLabel.textAlignment = 1;
    [self.view addSubview:_tipLabel];
    
    if (self.addressBook.name) {
        _nameLabel.text = self.addressBook.name;
        _tipLabel.text = [NSString stringWithFormat:@"%@还未开通无忧借条",self.addressBook.name];

    }

    if (self.addressBook.tel) {
        _telLabel1.text = [NSString stringWithFormat:@"手机号 : %@",self.addressBook.tel];
        
    }

    
    [self createButtonWithframe:CGRectMake(10, _tipLabel.bottom+20, kDeviceWidth-20, 40) withImage:@"yqhy" withView:self.view withTarget:self withAcation:@selector(iniviteButtonAction) withTag:101];

}

- (void)setAddressBook:(QCAddressBook *)addressBook {
    if (_addressBook != addressBook) {
        [_addressBook release];
        _addressBook = [addressBook retain];
        
        
    }
}

- (void)iniviteButtonAction
{
        if (self.addressBook.tel2) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择号码"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定" destructiveButtonTitle:self.addressBook.tel otherButtonTitles:self.addressBook.tel2, nil];
        [sheet showInView:self.view];
        [sheet release];
        }else {
        [self inviteTFriendRelation:self.addressBook.tel];
 
}

    
}


- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
        if (buttonIndex == 0) {
            [self inviteTFriendRelation:self.addressBook.tel];
            
        }else if (buttonIndex == 1) {
            [self inviteTFriendRelation:self.addressBook.tel2];
        }
}

- (void)inviteTFriendRelation:(NSString *)mobileNo
{
    NSArray *arr = @[mobileNo];
    [self sendSMS:[NSString stringWithFormat:@"用诚信呵护友情,朋友之间借贷怎能不用无忧借条。无忧借条下载地址:%@if.jsp   记得安装后添加我为好友。",YXB_IP_address_share] recipientList:arr];

    
}

#pragma mark - Message Delegate
- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
    
    if([MFMessageComposeViewController canSendText])
        
    {
        
        controller.body = bodyOfMessage;
        
        controller.recipients = recipients;
        
        controller.messageComposeDelegate = self;
        
//        [self presentModalViewController:controller animated:YES];
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}

// 处理发送完的响应结果
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if (result == MessageComposeResultCancelled) {
        NSLog(@"Message cancelled");
    }else if (result == MessageComposeResultSent) {
        [self showLoadingWithTitle:@"短信发送成功" imageName:@"friends_send"];
        [self performSelector:@selector(hideLoading) withObject:nil afterDelay:2];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        NSLog(@"Message failed")  ;
    }
}




- (void)createSureButtonWithframe:(CGRect)btnframe title:(NSString *)title withView:(UIView *)cview withTarget:(id)t withAcation:(SEL)s withTag:(NSInteger)tag
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = btnframe;
    button.backgroundColor = rgb(206, 37, 48, 1.0);
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:t action:s forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    //    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    button.adjustsImageWhenHighlighted = NO;
    button.layer.cornerRadius = 3.0;
    [cview addSubview:button];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
