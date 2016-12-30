//
//  StudentVerifyViewController.m
//  YOUXINBAO
//
//  Created by Feili on 15/8/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "StudentVerifyViewController.h"
#import "LoginModel.h"
#import "StudentInfo.h"
#import "AACreatePickerView.h"
#import "StudentPickerView.h"
#import "StudentConfig.h"
#import "StudentCerInfoV2.h"
#import "AppCertificationManager.h"
#import "HttpOperator.h"
#import "UIAlertView+Block.h"
#import "YXBTool.h"
#define  InviteNum 6

@interface StudentVerifyViewController ()<QCBaseTableViewDelegate,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    //    UIButton *commitBtn;
    UIButton *_picButton;
    UIView *footerView;
}
@property (nonatomic,strong)QCBaseTableView     *tableView;
@property (nonatomic,strong)NSMutableArray      *dataArray;
//@property (nonatomic,strong)StudentInfo         *studentInfo;
@property (nonatomic,strong)StudentCerInfoV2    *studentCerInfo;
@property(nonatomic,strong)AACreatePickerView   *pickerView;//学历 pickerView
@property(nonatomic,strong)StudentPickerView    *timerPickerView;//时间 pickerview
@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property (nonatomic,strong)NSString *imageUrl;// 图片地址
@property(nonatomic,strong)UIImage *tImage;//照片

@end

@implementation StudentVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
    [self setTitle:@"学生认证"];
    [self createMyTableView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitKeyBoard)];
    [self.view addGestureRecognizer:tap];
    
    //    [self.tableView reloadDeals];
    // Do any additional setup after loading the view.
}


-(void)exitKeyBoard
{
    //[self.view resignFirstResponder];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createMyTableView
{
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    self.scrollView.contentSize=CGSizeMake(kDeviceWidth, kDeviceHeight);
    [self.view addSubview:_scrollView];
    CGFloat x = 0, y = 0, w = kDeviceWidth, h = kDeviceHeight - 64;
    self.tableView = [[QCBaseTableView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.refreshDelegate = self;
    [self.scrollView addSubview:_tableView];
    
    
    
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 320)];
    //    footerView.backgroundColor=[UIColor redColor];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 25, 100, 15)];
    label.text=@"上传照片";
    [footerView addSubview:label];
    _picButton =[UIButton buttonWithType:UIButtonTypeCustom];
    _picButton.frame=CGRectMake(label.right+10, label.bottom+18, 132, 132);
    [_picButton setBackgroundImage:[UIImage imageNamed:@"studentsrz-add-icon.png"] forState:UIControlStateNormal];
    [_picButton addTarget:self action:@selector(takePic) forControlEvents:UIControlEventTouchUpInside];
    _picButton.center  = CGPointMake(self.view.center.x, _picButton.center.y);
    [footerView addSubview:_picButton];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(20, _picButton.bottom+10, kDeviceWidth-40, 18)];
    label1.text=@"注:所上传照片中必须包含以下几点: (学校、姓名、学号、本人照片)";
    label1.textColor=rgb(255, 0, 0, 1);
    label1.font=[UIFont systemFontOfSize:9];
    [footerView addSubview:label1];
    
    
    _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commitBtn.frame = CGRectMake(25, label1.bottom + 30, kDeviceWidth - 40, 40);
    _commitBtn.layer.cornerRadius = 5.0;
    [_commitBtn setImage:[UIImage imageNamed:@"rzrz-but.png"] forState:UIControlStateNormal];
    [_commitBtn addTarget:self action:@selector(alertCommitInfo) forControlEvents:UIControlEventTouchUpInside];
    _commitBtn.userInteractionEnabled=NO;
    [footerView addSubview:_commitBtn];
    footerView.hidden = YES;
    _tableView.tableFooterView = footerView;
}

-(void)alertCommitInfo
{   //textField结束编辑的时候,下边才可以赋值成功
    StudentCell *cell = (StudentCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[_dataArray count] - 1 inSection:0]];
    [cell.textfield resignFirstResponder];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"学生信息一旦验证将不能修改,是否确认保存信息?" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            if(self.tImage != nil)
            {
                [self uploadPicturesWithImage:_tImage];
                
            }
            else
            {
                [ProgressHUD showErrorWithStatus:@"您尚未上传图片"];
            }
        }
    }];
    
}


