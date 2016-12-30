//
//  LIXiCell.m
//  YOUXINBAO
//
//  Created by Feili on 16/1/28.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LIXiCell.h"
#import "YXBTool.h"
#import "UIAlertView+Block.h"

@interface LIXiCell ()<UITextFieldDelegate>
{
    UILabel *rightYuanLabel;
    NSString *rateInput;//用户输入的利息值
}
@property (nonatomic,strong)UISwitch *openSwitch;
@property (nonatomic,strong)UISegmentedControl *segmentControl;
@property (nonatomic,strong)UITextField *textFieldLiXi;
@property (nonatomic,strong)UITextField *textFieldJine;
@property (nonatomic,assign)NSInteger   numberOfPoint;  //小数点个数

@property (nonatomic,assign)BOOL IsSetFirstResponder;//是否设为第一响应

@end

@implementation LIXiCell

-(void)initViews
{
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    leftLabel.text = @"    利息";
    //    leftLabel.backgroundColor = [UIColor brownColor];
    leftLabel.font = [UIFont systemFontOfSize:JieKuanBaseFontSize];
 //    leftLabel.textColor = kRGB(91, 91, 91);
    [self.contentView addSubview:leftLabel];
    
    [self initSwitch];
    
    [self initSegmentControl];
    
    [self addTwoTextField];
    
}

-(void)initSwitch
{
    self.openSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(kDeviceWidth-95, 4, 0, 0)];
    [_openSwitch addTarget:self action:@selector(openSwitch:) forControlEvents:UIControlEventValueChanged];
    
    
    [self.contentView addSubview:_openSwitch];
}




-(void)updateAction
{
    YXBInterestType type = [self getYXBInterestType];
    YXBUseBankRate userBankRate = [self getIfUseBankRate];
    NSString *jine = _textFieldJine.text;
    NSString *lixi = _textFieldLiXi.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateHuanKuanInterestType:userBankRate:interest:rate:)]) {
        [self.delegate updateHuanKuanInterestType:type userBankRate:userBankRate interest:jine rate:lixi];
    }
    
}

-(void)openSwitch:(UISwitch *)openSwitch
{
    [self hiddenBottomOrNot];
    [self updateAction];
    
}

-(void)initSegmentControl
{
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"银行参考利息",@"自定义", nil]];
    _segmentControl.hidden = YES;
    _segmentControl.frame = CGRectMake(15,44,kDeviceWidth - 60,30);
    _segmentControl.selectedSegmentIndex = 1;
    _segmentControl.layer.cornerRadius = 5.0;
    _segmentControl.backgroundColor = [UIColor whiteColor];
    _segmentControl.tintColor = rgb(221, 39, 39, 1.0);
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0],NSFontAttributeName ,nil];
    
    [_segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    [self.contentView addSubview:_segmentControl];
    
}
//银行息 自定义 事件
-(void)segmentAction:(UISegmentedControl *)Seg
{
    [self addValueToTwoTextfieldWithSelectedIndex];
    if (Seg.selectedSegmentIndex == 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_textFieldJine becomeFirstResponder];
            
        });
        
        YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
        _textFieldLiXi.text = @"0.0";
        loan.interest = @"0";
        _textFieldJine.text = @"";
        

    }
    [self updateAction];
    
}

-(void)addValueToTwoTextfieldWithSelectedIndex
{
    YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
    NSInteger index = _segmentControl.selectedSegmentIndex;
    if (index == 0) {
//        _textFieldLiXi.userInteractionEnabled = NO;
//        _textFieldJine.userInteractionEnabled = NO;
        _textFieldLiXi.text = YXBBankRate;
        NSInteger lixi = [YXBTool lixiWithMoney:[loan.money integerValue] timeInterval:[loan.duration integerValue] yearRate:[YXBBankRate floatValue]];
        _textFieldJine.text = [@(lixi) stringValue];
        
    }
    else
    {
        
//        _textFieldLiXi.userInteractionEnabled = YES;
//        _textFieldJine.userInteractionEnabled = YES;
        
    }
    
}

