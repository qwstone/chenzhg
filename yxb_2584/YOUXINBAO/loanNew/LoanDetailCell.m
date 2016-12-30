//
//  LoanDetailCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/7/27.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "LoanDetailCell.h"

@interface LoanDetailCell ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *textfield;
@property(nonatomic,strong)UILabel *titleLabel;//标题


@end
@implementation LoanDetailCell

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
    //添加背景
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    CGFloat x = 0,y = 0;
    CGFloat w = kDeviceWidth,h = 50;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    bgView.backgroundColor = rgb(255, 255, 255, 0.8);
    [self.contentView addSubview:bgView];
    
    x = 20 , w = 80, h = bgView.height;
    self.titleLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:14 minimumScaleFactor:16 adjustsFontSizeToFitWidth:NO textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor]];
    [bgView addSubview:_titleLabel];
    
    //添加文本
#define LoginCellTextfieldleftAlign 20
    w = 300;
    x = kDeviceWidth - 20 - w;
//    w = bgView.width - x - 20;
    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(x, y, w, h)];
    _textfield.backgroundColor = [UIColor clearColor];
    _textfield.minimumFontSize = 8.0;
    _textfield.font = [UIFont systemFontOfSize:16.0];
    _textfield.textColor = [UIColor blackColor];
    _textfield.adjustsFontSizeToFitWidth = YES;
    _textfield.delegate = self;
    _textfield.textAlignment = NSTextAlignmentRight;
    _textfield.placeholder = @"1-50000";
    _textfield.leftViewMode=UITextFieldViewModeAlways;
//    _textfield.leftView=self.titleLabel;
    _textfield.keyboardType = UIKeyboardTypeNumberPad;
    [bgView addSubview:_textfield];
    
    
}


-(void)setModel:(LoginModel *)model
{
    if (_model != model) {
        _model = model;
        _titleLabel.text = model.titleName;
        _textfield.text = _model.text;
        
    }
}

-(void)setMyTextfieldBeginBlock:(void(^)())beginBlock EndBlock:(void(^)(NSString *text))block
{
    self.textfieldBeginBlock = beginBlock;
    self.textfieldEndBlock = block;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_textfieldBeginBlock) {
        self.textfieldBeginBlock();
    }
    return YES;
}// return NO to disallow editing.


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@",textField.text];
    [str replaceCharactersInRange:range withString:string];
    if (_textfieldEndBlock != nil) {
        self.textfieldEndBlock(str);
    }
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_textfieldEndBlock != nil) {
        self.textfieldEndBlock(textField.text);
    }
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called



@end