-(void)commitInfo
{
    
    
    /*
     _studentCerInfo.status = 1;
     _studentCerInfo.realName = @"";
     _studentCerInfo.idCardNo = @"";
     _studentCerInfo.SchoolName = @"";
     _studentCerInfo.stuIdCardNo = @"";
     _studentCerInfo.degree = @"";
     _studentCerInfo.graduationDate = @"";
     NSMutableArray *valueArray = [NSMutableArray arrayWithObjects:_studentCerInfo.realName,_studentCerInfo.idCardNo,_studentCerInfo.SchoolName,_studentCerInfo.stuIdCardNo,_studentCerInfo.degree,_studentCerInfo.graduationDate, nil];
     
     NSLog(@"values---%@",valueArray);
     */
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StudentVerifyViewController *this = self;
    
    
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            [this.tableView reloadDeals];
        }
        
    } param:^(NSString *s) {
        
        [this httpLoadParams:assginHtttperator];
        
    } complete:^(TResultSet* r, int taskid) {
        
        [this httpLoadComplete:r];
    }];
    [self.iHttpOperator connect];
    
    
}

- (void)httpLoadParams:(HttpOperator *)assginHtttperator{

    AppCertificationManager* manager = (AppCertificationManager*)  [assginHtttperator getAopInstance:[AppCertificationManager class] returnValue:[TResultSet class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    
    //        [manager getStudentSubmit_V2_1:userModel.user.yxbToken realName:_studentCerInfo.realName  idCardNo:_studentCerInfo.idCardNo schoolName:_studentCerInfo.schoolName stuIdCardNo:_studentCerInfo.stuIdCardNo degree:_studentCerInfo.degree  graduationDate:_studentCerInfo.graduationDate channelId:_studentCerInfo.channelId];
    if (_studentCerInfo.channelId == nil) {
        _studentCerInfo.channelId = @"";
    }
    
    if (userModel.user.yxbToken == nil ||
        _studentCerInfo.realName == nil ||
        _studentCerInfo.idCardNo == nil ||
        _studentCerInfo.schoolName == nil ||
        _studentCerInfo.stuIdCardNo == nil ||
        _studentCerInfo.degree == nil ||
        _studentCerInfo.graduationDate == nil ||
        _studentCerInfo.channelId == nil ||
        self.imageUrl == nil)
    {
        
        [ProgressHUD showErrorWithStatus:@"请完善学生信息后提交认证"];
        return;
    }
    
    
    
    [manager getStudentSubmit_V3:userModel.user.yxbToken realName:_studentCerInfo.realName  idCardNo:_studentCerInfo.idCardNo schoolName:_studentCerInfo.schoolName stuIdCardNo:_studentCerInfo.stuIdCardNo degree:_studentCerInfo.degree  graduationDate:_studentCerInfo.graduationDate imgUrl:self.imageUrl channelId:_studentCerInfo.channelId];
    

}
- (void)httpLoadComplete:(TResultSet *)r{

    if (r.errCode == 0) {
        
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        userModel.user.studentStatus= r.resInteger;
        [[QCUserManager sharedInstance] setLoginUser:userModel];
        [self checkSummitSelectedWithInfo:self.studentCerInfo];
        [ProgressHUD showSuccessWithStatus:r.errString];
        //            [YXBTool showAlertViewWithString:r.errString];
        [self leftClicked];
    }else {
        [ProgressHUD showErrorWithStatus:r.errString];
    }


}

-(void)requestData
{
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StudentVerifyViewController *this = self;
    
    
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:this cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
            [this.tableView reloadDeals];
        }
        
    } param:^(NSString *s) {
        
        [this httpLoadParamsTwo:assginHtttperator];
        
    } complete:^(StudentCerInfoV2* r, int taskid) {
        
        [this httpLoadCompleteTwo:r];
    }];
    [self.iHttpOperator connect];
    
    
}
- (void)httpLoadParamsTwo:(HttpOperator *)assginHtttperator{

    AppCertificationManager* manager = (AppCertificationManager*)  [assginHtttperator getAopInstance:[AppCertificationManager class] returnValue:[StudentCerInfoV2 class]];
    QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
    [manager getStudentCerInfo_V2:userModel.user.yxbToken];

}
- (void)httpLoadCompleteTwo:(StudentCerInfoV2 *)r{
    if (r.errCode == 0) {
        //            [ProgressHUD showSuccessWithStatus:r.errString];
        if (self.studentCerInfo == nil) {
            self.studentCerInfo = r;
            
        }
        NSLog(@"arr---%@",self.studentCerInfo.degreeList);
        [self processData];
        [self checkSummitSelectedWithInfo:self.studentCerInfo];
        StudentCell *cell=(StudentCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        StudentCell *cell1=(StudentCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        if (r.status==2) {
            cell.accessoryType=UITableViewCellAccessoryNone;
            cell1.accessoryType=UITableViewCellAccessoryNone;
            //            [_commitBtn setImage:[UIImage imageNamed:@"rzsave-but.png"] forState:UIControlStateNormal];
            //            _commitBtn.userInteractionEnabled=NO;
            //                _commitBtn.hidden=YES;
            footerView.hidden = YES;
            [self.dataArray removeObjectAtIndex:6];
            [self.tableView reloadData];
            
        }
        else{
            footerView.hidden = NO;
            
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell1.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
        }
        
        
    }else {
        [ProgressHUD showSuccessWithStatus:r.errString];
        
    }
    
    
    [self.tableView reloadDeals];

}




-(void)processData
{
    
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray array];
    }
    else
    {
        [self.dataArray removeAllObjects];
    }
    
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"姓       名",@"身份证号",@"学       校",@"学生证号",@"当前学历",@"毕业时间",@"邀请码", nil];
    NSMutableArray *placeHolderArray = [NSMutableArray arrayWithObjects:@"真实姓名",@"18位身份证号",@"所在学校全称(含校区)",@"真实学生证号",@"请选择",@"请选择",@"6位数字(可不填)", nil];
    
    NSMutableArray *valueArray = [NSMutableArray array];
    
    //    valueArray = [NSMutableArray arrayWithObjects:_studentInfo.realName,_studentInfo.idCardNO,_studentInfo.studentInfo.schoolName,_studentInfo.studentInfo.stuIdCardNo,_studentInfo.studentInfo.stuXueLi,_studentInfo.studentInfo.graduateDate, nil];
    valueArray = [NSMutableArray arrayWithObjects:
                  _studentCerInfo.realName == nil?@"":_studentCerInfo.realName,
                  _studentCerInfo.idCardNo == nil?@"":_studentCerInfo.idCardNo,_studentCerInfo.schoolName == nil?@"":_studentCerInfo.schoolName,_studentCerInfo.stuIdCardNo == nil?@"":_studentCerInfo.stuIdCardNo,_studentCerInfo.degree == nil?@"":_studentCerInfo.degree,_studentCerInfo.graduationDate == nil?@"":_studentCerInfo.graduationDate, _studentCerInfo.channelId == nil?@"":_studentCerInfo.channelId,nil];
    NSLog(@"array--%@",valueArray);
    
    for (int i = 0; i < [titleArray count]; i ++) {
        
        LoginModel *model = [[LoginModel alloc] init];
        model.titleName = titleArray[i];
        model.text = valueArray[i];
        model.placeHolder = placeHolderArray[i];
        [_dataArray addObject:model];
    }
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID  =@"cellID";
    StudentCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    __block typeof(self) this = self;
    if (cell == Nil) {
        cell = [[StudentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID width:_tableView.width height:StudentCellContentHeight];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    [cell setMyTextfieldBeginBlock:^{
        
        if (indexPath.row == 4) {
            if (_timerPickerView != nil) {
                if ([_timerPickerView isShow]) {
                    [_timerPickerView showPickerView];
                    
                }
            }
            
            [this.view endEditing:YES];
            [this xueliPickerAction:indexPath.row];
            
            
        }else if (indexPath.row == 5)
        {
            if (_pickerView != nil) {
                if (_pickerView.isShow) {
                    [_pickerView showPickerView];
                    
                }
            }
            [this.view endEditing:YES];
            [this graduatePickerAction:indexPath.row];
        }
        else if (indexPath.row==6){
            //   cell.textfield.keyboardType=UIKeyboardTypeNumberPad;
            
        }
        else
        {
            if (this.pickerView != nil) {
                if (this.pickerView.isShow) {
                    [this.pickerView showPickerView];
                }
            }
            if (this.timerPickerView != nil) {
                if (this.timerPickerView.isShow) {
                    [this.timerPickerView showPickerView];
                }
                //                [_timerPickerView removeFromSuperview];
            }
        }
    } EndBlock:^(NSString *text) {
        
        if (indexPath.row == 0) {
            this.studentCerInfo.realName = text;
        }else if (indexPath.row == 1)
        {
            this.studentCerInfo.idCardNo = text;
        }else if (indexPath.row == 2)
        {
            this.studentCerInfo.schoolName = text;
        }else if (indexPath.row == 3)
        {
            this.studentCerInfo.stuIdCardNo = text;
        }else if (indexPath.row == 4)
        {
            this.studentCerInfo.degree = text;
        }else if (indexPath.row == 5)
        {
            this.studentCerInfo.graduationDate = text;
        }
        else if (indexPath.row==6){
            
            this.studentCerInfo.channelId=text;
        }
        
        [this checkSummitSelectedWithInfo:this.studentCerInfo];
    }];
    
    LoginModel * model = _dataArray[indexPath.row];
    cell.model = model;
    cell.index=indexPath.row;
    if (indexPath.row == 4) {
        cell.pickerViewData = _studentCerInfo.degreeList;
        
    }else if(indexPath.row == 5)
    {
        cell.pickerViewData = _studentCerInfo.graduationDateList;
        
    }
    
    if (self.studentCerInfo.status == 1) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            [cell editEnable:NO];
            
        }
    }
    
    if (self.studentCerInfo.status == 2) {
        [cell editEnable:NO];
        
    }
    return cell;
}

