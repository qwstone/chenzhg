//
//  LeftViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/4/16.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#define kButtonTag 10000

#import "LeftViewController.h"
#import "QCMoneyListViewController.h"
#import "WWSideslipViewController.h"
#import "QCAboutUsViewController.h"
#import "QCFriendsViewController.h"
#import "MessageCenterController.h"
#import "YXBTool.h"
#import "AppDelegate.h"
#import "LeftHeaderView.h"
#import "LeftCell.h"
#import "PayHomeViewController.h"
#import "UserManager.h"
#import "MsgCenterMgr.h"
#import "MsgCenterMgr+Public.h"
#import "SetViewController.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "MyOrderListController.h"
#import "MyCodeViewController.h"
#import "QRCodeGenerator.h"
#import "AFHTTPRequestOperationManager.h"
#define LeftViewControllerCouponUrl @"webView/user/couponList.jsp?t=1"
@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource,LeftHeaderViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate> {
//    UIImageView *_portrait; //头像
//    UILabel *_name;
//    UILabel *_design;   //称号
//    UILabel *_signature;    //个性签名
//    UILabel *_money;
//    UIImageView *_level;    //等级
    UITableView *_tableView;
//    LeftHeaderView *_headerView;
    
    NSArray *_imageArr;
    NSArray *_textArr;
    AFHTTPRequestOperationManager *_manager;
}

@property (nonatomic,strong) LeftHeaderView *headerView;

@end

@implementation LeftViewController
-(void)dealloc{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.leftBG
//    self.view.backgroundColor = [UIColor grayColor];
    self.view.backgroundColor = [YXBTool colorWithHexString:@"#32323A"];
//    self.view.layer.contents = (id)[UIImage imageNamed:@"leftBG"].CGImage;
    
    [self initViews];
    
    _imageArr = @[@"usertc-nav1",@"usertc-nav8",@"usertc-nav9",@"usertc-nav2",@"usertc-nav3",@"usertc-nav4"];
    _textArr = @[@"资金明细",@"我的借条",@"我的订单",@"好友管理",@"我的优惠券",@"任务中心"];
}

