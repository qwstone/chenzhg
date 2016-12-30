//
//  QCPersonalProfileViewController.m
//  YOUXINBAO
//
//  Created by CH10 on 15/9/25.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCPersonalProfileViewController.h"
//#import "QCBaseTableView.h"
#import "PersonalProfileHeadTableViewCell.h"
#import "HttpOperator.h"
#import "UIImageView+WebCache.h"
#import "ModificationViewController.h"
#import "FriendScanViewController.h"
#import "YXBTool.h"
#import "UserManager.h"
#import "MyCodeViewController.h"
#import "QRCodeGenerator.h"
#import "AFHTTPRequestOperationManager.h"
@interface QCPersonalProfileViewController ()<UITableViewDataSource,UITableViewDelegate,ModificationViewControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;//左侧数据
    NSMutableArray *_dataRightArray;//右侧数据
    QCUserModel * _userModel;
    UIImageView *fullImageView;
    PersonalProfileHeadTableViewCell * indexcell;
    CGRect frame_first;
    AFHTTPRequestOperationManager *_manager;
}
@end

@implementation QCPersonalProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];
    [self requestData];
    [self setTitle:@"个人资料"];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self createNavigation];
    [self createUI];
}
-(void)createNavigation{
    
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn addTarget:self action:@selector(leftClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"navigation_abck_.png"] forState:UIControlStateNormal];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = navItem;
}
-(void)leftClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)requestData{
    _userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSArray *array1 = @[@"头像",@"昵称",@"无忧借条ID",@"二维码",@"我的地址",@"信用评级",@"积分等级"];
    [_dataArray addObject:array1];
}
-(void)createUI{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.bounces = YES;
    _tableView.dataSource = self;
    _tableView.backgroundColor = rgb(230, 230, 230, 230);
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    [self.view addSubview:_tableView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger line = indexPath.section*5+indexPath.row;
 
    if (line == 0) {//0 0
        static NSString *cellName = @"userImageID";
        PersonalProfileHeadTableViewCell *cell = [self createCellWithCellName:cellName line:line];
        cell.rownameLabel.text= [_dataArray objectAtIndex:0][line];
        [cell.userimageView sd_setImageWithURL:[NSURL URLWithString:_userModel.user.iconAddr]placeholderImage: [UIImage imageNamed:@"useimg"]];
        cell.userimageView.tag=9999;
        cell.userimageView.userInteractionEnabled=YES;
        [cell.userimageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)]];
        return cell;

    }else if (line==1||line==2||line==5) {
        static NSString * cellName = @"wordID";
        PersonalProfileHeadTableViewCell *cell = [self createCellWithCellName:cellName line:line];
        cell.rownameLabel.text = [_dataArray objectAtIndex:0][line];
        switch (line) {
            case 1:
                cell.detailsLabel.text = _userModel.user.nickname;
                break;
            case 2:
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.detailsLabel.text = _userModel.user.yxbId;
                break;
            case 5:
                cell.detailsLabel.text = _userModel.user.creditLevelDesc;
                break;
            default:
                break;
        }
        
        return cell;
    }
    else if (line==6)
    {
        static NSString *cellName = @"imageID2";
        PersonalProfileHeadTableViewCell *cell = [self createCellWithCellName:cellName line:line];
        cell.rownameLabel.text = [_dataArray objectAtIndex:0][line];
        cell.userModel = _userModel;
        return cell;
        
    }
    else
    {
        static NSString *cellName = @"imageID";
        PersonalProfileHeadTableViewCell *cell = [self createCellWithCellName:cellName line:line];
        if (line==3) {
            cell.detailImageView.image = [UIImage imageNamed:@"ewm925"];
        }else if (line==4){
            cell.detailImageView.image = [UIImage imageNamed:@"dz925"];
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0://修改头像
                [self updataImage];
                break;
            case 1:{//修改昵称
                ModificationViewController * modificationViewController = [[ModificationViewController alloc]init];
                modificationViewController.delegate = self;
                modificationViewController.nameLabel.text = @"新昵名 :";
                modificationViewController.pushIndexPath = indexPath;
                [self.navigationController pushViewController:modificationViewController animated:YES];
            }
                break;
            case 3://二维码
                [self qrCodeAction];
                break;
            case 4://我的地址
                [self jumpToMyAddress];
            default:
                break;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {//信用评级

            NSString *url = [YXBTool getURL:[NSString stringWithFormat:@"wap/creditmaps/grade-meter.jsp?userId=%ld",(long)_userModel.user.t_id] params:nil];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"信用评级"];
        }else if (indexPath.row == 1){//积分等级
            NSString *url = [YXBTool getURL:@"webView/user/creditLevel.jsp?t=1" params:nil];
            [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:@"我的信用等级"];
        }
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 14.0)];
    view.backgroundColor = rgb(230, 230, 230, 1);
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0&&indexPath.section==0) {
        return 117.0/2;
    }
    return 44.0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 14.0;
}
-(PersonalProfileHeadTableViewCell *)createCellWithCellName:(NSString*)cellName line:(NSInteger)line{
    PersonalProfileHeadTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil)
        cell = [[PersonalProfileHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    cell.rownameLabel.text = [_dataArray objectAtIndex:0][line];
    return cell;
}
-(void)qrCodeAction
{
    //二维码跳转
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    NSString *url = [NSString stringWithFormat:@"%@webView/qrCode/qrCodeJump.jsp?id=%@%04ld",YXB_IP_ADRESS,userModel.user.yxbId,(long)rand()%10000];
    UIImage *image = [QRCodeGenerator qrImageForString:url imageSize:kDeviceWidth];
    
    MyCodeViewController *code = [[MyCodeViewController alloc] init];
    code.image = image;
    code.shareUrlStr = [NSString stringWithFormat:@"%@&type=weichat",url];
    [self.navigationController pushViewController:code animated:YES];
    
    
}
-(void)jumpToMyAddress{

    
    NSString *str = [NSString stringWithFormat:@"%@webView/address/index.jsp?userId=%lu&type=%d",YXB_IP_ADRESS,(long)_userModel.user.t_id,0];
    NSString *url = [YXBTool getURL:str params:nil];
    [YXBTool jumpInnerSafaryWithUrl:url hasTopBar:NO titleName:nil];
}
#pragma mark - ModificationViewControllerDelegate
- (void)setModificationValue:(NSString *)value withIndexPath:(NSIndexPath *)indexPath{
    PersonalProfileHeadTableViewCell * cell = (PersonalProfileHeadTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
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

#pragma mark - acctionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
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
    }else if (actionSheet.tag == 355) {
        if (buttonIndex == 0) {
            //2.将大图图片保存到相册
            UIImage *image = fullImageView.image;
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }else if (buttonIndex == 1) {
//            NSLog(@"取消");
        }
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    indexcell.userimageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self upImageData:image type:1];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)upImageData:(UIImage *)image type:(NSInteger)type
{
    QCUserModel *_currUser = [[QCUserManager sharedInstance] getLoginUser];
    NSString *userName = _currUser.user.username;
    NSData *imgData = UIImageJPEGRepresentation(image, 0.75);
    NSString *Urlstring=[NSString stringWithFormat:@"%@uploadBatchPhoto.jsp?username=%@&type=%ld",YXB_IP_ADRESS,userName,(long)type];
    
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [_manager POST:Urlstring parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //上传
        [formData appendPartWithFileData:imgData name:@"image" fileName:@"image.jpg" mimeType:@"image/jpg"];
//        [formData appendPartWithFormData:imgData name:@"image"];
    } success:^(AFHTTPRequestOperation * operation, id responseObject) {
        //上传成功
        NSMutableString *responseString = [NSMutableString stringWithFormat:@"%@",responseObject];
        NSString *search = @"\n";
        NSString *replace = @"";

        NSRange substr = [responseString rangeOfString:search];

        while (substr.location != NSNotFound) {
            [responseString replaceCharactersInRange:substr withString:replace];
            substr = [responseString rangeOfString:search];
        }

        [self uploadUserPhoto:responseString];

    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }];

    
    
    
    
//    NSURL *url = [NSURL URLWithString:[Urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request setAuthImageData:imgData forKey:@"image"];
//    [request setFailedBlock:^{
//        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
//    }];
//    [request setCompletionBlock:^{
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
////        NSLog(@"照片地址:%@",responseString);
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
    __weak QCPersonalProfileViewController *this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
        }
        
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
    _userModel = [[QCUserManager sharedInstance]getLoginUser];
    [_tableView reloadData];
    
}

//查看大图状态的头像
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
//        NSLog(@"开始长按");
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
//        NSLog(@"结束长按");
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