-(void)addTwoTextField
{
#define fontSize 14.0
    CGFloat x = 15, y = _segmentControl.bottom + 11,w = (kDeviceWidth-60)/2.0, h = 20;
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 60, h)];
    [self.contentView addSubview:leftLabel];
    leftLabel.text = @"年化利率:";
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.font = [UIFont systemFontOfSize:fontSize];
    CGSize size = [YXBTool getFontSizeWithString:leftLabel.text font:leftLabel.font constrainSize:CGSizeMake(NSIntegerMax, NSIntegerMax)];
    leftLabel.width = size.width;
    leftLabel.textColor = [UIColor blackColor];
    
    self.textFieldLiXi = [[UITextField alloc] initWithFrame:ccr(leftLabel.right, y-5, w - leftLabel.width - 10, h+10)];
    _textFieldLiXi.textAlignment = NSTextAlignmentRight;
    _textFieldLiXi.keyboardType = UIKeyboardTypeDecimalPad;
    _textFieldLiXi.hidden = YES;
    _textFieldLiXi.delegate = self;
    _textFieldLiXi.text = @"0.0";
    _textFieldLiXi.textAlignment = NSTextAlignmentCenter;
    _textFieldLiXi.font = [UIFont systemFontOfSize:fontSize];
    _textFieldLiXi.borderStyle = UITextBorderStyleRoundedRect;
    [_textFieldLiXi setAdjustsFontSizeToFitWidth:YES];
    [self.contentView addSubview:_textFieldLiXi];
    

    
    //添加 %
    UILabel *leftLabelRight = [[UILabel alloc] initWithFrame:CGRectMake(_textFieldLiXi.right, y, 10, h)];
    [self.contentView addSubview:leftLabelRight];
    leftLabelRight.text = @"%";
    leftLabelRight.font = [UIFont systemFontOfSize:fontSize];
    CGSize rsize = [YXBTool getFontSizeWithString:leftLabelRight.text font:leftLabelRight.font constrainSize:CGSizeMake(NSIntegerMax, NSIntegerMax)];
    leftLabelRight.width = rsize.width;
    leftLabelRight.textColor = [UIColor blackColor];
    
    
    //添加金额
    
    x = (kDeviceWidth-60)/2.0;
    x = leftLabelRight.right;
    w = (kDeviceWidth-60)/2.0;
    
    self.textFieldJine = [[UITextField alloc] initWithFrame:ccr(x, y - 5, w-15, h + 10)];
    _textFieldJine.textAlignment = NSTextAlignmentRight;
    _textFieldJine.keyboardType = UIKeyboardTypeNumberPad;
    _textFieldJine.delegate = self;
    _textFieldJine.hidden = YES;
    _textFieldJine.textColor = [YXBTool colorWithHexString:@"#ed2e24"];
    _textFieldJine.font = [UIFont boldSystemFontOfSize:22];
    [_textFieldJine setAdjustsFontSizeToFitWidth:YES];
    [self.contentView addSubview:_textFieldJine];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(_textFieldJine.right, y, 15, h)];
    rightLabel.text = @"元";
    rightLabel.font = [UIFont systemFontOfSize:fontSize];
    rightLabel.hidden = YES;
    rightLabel.textColor = [UIColor blackColor];
    rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:rightLabel];
    
    rightYuanLabel = rightLabel;
    
}



-(YXBInterestType)getYXBInterestType
{
    YXBInterestType type = YXBInterestTypeNO; //默认无息
    if (_openSwitch.on == YES) {
        type = YXBInterestTypeYES;
    }
    
    return type;
    
}

-(YXBUseBankRate)getIfUseBankRate
{
    YXBUseBankRate useBankRate = YXBUseBankRateYES;
    if (_segmentControl.selectedSegmentIndex == 1) {
        useBankRate = YXBUseBankRateNO;
    }
    
    return useBankRate;
    
}

-(void)hiddenBottomOrNot
{
    if (_openSwitch.on == NO) {
        _segmentControl.hidden = YES;
        _textFieldLiXi.hidden = YES;
        _textFieldJine.hidden = YES;
        rightYuanLabel.hidden = YES;
        
        YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
        _textFieldLiXi.text = @"0.0";
        loan.interest = @"0";
        _textFieldJine.text = @"0";
        loan.useBankRate = YXBUseBankRateNO;
        _segmentControl.selectedSegmentIndex = 1;
        
        
    }
    else
    {
        
        _segmentControl.hidden = NO;
        _textFieldLiXi.hidden = NO;
        _textFieldJine.hidden = NO;
        rightYuanLabel.hidden = NO;
        
        
    }
}

