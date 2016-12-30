//
//  SetViewController.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/17.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//
//#import "RCIM.h"
#import "SetViewController.h"
#import "SetTableViewCell.h"
#import "ModificationViewController.h"
#import "GestureViewController.h"
#import "AuthenticationViewController.h"
#import "UserManager.h"
#import "UIImageView+WebCache.h"
#import "PasswordViewController.h"
#import "AAImageShowView.h"
#import "QCLoginOneViewController.h"
#import "StudentCertifyController.h"
#import "YXBTool.h"
#import "WhiteCollarViewController.h"
#import "SDImageCache.h"
#import "QCAboutUsViewController.h"
#import "StudentVerifyViewController.h"
#import "AmorOrderDetailViewController.h"
#import "SafeCenterController.h"
#import "SetNewViewController.h"
#import "AFHTTPRequestOperationManager.h"
#define SetViewControllerMyFaithUrl @"webView/user/creditLevel.jsp?t=1"
//#import "QCFeedbackViewController.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource,ModificationViewControllerDelegate,UIActionSheetDelegate>
{
    UITableView * _tableView;
    NSArray * rowNameArray;
    SetTableViewCell * indexcell;
    QCUserModel * _userModel;
     UIImageView *fullImageView;
    CGRect frame_first;
    AFHTTPRequestOperationManager *_manager;
}
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"设置"];
    rowNameArray = @[@"头像",@"昵称",@"签名",@"我的无忧借条代号",@"我的信用等级",@"身份验证",@"在校学生认证",@"白领认证",@"修改手势密码",@"修改登录密码",@"关于我们",@"清理缓存"];
    // Do any additional setup after loading the view.
    _userModel = [[QCUserManager sharedInstance]getLoginUser];
    [self initView];
}

- (void)initView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    
    
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 60)];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton * LogOutBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth-80, 40)];
    LogOutBtn.center = footerView.center;
    [LogOutBtn addTarget:self action:@selector(logOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [LogOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [LogOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    LogOutBtn.layer.borderWidth = 0.5;
    LogOutBtn.layer.borderColor = [UIColor grayColor].CGColor;
    LogOutBtn.layer.masksToBounds = YES;
    LogOutBtn.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:LogOutBtn];
    _tableView.tableFooterView = footerView;
    
    
    [self.view addSubview:_tableView];
}
#pragma mark - UIAlterView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10010) {
        if (buttonIndex == 1) {
            [self loginout];
        }
    }
}

- (void)loginout {

    QCUserManager * um = [QCUserManager sharedInstance];
    QCUserModel *model = [[QCUserManager sharedInstance] getLoginUser];
    model.isLogin = NO;
    model.gestureOpen = NO;
//    [YXBTool setGesturePassWord:nil];
    model.user.yxbCookie = nil;
    model.user.yxbToken = nil;
    [um setLoginUser:model];
    
    //关闭上一个人手势密码的判断
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"gesturePassword"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //断开融云连接   不接受推送消息
    //        [[RCIM sharedRCIM] disconnect:NO];
    //            [self toLogin];
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)toLogin {
    QCLoginOneViewController * loginView = [[QCLoginOneViewController alloc]init];
    UINavigationController * loginNav = [[UINavigationController alloc]initWithRootViewController:loginView];
    [self.navigationController presentViewController:loginNav animated:YES completion:nil ];
}


