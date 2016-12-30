//
//  WhiteCollarViewController.m
//  YOUXINBAO
//
//  Created by Walice on 15/7/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "WhiteCollarViewController.h"
#import "AppCertificationManager.h"
#import "WhiteCollarCerSelect.h"
#import "YXBTool.h"

@interface WhiteCollarViewController ()
//保存点击pickerView的selelctType
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *area;
@property (nonatomic,copy) NSString *business;


@property(nonatomic,copy) NSString *display;
//保存写字楼名称
@property(nonatomic,copy)NSString *office;
//保存写字楼id
@property(nonatomic,copy)NSString *officebuilding;
//公司名称
@property(nonatomic,copy)NSString *companyname;
@property(nonatomic,copy)NSString *companytel;

@end

@implementation WhiteCollarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationButtonItrmWithiamge:@"navigation_abck_.png" withRightOrleft:@"left" withtargrt:self withAction:@selector(leftClicked)];
    _dataArray=[NSMutableArray array];
    self.view.backgroundColor = rgb(238, 236, 246, 1.0);
    self.title=@"白领认证";
    [self _initViews];
   // [self _isAleadryRegister];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self _isAleadryRegister];

}
- (void)_isAleadryRegister{
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak WhiteCollarViewController * this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
        }
        
    } param:^(NSString *s) {
        AppCertificationManager *_activityM = (AppCertificationManager *)[assginHtttperator getAopInstance:[AppCertificationManager class] returnValue:[WhiteCollarCerInfo class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        NSString *userToken = userModel.user.yxbToken;
        NSInteger status = userModel.user.whiteCollarStatus;
        if ((userToken != nil) && [userToken length] > 0 && status==2)
        {
            
            [_activityM getWhiteCollarCerInfo:userToken];
            _btn.hidden=YES;
            
            
            
        }
        
        
    }complete:^(WhiteCollarCerInfo * r, int taskid) {
        if (r.errCode==0) {
            [this.provinceButton setTitle:r.provinceName forState:UIControlStateNormal];
            this.provinceButton.userInteractionEnabled=NO;
            [this.cityButton setTitle:r.cityName forState:UIControlStateNormal];
            this.cityButton.userInteractionEnabled=NO;
            [this.areaButton setTitle:r.districtName forState:UIControlStateNormal];
            this.areaButton.userInteractionEnabled=NO;
            [this.businessButton setTitle:r.businessAreaName forState:UIControlStateNormal];
            this.businessButton.userInteractionEnabled=NO;
            [this.officeBuildingButton setTitle:r.officeBuildingName forState:UIControlStateNormal];
            this.officeBuildingButton.userInteractionEnabled=NO;
            
            this.companyName.text=r.companyName;
            this.companyName.userInteractionEnabled=NO;
            this.companyTel.text=r.companyPhone;
            this.companyTel.userInteractionEnabled=NO;
        }
        
    }];
    
    [self.iHttpOperator connect];
    
}