- (void)initViews {
//    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
//    _portrait = [[UIImageView alloc] initWithFrame:CGRectMake(15, 40, 50, 50)];
//    _portrait.backgroundColor = [UIColor whiteColor];
//    [_portrait setImageWithURL:[NSURL URLWithString:userModel.user.iconAddr] placeholderImage:[UIImage imageNamed:@"register_photo.png"]];
//    [self.view addSubview:_portrait];
//    
//    _portrait.layer.cornerRadius = 50.0/2;
//    _portrait.layer.masksToBounds = YES;
//    
//    _name = [[UILabel alloc] initWithFrame:CGRectMake(75, 50, 140, 20)];
//    _name.backgroundColor = [UIColor clearColor];
//    _name.text = userModel.user.nickname;;
//    _name.textColor = [UIColor whiteColor];
//    _name.font = [UIFont systemFontOfSize:14];
//    [self.view addSubview:_name];
//    
//    _design = [[UILabel alloc] initWithFrame:CGRectMake(75, 70, 50, 20)];
//    _design.backgroundColor = [UIColor clearColor];
//    _design.text = @"信用达人";
//    _design.textColor = [UIColor whiteColor];
//    _design.font = [UIFont systemFontOfSize:13];
//    [self.view addSubview:_design];
//    
//    _level = [[UIImageView alloc] initWithFrame:CGRectMake(_design.right, 70, 25, 25)];
//    _level.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:_level];
//    
//    _signature = [[UILabel alloc] initWithFrame:CGRectMake(15, 110, 140, 20)];
//    _signature.backgroundColor = [UIColor clearColor];
//    _signature.text = userModel.user.signature;;
//    _signature.textColor = [UIColor whiteColor];
//    _signature.font = [UIFont systemFontOfSize:13];
//    [self.view addSubview:_signature];
//    
//    _money = [[UILabel alloc] initWithFrame:CGRectMake(15, 145, 140, 20)];
//    _money.backgroundColor = [UIColor clearColor];
//    _money.text = [NSString stringWithFormat:@"余额:￥ %@",userModel.user.remainMoney];
//    _money.minimumScaleFactor = 8.0;
//    _money.adjustsFontSizeToFitWidth = YES;
//    _money.textColor = [UIColor whiteColor];
//    _money.font = [UIFont systemFontOfSize:13];
//    [self.view addSubview:_money];
//    
//    UIButton *set = [UIButton buttonWithType:UIButtonTypeContactAdd
//                     ];
//    set.frame = CGRectMake(_level.right, _level.top-15, 25, 25);
//    [set addTarget:self action:@selector(setButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:set];
//    
//    UIButton *prepaid = [[UIButton alloc] initWithFrame:CGRectMake(30, 175, 50, 30)];
//    [prepaid setTitle:@"充值" forState:UIControlStateNormal];
//    [prepaid setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [prepaid addTarget:self action:@selector(prepaidAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:prepaid];
//    
//    UIButton *drawMoney = [[UIButton alloc] initWithFrame:CGRectMake(110, 175, 50, 30)];
//    [drawMoney setTitle:@"提现" forState:UIControlStateNormal];
//    [drawMoney setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [drawMoney addTarget:self action:@selector(drawMoneyAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:drawMoney];
//    
//    NSArray *labelNames = @[@"资金明细",@"好友管理",@"我的理财",@"任务中心",@"消息中心",@"关于我们"];
//    for (int column = 0; column < 2; column++) {
//        for (int row = 0; row < 3; row++) {
//            UIButton *multiButton = [[UIButton alloc] initWithFrame:CGRectMake(30+80*column, 235+95*row, 50, 50)];
//            multiButton.backgroundColor = [UIColor yellowColor];
//            [multiButton addTarget:self action:@selector(multiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//            multiButton.tag = kButtonTag+column+row*2;
//            [self.view addSubview:multiButton];
//            
//            UILabel *multiLabel = [[UILabel alloc] initWithFrame:CGRectMake(multiButton.left, multiButton.bottom+5, 100, 20)];
//            multiLabel.font = [UIFont systemFontOfSize:13];
//            multiLabel.textColor = [UIColor whiteColor];
//            multiLabel.text = labelNames[row*2+column];
//            [self.view addSubview:multiLabel];
//            
//        }
//    }
//    UITapGestureRecognizer *topTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topTapAction:)];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, getScreenFitSize(64))];
    topView.backgroundColor = [YXBTool colorWithHexString:@"28282E"];
    [self.view addSubview:topView];
    
//    [topView addGestureRecognizer:topTap];
    
//    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topTapAction:)];
    
    _headerView = [[LeftHeaderView alloc] initWithFrame:CGRectMake(0, getScreenFitSize(50), kLeftHeaderWidth, kLeftHeaderHeight)];
    _headerView.delegate = self;
    [self.view addSubview:_headerView];
    
//    [_headerView addGestureRecognizer:headTap];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _headerView.bottom, kLeftHeaderWidth, kDeviceHeight-_headerView.bottom) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.separatorColor = [YXBTool colorWithHexString:@"#777777"];
//        _tableView.separatorInset = UIEdgeInsetsMake(0,0,0,0);
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLeftHeaderWidth, getScreenFitSize(45))];
    _tableView.tableFooterView = footView;
    
    UILabel *tel = [[UILabel alloc] initWithFrame:CGRectMake(0, getScreenFitSize(20), kLeftHeaderWidth, getScreenFitSize(20))];
    tel.font = [UIFont systemFontOfSize:getScreenFitSize(12)];
    tel.textColor = [YXBTool colorWithHexString:@"#6B6B6B"];
    tel.textAlignment = NSTextAlignmentCenter;
    tel.backgroundColor = [UIColor clearColor];
    tel.text = @"客服电话：400-6688-658";
    [footView addSubview:tel];
}

//- (void)topTapAction:(UITapGestureRecognizer *)tap {
//    SetViewController *set = [[SetViewController alloc] init];
//    [self pushToViewController:set];
//    [self returnMainView];
//}

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [_tableView setSeparatorInset:UIEdgeInsetsMake(24,0,20,0)];
//    }
//    
//    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [_tableView setLayoutMargins:UIEdgeInsetsMake(24,0,20,0)];
//    }
//}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsMake(24,0,20,0)];
//    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsMake(24,0,20,0)];
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kLeftCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _imageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LeftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    [cell setLeftImage:[UIImage imageNamed:[_imageArr objectAtIndex:indexPath.row]]];
    [cell setLeftText:[_textArr objectAtIndex:indexPath.row]];
    if (indexPath.row == 3) {
        if ([[MsgCenterMgr sharedInstance] hasNewFriend]) {
            cell.hasNewIcon = YES;
        }else {
            cell.hasNewIcon = NO;
        }
    }
