//
//  StudentCell.m
//  YOUXINBAO
//
//  Created by Feili on 15/8/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "StudentCell.h"
#import "AACreatePickerView.h"
#import "AATimePickerView.h"
#define InViteNum 6

@interface StudentCell ()<UITextFieldDelegate>

@property(nonatomic,strong)UIImageView *photoView;
@property(nonatomic,strong)UILabel *titleLabel;//标题




@end

@implementation StudentCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)initViews
{
    //添加背景
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    CGFloat x = 0,y = 0;
    CGFloat w = self.cellWidth - 2 * x,h = self.cellHeight;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    bgView.backgroundColor = rgb(255, 255, 255, 0.8);
    [self.contentView addSubview:bgView];
    
    x = 20 , w = 80,h = bgView.height;
    self.titleLabel = [self labelWithFrame:CGRectMake(x, x, w, h) fontSize:15 minimumScaleFactor:15 adjustsFontSizeToFitWidth:NO textColor:rgb(48, 48, 48, 1) backgroundColor:[UIColor clearColor]];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:_titleLabel];
    
    //添加竖线
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(x+w, 3, 1, h-6)];
    line.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:line];
    line.hidden = YES;
    
    //添加文本
#define LoginCellTextfieldleftAlign 20
    x = x + w + LoginCellTextfieldleftAlign;
    w = bgView.width - x - 20;
    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(LoginCellTextfieldleftAlign, y, kDeviceWidth-LoginCellTextfieldleftAlign*2, h)];
    _textfield.backgroundColor = [UIColor clearColor];
    _textfield.minimumFontSize = 8.0;
    _textfield.font = [UIFont systemFontOfSize:16.0];
    _textfield.textColor = [UIColor blackColor];
    _textfield.adjustsFontSizeToFitWidth = YES;
    _textfield.minimumFontSize = 10.0/_textfield.font.pointSize;
    _textfield.delegate = self;
//    _textfield.textAlignment = NSTextAlignmentRight;
    
    _textfield.leftViewMode=UITextFieldViewModeAlways;
    _textfield.leftView=self.titleLabel;
    
    [bgView addSubview:_textfield];
    
    
    
}

-(void)setMyTextfieldEndBlockWithblock:(void(^)(NSString *text))block
{
    self.textfieldEndBlock = block;
}

-(void)setMyTextfieldBeginBlock:(void(^)())beginBlock EndBlock:(void(^)(NSString *text))block
{
    self.textfieldBeginBlock = beginBlock;
    self.textfieldEndBlock = block;
    
}

-(void)setModel:(LoginModel *)model
{
    if (_model != model) {
        _model = model;
        //        _photoView.image = [UIImage imageNamed:_model.imageName];
        _textfield.text = _model.text;
        _titleLabel.text = _model.titleName;
        _textfield.placeholder = _model.placeHolder;
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.pickerViewData != nil) {
        [self.textfield resignFirstResponder];
    }
    if (_textfieldBeginBlock) {
        self.textfieldBeginBlock();
    }
    
    if (self.pickerViewData == nil)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}// return NO to disallow editing.


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ( self.index==6)
    {
        NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
        
        [str replaceCharactersInRange:range withString:string];
        
        if (str.length > InViteNum)
        {
            //        [YXBTool showAlertViewWithString:[NSString stringWithFormat:@"邀请码最高%d位",InviteNum]];
//            textField.text=@"";
            return NO;
            
        }
        

    }
    
    return YES;

  
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_textfieldEndBlock != nil) {
        self.textfieldEndBlock(textField.text);
    }
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

//设置密码输入框
-(void)setSecureText
{
    if (_textfield.secureTextEntry == NO) {
        _textfield.secureTextEntry = YES;
        
    }
}

-(void)editEnable:(BOOL)isEnable
{
    if (isEnable) {
        _textfield.userInteractionEnabled = YES;
    }
    else
    {
        _textfield.userInteractionEnabled = NO;
    }
}

-(void)setText:(NSString *)text
{
    _text = text;
    _textfield.text = _text;
}

-(void)setStudentType:(StudentVerifyStatusType)studentType
{
    //StudentVerifyStatusTypePassedStudent 不显示  其余都显示
}

-(void)setIndex:(NSInteger)index
{
    _index=index;
    if (_index==6) {
        _textfield.keyboardType=UIKeyboardTypeNumberPad;

    }
}

@end
