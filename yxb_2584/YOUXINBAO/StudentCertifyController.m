//
//  StudentCertifyController.m
//  YOUXINBAO
//
//  Created by Walice on 15/6/4.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "StudentCertifyController.h"
#import "AppCertificationManager.h"
#import "StudentCerSelect.h"
#import "YXBTool.h"

@interface StudentCertifyController ()

@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *area;
@property (nonatomic,copy) NSString *school;
@property(nonatomic,copy) NSString *display;
@property(nonatomic,copy)NSString *schoolName;
@property(nonatomic,copy)NSString *domitoryName;
@property(nonatomic,copy)NSString *num;

@end

@implementation StudentCertifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    _dataArray=[NSMutableArray array];
    self.view.backgroundColor = rgb(238, 236, 246, 1.0);
    self.title=@"学生认证";
    [self _initViews];
   // [self _isAleadryRegister];
    
    
}
- (void)_isAleadryRegister{

    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak StudentCertifyController * this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
        }
        
    } param:^(NSString *s) {
        AppCertificationManager *_activityM = (AppCertificationManager *)[assginHtttperator getAopInstance:[AppCertificationManager class] returnValue:[StudentCerInfo class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        NSString *userToken = userModel.user.yxbToken;
         NSInteger studentStatus = userModel.user.studentStatus;
        if ((userToken != nil) && [userToken length] > 0&&studentStatus==2)
        {
            
            [_activityM getStudentCerInfo:userToken];
            _btn.hidden=YES;
  
        }
        
        
    }complete:^(StudentCerInfo * r, int taskid) {
        [this.provinceButton setTitle:r.provinceName forState:UIControlStateNormal];
        this.provinceButton.userInteractionEnabled=NO;
        [this.cityButton setTitle:r.cityName forState:UIControlStateNormal];
        this.cityButton.userInteractionEnabled=NO;
        [this.areaButton setTitle:r.districtName forState:UIControlStateNormal];
        this.areaButton.userInteractionEnabled=NO;
        [this.schlloButton setTitle:r.schoolName forState:UIControlStateNormal];
        this.schlloButton.userInteractionEnabled=NO;
        this.numField.text=r.stuIdCardNo;
        this.numField.userInteractionEnabled=NO;
        this.dormitoryView.text=r.dormitory;
        this.dormitoryView.userInteractionEnabled=NO;
        
    }];
    
    [self.iHttpOperator connect];
    
}