- (void)_initViews{
    
    _scrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-64)];
    _scrollerView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight);
    [self.view addSubview:_scrollerView];
    //提示
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 170, 20)];
    label.text=@"目前仅支持列表内商圈";
    label.textColor=[UIColor redColor];
    label.font=[UIFont systemFontOfSize:15];
    label.textAlignment=NSTextAlignmentLeft;
    [_scrollerView addSubview:label];

    //整个的view
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 30, kDeviceWidth, 260)];
    view.backgroundColor=[UIColor whiteColor];
    [_scrollerView addSubview:view];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(10, view.bottom+20, kDeviceWidth-20, 46);
    [_btn addTarget:self action:@selector(indentAction) forControlEvents:UIControlEventTouchUpInside];
    [_btn setBackgroundImage:[UIImage imageNamed:@"blue-but2.png"] forState:UIControlStateNormal];
    [_btn setTitle:@"确认提交" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_scrollerView addSubview:_btn];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 3, 60, 20)];
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
    
    //商圈
    UILabel *schoolLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 75, 40, 20)];
    schoolLabel.text=@"商圈:";
    [view addSubview:schoolLabel];
    _businessButton=[[UIButton alloc]initWithFrame:CGRectMake(50, 70, kDeviceWidth-50, 40)];
    [_businessButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_businessButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _businessButton.tag=1004;
    [view addSubview:_businessButton];
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(18, 111, kDeviceWidth-18, 1)];
    line2.backgroundColor=rgb(220, 220, 220, 1);
    [view addSubview:line2];
    
    //写字楼
    UILabel *officeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 125, 80, 20)];
    officeLabel.text=@"写字楼:";
    [view addSubview:officeLabel];
    _officeBuildingButton=[[UIButton alloc]initWithFrame:CGRectMake(50, 120, kDeviceWidth-50, 40)];
    [_officeBuildingButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_officeBuildingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _officeBuildingButton.tag=1005;
    [view addSubview:_officeBuildingButton];
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(18, 161, kDeviceWidth-18, 1)];
    line3.backgroundColor=rgb(220, 220, 220, 1);
    [view addSubview:line3];
    
    //公司名称
    UILabel *officeNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 175, 120, 20)];
    officeNameLabel.text=@"公司名称:";
    [view addSubview:officeNameLabel];
    _companyName=[[UITextField alloc]initWithFrame:CGRectMake(90, 170, kDeviceWidth-80, 30)];
    _companyName.delegate=self;
    _companyName.returnKeyType=UIReturnKeyDone;
    [view addSubview:_companyName];
    UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(18, 211, kDeviceWidth-18, 1)];
    line4.backgroundColor=rgb(220, 220, 220, 1);
    [view addSubview:line4];

    //公司联系方式
    UILabel *officeTelLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 225, 160, 20)];
    officeTelLabel.text=@"公司联系方式:";
    [view addSubview:officeTelLabel];
    _companyTel=[[UITextField alloc]initWithFrame:CGRectMake(120, 220, kDeviceWidth-115, 30)];
    _companyTel.returnKeyType = UIReturnKeyDone;
    _companyTel.delegate=self;
    [view addSubview:_companyTel];
    UIView *line5=[[UIView alloc]initWithFrame:CGRectMake(18, 261, kDeviceWidth-18, 1)];
    line5.backgroundColor=rgb(220, 220, 220, 1);
    [view addSubview:line5];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}