-(void)QCBaseTableViewDidPullDownRefreshed:(QCBaseTableView *)tableView
{
    [self requestData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    if (_pickerView != nil) {
        if (_pickerView.isShow) {
            [_pickerView showPickerView];
        }
    }
    if (_timerPickerView != nil) {
        if (_timerPickerView.isShow) {
            [_timerPickerView showPickerView];
        }
        //                [_timerPickerView removeFromSuperview];
    }
    
    
}

//添加pickerview

-(void)xueliPickerAction:(NSInteger)row
{
    __block typeof(self) this = self;
    
    StudentCell *cell = (StudentCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    if (_pickerView == nil) {
        //        NSArray *arr = [NSArray arrayWithObjects:@[@"大学生",@"研究生",@"博士生"], nil];
        NSLog(@"---%@",_studentCerInfo.degreeList);
        NSArray *arr = [NSArray arrayWithArray:_studentCerInfo.degreeList];
        
        _pickerView = [[AACreatePickerView alloc] initWithFrame:CGRectMake(0,  _tableView.height, _tableView.width, kCreatePickerCustomHeight) Component:1 listArr:[NSArray arrayWithObjects:arr, nil]];
        _pickerView.selectedBlock = ^ (NSString *text, AACreatePickerView *createPickerView) {
            cell.text = text;
            this.studentCerInfo.degree = text;
            [this checkSummitSelectedWithInfo:this.studentCerInfo];
            
        };
        [self.view addSubview:_pickerView];
    }
    [_pickerView showPickerView];
}


- (void)graduatePickerAction:(NSInteger)row
{
    StudentCell *cell = (StudentCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    
    __block typeof(self) this = self;
    if (_timerPickerView == nil) {
        _timerPickerView = [[StudentPickerView alloc] initWithFrame:CGRectMake(0, _tableView.height, _tableView.width, kTimeCustomHeight)];
        _timerPickerView.yearArray = _studentCerInfo.graduationDateList;
        _timerPickerView.selectedBlock = ^ (NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minIndexppp, StudentPickerView *timePickerView) {
            NSString *date = [NSString stringWithFormat:@"%ld年%02ld月",(long)year,(long)month];
            cell.text = date;
            this.studentCerInfo.graduationDate = date;
            [this checkSummitSelectedWithInfo:this.studentCerInfo];
            
            NSLog(@"date----%@",date);
        };
        [self.view addSubview:_timerPickerView];
    }
    
    [_timerPickerView showPickerView];
}

-(BOOL)checkSummitSelectedWithInfo:(StudentCerInfoV2 *)info
{
    self.studentCerInfo = info;
    BOOL isAllEdited = NO;
    if ([self.studentCerInfo.realName length] > 1 &&
        [self.studentCerInfo.idCardNo length] > 1 &&
        [self.studentCerInfo.schoolName length] > 1 &&
        [self.studentCerInfo.stuIdCardNo length] > 1 &&
        [self.studentCerInfo.degree length] > 1 &&
        [self.studentCerInfo.graduationDate length] > 1)
    {
        if (self.studentCerInfo.status < StudentVerifyStatusTypePassedStudent) {
            isAllEdited = YES;
            [_commitBtn setImage:[UIImage imageNamed:@"rzrz-buton.png"] forState:UIControlStateNormal];
            _commitBtn.userInteractionEnabled = YES;
            
        }
        else
        {
            isAllEdited = NO;
            [_commitBtn setImage:[UIImage imageNamed:@"rzrz-but.png"] forState:UIControlStateNormal];
            _commitBtn.userInteractionEnabled = NO;
            
        }
    }
    else
    {
        isAllEdited = NO;
        [_commitBtn setImage:[UIImage imageNamed:@"rzrz-but.png"] forState:UIControlStateNormal];
        _commitBtn.userInteractionEnabled = NO;
    }
    return isAllEdited;
}

-(BOOL)hasValueWithString:(NSString *)value
{
    NSLog(@"%@value---%@",[value class],value);
    BOOL hasValue = NO;
    if (value != nil && [value length] > 2) {
        hasValue = YES;
    }
    else
    {
        hasValue = NO;
    }
    
    return hasValue;
}


-(void)takePic
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"选择照片来源"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"拍照"
                                  otherButtonTitles:@"从手机相册选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sourceType = UIImagePickerControllerSourceTypeCamera;
    if (buttonIndex == 0) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
        [self createCameraViewWithCameraType:sourceType];
        
    }else if (buttonIndex == 1)
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self createCameraViewWithCameraType:sourceType];
        
    }
}