- (void)_initViews{
    
    
    _scrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64)];
    _scrollerView.contentSize=CGSizeMake(kDeviceWidth, kDeviceHeight);
    [self.view addSubview:_scrollerView];
    
    //提示
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 170, 20)];
    label.text=@"目前仅支持列表内学校";
    label.textColor=[UIColor redColor];
    label.font=[UIFont systemFontOfSize:15];
    label.textAlignment=NSTextAlignmentLeft;
    [_scrollerView addSubview:label];
    
    //整个的view
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 30, kDeviceWidth, 210)];
    view.backgroundColor=[UIColor greenColor];
    view.backgroundColor=[UIColor whiteColor];
    [_scrollerView addSubview:view];
    
    //确认提交按钮
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(10, view.bottom+20, kDeviceWidth-20, 46);
    [_btn addTarget:self action:@selector(indentAction) forControlEvents:UIControlEventTouchUpInside];
    [_btn setBackgroundImage:[UIImage imageNamed:@"blue-but2.png"] forState:UIControlStateNormal];
    [_btn setTitle:@"确认提交" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_scrollerView addSubview:_btn];

    CGFloat left=10;
    CGFloat lineX=18;
    CGFloat schoolY=75;
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(left, 3, 60, 20)];
    label1.text=@"地区:";
    [view addSubview:label1];
    //省
    _provinceButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 30, kDeviceWidth/3-20, 40)];
    [_provinceButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_provinceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _provinceButton.tag=1001;
    [view addSubview:_provinceButton];
    UILabel *labelP=[[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/3-20, 40, 20, 20)];
    labelP.text=@"省";
    [view addSubview:labelP];
    CALayer *border1 = [CALayer layer];
    border1.frame = CGRectMake(10.0f, 31, kDeviceWidth/3-20, 1.0f);
    border1.backgroundColor = [YXBTool colorWithHexString:@"#dcdcdc"].CGColor;
    [_provinceButton.layer addSublayer:border1];
    
    
    //市
    _cityButton=[[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth/3+10, 30, kDeviceWidth/3-20, 40)];
    [_cityButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _cityButton.tag=1002;
    [view addSubview:_cityButton];
    UILabel *labelS=[[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth/3*2-30, 40, 20, 20)];
    labelS.text=@"市";
    [view addSubview:labelS];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(kDeviceWidth/3+10, 60, kDeviceWidth/3-20, 1)];
    line.backgroundColor=rgb(220, 220, 220, 1);
    [view addSubview:line];
    
    //区
    _areaButton=[[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth/3*2+10, 30, kDeviceWidth/3-20, 40)];
    [_areaButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_areaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _areaButton.tag=1003;
    [view addSubview:_areaButton];
    UILabel *labelA=[[UILabel alloc]initWithFrame:CGRectMake(kDeviceWidth-30, 40, 20, 20)];
    labelA.text=@"区";
    [view addSubview:labelA];
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(kDeviceWidth/3*2+10, 60, kDeviceWidth/3-20, 1)];
    line1.backgroundColor=rgb(220, 220, 220, 1);
    [view addSubview:line1];
    
    
    //学校
    UILabel *schoolLabel=[[UILabel alloc]initWithFrame:CGRectMake(left, schoolY, 40, 20)];
    schoolLabel.text=@"学校:";
    [view addSubview:schoolLabel];
    _schlloButton=[[UIButton alloc]initWithFrame:CGRectMake(50, 70, kDeviceWidth-50, 40)];
    [_schlloButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_schlloButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _schlloButton.tag=1004;
    [view addSubview:_schlloButton];
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(lineX, 111, kDeviceWidth-18, 1)];
    line2.backgroundColor=rgb(220, 220, 220, 1);
    [view addSubview:line2];
    
    //学生证号
    UILabel *officeLabel=[[UILabel alloc]initWithFrame:CGRectMake(left, schoolY+50, 80, 20)];
    officeLabel.text=@"学生证号:";
    [view addSubview:officeLabel];
    _numField=[[UITextField alloc]initWithFrame:CGRectMake(90, 120, kDeviceWidth-90, 30)];
    [_numField addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _numField.returnKeyType=UIReturnKeyDone;
    _numField.delegate=self;
    _numField.tag=1005;
    [view addSubview:_numField];
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(lineX, 161, kDeviceWidth-18, 1)];
    line3.backgroundColor=rgb(220, 220, 220, 1);
    [view addSubview:line3];
    
    //宿舍地址
    UILabel *officeNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(left, schoolY+50+50, 120, 30)];
    officeNameLabel.text=@"宿舍地址:";
    [view addSubview:officeNameLabel];
    _dormitoryView=[[UITextField alloc]initWithFrame:CGRectMake(90, 170, kDeviceWidth-80, 40)];
    _dormitoryView.returnKeyType=UIReturnKeyDone;
    _dormitoryView.delegate=self;
    _dormitoryView.returnKeyType=UIReturnKeyDone;
    [view addSubview:_dormitoryView];
    UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(lineX, 211, kDeviceWidth-18, 1)];
    line4.backgroundColor=rgb(220, 220, 220, 1);
    [view addSubview:line4];


}

- (void)indentAction{
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    //__weak HttpOperator * assginHtttperator = _iHttpOperator;

//    __weak HttpOperator * assginHtttperator = _iHttpOperator;

    __weak StudentCertifyController * this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
        }
        
        
    } param:^(NSString *s) {
       // AppCertificationManager *_activityM = (AppCertificationManager *)[assginHtttperator getAopInstance:[AppCertificationManager class] returnValue:[TResultSet class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];

        NSString *userToken = userModel.user.yxbToken;
            if ((userToken != nil) && [userToken length] > 0)
            {
                _domitoryName=this.dormitoryView.text;
                _num=this.numField.text;
                if (![_domitoryName isEqualToString:@""]&![_num isEqualToString:@""] & ![this.provinceButton.titleLabel.text isEqualToString:@""] & ![this.cityButton.titleLabel.text isEqualToString:@""] & ![this.areaButton.titleLabel.text isEqualToString:@""] & ![this.schlloButton.titleLabel.text isEqualToString:@""]) {
//                    
//                    [_activityM getStudentSubmit:this.schoolName schoolType:this.school dormitory:this.domitoryName stuIdCardNo:this.num userToken:userToken];
                }else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请完善信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                }
                
                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        
        
    }complete:^(TResultSet * r, int taskid) {
        if (r.errCode==0) {
            QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
            userModel.user.studentStatus= r.resInteger;
            [[QCUserManager sharedInstance] setLoginUser:userModel];
            
            [this.provinceButton setTitle:this.provinceButton.titleLabel.text forState:UIControlStateNormal];
            this.provinceButton.userInteractionEnabled=NO;
            [this.cityButton setTitle:this.cityButton.titleLabel.text forState:UIControlStateNormal];
            this.cityButton.userInteractionEnabled=NO;
            [this.areaButton setTitle:this.areaButton.titleLabel.text forState:UIControlStateNormal];
            this.areaButton.userInteractionEnabled=NO;
            [this.schlloButton setTitle:this.schlloButton.titleLabel.text forState:UIControlStateNormal];
            this.schlloButton.userInteractionEnabled=NO;
            this.numField.text=_num;
            this.dormitoryView.text=_domitoryName;
            this.dormitoryView.userInteractionEnabled=NO;
            _btn.hidden=YES;
            
 

            
        }
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:r.errString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }];
    
    [self.iHttpOperator connect];
    
   }