-(void)setLoan:(YXBLoan *)loan
{
    YXBInterestType interestType = loan.interestType;
    _textFieldJine.text = loan.interest;
    
    if (interestType == YXBInterestTypeYES) {
        _openSwitch.on = YES;
        [self hiddenBottomOrNot];
        if (loan.useBankRate == YXBUseBankRateNO) {
            _segmentControl.selectedSegmentIndex = 1;
            _textFieldJine.borderStyle = UITextBorderStyleRoundedRect ;
            _textFieldLiXi.borderStyle = UITextBorderStyleRoundedRect ;
            CGFloat lilv = [YXBTool lilvWithMoney:[loan.money integerValue] timeInterval:[loan.duration integerValue] lixi:[loan.interest integerValue]];
            NSString *lilvStr = [NSString stringWithFormat:@"%.1f",lilv];
            _textFieldLiXi.text = lilvStr;
            if (self.delegate && [self.delegate respondsToSelector:@selector(updateHuanKuanRate:)]) {
                [self.delegate updateHuanKuanRate:_textFieldLiXi.text];
            }
            
        }
        else
        {
            _textFieldJine.borderStyle = UITextBorderStyleNone;
            _textFieldLiXi.borderStyle = UITextBorderStyleNone;
            
            
        }
        
    }
    //    [self updateAction];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _IsSetFirstResponder = YES;
    
    if (textField == _textFieldJine) {
        if ([_textFieldJine.text isEqualToString:@"0"]) {
            _textFieldJine.text = @"";
        }
    }
    else
    {
        if ([_textFieldLiXi.text isEqualToString:@"0.0"]) {
            _textFieldLiXi.text = @"";
        }
        
    }
    [super textFieldDidBeginEditing:textField];
    if (self.delegate && [self.delegate respondsToSelector:@selector(jiekuanBeginEditIsMoveKeyBoard:)]) {
        [self.delegate jiekuanBeginEditIsMoveKeyBoard:YES];
    }
    //    [self setOneEditable:textField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",textField.text];
    [str replaceCharactersInRange:range withString:string];
    
    if (textField == _textFieldLiXi) {
        
        rateInput = str;
        NSInteger lixi = [YXBTool lixiWithMoney:[loan.money integerValue] timeInterval:[loan.duration integerValue] yearRate:[str floatValue]];
        _textFieldJine.text = [@(lixi) stringValue];
        
    }
    else if (textField == _textFieldJine){
        
        BOOL willContinue = [self checkLiXiJinEWithTextField:textField shouldChangeCharactersInRange:range replacementString:string];
        if (willContinue == NO) {
            return willContinue;
        }
        
        CGFloat lilv = [YXBTool lilvWithMoney:[loan.money integerValue] timeInterval:[loan.duration integerValue] lixi:[str integerValue]];
        
        
        _textFieldLiXi.text = [NSString stringWithFormat:@"%.1f",lilv];
        
    }
    
    
    return YES;
}

