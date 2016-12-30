//
//  WhiteCollarViewController.h
//  YOUXINBAO
//
//  Created by Walice on 15/7/9.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"

#import "HttpOperator.h"
typedef NS_ENUM(NSInteger, QCWhiteCollarStyle){
    QCWProvincePickerView= 0,    //省
    QCWCityPickerView = 1 ,//市
    QCWAreaPickerView =2,//区
    QCWBusinessPickerView=3,//商圈
    QCWOfficeBuildingPickerView //写字楼
};

@interface WhiteCollarViewController : QCBaseViewController<UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UIButton *provinceButton;
@property(nonatomic,strong)UIButton*cityButton;
@property(nonatomic,strong)UIButton *areaButton;
@property(nonatomic,strong)UIButton *businessButton;
@property(nonatomic,strong)UIButton *officeBuildingButton;

@property(nonatomic,strong)UITextField *companyName;
@property(nonatomic,strong)UITextField *companyTel;

@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIScrollView *scrollerView;
@property(nonatomic,strong)UILabel *label2;
//确认,pickerView取消
@property(nonatomic,strong)UIButton * sureButton;
//提交按钮
@property(nonatomic,strong) UIButton * btn;
@property(nonatomic,strong)UIView * sendBackImage;

@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)QCWhiteCollarStyle style;

@end

