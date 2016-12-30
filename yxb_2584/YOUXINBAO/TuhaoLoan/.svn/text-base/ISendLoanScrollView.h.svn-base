//
//  ISendLoanScrollView.h
//  YOUXINBAO
//
//  Created by zjp on 15/4/28.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISendPickerView.h"
#import "ISendViewBg.h"
#import "CustomIOSAlertView.h"
#import "CreateBlankNote.h"
@protocol ISendScrollViewDelegate <NSObject>

- (void)ISendScrollViewzuotuhao:(CreateBlankNote *)noteList;

@end
@interface ISendLoanScrollView : UIScrollView<UIScrollViewDelegate,ISendPickerViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,CustomIOSAlertViewDelegate> {

    ISendPickerView *_visiblePicker;
    NSArray             *arr1;
    NSArray             *arr2;
    NSArray             *arr3;
    NSArray             *arr2to;
    NSArray             *arr3to;
    
    NSMutableAttributedString *strLabel;
    
    UIView              *_pivkerWindow;
    NSInteger           _numbers;

}


@property (nonatomic, assign) id <ISendScrollViewDelegate>tuhaoDelegate;

@property(nonatomic,strong)UILabel      *MyallZiJinText;
@property(nonatomic,strong)UILabel      *loanMoneypicklabel;
@property(nonatomic,strong)UITextField  *loanField;
@property(nonatomic,strong)UIButton     *selectBut;
@property(nonatomic,strong)UILabel      *loanTimePickLabel;
@property(nonatomic,strong)UILabel      *loanRatePickLabel;
@property(nonatomic,strong)UILabel      *MonthMoney;//每月收款金额
@property(nonatomic,strong)UILabel      *Prompt;//提示
@property(nonatomic,strong)UILabel      *loanPlan;
@property(nonatomic,strong)UIButton     *zuotuhao;

@property(nonatomic,copy)NSString      *timeToLoan;
@property(nonatomic,copy)NSString      *lilvToLoan;

@property(nonatomic,copy)NSString      *dingOrFen;//全额或分期
@property(nonatomic,assign)NSInteger           repaymentType;//还款方式

@property (nonatomic,assign)double   remainMoney;    /** 账号金额 初始值为0 */


@end
