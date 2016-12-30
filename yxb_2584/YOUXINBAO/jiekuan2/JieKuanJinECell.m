//
//  JieKuanJinECell.m
//  YOUXINBAO
//
//  Created by Feili on 16/1/26.
//  Copyright © 2016年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "JieKuanJinECell.h"
#import "YXBTool.h"
#import "CustomTextField.h"


@interface JieKuanJinECell ()<UITextFieldDelegate>
{
    UILabel *leftLabel;
}
@end

@implementation JieKuanJinECell


-(void)initViews
{
    
    leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    leftLabel.text = @"借款金额";
//    leftLabel.backgroundColor = [UIColor brownColor];
    leftLabel.font = [UIFont systemFontOfSize:JieKuanBaseFontSize];
//    leftLabel.textColor = kRGB(91, 91, 91);
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
    rightLabel.font = [UIFont systemFontOfSize:JieKuanBaseFontSize];
    rightLabel.text = @"元";
//    rightLabel.backgroundColor = [UIColor brownColor];

    rightLabel.textAlignment = NSTextAlignmentCenter;
//    rightLabel.textColor = kRGB(91, 91, 91);

    CustomTextField *textField = [[CustomTextField alloc] initWithFrame:CGRectMake(15 ,0, kDeviceWidth - 60, 40)];
    textField.font = [UIFont boldSystemFontOfSize:22];
    if (KDeviceOSVersion < 8.0) {
        textField.font = [UIFont boldSystemFontOfSize:JieKuanBaseFontSize];

    }
    textField.textColor = [YXBTool colorWithHexString:@"#ed2e24"];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.placeholder = @"100~100万";
    textField.leftView = leftLabel;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.rightView = rightLabel;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.textAlignment = NSTextAlignmentRight;
    textField.delegate = self;
    textField.placeHolderFont = [UIFont systemFontOfSize:JieKuanBaseFontSize];
    textField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:textField.placeholder
                                    attributes:@{
                                                 NSFontAttributeName : [UIFont systemFontOfSize:JieKuanBaseFontSize]
                                                 }
     ];
    
    
    [self.contentView addSubview:textField];
//    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    self.textField = textField;
    
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
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

    if ([str integerValue] > 1000000) {
//        [YXBTool showAlertViewWithString:@"借款限额最高 1,000,000元,请重新输入"];
        textField.text = YXBJieKuanMaxMoney;
        return NO;
    }else if ([str integerValue] <= 0)
    {
//        return NO;
    }
    
    
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
        if (self.delegate && [self.delegate respondsToSelector:@selector(updateJieKuanJinEWithMoney:)]) {
            
            [self.delegate updateJieKuanJinEWithMoney:textField.text];

        }
    

}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [super textFieldDidBeginEditing:textField];
    if (self.delegate && [self.delegate respondsToSelector:@selector(jiekuanBeginEditIsMoveKeyBoard:)]) {
        [self.delegate jiekuanBeginEditIsMoveKeyBoard:NO];
    }
}

-(void)setLoan:(YXBLoan *)loan
{
    if (loan.loanType == YXBLoanTypeKuaiShanDianJieKuan) {
        leftLabel.text = @"救急金额";
    }
    else
    {
        leftLabel.text = @"借款金额";
    }
    self.textField.text = loan.money;
    
}



@end
