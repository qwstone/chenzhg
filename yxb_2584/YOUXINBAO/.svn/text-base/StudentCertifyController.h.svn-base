//
//  StudentCertifyController.h
//  YOUXINBAO
//
//  Created by Walice on 15/6/4.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCBaseViewController.h"
#import "HttpOperator.h"
typedef NS_ENUM(NSInteger, QCPickerViewStyle){
    QCProvincePickerView= 0,    //系统通知
    QCCityPickerView = 1 ,//我的消息
    QCAreaPickerView =2,
    QCSchoolPickerView=3
};

@interface StudentCertifyController : QCBaseViewController<UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UIButton *provinceButton;
@property(nonatomic,strong)UIButton*cityButton;
@property(nonatomic,strong)UIButton *areaButton;
@property(nonatomic,strong)UIButton *schlloButton;

@property(nonatomic,strong)UITextField *numField;
@property(nonatomic,strong)UITextField *dormitoryView;

@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIScrollView *scrollerView;
@property(nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UIView * sendBackImage;
@property(nonatomic,strong)UIButton * sureButton;
@property(nonatomic,strong) UIButton * btn;


@property (retain, nonatomic) HttpOperator* iHttpOperator;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)QCPickerViewStyle style;
@property(nonatomic,assign)BOOL isFirst;
@end