//    //消息中心
//    else if (indexPath.row == 6) {
//        if ([[MsgCenterMgr sharedInstance] hasNewMessage]) {
//            cell.hasNewIcon = YES;
//        }else {
//            cell.hasNewIcon = NO;
//        }
//    }
    else {
        cell.hasNewIcon = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    WWSideslipViewController *slipVC;
//    UINavigationController *rootNav;
//    if ([[[[UIApplication sharedApplication].delegate window] rootViewController] isKindOfClass:[WWSideslipViewController class]]) {
//        slipVC = (WWSideslipViewController *)[[[UIApplication sharedApplication].delegate window] rootViewController];
//        rootNav = (UINavigationController *)[slipVC mainViewController];
//        
//    }else {
//        return;
//    }
    
    if (indexPath.row == 0) {
        //资金明细
        QCMoneyListViewController *moneyVC = [[QCMoneyListViewController alloc] init];
//        [rootNav pushViewController:moneyVC animated:YES];
        [self pushToViewController:moneyVC];
        
    }else if (indexPath.row == 3) {
        //好友管理
        QCFriendsViewController *friendVC = [[QCFriendsViewController alloc]init];
//        [rootNav pushViewController:friendVC animated:YES];
        [self pushToViewController:friendVC];
    }else if (indexPath.row == 4) {
        NSString *url = [YXBTool getURL:LeftViewControllerCouponUrl params:nil];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"我的优惠券"];
        //我的优惠券
    }else if (indexPath.row == 5) {
        //任务中心
        NSString *url = [YXBTool getURL:@"webView/user/invite/task.jsp" params:nil];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"任务中心"];
//        [YXBTool jumpSafariWithUrl:<#(NSString *)#>];
        
    }
//    else if (indexPath.row == 6) {
//        if ([[MsgCenterMgr sharedInstance] hasNewMessage]) {
//            [[MsgCenterMgr sharedInstance] removeMessgae];
//        }
//        //消息中心
//        MessageCenterController *messageVC=[[MessageCenterController alloc]init];
////        [rootNav pushViewController:messageVC animated:YES];
//        [self pushToViewController:messageVC];
//    }
    else if (indexPath.row == 2) {
//        //清楚缓存
//        [[SDImageCache sharedImageCache] clearDisk];
//        [ProgressHUD showSuccessWithStatus:@"清除成功"];
        //我的订单
        MyOrderListController *orderListController=[[MyOrderListController alloc]init];
        [self pushToViewController:orderListController];
        
    }else if (indexPath.row == 1) {
//        //关于我们
//        QCAboutUsViewController *aboutUsVC = [[QCAboutUsViewController alloc] init];
//        //        [rootNav pushViewController:aboutUsVC animated:YES];
//        [self pushToViewController:aboutUsVC];
//        借条中心
        LoanCenterViewController *loanCenter= [[LoanCenterViewController alloc] init];
        [self pushToViewController:loanCenter];
    }
//    [slipVC showMainView];
    [self returnMainView];
    
    [self performSelector:@selector(unselectCell) withObject:nil afterDelay:0.5];

}

- (void)pushToViewController:(UIViewController *)viewControll {
    WWSideslipViewController *slipVC;
    UINavigationController *rootNav;
    if ([[[[UIApplication sharedApplication].delegate window] rootViewController] isKindOfClass:[WWSideslipViewController class]]) {
        slipVC = (WWSideslipViewController *)[[[UIApplication sharedApplication].delegate window] rootViewController];
        rootNav = (UINavigationController *)[slipVC mainViewController];
        
    }else {
        return;
    }
    
    [rootNav pushViewController:viewControll animated:YES];
}

-(void)unselectCell{
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}


//
//- (void)setButtonAction:(UIButton *)button {
//    
//}