- (void)buttonAction:(UIButton *)button
{

//    if (kDeviceHeight==480) {
//        [_scrollerView setContentOffset:CGPointMake(0, 110) animated:YES];
//    }
//    if (kDeviceHeight==568) {
//          [_scrollerView setContentOffset:CGPointMake(0, 20) animated:YES];
//    }
    
    
    [_dormitoryView resignFirstResponder];
        if (_pickerView == nil) {
            _pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0,kDeviceHeight-64, kDeviceWidth, 100)];
            _pickerView.backgroundColor=[UIColor whiteColor];
            _pickerView.dataSource=self;
            _pickerView.delegate=self;
            [self.view addSubview:_pickerView];
            
            _sendBackImage = [[UIView alloc]initWithFrame:CGRectMake(0, _pickerView.origin.y-20, kDeviceWidth, 50)];
            _sendBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,_pickerView.origin.y-10, kDeviceWidth, 40)];
            _sendBackImage.backgroundColor = [UIColor whiteColor];
                        _sendBackImage.layer.borderWidth = 1.0;
                        _sendBackImage.layer.borderColor = [rgb(255, 156, 146, 1) CGColor];
            [self.view addSubview:_sendBackImage];
            
            _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _sureButton.frame = CGRectMake(0, _pickerView.origin.y-10, kDeviceWidth, 40);
            _sureButton.backgroundColor = [UIColor clearColor];
            [_sureButton setImage:[UIImage imageNamed:@"register_sure.png"] forState:UIControlStateNormal];
            [_sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_sureButton];
        }
    
    [UIView animateWithDuration:.3 animations:^{
        _pickerView.top = kDeviceHeight-64-_pickerView.height;
        _sendBackImage.bottom = _pickerView.top;
        _sureButton.bottom=_pickerView.top;
        
    }];
    
    [self.dataArray removeAllObjects];
    [_pickerView reloadAllComponents];
    
        if (self.iHttpOperator == nil) {
            self.iHttpOperator = [[HttpOperator alloc]init];
            
        }
        [self.iHttpOperator cancel];
        
        __weak HttpOperator * assginHtttperator = _iHttpOperator;
        __weak StudentCertifyController * this = self;
        [self.iHttpOperator connetStart:^(int d) {
            
        } cancel:^(int d) {
            
        } error:^(int d, THttpOperatorErrorCode error) {
            
            if (error == EHttp_Operator_Failed) {
                //服务器挂了
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alterView show];
              //  _sureButton.userInteractionEnabled=NO;
            }
            
        } param:^(NSString *s) {
            AppCertificationManager *_activityM = (AppCertificationManager *)[assginHtttperator getAopInstance:[AppCertificationManager class] returnValue:[NSSkyArray class]];
            
          
            if (button.tag==1001) {
                this.style = QCProvincePickerView;
//                if (self.display==nil) {
//                    [_cityView setTitle:nil forState:UIControlStateNormal];
//                    [_areaView setTitle:nil forState:UIControlStateNormal];
//                    [_schlloView setTitle:nil forState:UIControlStateNormal];
//                }

                
                QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
                NSString *userToken = userModel.user.yxbToken;
                if ((userToken != nil) && [userToken length] > 0)
                {
                    
                    [_activityM getStudentProvince:userToken];
                    
                    
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                    [self hidePickerView];
                }
              
                
            }
            
            if (button.tag==1002) {
                this.style = QCCityPickerView;
                if (_provinceButton.titleLabel.text!=nil) {
                      [_activityM getStudentCity:_province];
                    
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请先选择省" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                    [self hidePickerView];
                }
                
                
            }
            if (button.tag==1003) {
                this.style = QCAreaPickerView;

                if (_cityButton.titleLabel.text!=nil) {
                [_activityM getStudentDistrict:_province cityType:_city];
                    
                }
 
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请先选择市" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                    [self hidePickerView];
                   
                }
                
                
            }
            
            if (button.tag==1004) {
                this.style = QCSchoolPickerView;
                if (_areaButton.titleLabel.text!=nil) {
                [_activityM getStudentSchool:_province cityType:_city districtType:_area];
                    
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请先选择区域" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                    [self hidePickerView];

                    
                }
                
                
            }



            
            
        }complete:^(NSSkyArray * r, int taskid) {
            if (r.errCode==0) {
                [this.dataArray removeAllObjects];
                
                [this.dataArray addObject:@"请选择"];
                [this.dataArray addObjectsFromArray:r.iArray];
                
                
                [_pickerView reloadAllComponents];
                
//                StudentCerSelect *cer = this.dataArray[0];
//                NSString *selectTypeID=cer.selectTypeID;
//                NSString *name=cer.selectDisplayStr;
//                
//                if (button.tag==1001) {
//                    self.province = selectTypeID;
//                    [_provinceButton setTitle:name forState:UIControlStateNormal];
//                    [_cityButton setTitle:nil forState:UIControlStateNormal];
//                    _cityButton.titleLabel.text=nil;
//                    [_areaButton setTitle:nil forState:UIControlStateNormal];
//                    _areaButton.titleLabel.text=nil;
//                    [_schlloButton setTitle:nil forState:UIControlStateNormal];
//                    _schlloButton.titleLabel.text=nil;
//                }else if (button.tag == 1002) {
//                    self.city = selectTypeID;
//                    [_cityButton setTitle:name forState:UIControlStateNormal];
//                    [_areaButton setTitle:nil forState:UIControlStateNormal];
//                    _areaButton.titleLabel.text=nil;
//                    [_schlloButton setTitle:nil forState:UIControlStateNormal];
//                    _schlloButton.titleLabel.text=nil;
//                }else if (button.tag==1003) {
//                    self.area = selectTypeID;
//                    [_areaButton setTitle:name forState:UIControlStateNormal];
//                    [_schlloButton setTitle:nil forState:UIControlStateNormal];
//                    _schlloButton.titleLabel.text=nil;
//                    
//                    
//                }
//                else if (button.tag==1004){
//                    self.school=selectTypeID;
//                    [_schlloButton setTitle:name forState:UIControlStateNormal];
//                    StudentCerSelect *cer = [r.iArray firstObject];
//                    _schoolName = cer.selectDisplayStr;
//                }
//
            }
           
            
      }];
    
        [self.iHttpOperator connect];
   
}
- (void)sureAction{
    if (self.dataArray.count!=0) {
        NSInteger row=[_pickerView selectedRowInComponent:0];
        NSString *value=[_dataArray objectAtIndex:row];
        
        if ([value isEqual:@"请选择"]) {
            [YXBTool showAlertViewWithString:@"请选择对应的数据"];
        }
        else{
            
            [self hidePickerView];
        }

        
    }
   }