-(void)createCameraViewWithCameraType:(NSInteger)sourceType
{
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        if(![UIImagePickerController isSourceTypeAvailable:sourceType]) {
            [YXBTool showAlertViewWithString:@"您的手机暂不支持相机拍摄"];
            return;
        }
        
    }
    
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = NO;
    
    imagePickerController.sourceType = sourceType;
    
    imagePickerController.videoQuality = UIImagePickerControllerQualityType640x480;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
    
}


#pragma -mark imagePickerDelegate



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGSize size = originImage.size;
    if (size.width >= kDeviceWidth) {
        CGFloat height = (kDeviceWidth * size.height)/(CGFloat)size.width;
        UIImage * image = [YXBTool OriginImage:originImage scaleToSize:CGSizeMake(kDeviceWidth, height)];
        originImage = image;
    }
    
    _tImage = originImage;
    
    
    
    [_picButton setImage:originImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //    NSLog(@"self.imageNamesDict---%@",self.imagesDic);
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadPicturesWithImage:(UIImage *)image{
    NSString *url1 = [NSString stringWithFormat:@"uploadBatchPhoto.jsp?type=6&id=1111"];
    NSString *Urlstring = [NSString stringWithFormat:@"%@%@",YXB_IP_ADRESS,url1];
    NSLog(@"图片上传地址: %@",Urlstring);
    NSURL *url = [NSURL URLWithString:[Urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    __block StudentVerifyViewController *this = self;
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    //    [request setAuthImageData:image dataWithContentsOfFile:path] forKey:@"image"];
    NSData *dataObj = UIImageJPEGRepresentation(image, 1.0);
    NSLog(@"dataObj=====%ld",(long)[dataObj length]);
    
    [request setAuthImageData:dataObj forKey:@"image"];
    
    [request setFailedBlock:^{
        [ProgressHUD dismiss];
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"上传图片失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alterView show];
        NSLog(@"failed");
    }];
    [request setCompletionBlock:^{
        
//        NSLog(@"responseString--%@",request.responseString);
        this.imageUrl = request.responseString;
        this.imageUrl = [YXBTool decodeFromPercentEscapeString:request.responseString];
        //        if ([this.imageUrl length] > 5) {
        [ProgressHUD showSuccessWithStatus:@"图片上传成功"];
        [this commitInfo];
        
        //        }
        //        [ProgressHUD showSuccessWithStatus:@"图片上传失败"];
        
        
        
    }];
    
    [request startAsynchronous];
    NSLog(@"responseHeaders---%@",request.requestHeaders);
    [ProgressHUD showWithStatus:@"正在提交,请稍后" maskType:ProgressHUDMaskTypeGradient tipsType:ProgressHUDTipsTypeLongBottom];
    
    
}



@end
