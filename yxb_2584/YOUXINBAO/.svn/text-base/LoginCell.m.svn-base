//
//  LoginCell.m
//  DiTui
//
//  Created by Feili on 15/5/23.
//  Copyright (c) 2015年 YXBao. All rights reserved.
//

#import "LoginCell.h"

@interface LoginCell ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *photoView;
@property(nonatomic,strong)UILabel *titleLabel;//标题
@end
@implementation LoginCell

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
    
    /*
    //添加图像
    x = 0,w = 58,h = bgView.height;
    self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)]
    ;
    self.photoView.contentMode = UIViewContentModeCenter;
    [bgView addSubview:_photoView];
    
    */
    
    x = 20 , w = 80, h = bgView.height;
    self.titleLabel = [self labelWithFrame:CGRectMake(x, y, w, h) fontSize:14 minimumScaleFactor:16 adjustsFontSizeToFitWidth:NO textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor]];
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
    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(10, y, kDeviceWidth-20, h)];
    _textfield.backgroundColor = [UIColor clearColor];
    _textfield.minimumFontSize = 8.0;
    _textfield.font = [UIFont systemFontOfSize:16.0];
    _textfield.textColor = [UIColor blackColor];
    _textfield.adjustsFontSizeToFitWidth = YES;
    _textfield.delegate = self;
    _textfield.textAlignment = NSTextAlignmentRight;
    
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


//-(void)setMyTextfieldEndBlockWithblock:(void(^)())block
//{
//    self.textfieldEndBlock = block;
//}
-(void)setModel:(LoginModel *)model
{
    if (_model != model) {
        _model = model;
//        _photoView.image = [UIImage imageNamed:_model.imageName];
        _textfield.text = _model.text;
        _titleLabel.text = _model.titleName;
    }
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

-(void)setRightNextImage:(BOOL)isNext
{
    if (isNext) {
        _textfield.layer.contents = (id)[UIImage imageNamed:@"next.png"].CGImage;
        _textfield.contentMode = UIViewContentModeRight;
        _textfield.layer.contentsScale = [UIScreen mainScreen].scale;
    }
    else
    {
        _textfield.layer.contents = nil;

    }
}


@end
