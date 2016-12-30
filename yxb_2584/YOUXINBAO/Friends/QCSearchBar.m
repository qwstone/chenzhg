//
//  QCSearchBar.m
//  YOUXINBAO
//
//  Created by CH10 on 14-4-30.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "QCSearchBar.h"
#import "UIView+ViewFrameGeometry.h"
#import "QCConst.h"
#import "QCFriendsViewController.h"
#import "QCAddressListViewController.h"

@implementation QCSearchBar {
    UIButton *_cancel;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]
                            removeObserver:self
                            name:@"UITextFieldTextDidChangeNotification"
                            object:nil];
    Release(_cancel);
    self.text = nil;
    self.textField = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textField = [[UITextField  alloc] initWithFrame:CGRectMake(0,(frame.size.height-32)/2, frame.size.width, 32)];
		_textField.borderStyle = UITextBorderStyleNone;
        //        _textField.bounds = CGRectMake(0, 0, frame.size.width - 20, 31);
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.background = [UIImage imageNamed:@"friend_searchBoard_"];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.placeholder = @"手机号码/无忧借条ID";
        _textField.font = [UIFont systemFontOfSize:14.0];
        _textField.delegate = self;
        [self addSubview:_textField];
        
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 17)];
        leftView.backgroundColor = [UIColor clearColor];
        leftView.image = [UIImage imageNamed:@"friend_search_bar_icon_normal"];
        leftView.contentMode = UIViewContentModeScaleAspectFit;
        _textField.leftView = leftView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        [leftView release];
        
        _cancel = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        _cancel.frame = CGRectMake(frame.size.width+5, (frame.size.height-25)/2, 40, 25);
        _cancel.backgroundColor = [UIColor clearColor];
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        _cancel.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancel setTitleColor:rgb(136, 136, 136, 1) forState:UIControlStateNormal];
        [_cancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        _cancel.hidden = YES;
        [self addSubview:_cancel];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged)
                                                    name:@"UITextFieldTextDidChangeNotification"
                                                        object:nil];
        
    }
    return self;
}

#pragma mark - Methods
- (void)resignFirstResponder {
    [_textField resignFirstResponder];
}

#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:.2 animations:^{
        _textField.width = self.frame.size.width-40;
        
        _cancel.hidden = NO;
        _cancel.left = self.frame.size.width-35;
    }];
    if ([self.delegate respondsToSelector:@selector(QCSearchBarDidBeginEditing:)]) {
        [self.delegate QCSearchBarDidBeginEditing:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:.2 animations:^{
        _textField.width = self.frame.size.width;
        
        _cancel.left = self.frame.size.width+5;
        _cancel.hidden = YES;
    }];
    
    if ([self.delegate respondsToSelector:@selector(QCSearchBarDidEndEditing:)]) {
        [self.delegate QCSearchBarDidEndEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (string.length == 0) {
        if (textField.text.length == 1) {
            self.text = nil;
        }else if (textField.text.length > 1) {
            
            self.text = [textField.text substringToIndex:textField.text.length-1];
        }
        
        
    }else {
        NSString *text = [NSString stringWithFormat:@"%@%@",textField.text,string];
        self.text = text;
        
    }
    
    if ([self.delegate respondsToSelector:@selector(QCSearchBarshouldChangeCharacters:)]) {
        [self.delegate QCSearchBarshouldChangeCharacters:self];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    self.text = nil;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.text = textField.text;
    if ([self.delegate respondsToSelector:@selector(QCSearchBarDidSearch:)]) {
        [self.delegate QCSearchBarDidSearch:self];
    }
    [_textField resignFirstResponder];
    return YES;
}

#pragma mark - Actions
- (void)cancelAction:(UIButton *)button {
    self.text = nil;

    if ([self.delegate respondsToSelector:@selector(QCSearchBarShouldClear:)]) {
        [self.delegate QCSearchBarShouldClear:self];
    }
    [_textField resignFirstResponder];
}

- (void)textFiledEditChanged {
    if(self.isVisible) {
        NSString *toBeString = _textField.text;
       // NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
        NSString *lang=[[UIApplication sharedApplication]textInputMode].primaryLanguage;

//        NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];// 键盘输入模式

        if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [_textField markedTextRange];
            //获取高亮部分
            UITextPosition *position = [_textField positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (toBeString.length > MAX_INPUT) {
                    self.text = [toBeString substringToIndex:MAX_INPUT];
                }else {
                    self.text = toBeString;
                    
                    if ([self.delegate respondsToSelector:@selector(QCSearchBarshouldChangeCharacters:)]) {
                        [self.delegate QCSearchBarshouldChangeCharacters:self];
                    }
                }
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else{
                
            }
        }
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        else{
            if (toBeString.length > MAX_INPUT) {
                _textField.text = [toBeString substringToIndex:MAX_INPUT];
            }
        }
        
    }
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