#pragma mark - HeaderView delegate
- (void)LeftHeaderView:(UIView *)leftView ButtonClickedAtIndex:(NSInteger)index {
    if (index == 0) {
        //充值
        [self returnMainView];
//        [YXBTool jumpSafariWithUrl:[YXBTool getURL:payUrl params:nil]];
        PayHomeViewController *pay = [[PayHomeViewController alloc] init];
        [self pushToViewController:pay];
    }else if (index == 1) {
        //提现
        [self returnMainView];
//        NSString *payUrl=[NSString stringWithFormat:@"%@charge/withdraw.jsp?a=23",YXB_IP_ADRESS];
        NSString *payUrl=[NSString stringWithFormat:@"%@webView/user/withdraw.jsp?a=23",YXB_IP_ADRESS];

        [YXBTool jumpSafariWithUrl:[YXBTool getURL:payUrl params:nil]];
    }
}

- (void)LeftHeaderView:(UIView *)leftView portraitTapAction:(UITapGestureRecognizer *)tap {
    [self updataImage];
}

- (void)LeftHeaderView:(UIView *)leftView qrCodeAction:(UIButton *)button {
    //    http://60.195.254.33:8083/webView/qrCode/qrCodeJump.jsp
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *url = [NSString stringWithFormat:@"%@webView/qrCode/qrCodeJump.jsp?id=%@%04ld",YXB_IP_ADRESS,userModel.user.yxbId,(long)rand()%10000];
    UIImage *image = [QRCodeGenerator qrImageForString:url imageSize:kDeviceWidth];
    
    MyCodeViewController *code = [[MyCodeViewController alloc] init];
    code.image = image;
    [self returnMainView];
    [self pushToViewController:code];
}

//- (void)prepaidAction:(UIButton *)button {
//    
//    
//    [self returnMainView];
//    NSString *payUrl = @"http://60.195.254.33:8083/charge/recharge.jsp?a=23";
//    [YXBTool jumpSafariWithUrl:[YXBTool getURL:payUrl params:nil]];
////    [YXBTool jumpInnerSafaryWithUrl:[YXBTool getURL:payUrl params:nil] hasTopBar:NO];
//}
//
//- (void)drawMoneyAction:(UIButton *)button {
//    [self returnMainView];
//    NSString *payUrl = @"http://60.195.254.33:8083/charge/withdraw.jsp?a=23";
//    [YXBTool jumpSafariWithUrl:[YXBTool getURL:payUrl params:nil]];
//
//}


//刷新数据
-(void)refreshData
{
    [_headerView refreshData];
    [_tableView reloadData];
//    QCUserModel *userModel = [[QCUserManager sharedInstance] getLoginUser];
//
//    [_portrait setImageWithURL:[NSURL URLWithString:userModel.user.iconAddr] placeholderImage:[UIImage imageNamed:@"register_photo.png"]];
//    _name.text = userModel.user.nickname;
//    _design.text = @"信用达人";
//    _signature.text = [NSString stringWithFormat:@"“%@”",userModel.user.signature];
//    _money.text = [NSString stringWithFormat:@"余额:￥ %@",userModel.user.remainMoney];




}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  @author chenglibin
 *
 *  由左侧返回首页
 */
-(void)returnMainView
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [[appDelegate getMySlidesipViewController] showMainView];

}

#pragma mark - updateImage
- (void)updataImage
{
    UIActionSheet *sheet;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
    
}