-(BOOL)checkLiXiJinEWithTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    //禁止用户输入字母
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    for (int i = 0; i < [string length]; i++) {
        unichar c = [string characterAtIndex:i];
        if (![myCharSet characterIsMember:c]) {
            return NO;
        }
    }
    
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",textField.text];
    [str replaceCharactersInRange:range withString:string];
    
    if ([string isEqualToString:@"0"] && [str integerValue] == 0) {
        return NO;
    }
    
    if (textField == _textFieldLiXi) {
        NSInteger flag=0;
        const NSInteger limited = 2;
        if (![textField.text containsString:@"."]){
            _numberOfPoint = 0;
        }else if(0 == _numberOfPoint){
            _numberOfPoint = 1;
        }
        
        //1、如果text field中没有字符，且输入的字符位 ‘.’，则自动填充 ‘0’
        if (textField.text.length < 1 && [string isEqualToString:@"."]) {
            textField.text = @"0";
            _numberOfPoint ++;
            return YES;
        }else if(0 == textField.text.length && [string isEqualToString:@"0"]) {
            textField.text = @"0.";
            _numberOfPoint ++;
            return NO;
        }else {
            //只能有一个小数点
            if (_numberOfPoint > 0 && [string isEqualToString:@"."]) {
                return NO;
            }
            if (_numberOfPoint == 0 && [string isEqualToString:@"."]) {
                _numberOfPoint ++;
            }
            
            if (range.location >= str.length - 3) {
                //从后往前遍历字符串flag用于记录小数点后的数字位数
                for (int i = (int)str.length-1 ; i>=0; i--) {
                    if ([str characterAtIndex:i] == '.') {
                        if (flag > limited) {
                            //回收键盘
                            _IsSetFirstResponder = NO;
                            [textField resignFirstResponder];
                            return NO;
                        }
                        break;
                    }
                    flag++;
                }
            }
        }
        
        NSArray *baoliuWei = [str componentsSeparatedByString:@"."];
        if ([baoliuWei count] > 1) {
            if ([baoliuWei[1] length] == 2) {
                return NO;
            }
        }
        
        
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //刷新
    YXBLoan *loan = [JieKuanInstance shareInstance].yxbLoan;
    
    [self updateAction];
    
    [self performSelector:@selector(hideKeyboard:) withObject:textField afterDelay:0.2f];
    
//    __weak typeof(self)weakSelf = self;
//    dispatch_group_t UpdateGroup = dispatch_group_create();
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
//    dispatch_group_async(UpdateGroup, mainQueue, ^{
//        [self updateAction];
//    });
//    dispatch_group_notify(UpdateGroup, mainQueue, ^{
//        if (_IsSetFirstResponder) {
//            NSLog(@"设置第一响应者");
//            if (textField == weakSelf.textFieldJine) {
//                [weakSelf.textFieldJine becomeFirstResponder];
//            }
//            else
//                [weakSelf.textFieldLiXi becomeFirstResponder];
//        }
//    });
//    dispatch_release(UpdateGroup);

    
    if (!_IsSetFirstResponder) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(jiekuanEndEdit)]) {
            [self.delegate jiekuanEndEdit];
        }

    }
        if (textField == self.textFieldLiXi) {
        CGFloat lilv = [YXBTool lilvWithMoney:[loan.money integerValue] timeInterval:[loan.duration integerValue] lixi:[loan.interest integerValue]];
        NSString *lilvStr = [NSString stringWithFormat:@"%.1f",lilv];
        if (rateInput != nil && [rateInput floatValue] > 0) {
            [self showAlertWithDiffRateOne:rateInput rateTwo:lilvStr];
            
        }
        
        
    }
    else
    {
        NSInteger lixiMoney = [textField.text integerValue];
        if (lixiMoney != 0) {
            loan.interest = [NSString stringWithFormat:@"%ld",(long)lixiMoney];
            textField.text = loan.interest;
        }
    }
    
}

-(void)setOneEditable:(UITextField *)textfield
{
    if (textfield == self.textFieldLiXi) {
//        self.textFieldJine.userInteractionEnabled = NO;
    }
    else
    {
//        self.textFieldLiXi.userInteractionEnabled = NO;
    }
}



-(void)hideKeyboard:(UITextField *)textfield
{
    if (_segmentControl.selectedSegmentIndex == 1) {
        _IsSetFirstResponder = NO;
    }
    
    if (_IsSetFirstResponder) {
        if (textfield == _textFieldJine) {
            [_textFieldLiXi becomeFirstResponder];
        }
        else
            [_textFieldJine becomeFirstResponder];
    }
    
    
//    self.buttonJine.hidden = YES;
//    self.buttonLiXi.hidden = YES;
//    [self.textFieldLiXi resignFirstResponder];
//    [self.textFieldJine resignFirstResponder];
}


-(void)keyBtnAction:(UIButton *)sender
{
    _IsSetFirstResponder = NO;
    [self.textFieldLiXi resignFirstResponder];
    [self.textFieldJine resignFirstResponder];
    
    
    
}


-(void)layoutSubviews
{
    [self addValueToTwoTextfieldWithSelectedIndex];
    [super layoutSubviews];
    
}

-(BOOL)isTextFieldEdit
{
    if (_textFieldJine.isFirstResponder || _textFieldLiXi.isFirstResponder) {
        return YES;
    }
    return NO;
}

-(void)showAlertWithDiffRateOne:(NSString *)rate1 rateTwo:(NSString *)rate2
{
    
    if ([rate1 floatValue] != [rate2 floatValue]) {
//        [self.textFieldLiXi resignFirstResponder];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //            [YXBTool showAlertViewWithString:@"当借款周期短或借款额度小点击完成时，会显示利率有变动，但是实际利息额度不变，是因为利率取整数不精确到角分，属于正常情况！"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"当借款周期短或借款额度小点击完成时，会显示利率有变动，但是实际利息额度不变，是因为利率取整数不精确到角分，属于正常情况！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        });
        
        rateInput = nil;
    }
}

@end
