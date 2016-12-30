//
//  PassWordTableViewCell.m
//  YOUXINBAO
//
//  Created by 张淼 on 15/4/29.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "PassWordTableViewCell.h"

@implementation PassWordTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, kDeviceWidth-30, kDeviceWidth/6)];
        _textField.delegate =self;
        _leftView = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 110, 50)];
        _leftView.font = [UIFont systemFontOfSize:17];
        _leftView.textColor = [UIColor blackColor];
        _leftView.textAlignment = NSTextAlignmentCenter;
        _textField.leftView = _leftView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.layer.borderColor = [rgb(225, 225, 225, 0.8) CGColor];
        _textField.layer.borderWidth = 1;
        [self.contentView addSubview:_textField];
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIView * sendBackImage;
    if (sendBackImage == nil) {
        sendBackImage = [[UIView alloc]initWithFrame:CGRectMake(-1, 0, kDeviceWidth+2, 50)];
        sendBackImage.backgroundColor = [UIColor whiteColor];
        CALayer * lineup = [CALayer layer];
        lineup.backgroundColor = [rgb(255, 156, 146, 1) CGColor];
        lineup.frame = CGRectMake(0, 0, sendBackImage.width, 1);
        [sendBackImage.layer addSublayer:lineup];
        
        CALayer * linedown = [CALayer layer];
        linedown.backgroundColor = [rgb(255, 156, 146, 1) CGColor];
        linedown.frame = CGRectMake(0, sendBackImage.height-1, sendBackImage.width, 1);
        [sendBackImage.layer addSublayer:linedown];
        
        sendBackImage.userInteractionEnabled = YES;
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, kDeviceWidth-20, 40)];
        [btn setBackgroundImage:[UIImage imageNamed:@"register_sure.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(keyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [sendBackImage addSubview:btn];
    }
   
    textField.inputAccessoryView = sendBackImage;
}
- (void)keyBtnAction:(UIButton *)sender
{
    [_textField resignFirstResponder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