#pragma mark ----------------------------------------------------- ActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSLog(@"%d",buttonIndex);
    
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                    
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 0) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            } else {
                return;
                
            }
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        //        [imagePickerController release];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //    [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
    //    [self.delegate changUserPhoto:image];
    [self upImageData:image type:1];
    //    TUserManager * curruserManger = [TUserManager sharedInstance];
    //    NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(image)];
    //    TUser * ccurrUser = [curruserManger getLoginUser];
    //    ccurrUser.userImage = [NSData dataWithData:UIImagePNGRepresentation(image)];
    
    //    [curruserManger setLoginUser:ccurrUser];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void)upImageData:(UIImage *)image type:(NSInteger)type
{
    //    indicatorbgView.hidden = NO;
    //    [indicatorView startAnimating];
    QCUserModel *_currUser = [[QCUserManager sharedInstance] getLoginUser];
    NSString *userName = _currUser.user.username;
    NSData *imgData = UIImageJPEGRepresentation(image, 0.75);
    NSString * Urlstring = [NSString stringWithFormat:@"%@uploadBatchPhoto.jsp?username=%@&type=%ld&contentlength=%lu",YXB_IP_ADRESS,userName,(long)type,(unsigned long)imgData.length];
    NSLog(@"上传头像地址：p url---%@",Urlstring);
    
    
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [_manager POST:Urlstring parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>   formData) {
        //上传
//        [formData appendPartWithFormData:imgData name:@"image"];
        [formData appendPartWithFileData:imgData name:@"image" fileName:@"image.jpg" mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *  operation, id  responseObject) {
        //上传成功
        //        [indicatorView stopAnimating];
        //        indicatorbgView.hidden = YES;


        NSMutableString *responseString = [NSMutableString stringWithFormat:@"%@",responseObject];
        NSString *search = @"\n";
        NSString *replace = @"";

        NSRange substr = [responseString rangeOfString:search];

        while (substr.location != NSNotFound) {
            [responseString replaceCharactersInRange:substr withString:replace];
            substr = [responseString rangeOfString:search];
        }

        NSLog(@"照片地址:%@",responseString);
        [self uploadUserPhoto:responseString withImage:image];
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }];

    
    
    
//    NSURL *url = [NSURL URLWithString:[Urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    __weak LeftViewController *this = self;
//    [request setAuthImageData:imgData forKey:@"image"];
//    //    [request setContentLength:imgData.length];
//    //    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [imgData length]]];
//    NSLog(@"imdddd =%lu",(unsigned long)imgData.length);
//    [request setFailedBlock:^{
//        //        [indicatorView stopAnimating];
//        //        indicatorbgView.hidden = YES;
//        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
//        //        [alertView release];
//    }];
//    [request setCompletionBlock:^{
//        //        [indicatorView stopAnimating];
//        //        indicatorbgView.hidden = YES;
//        
//        
//        NSMutableString *responseString = [NSMutableString stringWithFormat:@"%@",request.responseString];
//        NSString *search = @"\n";
//        NSString *replace = @"";
//        
//        NSRange substr = [responseString rangeOfString:search];
//        
//        while (substr.location != NSNotFound) {
//            [responseString replaceCharactersInRange:substr withString:replace];
//            substr = [responseString rangeOfString:search];
//        }
//        
//        NSLog(@"照片地址:%@",responseString);
//        [this uploadUserPhoto:responseString withImage:image];
//    }];
//    [request startAsynchronous];
    
    
}

//保存图片
- (void)uploadUserPhoto:(NSString *)imageUrl withImage:(UIImage *)image
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak LeftViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
    } param:^(NSString *s) {
        [this httpLOadParams:s httpOperation:assginHtttperator withImageUrl:imageUrl];
    } complete:^(TResultSet* r, int taskid) {
        [this httpLoadComplete:r withImage:image];
        //        [alertView release];
        
    }];
    [self.iHttpOperator connect];
    
}
//上传参数
- (void)httpLOadParams:(NSString *)s httpOperation:(HttpOperator *)httpOperation withImageUrl:(NSString *)imageUrl
{
    QCUserModel * user = [[QCUserManager sharedInstance]getLoginUser];
    UserManager* _currUser = (UserManager*)  [httpOperation getAopInstance:[UserManager class] returnValue:[TResultSet class]];
    [_currUser uploadIconByUsername:user.user.username iconAddr:imageUrl];
    //        [_currUser release];

}
//请求完成
-(void)httpLoadComplete:(TResultSet *)r withImage:(UIImage *)image{
    if (r.errCode == 0) {
        [self.headerView updatePortraitWithImage:image];
        QCUserManager * um = [QCUserManager sharedInstance];
        QCUserModel * userModel = [um getLoginUser];
        userModel.user.iconAddr = r.resString;
        [um setLoginUser: userModel];
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        RootViewController *rootVC = [appDelegate getRootViewController];
        [rootVC.navUserImg sd_setImageWithURL:[NSURL URLWithString:userModel.user.iconAddr] placeholderImage:[UIImage imageNamed:@"useimg"]];
    }
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}
-(void)viewWillAppear:(BOOL)animated
{
//    [self refreshData];
    [super viewWillAppear:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:YES];
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
