//
//  AACollectCell.m
//  YOUXINBAO
//
//  Created by Walice on 15/6/19.
//  Copyright (c) 2015年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import "AACollectCell.h"

@implementation AACollectCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    
    return self;
}

- (void)_initViews{
    _leftLabel=[[UILabel alloc]init];
    [self addSubview:_leftLabel];
    
    _textView=[[UITextView alloc]init];
    [self addSubview:_textView];
    
    _textViewplacehide=[[UILabel alloc]init];
    [self addSubview:_textViewplacehide];
    
    [self setNeedsLayout];



}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    _leftLabel.frame=CGRectMake(15, 18, 80, 20);
    _leftLabel.font=[UIFont systemFontOfSize:16];
    _leftLabel.textAlignment= NSTextAlignmentJustified;
    
    
    _textView.frame=CGRectMake(90, 10, kDeviceWidth-100, 40);
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.delegate=self;
    //[_textView becomeFirstResponder];
    
    _textViewplacehide.frame=CGRectMake(100, 10, kDeviceWidth-110, 40);
    _textViewplacehide.numberOfLines=0;
    _textViewplacehide.enabled = NO;
    _textViewplacehide.font = [UIFont systemFontOfSize:14];
    _textViewplacehide.textColor = rgb(182, 182, 182, 1);
    

}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>0) {
        _textViewplacehide.hidden = YES;
    }else{
        if (textView.text.length ==0) {
            _textViewplacehide.hidden = NO;
        }
        
        
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    
    return YES;
}



//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"]) {
//        [_textView resignFirstResponder];
//        return NO;
//    }
//    
//    if (text.length>0) {
//        _textViewplacehide.hidden = YES;
//    }else{
//        if (range.location ==0) {
//        _textViewplacehide.hidden = NO;
//        }
//        
//        
//    }
//    return YES;
//}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if([self.delegate respondsToSelector:@selector(AAcollectAction:)]){
        [self.delegate AAcollectAction:textView];
    };

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
