//
//  LoanDetailLiXiDetailCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/8/3.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanDetailLiXiDetailCell.h"
#import "QCHomeDataManager.h"
#import "LoanCalculateUtil.h"

@interface LoanDetailLiXiDetailCell ()<UITextFieldDelegate>

@property (nonatomic,strong)UITextField *lixiField;
@property (nonatomic,strong)UILabel     *rateLabel;
@property (nonatomic,strong)UIButton    *lixiBtn;//先息、后息btn
@property (nonatomic,strong)UILabel     *tintLabel;//利息提示label
@property (nonatomic,strong)UILabel     *moneyTintLabel;//打款提示

@end
@implementation LoanDetailLiXiDetailCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    
    return self;
}

-(void)initViews
{
    //输入利息值
    self.lixiField = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, (kDeviceWidth-40)/2.0, 40)];
    _lixiField.backgroundColor = [UIColor whiteColor];
    _lixiField.placeholder = @"请输入利息";
    _lixiField.textAlignment = NSTextAlignmentCenter;
    _lixiField.delegate =self;
    _lixiField.keyboardType =UIKeyboardTypeNumberPad;
    _lixiField.layer.cornerRadius = 3.0;
    _lixiField.layer.borderWidth = 1.0;
    _lixiField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.contentView addSubview:_lixiField];

    //利率显示
    self.rateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_lixiField.right + 10,_lixiField.top, (_lixiField.width - 10)/2.0, _lixiField.height)];
    _rateLabel.textColor = [UIColor grayColor];
    _rateLabel.textAlignment = NSTextAlignmentLeft;
    _rateLabel.font = [UIFont systemFontOfSize:16];
    _rateLabel.adjustsFontSizeToFitWidth = YES;
    _rateLabel.minimumScaleFactor = 8.0/_rateLabel.font.pointSize;
    [self.contentView addSubview:_rateLabel];
    
    //固定文字
    UILabel *banklabel = [[UILabel alloc]initWithFrame:CGRectMake(_rateLabel.right, _rateLabel.top, _rateLabel.width, _rateLabel.height)];
    banklabel.textColor = rgb(74, 74, 74, 1);
    banklabel.textAlignment = NSTextAlignmentRight;
    banklabel.font = [UIFont systemFontOfSize:16];
    banklabel.text = @"年化利率";
    [self.contentView addSubview:banklabel];
    
    //添加银行利息  利息取整说明文字
    
    self.tintLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _lixiField.bottom+10, kDeviceWidth-40, 12)];
    //    introLabel.textColor = rgb(221, 101, 115, 1.0);
    _tintLabel.textColor = [UIColor grayColor];
    _tintLabel.textAlignment = NSTextAlignmentCenter;
    _tintLabel.font = [UIFont systemFontOfSize:14];
    _tintLabel.text = @"利息取整,只进不舍。例:应付1.01元,实付2元。";
    _tintLabel.adjustsFontSizeToFitWidth = YES;
    _tintLabel.minimumScaleFactor = 8.0/_tintLabel.font.pointSize;
    [self.contentView addSubview:_tintLabel];
    
    
    //添加扣息方式
    //固定文字
    UILabel *kouxilabel = [[UILabel alloc]initWithFrame:CGRectMake(20, _tintLabel.bottom + 10, 100, _rateLabel.height)];
    kouxilabel.textColor = rgb(74, 74, 74, 1);
    kouxilabel.textAlignment = NSTextAlignmentLeft;
    kouxilabel.font = [UIFont systemFontOfSize:16];
    kouxilabel.text = @"扣息方式";
    [self.contentView addSubview:kouxilabel];

    //先息  后息
    //先息后息 设置
    UIImage * imageON = [UIImage imageNamed:@"xianxi.png"];
    UIImage * imageOff = [UIImage imageNamed:@"houxi.png"];

    self.lixiBtn = [[UIButton alloc]initWithFrame:CGRectMake(kDeviceWidth-20-imageON.size.width, _tintLabel.bottom + 15, imageON.size.width, imageON.size.height)];
    [_lixiBtn setImage:imageON forState:UIControlStateSelected];
    [_lixiBtn setImage:imageOff forState:UIControlStateNormal];
    _lixiBtn.selected = NO;
    [_lixiBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_lixiBtn];
//    //添加打款提示label
//    self.moneyTintLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kouXiFangShiSwitch.bottom, kDeviceWidth-40, 30)];
//    tintLabel.hidden = YES;
//    tintLabel.font = [UIFont systemFontOfSize:14.0];
//    tintLabel.textAlignment = NSTextAlignmentRight;
//    moneyLendLabel = tintLabel;

    
}

-(void)buttonAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.loan.interestType = LoanInterestTypePre;
    }
    else
    {
        self.loan.interestType = LoanInterestTypePost;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(updateLoanDetailWithLoan:)]) {
        [_delegate updateLoanDetailWithLoan:self.loan];
    }
}

-(void)setLoan:(Loan *)loan
{
    _loan = loan;
    
    /*
    LoanInterestCalculateType iType = [_loan loanInterestCalculateType];
    if (iType == LoanInterestCalculateTypeBank) {
        _lixiField.userInteractionEnabled = NO;
        NSString *rate = [QCHomeDataManager sharedInstance].annualPercentageRate;
        _rateLabel.text = [NSString stringWithFormat:@"%@%%",rate];
    }
    else
    {
        _lixiField.userInteractionEnabled = YES;
        _rateLabel.text = @"利率";
    }
    */
    
    if (_loan.useBankRate == 1) {
        NSString *rate = [QCHomeDataManager sharedInstance].annualPercentageRate;
        NSInteger lixi = [LoanCalculateUtil interestWithMoney:[_loan.money integerValue] timelong:_loan.loanPeriod rate:[rate floatValue]/100];
        _lixiField.text = [NSString stringWithFormat:@"%ld",(long)lixi];

    }
    else
    {
        _lixiField.text = _loan.interest;
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.loan.interest = textField.text;
    if (_delegate && [_delegate respondsToSelector:@selector(updateLoanDetailWithLoan:)]) {
        [_delegate updateLoanDetailWithLoan:self.loan];
    }

}

@end