#pragma mark -pickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;

}
- (void)textViewDidBeginEditing:(UITextView *)textView{

    [self hidePickerView];
}

- (void)hidePickerView {
    [UIView animateWithDuration:.3 animations:^{
        
        _pickerView.top = kDeviceHeight-64+_sendBackImage.height;
        _sendBackImage.bottom = _pickerView.top;
        _sureButton.bottom=_pickerView.top;
    }];
}

//#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row==0) {
        return @"请选择";
    }
    else{
    StudentCerSelect *cer = self.dataArray[row];
    return cer.selectDisplayStr;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row==0) {
        return;
    }
    else{
    StudentCerSelect *cer = self.dataArray[row];
    _display = cer.selectDisplayStr;
    NSString *selectTypeID=cer.selectTypeID;
    if (self.style == QCProvincePickerView) {
        [_provinceButton setTitle:_display forState:UIControlStateNormal];
        [_cityButton setTitle:nil forState:UIControlStateNormal];
        [_areaButton setTitle:nil forState:UIControlStateNormal];
        [_schlloButton setTitle:nil forState:UIControlStateNormal];
        
        self.province = selectTypeID;
    }else if (self.style == QCCityPickerView) {
        [_cityButton setTitle:_display forState:UIControlStateNormal];
        [_areaButton setTitle:nil forState:UIControlStateNormal];
        [_schlloButton setTitle:nil forState:UIControlStateNormal];
        
        self.city = selectTypeID;
    }else if (self.style == QCAreaPickerView) {
      [_areaButton setTitle:_display forState:UIControlStateNormal];
        [_schlloButton setTitle:nil forState:UIControlStateNormal];
        self.area = selectTypeID;
        
    }
    else if (self.style==QCSchoolPickerView){
        
        [_schlloButton setTitle:_display forState:UIControlStateNormal];
            _schoolName=_display;
        self.school=selectTypeID;
        
    }
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.view endEditing:YES];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
     [self _isAleadryRegister];
}

@end