- (void)keyboardShow1{
    
    [self.view endEditing:YES];
    
}
- (void)indentAction{
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak WhiteCollarViewController * this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
        }
        
        
    } param:^(NSString *s) {
        AppCertificationManager *_activityM = (AppCertificationManager *)[assginHtttperator getAopInstance:[AppCertificationManager class] returnValue:[TResultSet class]];
        QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
        
        NSString *userToken = userModel.user.yxbToken;
        if ((userToken != nil) && [userToken length] > 0)
        {
            _companyname=this.companyName.text;
            _companytel=this.companyTel.text;
            if (![_companyname isEqualToString:@""] & ![_companytel isEqualToString:@""] & ![_provinceButton.titleLabel.text isEqualToString:@""] & ![_cityButton.titleLabel.text isEqualToString:@""] & ![_areaButton.titleLabel.text isEqualToString:@""] & ![_businessButton.titleLabel.text isEqualToString:@""]&![_officeBuildingButton.titleLabel.text isEqualToString:@""]) {
                


                [_activityM getWhiteCollarSubmit:_office officeBuildingId:_officebuilding businessAreaName:this.business companyName:_companyname companyPhone:_companytel userToken:userToken];
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
            userModel.user.whiteCollarStatus =r.resInteger;
            [[QCUserManager sharedInstance] setLoginUser:userModel];
            
            [this.provinceButton setTitle:this.provinceButton.titleLabel.text forState:UIControlStateNormal];
            this.provinceButton.userInteractionEnabled=NO;
            [this.cityButton setTitle:this.cityButton.titleLabel.text forState:UIControlStateNormal];
            this.cityButton.userInteractionEnabled=NO;
            [this.areaButton setTitle:this.areaButton.titleLabel.text forState:UIControlStateNormal];
            this.areaButton.userInteractionEnabled=NO;
            [this.businessButton setTitle:this.businessButton.titleLabel.text forState:UIControlStateNormal];
            this.businessButton.userInteractionEnabled=NO;
            [this.officeBuildingButton setTitle:this.officeBuildingButton.titleLabel.text forState:UIControlStateNormal];
            this.officeBuildingButton.userInteractionEnabled=NO;
            
            this.companyName.text=this.companyname;
            this.companyName.userInteractionEnabled=NO;
            this.companyTel.text=this.companytel;
            this.companyTel.userInteractionEnabled=NO;
            _btn.hidden=YES;
            [this leftClicked];

           
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
//        [_scrollerView setContentOffset:CGPointMake(0, 20) animated:YES];
//    }
    
    
    [self.view endEditing:YES];
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
        _sureButton.bottom = _pickerView.top;
        _sendBackImage.bottom=_pickerView.top;
        
    }];
    
    [self.dataArray removeAllObjects];
    [_pickerView reloadAllComponents];
    
    if (self.iHttpOperator == nil) {
        self.iHttpOperator = [[HttpOperator alloc]init];
        
    }
    [self.iHttpOperator cancel];
    
    __weak HttpOperator * assginHtttperator = _iHttpOperator;
    __weak WhiteCollarViewController * this = self;
    [self.iHttpOperator connetStart:^(int d) {
        
    } cancel:^(int d) {
        
    } error:^(int d, THttpOperatorErrorCode error) {
        
        if (error == EHttp_Operator_Failed) {
            //服务器挂了
            UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败,请检查手机网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alterView show];
        }
        
    } param:^(NSString *s) {
        AppCertificationManager *_activityM = (AppCertificationManager *)[assginHtttperator getAopInstance:[AppCertificationManager class] returnValue:[NSSkyArray class]];
        
        
        if (button.tag==1001) {
            this.style = QCWProvincePickerView;
            QCUserModel * userModel = [[QCUserManager sharedInstance]getLoginUser];
            NSString *userToken = userModel.user.yxbToken;
            if ((userToken != nil) && [userToken length] > 0)
            {
                
                [_activityM getWhiteCollarProvince:userToken];
                
                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您尚未登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            
            
        }
        
        if (button.tag==1002) {
            this.style = QCWCityPickerView;

            if (_provinceButton.titleLabel.text!=nil) {
                [_activityM getWhiteCollarCity:_province];
                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请先选择省" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                [self hidePickerView];
            }
            
            
        }
        if (button.tag==1003) {
            this.style = QCWAreaPickerView;
            
            if (_cityButton.titleLabel.text!=nil) {
            [_activityM getWhiteCollarDistrict:_province cityType:_city];
                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请先选择市" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                [self hidePickerView];
            }
            
            
        }
        
        if (button.tag==1004) {
            this.style = QCWBusinessPickerView;
            if (_areaButton.titleLabel.text!=nil) {
                [_activityM getWhiteCollarBusinessArea:_province cityType:_city districtType:_area];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请先选择区域" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                [self hidePickerView];
            }
            
            
        }
        
        if (button.tag==1005) {
            this.style = QCWOfficeBuildingPickerView;
//            if ((_business != nil) && [_business length] > 0)
//            {
//                
//                [_activityM getWhiteCollarOfficeBuilding:_province cityType:_city districtType:_area businessArea:_business];
//                
//                
//            }
            if (_businessButton.titleLabel.text!=nil) {
            [_activityM getWhiteCollarOfficeBuilding:_province cityType:_city districtType:_area businessArea:_business];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请先选择商圈" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
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
            
//            WhiteCollarCerSelect *cer = this.dataArray[0];
//            NSString *selectTypeID=cer.selectTypeID;
//            NSString *name=cer.selectDisplayStr;
//            
//            if (button.tag==1001) {
//                self.province = selectTypeID;
//                [_provinceButton setTitle:name forState:UIControlStateNormal];
//                [_cityButton setTitle:nil forState:UIControlStateNormal];
//                _cityButton.titleLabel.text=nil;
//                [_areaButton setTitle:nil forState:UIControlStateNormal];
//                _areaButton.titleLabel.text=nil;
//                [_businessButton setTitle:nil forState:UIControlStateNormal];
//                _businessButton.titleLabel.text=nil;
//                [_officeBuildingButton setTitle:nil forState:UIControlStateNormal];
//                _officeBuildingButton.titleLabel.text=nil;
//            }else if (button.tag == 1002) {
//                self.city = selectTypeID;
//                [_cityButton setTitle:name forState:UIControlStateNormal];
//                [_areaButton setTitle:nil forState:UIControlStateNormal];
//                _areaButton.titleLabel.text=nil;
//                [_businessButton setTitle:nil forState:UIControlStateNormal];
//                _businessButton.titleLabel.text=nil;
//                [_officeBuildingButton setTitle:nil forState:UIControlStateNormal];
//                _officeBuildingButton.titleLabel.text=nil;
//            }else if (button.tag==1003) {
//                self.area = selectTypeID;
//                [_areaButton setTitle:name forState:UIControlStateNormal];
//                [_businessButton setTitle:nil forState:UIControlStateNormal];
//                _businessButton.titleLabel.text=nil;
//                [_officeBuildingButton setTitle:nil forState:UIControlStateNormal];
//                _officeBuildingButton.titleLabel.text=nil;
//                
//                
//            }
//            else if (button.tag==1004){
//                self.business=selectTypeID;
//                [_businessButton setTitle:name forState:UIControlStateNormal];
//                [_officeBuildingButton setTitle:nil forState:UIControlStateNormal];
//                _officeBuildingButton.titleLabel.text=nil;
//            }
//            
//            else if (button.tag==1005){
//                self.officebuilding=selectTypeID;
//                [_officeBuildingButton setTitle:name forState:UIControlStateNormal];
//                WhiteCollarCerSelect *cer = [r.iArray firstObject];
//                _office = cer.selectDisplayStr;
//
//                
//            }
//            
//
//            
//        }
//        else if (r.errCode==7) {
//            [this.dataArray removeAllObjects];
//        }
//        else
//            [ProgressHUD showSuccessWithStatus:@"请求失败"];
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
        
        _pickerView.top = kDeviceHeight-64+_sureButton.height;
        _sureButton.bottom = _pickerView.top;
        _sendBackImage.bottom=_pickerView.top;
    }];
}

//#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row==0) {
        return @"请选择";
    }
    else{
    WhiteCollarCerSelect *cer = self.dataArray[row];
    return cer.selectDisplayStr;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row==0) {
        return;
    }
    else{
    WhiteCollarCerSelect *cer = self.dataArray[row];
    _display = cer.selectDisplayStr;
    NSString *selectTypeID=cer.selectTypeID;
    if (self.style == QCWProvincePickerView) {
        [_provinceButton setTitle:_display forState:UIControlStateNormal];
        [_cityButton setTitle:nil forState:UIControlStateNormal];
        [_areaButton setTitle:nil forState:UIControlStateNormal];
        [_businessButton setTitle:nil forState:UIControlStateNormal];
         [_officeBuildingButton setTitle:nil forState:UIControlStateNormal];
        
        self.province = selectTypeID;
    }else if (self.style == QCWCityPickerView) {
        [_cityButton setTitle:_display forState:UIControlStateNormal];
        [_areaButton setTitle:nil forState:UIControlStateNormal];
        [_businessButton setTitle:nil forState:UIControlStateNormal];
         [_officeBuildingButton setTitle:nil forState:UIControlStateNormal];
        
        self.city = selectTypeID;
    }else if (self.style == QCWAreaPickerView) {
        [_areaButton setTitle:_display forState:UIControlStateNormal];
        [_businessButton setTitle:nil forState:UIControlStateNormal];
         [_officeBuildingButton setTitle:nil forState:UIControlStateNormal];
        self.area = selectTypeID;
        
    }
    else if (self.style==QCWBusinessPickerView){
        
        [_businessButton setTitle:_display forState:UIControlStateNormal];
         [_officeBuildingButton setTitle:nil forState:UIControlStateNormal];
        self.business=selectTypeID;
        
    }
    else if (self.style==QCWOfficeBuildingPickerView){
        
        [_officeBuildingButton setTitle:_display forState:UIControlStateNormal];
        self.officebuilding=selectTypeID;
        self.office=_display;
    }
    
    }
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