- (void)logOutAction:(UIButton *)sender
{
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"确定退出当前账户？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alterView.tag = 10010;
    [alterView show];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }else{
        return 50;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return 5;
            break;
        case 1:
            return 5;
            break;
        case 2:
            return 2;
            break;
//去掉黑名单
//        case 2:
//            return 1;
//            break;

        default:
            return 0;
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        static NSString * cellID = IMAGECELLID;
        
        SetTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == Nil) {
            cell = [[SetTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
//        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        [cell.userimageView sd_setImageWithURL:[NSURL URLWithString:_userModel.user.iconAddr]placeholderImage: [UIImage imageNamed:@"useimg"]];
        cell.rownameLabel.text= rowNameArray[indexPath.row];
        cell.userimageView.tag=9999;
        cell.userimageView.userInteractionEnabled=YES;
        [cell.userimageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)]];
        return cell;

    }else{
        static NSString * cellID = OTHERCELLID;
        
        SetTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == Nil) {
            cell = [[SetTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        
        if (indexPath.section == 0) {
            cell.rownameLabel.text = rowNameArray[indexPath.row];
            if (indexPath.row == 1) {
                cell.detailsLabel.text = _userModel.user.nickname;
            }else if(indexPath.row == 2){
                cell.detailsLabel.text = _userModel.user.signature;
            }else if(indexPath.row == 3){
                cell.detailsLabel.text = _userModel.user.yxbId;
            }

        }else if (indexPath.section == 1){
            cell.rownameLabel.text = rowNameArray[indexPath.row +5];
            cell.detailsLabel.text = nil;
        }else if (indexPath.section == 2){
            cell.detailsLabel.text = nil;
            cell.rownameLabel.text = rowNameArray[indexPath.row +10];
        }
        if (indexPath.section == 0 && indexPath.row == 3) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

        
        return cell;

    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 1) {
        ModificationViewController * modificationViewController = [[ModificationViewController alloc]init];
        modificationViewController.delegate =self;
        modificationViewController.nameLabel.text = @"新昵名 :";
        modificationViewController.pushIndexPath = indexPath;
        [self.navigationController pushViewController:modificationViewController animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 0){
        [self updataImage];
    }else if (indexPath.section == 0 && indexPath.row == 2){
        ModificationViewController * modificationViewController = [[ModificationViewController alloc]init];
        modificationViewController.delegate =self;
        modificationViewController.nameLabel.text = @"个性签名 :";
        modificationViewController.pushIndexPath = indexPath;
        [self.navigationController pushViewController:modificationViewController animated:YES];
    }else if (indexPath.section == 0 && indexPath.row == 4){

    
        NSString *url = [YXBTool getURL:SetViewControllerMyFaithUrl params:nil];
        [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"我的信用等级"];

    }else if (indexPath.section == 1&& indexPath.row == 1){
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        NSInteger status = userModel.user.whiteCollarStatus;
        if (status==2) {
            [YXBTool showAlertViewWithString:@"白领认证信息已提交，无法学生认证"];
            return;
        }
        else{
        
            
            StudentVerifyViewController *controller = [[StudentVerifyViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            
 
        }

        
    }
    else if (indexPath.section == 1&& indexPath.row == 2){

//        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
//        NSInteger studentStatus = userModel.user.studentStatus;
//        
//        if (studentStatus==2) {
//            [YXBTool showAlertViewWithString:@"学生认证信息已提交，无法白领认证"];
//            return;
//        }
//        else{
//            WhiteCollarViewController *white=[[WhiteCollarViewController alloc]init];
//            [self.navigationController pushViewController:white animated:YES];
//        
//        
//        }
        SafeCenterController *safe=[[SafeCenterController alloc]init];
        [self.navigationController pushViewController:safe animated:YES];
        
        
    }
    
    else if (indexPath.section == 1&& indexPath.row == 3){
//        GestureViewController * gestureViewController = [[GestureViewController alloc]init];
//        [self.navigationController pushViewController:gestureViewController animated:YES];
        SetNewViewController *new=[[SetNewViewController alloc]init];
        [self.navigationController pushViewController:new animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        AuthenticationViewController * authentication = [[AuthenticationViewController alloc]init];
        [self.navigationController pushViewController:authentication animated:YES];
    }else if (indexPath.section == 1 && indexPath.row ==4){
        PasswordViewController * passsWordViewController = [[PasswordViewController alloc]init];
        [self.navigationController pushViewController:passsWordViewController animated:YES];
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        //关于我们
        QCAboutUsViewController *aboutUsVC = [[QCAboutUsViewController alloc] init];
        //        [rootNav pushViewController:aboutUsVC animated:YES];
        [self.navigationController pushViewController:aboutUsVC animated:YES];
        
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        //清楚缓存
        [[SDImageCache sharedImageCache] clearDisk];
        [ProgressHUD showSuccessWithStatus:@"清除成功"];
    }
    indexcell = (SetTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)setModificationValue:(NSString *)value withIndexPath:(NSIndexPath *)indexPath{
   SetTableViewCell * cell = (SetTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.detailsLabel.text = value;
}

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
    }else if (actionSheet.tag == 355) {
        if (buttonIndex == 0) {
            //2.将大图图片保存到相册
            UIImage *image = fullImageView.image;
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }else if (buttonIndex == 1) {
            NSLog(@"取消");
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    indexcell.userimageView.image = image;
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
//    NSString * Urlstring = [NSString stringWithFormat:@"http://60.195.254.33:8083/uploadPhoto.jsp?username=%@&type=%ld&contentlength=%lu",userName,(long)type,(unsigned long)imgData.length];
    NSString *Urlstring=[NSString stringWithFormat:@"%@uploadBatchPhoto.jsp?username=%@&type=%ld",YXB_IP_ADRESS,userName,(long)type];
    
    _manager = [AFHTTPRequestOperationManager manager];

    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    [_manager POST:Urlstring parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

//        [formData appendPartWithFormData:imgData name:@"image"];
        [formData appendPartWithFileData:imgData name:@"image" fileName:@"image.jpg" mimeType:@"image/jpg"];

    } success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSMutableString *responseString = [NSMutableString stringWithFormat:@"%@",responseObject];
        NSString *search = @"\n";
        NSString *replace = @"";

        NSRange substr = [responseString rangeOfString:search];

        while (substr.location != NSNotFound) {
            [responseString replaceCharactersInRange:substr withString:replace];
            substr = [responseString rangeOfString:search];
        }

        NSLog(@"照片地址:%@",responseString);
        [self uploadUserPhoto:responseString];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }];
    
    
//    NSURL *url = [NSURL URLWithString:[Urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request setAuthImageData:imgData forKey:@"image"];
//    //    [request setContentLength:imgData.length];
//    //    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [imgData length]]];
//    NSLog(@"imdddd =%lu",(unsigned long)imgData.length);
//    [request setFailedBlock:^{
////        [indicatorView stopAnimating];
////        indicatorbgView.hidden = YES;
//        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
////        [alertView release];
//    }];
//    [request setCompletionBlock:^{
////        [indicatorView stopAnimating];
////        indicatorbgView.hidden = YES;
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
//        [self uploadUserPhoto:responseString];
//    }];
//    [request startAsynchronous];
    
    
}


//完成验证
- (void)uploadUserPhoto:(NSString *)imageUrl
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak SetViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        [this httpLoadError:error];
    } param:^(NSString *s) {

        [this httpLoadParams:assginHtttperator imageUrl:imageUrl];
    } complete:^(TResultSet* r, int taskid) {
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
}
- (void)httpLoadParams:(HttpOperator *)assginHtttperator imageUrl:(NSString *)imageUrl{

    QCUserModel * user = [[QCUserManager sharedInstance]getLoginUser];
    UserManager* _currUser = (UserManager*)  [assginHtttperator getAopInstance:[UserManager class] returnValue:[TResultSet class]];
    [_currUser uploadIconByUsername:user.user.username iconAddr:imageUrl];
    
}
- (void)httpLoadComplete:(TResultSet *)r{

    QCUserManager * um = [QCUserManager sharedInstance];
    QCUserModel * userModel = [um getLoginUser];
    userModel.user.iconAddr = r.resString;
    [um setLoginUser: userModel];
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message: r.errString delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    //        [alertView release];


}


-(void)actionTap:(UITapGestureRecognizer *)sender{
    QCUserModel *_currUser = [[QCUserManager sharedInstance] getLoginUser];
    if ([YXBTool containString:@"default_icon.png" sourceString:_currUser.user.iconAddr] || [YXBTool containString:@"default_icon.jpg" sourceString:_currUser.user.iconAddr] || _currUser.user.iconAddr == nil || _currUser.user.iconAddr.length == 0) {
        [self updataImage];
    }else {
        CGPoint location = [sender locationInView:_tableView];
        NSIndexPath *indexPath  = [_tableView indexPathForRowAtPoint:location];
        
        UITableViewCell *cell = (UITableViewCell *)[_tableView  cellForRowAtIndexPath:indexPath];
        UIImageView *imageView=(UIImageView *)[cell.contentView viewWithTag:9999];
        
        
        frame_first = CGRectMake(cell.frame.origin.x+imageView.frame.origin.x, cell.frame.origin.y+imageView.frame.origin.y-_tableView.contentOffset.y+64, imageView.frame.size.width, imageView.frame.size.height);
        fullImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, [UIScreen mainScreen].bounds.size.height)];
        fullImageView.backgroundColor=[UIColor blackColor];
        fullImageView.userInteractionEnabled=YES;
        [fullImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap2:)]];
        fullImageView.contentMode=UIViewContentModeScaleAspectFit;
        
        //保存图片
        //保存相片方法
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(savePhoto:)];
        [fullImageView addGestureRecognizer:longPress];
        
        if (![fullImageView superview]) {
            
            fullImageView.image=imageView.image;
            
            [self.view.window addSubview:fullImageView];
            
            
            
            fullImageView.frame=frame_first;
            [UIView animateWithDuration:0.3 animations:^{
                
                fullImageView.frame=CGRectMake(0, 0, kDeviceWidth, [UIScreen mainScreen].bounds.size.height);
                
                
            } completion:^(BOOL finished) {
                
                [UIApplication sharedApplication].statusBarHidden=YES;
                
            }];
            
        }
        
        
    }
    
}

-(void)actionTap2:(UITapGestureRecognizer *)sender{
    
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        fullImageView.frame=frame_first;
        
        
    } completion:^(BOOL finished) {
        
        [fullImageView removeFromSuperview];
        
        
    }];
    
    
    [UIApplication sharedApplication].statusBarHidden=NO;
    
    
}


- (void)savePhoto:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始长按");
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"请选择是否保存图片"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"保存"
                                      otherButtonTitles:nil,nil];
        actionSheet.actionSheetStyle = UIBarStyleDefault;
        actionSheet.tag = 355;
        [actionSheet showInView:self.view];
    }
    else if(longPress.state == UIGestureRecognizerStateEnded) {
        NSLog(@"结束长按");
    }
    
}

//保存图片到相册成功之后调用的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    //保存成功
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alterView show];
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
